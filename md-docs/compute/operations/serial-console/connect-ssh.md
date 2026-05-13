# Подключение к серийной консоли виртуальной машины по SSH

{% note alert %}

Для подключения к серийной консоли виртуальной машины по SSH можно использовать только незащищенный паролем ключ. В противном случае соединение будет разорвано после ввода пароля.

{% endnote %}

После [включения доступа](index.md), вы можете подключиться к серийной консоли для взаимодействия с [ВМ](../../concepts/vm.md). Перед [подключением](../../../glossary/ssh-keygen.md) к серийной консоли внимательно ознакомьтесь с разделом [Безопасность](#security).

## Безопасность {#security}

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

Важным моментом при удаленном доступе является защита от [атак посредника (MITM-атак)](https://ru.wikipedia.org/wiki/Атака_посредника). Защититься от MITM-атак можно, используя шифрование между клиентом и сервером.

Установить безопасное подключение можно следующими способами:
* Вы можете скачивать текущий [SHA256 Fingerprint](https://storage.yandexcloud.net/cloud-certs/serialssh-fingerprint.txt) (отпечаток) SSH-ключа перед каждым подключением к ВМ.

  При первом подключении к ВМ клиент сообщает отпечаток SSH-ключа и ожидает решения по установке соединения:
  * `YES` — установить соединение.
  * `NO` — отказаться.

  Убедитесь, что отпечаток по ссылке совпадает с отпечатком, полученным от клиента.
* Вы можете скачивать публичный [SSH-ключ](https://storage.yandexcloud.net/serialssh-certs/serialssh-knownhosts) хоста перед каждым подключением к серийной консоли.

  Используйте полученный публичный SSH-ключ при подключении к серийной консоли.

  Рекомендуемые параметры запуска:

  ```bash
  ssh -o ControlPath=none -o IdentitiesOnly=yes -o CheckHostIP=no -o StrictHostKeyChecking=yes -o UserKnownHostsFile=./serialssh-knownhosts -p 9600 -i ~/.ssh/<имя_закрытого_SSH-ключа> <идентификатор_ВМ>.<имя_пользователя>@serialssh.cloud.yandex.net
  ```

  Публичный SSH-ключ хоста в будущем может быть изменен.

Чаще сверяйтесь с указанными файлами. Скачивайте данные файлы только по протоколу HTTPS, предварительно убедившись в валидности сертификата сайта `https://storage.yandexcloud.net`. Если из-за проблем с сертификатом сайт не может обеспечить безопасное шифрование ваших данных, браузер предупреждает об этом.

## Подключиться к серийной консоли {#connect-to-serial-console}

{% note info %}

Работа серийной консоли зависит от настроек используемой операционной системы. Сервис Compute Cloud обеспечивает канал между пользователем и COM-портом ВМ и не гарантирует стабильность работы консоли со стороны ОС.

{% endnote %}

Для подключения к ВМ необходимо знать ее идентификатор. Как получить идентификатор ВМ читайте в разделе [Получить информацию о виртуальной машине](../vm-info/get-info.md).

Дальнейший порядок действий по подключению зависит от того, включен ли для ВМ доступ по [OS Login](../../../organization/concepts/os-login.md). Если для ВМ [включен](../vm-connect/enable-os-login.md) доступ по OS Login, подключиться к серийной консоли можно с использованием экспортированного SSH-сертификата. Для подключения к ВМ с выключенным доступом по OS Login используются [SSH-ключи](../../../glossary/ssh-keygen.md).

Некоторые ОС могут запрашивать данные пользователя для доступа на ВМ. Поэтому перед подключением к серийной консоли таких ВМ необходимо создать локальный пароль пользователя.

{% list tabs %}

- С SSH-ключом

  1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

  1. Подключитесь к ВМ.

      Пример команды подключения:

      ```bash
      ssh -t -p 9600 -o IdentitiesOnly=yes -i <путь_к_закрытому_SSH-ключу> <идентификатор_ВМ>.<имя_пользователя>@serialssh.cloud.yandex.net
      ```

      Где: 
      * `путь_к_закрытому_SSH-ключу` — путь к закрытой части [SSH-ключа](../vm-connect/ssh.md#creating-ssh-keys), полученного при [создании ВМ](../vm-create/create-linux-vm.md).
      * `идентификатор_ВМ` — идентификатор виртуальной машины. Как получить идентификатор ВМ читайте в разделе [Получить информацию о виртуальной машине](../vm-info/get-info.md).
      * `имя_пользователя` — имя администратора, указанное при создании ВМ.

      ```bash
      ssh -t -p 9600 -o IdentitiesOnly=yes -i ~/.ssh/id_ed25519 fhm0b28lgfp4********.yc-user@serialssh.cloud.yandex.net
      ```

      При подключении система может запросить логин и пароль для аутентификации на ВМ. Введите созданные ранее логин и пароль, после чего вы получите доступ к серийной консоли.

- С SSH-сертификатом по OS Login

  1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

      По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

  1. [Экспортируйте](../vm-connect/os-login-export-certificate.md) сертификат OS Login, указав [идентификатор](../../../organization/operations/organization-get-id.md) вашей организации:

      ```bash
      yc compute ssh certificate export \
        --organization-id <идентификатор_организации>
      ```

      Результат:

      ```text
      Identity: /home/myuser/.ssh/yc-organization-id-bpfaidqca8vd********-yid-orgusername
      Certificate: /home/myuser/.ssh/yc-organization-id-bpfaidqca8vd********-yid-orgusername-cert.pub
      ```

      Экспортированный сертификат действителен один час.

  1. Подключитесь к ВМ.

      Пример команды подключения:

      ```bash
      ssh -t -p 9600 -i <путь_к_SSH-сертификату> <идентификатор_ВМ>.<логин_пользователя_OS_Login>@serialssh.cloud.yandex.net
      ```

      Где:
      * `<путь_к_SSH-сертификату>` — путь к экспортированному SSH-сертификату, значение поля `Identity`.
      * `<идентификатор_ВМ>` — идентификатор виртуальной машины, к серийной консоли которой требуется подключиться.
      * `<имя_пользователя_OS_Login>` — идентификатор пользователя OS Login в организации. Логин пользователя OS Login указан в конце имени экспортированного сертификата после [идентификатора](../../../organization/operations/organization-get-id.md) организации.

          Также логин пользователя можно получить с помощью команды `yc organization-manager os-login profile list` [Yandex Cloud CLI](../../../cli/cli-ref/organization-manager/cli-ref/oslogin/profile/list.md) или в [интерфейсе Cloud Center](https://center.yandex.cloud/organization) в профиле пользователя на вкладке **Профили OS Login**.

          {% note info %}

          Минимально необходимая роль, позволяющая просматривать список профилей OS Login пользователей — [роль](../../../organization/security/index.md#organization-manager-osLogins-viewer) `organization-manager.osLogins.viewer`, назначенная на организацию. Информацию о других ролях, позволяющих просматривать список профилей OS Login, см. в разделе [Управление доступом в Yandex Identity Hub](../../../organization/security/index.md#service-roles).

          {% endnote %}

      Пример для пользователя с логином `yid-orgusername` и ВМ с идентификатором `epd22a2tj3gd********`:

      ```bash
      ssh -p 9600 -i /home/myuser/.ssh/yc-organization-id-bpfaidqca8vd********-yid-orgusername epd22a2tj3gd********.yid-orgusername@serialssh.cloud.yandex.net
      ```

      При подключении система может запросить логин и пароль для аутентификации на ВМ. Введите созданные ранее логин и пароль, после чего вы получите доступ к серийной консоли.

{% endlist %}

Вы также можете подключиться к серийной консоли с помощью [SSH-ключей для других пользователей](../vm-connect/ssh.md#vm-authorized-keys).


### Решение проблем {#troubleshooting}

* Если после подключения к серийной консоли на экране ничего не отображается:
  * Нажмите на клавиатуре клавишу **Enter**.
  * Перезапустите ВМ (для ВМ, созданных до 22 февраля 2019 года).
* Если при подключении с помощью SSH-ключа возникает ошибка `Warning: remote host identification has changed!`, выполните команду `ssh-keygen -R <IP-адрес_ВМ>`.
* Если при подключении с помощью SSH-сертификата возникает ошибка `Permission denied (publickey).`, убедитесь, что для ВМ включена авторизация по OS Login при подключении к серийной консоли, а сертификат — не просрочен. При необходимости включите для ВМ авторизацию по OS Login при подключении к серийной консоли или повторно экспортируйте SSH-сертификат.
* Если при подключении с помощью SSH-сертификата возникает ошибка `Connection closed by 2a0d:d6c1:0:**::*** port 9600`, на локальной машине откройте файл `known_hosts` и удалите все строки, которые начинаются с `[serialssh.cloud.yandex.net]:9600`. Затем повторите подключение и на вопрос `Are you sure you want to continue connecting (yes/no/[fingerprint])?` ответьте `yes`.


## Отключиться от серийной консоли {#turn-off-serial-console}

Чтобы отключиться от серийной консоли:
1. Нажмите на клавиатуре клавишу **Enter**.
1. Введите последовательно символы `~.`.