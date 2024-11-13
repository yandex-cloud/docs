# Создание кластера Linux-серверов «1С:Предприятия» с кластером {{ mpg-name }}


В {{ yandex-cloud }} вы можете создать кластер {{ mpg-full-name }}, оптимизированный для работы с системой «1С:Предприятие».

Создаваемая инфраструктура «1С:Предприятие» будет состоять из рабочего сервера 1С, сервера лицензий 1С и [кластера {{ mpg-short-name }}](../../managed-postgresql/concepts/index.md).  Серверы 1С будут работать под управлением ОС [CentOS 7](/marketplace/products/yc/centos-7) и не будут иметь выхода в интернет. Доступ к кластеру будет осуществляться через шифрованное [соединение с сервером OpenVPN](../../tutorials/routing/openvpn.md).

Для настройки кластера 1С и проверки работоспособности созданной инфраструктуры на вашем локальном компьютере под управлением ОС Windows (вне {{ yandex-cloud }}) должен быть установлен клиент «1С:Предприятия» с консолью администрирования 1С.

Создание инфраструктуры «1С:Предприятие», описанной в руководстве, проверялось на платформе 1С версии `8.3.25`.

{% note info %}

Для работы с системой «1С:Предприятие» вам понадобится лицензия. Подробная информация о лицензиях и их установке, а также необходимые дистрибутивы доступны на [сайте «1С:Предприятия»](https://its.1c.ru/).

{% endnote %}

Чтобы настроить кластер серверов «1С:Предприятия»:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Настройте VPN для доступа к облачной инфраструктуре](#setup-vpn). 
1. [Создайте виртуальные машины для серверов «1С:Предприятия»](#create-1c-vms).
1. [Создайте кластер {{ mpg-name }}](#create-pg-cluster).
1. [Настройте Samba-сервер на серверах 1С](#set-up-samba).
1. [Настройте серверы «1С:Предприятия»](#setup-1c-server).
1. [Настройте кластер серверов и информационную базу 1С](#setup-cluster).
1. [Подключитесь к информационной базе](#connect-to-infobase).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры «1С:Предприятия» в {{ yandex-cloud }} входит:
* плата за [диски](../../compute/concepts/disk.md) и постоянно запущенные [ВМ](../../compute/concepts/vm.md) (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за постоянно запущенный кластер {{ mpg-name }} (см. [тарифы {{ mpg-name }}](../../managed-postgresql/pricing.md));
* плата за использование статического [публичного IP-адреса](../../vpc/concepts/address.md) (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).

## Настройте VPN для доступа к облачной инфраструктуре {#setup-vpn}

Для безопасного доступа к создаваемой в {{ yandex-cloud }} инфраструктуре «1С:Предприятия» необходимо настроить [VPN](../../glossary/vpn.md). Для решения этой задачи будет использоваться продукт [OpenVPN Access Server](/marketplace/products/yc/openvpn-access-server) и предоставляемый им клиент для ОС Windows.

### Создайте облачную сеть и подсети {#setup-network}

Чтобы создать [облачную сеть](../../vpc/concepts/network.md) с [подсетями](../../vpc/concepts/network.md#subnet) в трех [зонах доступности](../../overview/concepts/geo-scope.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где требуется создать облачную сеть.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. В правом верхнем углу нажмите **{{ ui-key.yacloud.vpc.networks.button_create }}**.
  1. В поле **{{ ui-key.yacloud.vpc.networks.create.field_name }}** укажите имя сети `my-1c-network`.
  1. Включите опцию **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}**.
  1. Нажмите **{{ ui-key.yacloud.vpc.networks.button_create }}**.

{% endlist %}

### Настройте разрешения сетевого трафика {#network-settings}

[Группы безопасности](../../vpc/concepts/security-groups.md) работают как виртуальный брандмауэр для входящего и исходящего трафика. См. подробнее о [группе безопасности по умолчанию](../../vpc/concepts/security-groups.md#default-security-group).
  
Для корректной работы OpenVPN Access Server и кластера {{ mpg-short-name }} [добавьте](../../vpc/operations/security-group-add-rule.md) дополнительные правила в группу безопасности по умолчанию облачной сети `my-1c-network`:

Направление<br>трафика | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}
--- | --- | --- | --- | --- | ---
Входящий | `VPN Server 443` | `443` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Входящий | `VPN Server 1194` | `1194` | `{{ ui-key.yacloud.common.label_udp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Входящий | `Admin Web UI,`</br>`Client Web UI` | `943` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`
Входящий | `{{ mpg-short-name }}` | `6432` | `{{ ui-key.yacloud.common.label_tcp }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0`

### Запустите VPN-сервер {#create-vpn-server}

Создайте ВМ, которая будет работать шлюзом для VPN-подключений:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Зарезервируйте](../../vpc/operations/get-static-ip.md) публичный IP-адрес для вашего VPN-сервера.
  1. На странице [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления]({{ link-console-main }}) нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** в поле **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** введите `OpenVPN Access Server` и выберите публичный образ [OpenVPN Access Server](/marketplace/products/yc/openvpn-access-server).
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), например: `{{ region-id }}-b`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}** выберите [тип диска](../../compute/concepts/disk.md#disks_types) `{{ ui-key.yacloud.compute.value_disk-type-network-hdd }}` и задайте размер `20 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** перейдите на вкладку `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` и укажите необходимую [платформу](../../compute/concepts/vm-platforms.md), количество vCPU и объем RAM:

      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Ice Lake`.
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `2`.
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `100%`.
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `2 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите сеть `my-1c-network` и подсеть, соответствующую выбранной зоне доступности ВМ.
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** выберите `{{ ui-key.yacloud.component.compute.network-select.switch_list }}` и зарезервированный ранее публичный IP-адрес из списка.

          При настройке VPN-сервера используйте только статический публичный IP-адрес. Динамический IP-адрес может измениться после перезагрузки ВМ, и соединения перестанут работать.

      * Поле **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** оставьте пустым. Создаваемой виртуальной машине будет назначена [группа безопасности по умолчанию](../../vpc/concepts/security-groups.md#default-security-group).

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа на ВМ:

      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя, например: `yc-user`. Не используйте имя `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `vpn-server`.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.
  1. Появится окно с информацией о типе тарификации: BYOL (Bring Your Own License). Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

### Получите пароль администратора {#get-admin-password}

{% include [openvpn-get-admin-password](../_tutorials_includes/openvpn-get-admin-password.md) %}

### Активируйте лицензию {#get-license}

{% include [openvpn-activate-license](../_tutorials_includes/openvpn-activate-license.md) %}

### Создайте пользователя OpenVPN {#configure-openvpn}

{% include [openvpn-create-user](../_tutorials_includes/openvpn-create-user.md) %}

### Подключитесь к VPN {#test-vpn}

В панели пользователя можно загрузить клиента [OpenVPN Connect](https://openvpn.net/vpn-client/) для Windows, Linux, MacOS, Android, iOS.

Поскольку в настоящем руководстве рассматривается настройка клиента «1С:Предприятие» в ОС Windows, скачайте и установите на вашем локальном компьютере клиента OpenVPN для Windows:

1. Скачайте дистрибутив для установки:

    * Откройте в браузере панель пользователя по адресу `https://<публичный_IP-адрес_ВМ>/`.
    * Войдите с помощью логина `test-user` и пароля.
    * Скачайте дистрибутив OpenVPN Connect версии 2 или версии 3, нажав на значок Windows.
1. Установите и запустите OpenVPN Connect.
1. VPN-соединение включится автоматически, если в профиле пользователя разрешен автоматический вход.

В приложение можно импортировать новый профиль конфигурации. Для этого укажите адрес `https://<публичный_IP-адрес_ВМ>/` или выберите файл с профилем.

## Создайте виртуальные машины для серверов «1С:Предприятия» {#create-1c-vms}

Лицензия для «1С:Предприятия» должна быть установлена на отдельном сервере, чтобы изменения конфигурации других серверов системы 1С не затрагивали установленную лицензию. На этом этапе вы создадите две виртуальные машины, одна из которых будет выполнять роль сервера «1С:Предприятия», а вторая — роль сервера лицензирования.

Создайте ВМ для сервера «1С:Предприятия»: 

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) в [консоли управления]({{ link-console-main }}) нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_image }}** в поле **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** введите `CentOS 7` и выберите публичный образ [CentOS 7](/marketplace/products/yc/centos-7).
  1. В блоке **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}** выберите [зону доступности](../../overview/concepts/geo-scope.md), в которой расположен ранее созданный VPN-сервер.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}** перейдите на вкладку `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` и укажите необходимую [платформу](../../compute/concepts/vm-platforms.md), количество vCPU и объем RAM:

      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}** — `Intel Ice Lake`.
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}** — `4`.
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}** — `100%`.
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}** — `4 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** выберите сеть `my-1c-network` и подсеть, соответствующую выбранной зоне доступности ВМ.
      * В поле **{{ ui-key.yacloud.component.compute.network-select.field_external }}** оставьте значение `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}`, чтобы назначить ВМ случайный внешний IP-адрес из пула {{ yandex-cloud }}.

          Публичный адрес потребуется виртуальной машине для настройки программного обеспечения. После завершения настройки ПО вы отвяжете публичный IP-адрес от ВМ, а доступ к ней будет осуществляться через сервер OpenVPN.
      * Поле **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}**, оставьте пустым. Создаваемой виртуальной машине будет назначена [группа безопасности по умолчанию](../../vpc/concepts/security-groups.md#default-security-group).

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_access }}** выберите вариант **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** и укажите данные для доступа на ВМ:

      * В поле **{{ ui-key.yacloud.compute.instances.create.field_user }}** введите имя пользователя, например: `yc-user`. Не используйте имя `root` или другие имена, зарезервированные ОС. Для выполнения операций, требующих прав суперпользователя, используйте команду `sudo`.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_base }}** задайте имя ВМ: `server-1c`.
  1. Нажмите кнопку **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

{% endlist %}

Аналогичным образом с теми же параметрами создайте ВМ с именем `licensing-server-1c` для сервера лицензирования.

## Создайте кластер {{ mpg-name }} {#create-pg-cluster}

В {{ yandex-cloud }} можно создать кластер {{ mpg-name }} с настройками, оптимизированными для работы с платформой «1С:Предприятие». Настройки кластера могут варьироваться в зависимости от требований вашего проекта.

Чтобы создать оптимизированный для работы с 1С кластер {{ mpg-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** и выберите **{{ ui-key.yacloud.iam.folder.dashboard.value_managed-postgresql }}**.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}**:

      * В поле **{{ ui-key.yacloud.mdb.forms.base_field_name }}** введите имя кластера: `1c-pg`.
      * В списке **{{ ui-key.yacloud.mdb.forms.base_field_version }}** выберите `15-1c`.

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_resource }}** выберите `s3-c2-m8`. Такой конфигурации будет достаточно для проверки работоспособности решения. Если вы прогнозируете значительную нагрузку на создаваемую базу данных «1С:Предприятия», выберите более производительный класс хоста.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_disk }}** выберите `network-ssd` и укажите размер `114 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_database }}** укажите:

      * **{{ ui-key.yacloud.mdb.forms.database_field_name }}** — `1c-database`.
      * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** — `user1`.
      * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}** – пароль, который вы будете использовать для доступа к базе данных.
      * **{{ ui-key.yacloud.mdb.forms.database_field_lc-collate }}** — `ru_RU.UTF-8`.
      * **{{ ui-key.yacloud.mdb.forms.database_field_lc-ctype }}** — `ru_RU.UTF-8`.

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network }}** выберите сеть `my-1c-network`.

      Поле **{{ ui-key.yacloud.mdb.forms.field_security-group }}**, оставьте пустым. Создаваемому кластеру будет назначена [группа безопасности по умолчанию](../../vpc/concepts/security-groups.md#default-security-group).

  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_host }}** выберите разные зоны доступности для ваших хостов, чтобы обеспечить отказоустойчивость.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_create }}**.

{% endlist %}

Создание кластера БД может занять несколько минут.

## Настройте Samba-сервер на серверах 1С {#set-up-samba}

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к ВМ `server-1c` по SSH.

1. Установите Samba, необходимые зависимости и текстовый редактор `nano`:

    ```bash
    sudo yum install nano samba samba-client samba-common
    ```

1. Отключите работу протокола IPv6, чтобы избежать конфликтов в работе сервера.

    * Откройте файл `/etc/sysctl.conf`:

        ```bash
        sudo nano /etc/sysctl.conf
        ```

        Добавьте в файл `/etc/sysctl.conf` следующие строки:

        ```text
        net.ipv6.conf.all.disable_ipv6 = 1
        net.ipv6.conf.default.disable_ipv6 = 1
        ```

    * Откройте файл `/etc/sysconfig/network`:

        ```bash
        sudo nano /etc/sysconfig/network
        ```

        Добавьте в файл `/etc/sysconfig/network` следующие строки:

        ```text
        NETWORKING_IPv6=no
        HOSTNAME=server-1c
        ```

1. Настройте Samba. Для этого откройте файл конфигурации `/etc/samba/smb.conf`:

    ```bash
    sudo nano /etc/samba/smb.conf
    ```

    Приведите файл к следующему виду:

    ```text
    [global]
            workgroup = WORKGROUP
            server string = Samba Server%v
            netbios name = centos
            security = user
            map to guest = bad user
            dns proxy = no
            passdb backend = tdbsam
            printing = cups
            printcap name = cups
            load printers = yes
            cups iptions = raw
            security = user

    [files]
            path = /1c-files
            browsable = yes
            writable = yes
            guest ok = yes
            read only = no
    ```

1. Создайте общий каталог и назначьте на него необходимые права:

    ```bash
    sudo mkdir /1c-files
    sudo chmod -R 777 /1c-files
    ```

1. Отключите SELinux. Для этого откройте файл конфигурации `/etc/sysconfig/selinux`:

    ```bash
    sudo nano /etc/sysconfig/selinux
    ```

    Измените значение параметра `SELINUX`:

    ```text
    SELINUX=disabled
    ```

1. Добавьте службу сервера Samba в список автозагрузки:

    ```bash
    sudo systemctl enable smb.service
    ```

    Результат:

    ```text
    Created symlink from /etc/systemd/system/multi-user.target.wants/smb.service to /usr/lib/systemd/system/smb.service.
    ```

1. Перезапустите службу сервера Samba:

    ```bash
    sudo systemctl restart smb.service
    ```

Аналогичным образом настройте Samba-сервер на ВМ `licensing-server-1c`.

## Настройте серверы «1С:Предприятия» {#setup-1c-server}

1. Скопируйте дистрибутив сервера «1С:Предприятия» с локального компьютера на ВМ `server-1c`:

    ```bash
    scp <имя_файла> <имя_пользователя>@<публичный_IP-адрес_ВМ>:/1c-files
    ```

    Где:
    * `<имя_файла>` — имя бинарного файла с дистрибутивом. Например: `setup-full-8.3.25.1257-x86_64.run`.
    * `<имя_пользователя>` — имя пользователя ВМ. Например: `yc-user`.
    * `<публичный_IP-адрес_ВМ>` — публичный IP-адрес ВМ с сервером 1С.

1. [Подключитесь](../../compute/operations/vm-connect/ssh.md) к ВМ `server-1c` по SSH.

1. Установите сервер «1С:Предприятия» на ВМ:

    ```bash
    cd /1c-files
    sudo ./<имя_файла> --mode unattended --enable-components server,ws,server_admin
    ```

    Где `<имя_файла>` — имя бинарного файла с дистрибутивом. Например: `setup-full-8.3.25.1257-x86_64.run`.

1. После завершения установки удалите дистрибутив, указав имя бинарного файла с дистрибутивом:

    ```bash
    rm <имя_файла>
    ```

1. Запустите службу сервера 1С и добавьте ее в список автозагрузки:

    ```bash
    sudo ln /opt/1cv8/x86_64/8.3.25.1257/srv1cv8-8.3.25.1257@.service /etc/systemd/system
    sudo systemctl start srv1cv8-8.3.25.1257@.services.service
    sudo systemctl enable srv1cv8-8.3.25.1257@.services.service
    ```

    Результат:

    ```text
    Created symlink from /etc/systemd/system/multi-user.target.wants/srv1cv8-8.3.25.1257@.services.service to /etc/systemd/system/srv1cv8-8.3.25.1257@.service.
    ```

    Путь к файлам установки сервера «1С:Предприятие» зависит от версии установленной платформы 1С. В примере приведены команды для запуска службы сервера «1С:Предприятие» версии `8.3.25`.

1. Убедитесь, что служба сервера «1С:Предприятие» запущена:

    ```bash
    systemctl status -l srv1cv8-8.3.25.1257@.services
    ```

    Результат:

    ```bash
    ● srv1cv8-8.3.25.1257@.services.service - 1C:Enterprise Server 8.3 (8.3.25.1257) (.services)
       Loaded: loaded (/etc/systemd/system/srv1cv8-8.3.25.1257@.service; disabled; vendor preset: disabled)
       Active: active (running) since Thu 2024-07-18 09:09:12 UTC; 6min ago
     Main PID: 16656 (ragent)
       CGroup: /system.slice/system-srv1cv8\x2d8.3.25.1257.slice/srv1cv8-8.3.25.1257@.services.service
               ├─16656 /opt/1cv8/x86_64/8.3.25.1257/ragent -d /home/usr1cv8/.1cv8/1C/1cv8 -port 1540 -regport 1541 -range 1560:1591 -seclev 0 -pingPeriod 1000 -pingTimeout 5000
               ├─16670 /opt/1cv8/x86_64/8.3.25.1257/rmngr -port 1541 -host server-1c.ru-central1.internal -range 1560:1591 -d /home/usr1cv8/.1cv8/1C/1cv8/ -clstid 29361c8c-d4b8-47fd-8b53-43d8349f0e94
               └─16769 /opt/1cv8/x86_64/8.3.25.1257/rphost -range 1560:1591 -reghost server-1c.ru-central1.internal -regport 1541 -pid 43049953-184b-453f-985c-604fb96300ae
    ```

Аналогичным образом настройте сервер 1С на ВМ `licensing-server-1c`.

После завершения настройки обоих серверов 1С [отвяжите публичные IP-адреса](../../compute/operations/vm-control/vm-detach-public-ip.md) от виртуальных машин `server-1c` и `licensing-server-1c`. Дальнейший доступ к серверам 1С будет осуществляться через сервер OpenVPN.

## Настройте кластер серверов и информационную базу 1С {#setup-cluster}

Перед началом работы с системой «1С:Предприятие» настройте роли серверов и добавьте в кластер информационную базу:

1. Запустите консоль администрирования 1С на вашем локальном компьютере с ОС Windows и запущенным клиентом OpenVPN.
1. Добавьте в кластер серверов центральный сервер «1С:Предприятия»:
    1. Правой кнопкой мыши нажмите **Central 1C:Enterprise 8.3 servers** и в открывшемся контекстном меню выберите **Создать** → **Центральный сервер 1С:Предприятия 8.3**. В открывшемся окне:
        1. В поле **Имя** введите внутренний [FQDN](../../glossary/fqdn.md) сервера: `server-1c.{{ region-id }}.internal`.

            Внутренний FQDN ВМ можно узнать в [консоли управления]({{ link-console-main }}) в поле **{{ ui-key.yacloud.compute.instance.overview.label_host }}** на странице ВМ.

        1. Нажмите **OK**.

        В дереве слева отобразится локальный кластер. 

1. Добавьте сервер лицензирования 1С в кластер серверов:
    1. Раскройте вкладку **Кластеры** → **Local cluster**.
    1. Правой кнопкой мыши нажмите **Рабочие серверы** и в открывшемся контекстном меню выберите **Создать** → **Рабочий сервер**.
    1. В открывшемся окне в поле **Компьютер** укажите `licensing-server-1c.{{ region-id }}.internal` и нажмите **OK**.

    Этот сервер будет использоваться для раздачи лицензий другим серверам 1С.

1. Добавьте требования назначения функциональности серверу `licensing-server-1c`:
    1. Раскройте вкладку добавленного сервера `licensing-server-1c.{{ region-id }}.internal`, правой кнопкой мыши нажмите **Требования назначения функциональности** и в открывшемся контекстном меню выберите **Создать** → **Требование назначения функциональности**. В открывшемся окне:
        * В списке **Объект требования** выберите `Любой объект требования`.
        * В списке **Тип требования** выберите `Не назначать`.
        * Остальные параметры оставьте без изменений и нажмите **OK**.

    1. Откройте контекстное меню кластера **Local cluster** и выберите **Применить требования назначения функциональности (полное)**, чтобы применить новое требование назначения к кластеру.
    1. Добавьте еще одно требование назначения функциональности серверу `licensing-server-1c.{{ region-id }}.internal` со следующими параметрами:
        * В списке **Объект требования** выберите `Сервис лицензирования`.
        * В списке **Тип требования** выберите `Назначать`.
        * Остальные параметры оставьте без изменений и нажмите **OK**.

    1. Откройте контекстное меню кластера **Local cluster** и выберите **Применить требования назначения функциональности (полное)**, чтобы применить новое требование назначения к кластеру.

1. Добавьте требования назначения функциональности серверу `server-1c`:
    1. Раскройте вкладку сервера `server-1c.{{ region-id }}.internal`, правой кнопкой мыши нажмите **Требования назначения функциональности** и в открывшемся контекстном меню выберите **Создать** → **Требование назначения функциональности**. В открывшемся окне:
        * В списке **Объект требования** выберите `Клиентское соединение с ИБ`.
        * В списке **Тип требования** выберите `Назначать`.
        * Остальные параметры оставьте без изменений и нажмите **OK**.

    1. Откройте контекстное меню кластера **Local cluster** и выберите **Применить требования назначения функциональности (полное)**, чтобы применить новое требование назначения к кластеру.
    1. Добавьте еще одно требование назначения функциональности серверу `server-1c.{{ region-id }}.internal` со следующими параметрами:
        * В списке **Объект требования** выберите `Сервис лицензирования`.
        * В списке **Тип требования** выберите `Не назначать`.
        * Остальные параметры оставьте без изменений и нажмите **OK**.

    1. Откройте контекстное меню кластера **Local cluster** и выберите **Применить требования назначения функциональности (полное)**, чтобы применить новое требование назначения к кластеру.

1. Правой кнопкой мыши нажмите элемент **Информационные базы** внутри блока элементов **Local cluster** и в открывшемся контекстном меню выберите **Создать** → **Информационная база**. В открывшемся окне укажите:
    * **Имя** — `1c-database`.
    * **Защищенное соединение** — `постоянно`.
    * **Сервер баз данных** — адрес вашего хоста БД и порт. Например, `rc1b-cfazv1db********.{{ dns-zone }} port=6432`.

        Чтобы узнать адрес хоста:

        {% list tabs group=instructions %}

        - Консоль управления {#console}

          * В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога.
          * В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
          * В открывшемся окне выберите созданный ранее кластер `1c-pg`.
          * В меню слева выберите вкладку **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}**.
          * В поле **{{ ui-key.yacloud.mdb.cluster.hosts.host_column_name }}** подведите курсор к имени хоста (вида `rc1b-cfazv1db********`) и скопируйте полное доменное имя базы данных, нажав появившийся значок ![copy](../../_assets/copy.svg). К имени хоста добавится полное доменное имя, в результате в поле **Сервер баз данных** должно быть указано имя вида `rc1c-cfazv1db********.{{ dns-zone }} port=6432`.

        {% endlist %}

    * **Тип СУБД** — `{{ PG }}`.
    * **База данных** — имя базы данных, `1c-database`.
    * **Пользователь сервера БД** — `user1`.
    * **Пароль пользователя БД** — пароль пользователя, который вы задали при создании кластера.
    * **Разрешить выдачу лицензий сервером 1С:Предприятия** — `Да`.
    * **Язык (Страна)** — `русский (Россия)`.
    * **Создать базу данных в случае ее отсутствия** — отключено.
    * **Установить блокировку регламентных заданий** — отключено.

   Нажмите **ОК**.

## Подключитесь к информационной базе {#connect-to-infobase}

1. Запустите клиент «1С:Предприятия» на вашем локальном компьютере с ОС Windows и запущенным клиентом OpenVPN.
1. Нажмите кнопку **Добавить**.
1. Выберите **Добавление в список существующей информационной базы** и нажмите **Далее**.
1. Введите имя информационной базы, выберите **На сервере 1С:Предприятия** и задайте следующие настройки:
    * **Кластер серверов** — `server-1c.{{ region-id }}.internal`.
    * **Имя информационной базы** — `1c-database`.

1. Нажмите **Далее**.
1. Нажмите **Готово**.

Информационная база должна появиться в списке баз. После этого вы можете приступить к ее конфигурированию и использованию.

## Удалите созданные ресурсы {#clear-out}

Чтобы перестать платить за развернутую инфраструктуру:
1. [Удалите](../../compute/operations/vm-control/vm-delete.md) ВМ `server-1c`, `licensing-server-1c` и `vpn-server`.
1. [Удалите](../../managed-postgresql/operations/cluster-delete.md) кластер `1c-pg`.
1. [Удалите](../../vpc/operations/address-delete.md) публичный статический IP-адрес.