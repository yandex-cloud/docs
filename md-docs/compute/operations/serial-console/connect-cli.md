# Подключение к серийной консоли виртуальной машины с помощью CLI

После [включения доступа](index.md), вы можете подключиться к серийной консоли для взаимодействия с [ВМ](../../concepts/vm.md).

{% note warning %}

Оцените риск включения доступа через серийную консоль, учитывая следующие факторы:

* ВМ будет доступна для управления из интернета даже в случае отсутствия внешнего IP-адреса. 
  Получить доступ к серийной консоли ВМ из консоли управления Yandex Cloud сможет пользователь, успешно аутентифицированный в консоли управления Yandex Cloud при наличии должных прав на ВМ. Доступ к серийной консоли ВМ из клиентского приложения [SSH](../vm-connect/ssh.md) (например, Putty) или [CLI](../../../cli/index.md) также возможен путем аутентификации через SSH-ключ. В связи с этим необходимо тщательно контролировать SSH-ключ и завершать веб-сессию для снижения рисков ее перехвата.

* Сессия будет доступна одновременно всем пользователям, имеющим право доступа к серийной консоли.
  Действия одного пользователя будут видны другим пользователям, если в это время они смотрят вывод серийной консоли.

* Незавершенная сессия может быть использована другим пользователем.

Мы рекомендуем включать серийную консоль только в случае крайней необходимости, выдавать такой доступ узкому кругу лиц и использовать стойкие пароли для доступа к ВМ.

Не забывайте [отключать доступ](disable.md) после работы с серийной консолью.

{% endnote %}

## Подключиться к серийной консоли {#connect-to-serial-console}

{% note info %}

Работа серийной консоли зависит от настроек используемой операционной системы. Сервис Compute Cloud обеспечивает канал между пользователем и COM-портом ВМ и не гарантирует стабильность работы консоли со стороны ОС.

{% endnote %}

Чтобы подключиться к серийной консоли, используйте CLI.

Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

Дальнейший порядок действий по подключению зависит от операционной системы и от того, включен ли для ВМ доступ по [OS Login](../../../organization/concepts/os-login.md). Если для ВМ [включен](../vm-connect/enable-os-login.md) доступ по OS Login, подключение к серийной консоли происходит с использованием короткоживущих SSH-сертификатов. Для подключения к ВМ с выключенным доступом по OS Login используются [SSH-ключи](../../../glossary/ssh-keygen.md).

Некоторые ОС могут запрашивать данные пользователя для доступа на ВМ. Поэтому перед подключением к серийной консоли таких ВМ необходимо создать локальный пароль пользователя.

{% list tabs %}

- Linux c SSH-ключом

  1. Создайте локальный пароль пользователя на ВМ:
      1. [Подключитесь](../vm-connect/ssh.md) к ВМ по SSH.
      1. Создайте пользователя для аутентификации на ВМ через серийную консоль и задайте для него локальный пароль:
         
         ```bash
         sudo useradd <имя_пользователя> && sudo passwd <имя_пользователя>
         ```
         
         Где `<имя_пользователя>` — имя создаваемого пользователя, например `yc-user`.
         
         По запросу системы введите пароль пользователя, затем подтвердите его.
         
         Результат:
         
         ```text
         passwd: password updated successfully
         ```
      1. Отключитесь от ВМ. Для этого введите команду `logout`.

  1. Посмотрите описание команды CLI для подключения к серийной консоли:

      ```bash
      yc compute connect-to-serial-port --help
      ```

  1. Получите список ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

      ```bash
      yc compute instance list
      ```
      
      Результат:
      ```text
      +----------------------+-----------------+---------------+---------+----------------------+
      |          ID          |       NAME      |    ZONE ID    | STATUS  |     DESCRIPTION      |
      +----------------------+-----------------+---------------+---------+----------------------+
      | fhm0b28lgfp4******** | first-instance  | ru-central1-a | RUNNING | my first vm via CLI  |
      | fhm9gk85nj7g******** | second-instance | ru-central1-a | RUNNING | my second vm via CLI |
      +----------------------+-----------------+---------------+---------+----------------------+
      ```

  1. Укажите имя ВМ и включите авторизацию по метаданным при подключении к серийной консоли:
     
     ```bash
     yc compute instance update \
       --name <имя_ВМ> \
       --serial-port-settings ssh-authorization=INSTANCE_METADATA
     ```
     
     Результат:
     
     ```yaml
     done (6s)
     id: fhm0b28lgfp4********
     folder_id: b1g9d2k0itu4********
     created_at: "2024-03-28T19:53:23Z"
     name: first-instance
     zone_id: ru-central1-a
     platform_id: standard-v3
     resources:
       memory: "1073741824"
       cores: "2"
       core_fraction: "20"
     status: RUNNING
     metadata_options:
       gce_http_endpoint: ENABLED
       aws_v1_http_endpoint: ENABLED
       gce_http_token: ENABLED
       aws_v1_http_token: DISABLED
     boot_disk:
       mode: READ_WRITE
       device_name: epdu3ce920e7********
       auto_delete: true
       disk_id: epdu3ce920e7********
     network_interfaces:
       - index: "0"
         mac_address: d0:0d:5c:**:**:**
         subnet_id: e2luhnr3rhf8********
         primary_v4_address:
           address: 192.168.1.21
           one_to_one_nat:
             address: 51.250.***.***
             ip_version: IPV4
         security_group_ids:
           - enpjauvetqfb********
     serial_port_settings:
       ssh_authorization: INSTANCE_METADATA
     gpu_settings: {}
     fqdn: sample-vm.ru-central1.internal
     scheduling_policy:
       preemptible: true
     network_settings:
       type: STANDARD
     placement_policy: {}
     hardware_generation:
       legacy_features:
         pci_topology: PCI_TOPOLOGY_V1
     ```
     
     Если на уровне организации [включен](../../../organization/operations/os-login-access.md) доступ по OS Login, то для новых ВМ, создаваемых в этой организации, полю `serial_port_settings.ssh_authorization` по умолчанию будет присваиваться значение `OS_LOGIN`. Если доступ по OS Login выключен, этому полю по умолчанию будет присваиваться значение `INSTANCE_METADATA`.

  1. Подключитесь к серийной консоли нужной ВМ:

      ```bash
      yc compute connect-to-serial-port \
        --instance-name <имя_ВМ> \
        --ssh-key ~/.ssh/id_ed25519
      ```

      Где:
      * `--instance-name` — обязательный параметр. Имя виртуальной машины.
          Вместо имени ВМ можно передать ее идентификатор в параметре `--instance-id`.

      * `--ssh-key` — опциональный параметр. Путь к закрытому ключу для [SSH-доступа](../../../glossary/ssh-keygen.md) к ВМ, например `~/.ssh/id_ed25519`. Если параметр не указан, будет сгенерирован SSH-ключ `yc_serialssh_key`.

      {% note alert %}
      
      Для подключения к серийной консоли виртуальной машины по SSH можно использовать только незащищенный паролем ключ. В противном случае соединение будет разорвано после ввода пароля.
      
      {% endnote %}

      При подключении система может запросить логин и пароль для аутентификации на ВМ. Введите созданные ранее логин и пароль, после чего вы получите доступ к серийной консоли.

      Подробнее о команде `yc compute connect-to-serial-port` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/connect-to-serial-port.md).

- Linux по OS Login

  1. Создайте локальный пароль пользователя на ВМ:
      1. [Подключитесь](../vm-connect/os-login.md) к ВМ по OS Login.
      1. Создайте пользователя для аутентификации на ВМ через серийную консоль и задайте для него локальный пароль:
         
         ```bash
         sudo useradd <имя_пользователя> && sudo passwd <имя_пользователя>
         ```
         
         Где `<имя_пользователя>` — имя создаваемого пользователя, например `yc-user`.
         
         По запросу системы введите пароль пользователя, затем подтвердите его.
         
         Результат:
         
         ```text
         passwd: password updated successfully
         ```
      1. Отключитесь от ВМ. Для этого введите команду `logout`.

  1. Получите список ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

      ```bash
      yc compute instance list
      ```
      
      Результат:
      ```text
      +----------------------+-----------------+---------------+---------+----------------------+
      |          ID          |       NAME      |    ZONE ID    | STATUS  |     DESCRIPTION      |
      +----------------------+-----------------+---------------+---------+----------------------+
      | fhm0b28lgfp4******** | first-instance  | ru-central1-a | RUNNING | my first vm via CLI  |
      | fhm9gk85nj7g******** | second-instance | ru-central1-a | RUNNING | my second vm via CLI |
      +----------------------+-----------------+---------------+---------+----------------------+
      ```

  1. Включите для ВМ авторизацию по OS Login при подключении к серийной консоли, указав имя ВМ:
     
     ```bash
     yc compute instance update \
       --name <имя_ВМ> \
       --serial-port-settings ssh-authorization=OS_LOGIN
     ```
     
     Результат:
     
     ```yaml
     done (6s)
     id: fhm0b28lgfp4********
     folder_id: b1g9d2k0itu4********
     created_at: "2024-03-28T19:53:23Z"
     name: first-instance
     zone_id: ru-central1-a
     platform_id: standard-v3
     resources:
       memory: "1073741824"
       cores: "2"
       core_fraction: "20"
     status: RUNNING
     metadata_options:
       gce_http_endpoint: ENABLED
       aws_v1_http_endpoint: ENABLED
       gce_http_token: ENABLED
       aws_v1_http_token: DISABLED
     boot_disk:
       mode: READ_WRITE
       device_name: epdu3ce920e7********
       auto_delete: true
       disk_id: epdu3ce920e7********
     network_interfaces:
       - index: "0"
         mac_address: d0:0d:5c:**:**:**
         subnet_id: e2luhnr3rhf8********
         primary_v4_address:
           address: 192.168.1.21
           one_to_one_nat:
             address: 51.250.***.***
             ip_version: IPV4
         security_group_ids:
           - enpjauvetqfb********
     serial_port_settings:
       ssh_authorization: OS_LOGIN
     gpu_settings: {}
     fqdn: sample-vm.ru-central1.internal
     scheduling_policy:
       preemptible: true
     network_settings:
       type: STANDARD
     placement_policy: {}
     hardware_generation:
       legacy_features:
         pci_topology: PCI_TOPOLOGY_V1
     ```
     
     {% note info %}
     
     Если на уровне организации [включен](../../../organization/operations/os-login-access.md) доступ по OS Login, то для новых ВМ, создаваемых в этой организации, полю `serial_port_settings.ssh_authorization` по умолчанию будет присваиваться значение `OS_LOGIN`. Если доступ по OS Login выключен, этому полю по умолчанию будет присваиваться значение `INSTANCE_METADATA`.
     
     {% endnote %}

  1. Посмотрите описание команды CLI для подключения к серийной консоли:

      ```bash
      yc compute connect-to-serial-port --help
      ```

  1. Подключитесь к серийной консоли нужной ВМ:

      ```bash
      yc compute connect-to-serial-port \
        --instance-name <имя_ВМ>
      ```

      Где `--instance-name` — обязательный параметр. Имя виртуальной машины. Вместо имени ВМ можно передать ее идентификатор в параметре `--instance-id`.

      При подключении система может запросить логин и пароль для аутентификации на ВМ. Введите созданные ранее логин и пароль, после чего вы получите доступ к серийной консоли.

      Подробнее о команде `yc compute connect-to-serial-port` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/connect-to-serial-port.md).

- Windows

  1. Посмотрите описание команды CLI для подключения к серийной консоли:

      ```bash
      yc compute connect-to-serial-port --help
      ```

  1. Получите список ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

      ```bash
      yc compute instance list
      ```
      
      Результат:
      ```text
      +----------------------+-----------------+---------------+---------+----------------------+
      |          ID          |       NAME      |    ZONE ID    | STATUS  |     DESCRIPTION      |
      +----------------------+-----------------+---------------+---------+----------------------+
      | fhm0b28lgfp4******** | first-instance  | ru-central1-a | RUNNING | my first vm via CLI  |
      | fhm9gk85nj7g******** | second-instance | ru-central1-a | RUNNING | my second vm via CLI |
      +----------------------+-----------------+---------------+---------+----------------------+
      ```

  1. Укажите имя ВМ и включите авторизацию по метаданным при подключении к серийной консоли:
     
     ```bash
     yc compute instance update \
       --name <имя_ВМ> \
       --serial-port-settings ssh-authorization=INSTANCE_METADATA
     ```
     
     Результат:
     
     ```yaml
     done (6s)
     id: fhm0b28lgfp4********
     folder_id: b1g9d2k0itu4********
     created_at: "2024-03-28T19:53:23Z"
     name: first-instance
     zone_id: ru-central1-a
     platform_id: standard-v3
     resources:
       memory: "1073741824"
       cores: "2"
       core_fraction: "20"
     status: RUNNING
     metadata_options:
       gce_http_endpoint: ENABLED
       aws_v1_http_endpoint: ENABLED
       gce_http_token: ENABLED
       aws_v1_http_token: DISABLED
     boot_disk:
       mode: READ_WRITE
       device_name: epdu3ce920e7********
       auto_delete: true
       disk_id: epdu3ce920e7********
     network_interfaces:
       - index: "0"
         mac_address: d0:0d:5c:**:**:**
         subnet_id: e2luhnr3rhf8********
         primary_v4_address:
           address: 192.168.1.21
           one_to_one_nat:
             address: 51.250.***.***
             ip_version: IPV4
         security_group_ids:
           - enpjauvetqfb********
     serial_port_settings:
       ssh_authorization: INSTANCE_METADATA
     gpu_settings: {}
     fqdn: sample-vm.ru-central1.internal
     scheduling_policy:
       preemptible: true
     network_settings:
       type: STANDARD
     placement_policy: {}
     hardware_generation:
       legacy_features:
         pci_topology: PCI_TOPOLOGY_V1
     ```
     
     Если на уровне организации [включен](../../../organization/operations/os-login-access.md) доступ по OS Login, то для новых ВМ, создаваемых в этой организации, полю `serial_port_settings.ssh_authorization` по умолчанию будет присваиваться значение `OS_LOGIN`. Если доступ по OS Login выключен, этому полю по умолчанию будет присваиваться значение `INSTANCE_METADATA`.

  1. Подключитесь к SAC Windows нужной ВМ:

      ```bash
      yc compute connect-to-serial-port \
        --instance-name <имя_ВМ> \
        --port 2
      ```

      Где:
      * `--instance-name` — обязательный параметр. Имя виртуальной машины. Вместо имени ВМ можно передать ее идентификатор в параметре `--instance-id`.
      * `--port` — опциональный параметр. Номер порта для подключения к серийной консоли. При подключении к серийной консоли Windows (SAC) передайте значение `2`.

      По запросу системы введите логин, домен (имя ВМ) и пароль. Подробнее см. в разделе [Запустить командную оболочку в Windows SAC](windows-sac.md).

      Подробнее о команде `yc compute connect-to-serial-port` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/connect-to-serial-port.md).

{% endlist %}

### Решение проблем {#troubleshooting}

* Если после подключения к серийной консоли на экране ничего не отображается:
  * Нажмите на клавиатуре клавишу **Enter**.
  * Перезапустите ВМ (для ВМ, созданных до 22 февраля 2019 года).

## Отключиться от серийной консоли {#turn-off-serial-console}

Чтобы отключиться от серийной консоли:
1. Нажмите на клавиатуре клавишу **Enter**.
1. Введите последовательно символы `~.`.