# Подключиться к серийной консоли виртуальной машины с ОС Linux

{% note warning %}

Оцените риск разрешения доступа к ВМ через серийную консоль, учитывая следующие факторы:

* ВМ будет доступна для управления из интернета даже при отсутствии у нее внешнего IP-адреса.

    При наличии необходимых [прав](../../security/index.md) доступа к ВМ подключиться к серийной консоли сможет пользователь, успешно аутентифицированный в [консоли управления](https://console.yandex.cloud) Yandex Cloud.
    
    Доступ к серийной консоли ВМ из клиентского приложения [SSH](../vm-connect/ssh.md) (например, Putty) или [CLI](../../../cli/index.md) также возможен путем аутентификации с помощью SSH-ключа. Поэтому необходимо защитить SSH-ключ от несанкционированного доступа, а также всегда завершать веб-сессию для снижения рисков ее перехвата.

* Сессия работы с серийной консолью будет доступна одновременно всем пользователям, имеющим право доступа к серийной консоли. Действия одного пользователя будут видны другим пользователям, если в это время они просматривают вывод серийной консоли.
* Незавершенная сессия работы с серийной консолью может быть использована другим пользователем.

Мы рекомендуем разрешать доступ к серийной консоли только в случае крайней необходимости, выдавать такой доступ узкому кругу доверенных лиц и использовать стойкие пароли для доступа к ВМ.

После завершения использования серийной консоли не забудьте [запретить](index.md#disable) доступ к ней.

{% endnote %}

Чтобы подключиться к [серийной консоли](../../concepts/serial-console.md) ВМ, для этой виртуальной машины необходимо предварительно [разрешить доступ](index.md#enable) к серийной консоли.

Вы можете подключиться к серийной консоли с помощью [консоли управления](https://console.yandex.cloud), а также с использованием стандартного [SSH](../../../glossary/ssh-keygen.md)-клиента или через [OS Login](../../../organization/concepts/os-login.md).

Перед подключением к серийной консоли внимательно ознакомьтесь с разделом [Безопасность при использовании SSH](../../concepts/serial-console.md#security).

## Перед началом работы {#before-you-begin}

Некоторые операционные системы для доступа на ВМ через серийную консоль могут запрашивать данные локального пользователя. Поэтому перед подключением к серийной консоли необходимо задать локальный пароль пользователя.

В примере ниже вы создадите учетную запись нового локального пользователя Linux с парольной защитой:

1. Подключитесь к виртуальной машине [по SSH](../vm-connect/ssh.md) или [по OS Login](../vm-connect/os-login.md).
1. Создайте учетную запись нового локального пользователя, защищенную паролем:

    ```bash
    export NEW_USERNAME=<имя_нового_пользователя>
    sudo useradd -m -d /home/$NEW_USERNAME -s /bin/bash $NEW_USERNAME \
    && sudo passwd $NEW_USERNAME
    ```

    В результате система запросит ввести и подтвердить пароль нового пользователя:

    ```text
    New password:
    Retype new password:
    passwd: password updated successfully
    ```

{% note warning %}

Работа серийной консоли зависит от настроек используемой операционной системы. Сервис Yandex Compute Cloud обеспечивает канал между пользователем и COM-портом виртуальной машины и не гарантирует стабильность работы консоли со стороны ОС.

{% endnote %}

## Подключиться с помощью консоли управления {#connect-via-console}

{% list tabs %}

- Консоль управления

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится виртуальная машина.
  1. Перейдите в сервис **Compute Cloud**.
  1. На панели слева выберите ![server](../../../_assets/console-icons/server.svg) **Виртуальные машины** и в открывшемся списке выберите нужную виртуальную машину.
  1. В меню слева выберите **Серийная консоль**.
  1. В верхней части экрана в раскрывающемся списке выберите [последовательный порт](../../concepts/serial-console.md#serial-ports), используемый серийной консолью для подключения к ВМ.

      По умолчанию на ВМ с ОС Linux используется последовательный порт `COM1`. Чтобы использовать другой порт, самостоятельно настройте его на стороне операционной системы вашей виртуальной машины.

  1. В открывшемся окне серийной консоли введите имя пользователя и пароль, заданные [ранее](#before-you-begin).

{% endlist %}

{% note warning %}

После завершения использования серийной консоли не забудьте [запретить](index.md#disable) доступ к ней.

{% endnote %}

## Подключиться с помощью стандартного SSH-клиента {#connect-with-ssh-client}

{% note alert %}

Для подключения к серийной консоли виртуальной машины по SSH можно использовать только SSH-ключ, не защищенный паролем. В противном случае соединение будет разорвано после ввода пароля.

{% endnote %}

Убедитесь, что на вашем компьютере установлен и настроен интерфейс [Yandex Cloud CLI](../../../cli/index.md).

Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

Дальнейший порядок действий по подключению зависит от того, включен ли для ВМ доступ по [OS Login](../../../organization/concepts/os-login.md). Если для ВМ [включен](../vm-connect/enable-os-login.md) доступ по OS Login, подключиться к серийной консоли можно с использованием экспортированного SSH-сертификата. Для подключения к ВМ с выключенным доступом по OS Login используются [SSH-ключи](../../../glossary/ssh-keygen.md).

{% list tabs group=os_login_type %}

- По SSH-ключу {#ssh-key}

  1. Включите авторизацию по метаданным при подключении к серийной консоли:
     
     ```bash
     yc compute instance update <имя_или_идентификатор_ВМ> \
       --serial-port-settings ssh-authorization=INSTANCE_METADATA \
       --metadata enable-oslogin=false,serial-port-enable=1,ssh-keys='<имя_пользователя>:<публичный_SSH-ключ>'
     ```
     
     Где:
     * `<имя_или_идентификатор_ВМ>` — о том, как узнать имя или идентификатор ВМ, читайте в разделе [Получить информацию о виртуальной машине](../vm-info/get-info.md).
     * `--metadata` — [метаданные](../../concepts/vm-metadata.md) виртуальной машины:
     
         * `ssh-keys` — имя локального пользователя ВМ и содержимое [публичного SSH-ключа](../vm-connect/ssh.md#creating-ssh-keys), с которым этот пользователь сможет подключаться к ВМ по SSH.
     
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
     
     Подробнее о команде `yc compute instance update` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/instance/update.md).
     
     {% note info %}
     
     Если на уровне организации [включен](../../../organization/operations/os-login-access.md) доступ по OS Login, то для новых ВМ, создаваемых в этой организации, полю `serial_port_settings.ssh_authorization` по умолчанию будет присваиваться значение `OS_LOGIN`. Если доступ по OS Login в организации выключен, этому полю по умолчанию будет присваиваться значение `INSTANCE_METADATA`.
     
     {% endnote %}
  1. Подключитесь к серийной консоли виртуальной машины:

      ```bash
      ssh -t \
        -p 9600 \
        -o IdentitiesOnly=yes \
        -i <путь_к_закрытому_SSH-ключу> \
        <идентификатор_ВМ>.<имя_пользователя>.port=1@serialssh.cloud.yandex.net
      ```

      Где:

      * `путь_к_закрытому_SSH-ключу` — путь к закрытой части [SSH-ключа](../vm-connect/ssh.md#creating-ssh-keys), который вы используете для подключения к ВМ.
      * `идентификатор_ВМ` — идентификатор виртуальной машины.
      * `имя_пользователя` — имя пользователя для подключения по SSH, указанное в метаданных ВМ.
      * `port=1` — номер [последовательного порта](../../concepts/serial-console.md#serial-ports), используемого серийной консолью для подключения к ВМ.

          По умолчанию на ВМ с ОС Linux используется последовательный порт `COM1`. Чтобы использовать другой порт, самостоятельно настройте его на стороне операционной системы вашей виртуальной машины.

      При подключении система может запросить логин и пароль для аутентификации на ВМ. Введите созданные [ранее](#before-you-begin) логин и пароль, после чего вы получите доступ к виртуальной машине.
  1. Завершите работу с серийной консолью:
     
     1. Выйдите из профиля локального пользователя операционной системы:
     
         ```bash
         exit
         ```
     1. Закройте сеанс работы с серийной консолью. Для этого введите следующую последовательность символов:
     
         ```text
         ~.
         ```

- По сертификату через OS Login {#ssh-cert}

  1. Включите авторизацию по OS Login при подключении к серийной консоли:
     
     ```bash
     yc compute instance update <имя_или_идентификатор_ВМ> \
       --serial-port-settings ssh-authorization=OS_LOGIN \
       --metadata enable-oslogin=true,serial-port-enable=1,ssh-keys='<имя_пользователя>:<публичный_SSH-ключ>'
     ```
     
     Где:
     * `<имя_или_идентификатор_ВМ>` — о том, как узнать имя или идентификатор ВМ, читайте в разделе [Получить информацию о виртуальной машине](../vm-info/get-info.md).
     * `--metadata` — [метаданные](../../concepts/vm-metadata.md) виртуальной машины:
     
         * `ssh-keys` — имя локального пользователя ВМ и содержимое [публичного SSH-ключа](../vm-connect/ssh.md#creating-ssh-keys), с которым этот пользователь сможет подключаться к ВМ по SSH в случае, если доступ по OS Login для этой ВМ позднее будет отключен.
     
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
     
     Подробнее о команде `yc compute instance update` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/instance/update.md).
     
     {% note info %}
     
     Если на уровне организации [включен](../../../organization/operations/os-login-access.md) доступ по OS Login, то для новых ВМ, создаваемых в этой организации, полю `serial_port_settings.ssh_authorization` по умолчанию будет присваиваться значение `OS_LOGIN`. Если доступ по OS Login в организации выключен, этому полю по умолчанию будет присваиваться значение `INSTANCE_METADATA`.
     
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
  1. Подключитесь к серийной консоли виртуальной машины:

      ```bash
      ssh -t \
        -p 9600 \
        -i <путь_к_SSH-сертификату> \
        <идентификатор_ВМ>.<логин_пользователя_OS_Login>.port=1@serialssh.cloud.yandex.net
      ```

      Где:
      * `<путь_к_SSH-сертификату>` — путь к экспортированному ранее SSH-сертификату (`Identity`).
      * `<идентификатор_ВМ>` — идентификатор виртуальной машины.
      * `<имя_пользователя_OS_Login>` — логин пользователя OS Login в организации. Логин пользователя OS Login указан в конце имени экспортированного сертификата после [идентификатора](../../../organization/operations/organization-get-id.md) организации.

          Также логин пользователя можно получить с помощью команды `yc organization-manager os-login profile list` [Yandex Cloud CLI](../../../cli/cli-ref/organization-manager/cli-ref/oslogin/profile/list.md) или в [интерфейсе Cloud Center](https://center.yandex.cloud/organization) в профиле пользователя на вкладке **Профили OS Login**.

          {% note info %}
          
          Минимально необходимая роль, позволяющая просматривать список профилей OS Login пользователей — [роль](../../../organization/security/index.md#organization-manager-osLogins-viewer) `organization-manager.osLogins.viewer`, назначенная на организацию. Информацию о других ролях, позволяющих просматривать список профилей OS Login, см. в разделе [Управление доступом в Yandex Identity Hub](../../../organization/security/index.md#service-roles).

          {% endnote %}

      * `port=1` — номер [последовательного порта](../../concepts/serial-console.md#serial-ports), используемого серийной консолью для подключения к ВМ.

          По умолчанию на ВМ с ОС Linux используется последовательный порт `COM1`. Чтобы использовать другой порт, самостоятельно настройте его на стороне операционной системы вашей виртуальной машины.

      При подключении система может запросить логин и пароль для аутентификации на ВМ. Введите созданные [ранее](#before-you-begin) логин и пароль, после чего вы получите доступ к виртуальной машине.
  1. Завершите работу с серийной консолью:
     
     1. Выйдите из профиля локального пользователя операционной системы:
     
         ```bash
         exit
         ```
     1. Закройте сеанс работы с серийной консолью. Для этого введите следующую последовательность символов:
     
         ```text
         ~.
         ```

{% endlist %}

{% note warning %}

После завершения использования серийной консоли не забудьте [запретить](index.md#disable) доступ к ней.

{% endnote %}

## Подключиться с помощью Yandex Cloud CLI {#connect-with-yc-cli}

{% note alert %}

Для подключения к серийной консоли виртуальной машины по SSH можно использовать только SSH-ключ, не защищенный паролем. В противном случае соединение будет разорвано после ввода пароля.

{% endnote %}

Убедитесь, что на вашем компьютере установлен и настроен интерфейс [Yandex Cloud CLI](../../../cli/index.md).

Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

Дальнейший порядок действий по подключению зависит от того, включен ли для ВМ доступ по [OS Login](../../../organization/concepts/os-login.md). Если для ВМ [включен](../vm-connect/enable-os-login.md) доступ по OS Login, подключение к серийной консоли происходит с использованием короткоживущих SSH-сертификатов. Для подключения к ВМ с выключенным доступом по OS Login используются [SSH-ключи](../../../glossary/ssh-keygen.md).

{% list tabs group=os_login_type %}

- По SSH-ключу {#ssh-key}

  1. Посмотрите описание команды CLI для подключения к серийной консоли:

      ```bash
      yc compute connect-to-serial-port --help
      ```
  1. Включите авторизацию по метаданным при подключении к серийной консоли:
     
     ```bash
     yc compute instance update <имя_или_идентификатор_ВМ> \
       --serial-port-settings ssh-authorization=INSTANCE_METADATA \
       --metadata enable-oslogin=false,serial-port-enable=1,ssh-keys='<имя_пользователя>:<публичный_SSH-ключ>'
     ```
     
     Где:
     * `<имя_или_идентификатор_ВМ>` — о том, как узнать имя или идентификатор ВМ, читайте в разделе [Получить информацию о виртуальной машине](../vm-info/get-info.md).
     * `--metadata` — [метаданные](../../concepts/vm-metadata.md) виртуальной машины:
     
         * `ssh-keys` — имя локального пользователя ВМ и содержимое [публичного SSH-ключа](../vm-connect/ssh.md#creating-ssh-keys), с которым этот пользователь сможет подключаться к ВМ по SSH.
     
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
     
     Подробнее о команде `yc compute instance update` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/instance/update.md).
     
     {% note info %}
     
     Если на уровне организации [включен](../../../organization/operations/os-login-access.md) доступ по OS Login, то для новых ВМ, создаваемых в этой организации, полю `serial_port_settings.ssh_authorization` по умолчанию будет присваиваться значение `OS_LOGIN`. Если доступ по OS Login в организации выключен, этому полю по умолчанию будет присваиваться значение `INSTANCE_METADATA`.
     
     {% endnote %}
  1. Подключитесь к серийной консоли виртуальной машины:

      ```bash
      yc compute connect-to-serial-port \
        --instance-name <имя_ВМ> \
        --ssh-key <путь_к_закрытому_SSH-ключу> \
        --port 1
      ```

      Где:
      * `--instance-name` — имя виртуальной машины. Вместо имени ВМ вы можете передать ее идентификатор в параметре `--instance-id`.
      * `--ssh-key` — путь к закрытому ключу для [SSH-доступа](../../../glossary/ssh-keygen.md) к ВМ, например `~/.ssh/id_ed25519`.
      * `--port` — номер [последовательного порта](../../concepts/serial-console.md#serial-ports), используемого серийной консолью для подключения к ВМ.

          По умолчанию на ВМ с ОС Linux используется последовательный порт `COM1`. Чтобы использовать другой порт, самостоятельно настройте его на стороне операционной системы вашей виртуальной машины.

      При подключении система может запросить логин и пароль для аутентификации на ВМ. Введите созданные ранее логин и пароль, после чего вы получите доступ к виртуальной машине.

      Подробнее о команде `yc compute connect-to-serial-port` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/connect-to-serial-port.md).
  1. Завершите работу с серийной консолью:
     
     1. Выйдите из профиля локального пользователя операционной системы:
     
         ```bash
         exit
         ```
     1. Закройте сеанс работы с серийной консолью. Для этого введите следующую последовательность символов:
     
         ```text
         ~.
         ```

- По сертификату через OS Login {#ssh-cert}

  1. Посмотрите описание команды CLI для подключения к серийной консоли:

      ```bash
      yc compute connect-to-serial-port --help
      ```
  1. Включите авторизацию по OS Login при подключении к серийной консоли:
     
     ```bash
     yc compute instance update <имя_или_идентификатор_ВМ> \
       --serial-port-settings ssh-authorization=OS_LOGIN \
       --metadata enable-oslogin=true,serial-port-enable=1,ssh-keys='<имя_пользователя>:<публичный_SSH-ключ>'
     ```
     
     Где:
     * `<имя_или_идентификатор_ВМ>` — о том, как узнать имя или идентификатор ВМ, читайте в разделе [Получить информацию о виртуальной машине](../vm-info/get-info.md).
     * `--metadata` — [метаданные](../../concepts/vm-metadata.md) виртуальной машины:
     
         * `ssh-keys` — имя локального пользователя ВМ и содержимое [публичного SSH-ключа](../vm-connect/ssh.md#creating-ssh-keys), с которым этот пользователь сможет подключаться к ВМ по SSH в случае, если доступ по OS Login для этой ВМ позднее будет отключен.
     
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
     
     Подробнее о команде `yc compute instance update` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/instance/update.md).
     
     {% note info %}
     
     Если на уровне организации [включен](../../../organization/operations/os-login-access.md) доступ по OS Login, то для новых ВМ, создаваемых в этой организации, полю `serial_port_settings.ssh_authorization` по умолчанию будет присваиваться значение `OS_LOGIN`. Если доступ по OS Login в организации выключен, этому полю по умолчанию будет присваиваться значение `INSTANCE_METADATA`.
     
     {% endnote %}
  1. Подключитесь к серийной консоли виртуальной машины:

      ```bash
      yc compute connect-to-serial-port \
        --instance-name <имя_ВМ> \
        --port 1
      ```

      Где:
      
      * `--instance-name` — имя виртуальной машины. Вместо имени ВМ можно передать ее идентификатор в параметре `--instance-id`.
      * `--port` — номер [последовательного порта](../../concepts/serial-console.md#serial-ports), используемого серийной консолью для подключения к ВМ.

          По умолчанию на ВМ с ОС Linux используется последовательный порт `COM1`. Чтобы использовать другой порт, самостоятельно настройте его на стороне операционной системы вашей виртуальной машины.

      При подключении система может запросить логин и пароль для аутентификации на ВМ. Введите созданные ранее логин и пароль, после чего вы получите доступ к виртуальной машине.

      Подробнее о команде `yc compute connect-to-serial-port` читайте в [справочнике CLI](../../../cli/cli-ref/compute/cli-ref/connect-to-serial-port.md).
  1. Завершите работу с серийной консолью:
     
     1. Выйдите из профиля локального пользователя операционной системы:
     
         ```bash
         exit
         ```
     1. Закройте сеанс работы с серийной консолью. Для этого введите следующую последовательность символов:
     
         ```text
         ~.
         ```

{% endlist %}

{% note warning %}

После завершения использования серийной консоли не забудьте [запретить](index.md#disable) доступ к ней.

{% endnote %}

## Решение проблем при подключении {#troubleshooting-ssh}

* Если после подключения к серийной консоли на экране ничего не отображается:
    * Нажмите на клавиатуре клавишу **Enter**.
    * Перезапустите ВМ (для ВМ, созданных до 22 февраля 2019 года).
* Если при подключении с помощью SSH-ключа возникает ошибка `Warning: remote host identification has changed!`, выполните команду `ssh-keygen -R <IP-адрес_ВМ>`.
* Если при подключении с помощью SSH-сертификата возникает ошибка `Permission denied (publickey).`, убедитесь, что для ВМ включена авторизация по OS Login при подключении к серийной консоли, а сертификат — не просрочен. При необходимости включите для ВМ авторизацию по OS Login при подключении к серийной консоли или повторно экспортируйте SSH-сертификат.
* Если при подключении с помощью SSH-сертификата возникает ошибка `Connection closed by 2a0d:d6c1:0:**::*** port 9600`, на локальной машине откройте файл `known_hosts` и удалите все строки, которые начинаются с `[serialssh.cloud.yandex.net]:9600`. Затем повторите подключение и на вопрос `Are you sure you want to continue connecting (yes/no/[fingerprint])?` ответьте `yes`.

#### См. также {#see-also}

* [Серийная консоль виртуальной машины](../../concepts/serial-console.md)
* [Управлять доступом к серийной консоли](index.md)
* [Подключиться к серийной консоли виртуальной машины с ОС Windows](windows-sac.md)