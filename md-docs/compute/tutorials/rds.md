# Развертывание Microsoft Remote Desktop Services


{% note warning %}

В Yandex Cloud продукты Microsoft можно использовать только с вашими собственными лицензиями и только на выделенных хостах. Подробнее см. [Использование своей лицензии для продуктов Microsoft](../../microsoft/byol.md).

{% endnote %}



В сценарии описывается развертывание Microsoft Windows Server Datacenter с предустановленной службой Remote Desktop Services в Yandex Cloud. Инсталляция Microsoft Windows Server with Remote Desktop Services будет состоять из одного сервера, на котором будут установлены службы Remote Desktop Services и Active Directory. Образы представлены с подготовленными квотами на 5, 10, 25, 50 и 100 пользователей. Выберите версию с необходимой квотой. Все примеры приводятся для сервера с квотой на 5 пользователей.

{% note warning %}

Для увеличения квоты необходимо пересоздать ВМ.

{% endnote %}

Чтобы развернуть инфраструктуру Remote Desktop Services:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте облачную сеть и подсети](#create-network).
1. [Создайте скрипт для управления локальной учетной записью администратора](#admin-script).
1. [Создайте ВМ для Remote Desktop Services](#add-vm).
1. [Установите и настройте службу контроллера домена (Active Directory)](#install-ad).
1. [Настройте правила файрвола](#firewall).
1. [Настройте сервер лицензирования в домене](#license-server).
1. [Настройте роль Remote Desktop Session Host](#rdsh).
1. [Создайте пользователей](#create-users).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

{% note info %}

Проверьте, что в платежном аккаунте указаны пользовательские данные, [необходимые для выполнения требований лицензионной политики Microsoft](../../microsoft/check-user-data.md). Без этих данных вы не сможете запустить продукт.

{% endnote %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость инсталляции Microsoft Windows Server with Remote Desktop Services входят:

* плата за постоянно запущенные виртуальные машины (см. [тарифы Yandex Compute Cloud](../pricing.md));
* плата за использование динамических или статических публичных IP-адресов (см. [тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md));
* стоимость исходящего трафика из Yandex Cloud в интернет (см. [тарифы Yandex Compute Cloud](../pricing.md)).

## Создайте облачную сеть и подсети {#create-network}

Создайте облачную сеть `my-network` с подсетями во всех зонах доступности, где будут находиться виртуальные машины.

1. Создайте облачную сеть:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     Чтобы создать [облачную сеть](../../vpc/concepts/network.md):
     1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором будет создана облачная сеть.
     1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Virtual Private Cloud**.
     1. Нажмите кнопку **Создать сеть**
     1. Задайте имя сети: `my-network`.
     1. Нажмите кнопку **Создать сеть**.

   - CLI {#cli}

     Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).
  
     По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа. 

     Чтобы создать облачную сеть, выполните команду:

     ```
     yc vpc network create --name my-network
     ```

   - API {#api}

     Воспользуйтесь методом REST API [create](../../vpc/api-ref/Network/create.md) для ресурса [Network](../../vpc/api-ref/Network/index.md) или вызовом gRPC API [NetworkService/Create](../../vpc/api-ref/grpc/Network/create.md).

   {% endlist %}

2. Создайте подсеть в сети `my-network`:

   {% list tabs group=instructions %}

     - Консоль управления {#console}

       Чтобы создать подсеть:
       1. Откройте раздел **Virtual Private Cloud** в каталоге, где требуется создать подсеть.
       1. Нажмите на имя облачной сети.
       1. Нажмите кнопку **Добавить подсеть**.
       1. Заполните форму: введите имя подсети `my-subnet-d`, выберите зону доступности `ru-central1-d` из выпадающего списка.
       1. Введите CIDR подсети: IP-адрес и маску подсети: `10.1.0.0/16`. Подробнее про диапазоны IP-адресов в подсетях читайте в разделе [Облачные сети и подсети](../../vpc/concepts/network.md).
       1. Нажмите кнопку **Создать подсеть**.

     - CLI {#cli}

       Чтобы создать подсеть, выполните команду:

       ```
       yc vpc subnet create \
         --name my-subnet-d \
         --zone ru-central1-d \
         --network-name my-network \
         --range 10.1.0.0/16
       ```
     
     - API {#api}

       Воспользуйтесь методом REST API [create](../../vpc/api-ref/Subnet/create.md) для ресурса [Subnet](../../vpc/api-ref/Subnet/index.md) или вызовом gRPC API [SubnetService/Create](../../vpc/api-ref/grpc/Subnet/create.md).

   {% endlist %}


## Создайте скрипт для управления локальной учетной записью администратора {#admin-script}

Создайте файл `setpass`, содержащий скрипт, который будет устанавливать пароль для локальной учетной записи администратора при создании виртуальных машин через CLI:

{% list tabs group=programming_language %}

- PowerShell {#powershell}

    ```
    #ps1
    Get-LocalUser | Where-Object SID -like *-500 | Set-LocalUser -Password (ConvertTo-SecureString "<ваш пароль>" -AsPlainText -Force)
    ```
{% endlist %}

Пароль должен соответствовать [требованиям к сложности](https://docs.microsoft.com/ru-ru/windows/security/threat-protection/security-policy-settings/password-must-meet-complexity-requirements#справочные-материалы).

Подробные рекомендации по защите Active Directory читайте на [сайте разработчика](https://docs.microsoft.com/ru-ru/windows-server/identity/ad-ds/plan/security-best-practices/best-practices-for-securing-active-directory).

## Создайте ВМ для Windows Server with Remote Desktop Services {#add-vm}

Создайте виртуальную машину для Windows Server with Remote Desktop Services. Эта машина будет иметь доступ в интернет.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице каталога в [консоли управления](https://console.yandex.cloud) нажмите кнопку **Создать ресурс** и выберите `Виртуальная машина`.
  1. В блоке **Образ загрузочного диска** в поле **Поиск продукта** введите `RDS` и выберите подходящий образ [RDS](https://yandex.cloud/ru/marketplace?tab=software&search=windows+rds): 
  1. В блоке **Расположение** выберите [зону доступности](../../overview/concepts/geo-scope.md) `ru-central1-d`.
  1. В блоке **Диски и файловые хранилища** задайте размер загрузочного [диска](../concepts/disk.md) `50 ГБ`.
  1. В блоке **Вычислительные ресурсы** перейдите на вкладку `Своя конфигурация` и укажите необходимую [платформу](../concepts/vm-platforms.md), количество vCPU и объем RAM:

      * **Платформа** — `Intel Ice Lake`.
      * **vCPU** — `4`.
      * **Гарантированная доля vCPU** — `100%`.
      * **RAM** — `8 ГБ`.
  1. В блоке **Сетевые настройки** укажите:

      * **Подсеть** — сеть `my-network` и подсеть `my-subnet-d`.
      * **Публичный IP-адрес** — `Автоматически`.
  1. В блоке **Общая информация** задайте имя ВМ: `my-rds-vm`.
  1. Нажмите кнопку **Создать ВМ**.

  Дождитесь, когда статус ВМ сменится на `Running`, и сбросьте пароль:
  
  1. Выберите виртуальную машину.
  1. Нажмите кнопку **Сбросить пароль**.
  1. Укажите **Имя пользователя**, для которого нужно сбросить пароль. Если у ВМ не существует пользователя с таким именем, он будет создан с правами администратора.
  1. Нажмите кнопку **Сгенерировать пароль**.
  1. Сохраните **Новый пароль**. После закрытия окна он будет недоступен.

- CLI {#cli}

  ```
   yc compute instance create \
     --name my-rds-vm \
     --hostname my-rds-vm \
     --memory 8 \
     --cores 4 \
     --zone ru-central1-d \
     --network-interface subnet-name=my-subnet-d,ipv4-address=10.1.0.3,nat-ip-version=ipv4 \
     --create-boot-disk image-folder-id=standard-images,image-family=windows-2022-dc-gvlk-rds-5 \
     --metadata-from-file user-data=setpass
  ```

  {% note info %}
  
  Команды [`yc compute instance create`](../../cli/cli-ref/compute/cli-ref/instance/create.md) | [`create-with-container`](../../cli/cli-ref/compute/cli-ref/instance/create-with-container.md) | [`update`](../../cli/cli-ref/compute/cli-ref/instance/update.md) | [`add-metadata`](../../cli/cli-ref/compute/cli-ref/instance/add-metadata.md) поддерживают подстановку в метаданные ВМ значений переменных окружения. Эти значения, заданные в ключе `user-data` в формате `$<имя_переменной>`, в момент выполнения команды Yandex Cloud CLI будут подставлены в метаданные ВМ из переменных окружения среды, в которой выполняется команда. 
  
  Чтобы изменить такое поведение, не подставлять значение переменной из среды выполнения команды CLI и передать в метаданные ВМ имя переменной в формате `$<имя_переменной>`, используйте синтаксис с двумя символами доллара. Например: `$$<имя_переменной>`.
  
  Подробнее см. в разделе [Особенности передачи переменных окружения в метаданных через CLI](../concepts/metadata/sending-metadata.md#environment-variables).
  
  {% endnote %}

- API {#api}

  Воспользуйтесь методом REST API [create](../api-ref/Instance/create.md) для ресурса [Instance](../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Create](../api-ref/grpc/Instance/create.md).

{% endlist %}

## Установите и настройте службу контроллера домена (Active Directory) {#install-ad}

1. Перезапустите ВМ `my-rds-vm`:

   {% list tabs group=instructions %}
   
   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором будет создана прерываемая ВМ.
     1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Compute Cloud**.
     1. Выберите виртуальную машину `my-rds-vm`.
     1. Нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **Перезапустить**.
   
   - CLI {#cli}
   
     ```
     yc compute instance restart my-rds-vm
     ```
   
   - API {#api}
   
     Воспользуйтесь методом REST API [restart](../api-ref/Instance/restart.md) для ресурса [Instance](../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Restart](../api-ref/grpc/Instance/restart.md).
   
   {% endlist %}

1. Подключитесь к ВМ `my-rds-vm` с [помощью RDP](../operations/vm-connect/rdp.md). Используйте логин `Administrator` и ваш пароль.
1. Установите роли Active Directory:

    {% list tabs group=programming_language %}
    
    - PowerShell {#powershell}

        ```powershell
        Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
        Restart-Computer -Force
        ```
      
    {% endlist %}

1. Создайте лес Active Directory:

    {% list tabs group=programming_language %}
    
    - PowerShell {#powershell}

        ```powershell
        Install-ADDSForest -DomainName 'yantoso.net' -Force:$true
        ```
      
    {% endlist %}

   Windows перезапустится автоматически. Снова подключитесь к ВМ `my-rds-vm`. Используйте логин `yantoso\Administrator` и ваш пароль. Снова откройте PowerShell.

## Настройте правила файрвола {#firewall}

1. Добавьте правила файрвола, защищающие службу Active Directory от запросов из внешних сетей:
    
    {% list tabs group=programming_language %}
    
    - PowerShell {#powershell}

        ```powershell
        Set-NetFirewallRule `
          -DisplayName 'Active Directory Domain Controller - LDAP (UDP-In)' `
          -RemoteAddress:Intranet
        
        Set-NetFirewallRule `
          -DisplayName 'Active Directory Domain Controller - LDAP (TCP-In)' `
          -RemoteAddress:Intranet
        
        Set-NetFirewallRule `
          -DisplayName 'Active Directory Domain Controller - Secure LDAP (TCP-In)' `
          -RemoteAddress:Intranet
        ```
      
    {% endlist %}

## Настройте сервер лицензирования в домене {#license-server}

1. Добавьте системного пользователя Network Service в Terminal Server License Servers, группу безопасности Active Directory:
    
    {% list tabs group=programming_language %}
    
    - PowerShell {#powershell}

        ```powershell
        net localgroup "Terminal Server License Servers" /Add 'Network Service'
        ```
      
    {% endlist %}
   
1. Установите тип лицензирования.
    
    {% note info %}
    
    Доступны только `User CAL` лицензии.
    
    {% endnote %}

    {% list tabs group=programming_language %}
    
    - PowerShell {#powershell}

        ```powershell
        New-ItemProperty `
        -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services' `
        -Name 'LicensingMode' `
        -Value 4 `
        -PropertyType 'DWord'
        ```
      
    {% endlist %}
    
1. Укажите службу лицензирования RDS:

    {% list tabs group=programming_language %}
    
    - PowerShell {#powershell}

        ```powershell
        New-ItemProperty `
        -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services' `
        -Name 'LicenseServers' `
        -Value 'localhost' `
        -PropertyType 'String'
        ```
      
    {% endlist %}

1. (Опционально) Ограничьте количество разрешенных одновременных сессий к серверу:

    {% list tabs group=programming_language %}
    
    - PowerShell {#powershell}
        
      ```powershell
      New-ItemProperty `
      -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services' `
      -Name 'MaxInstanceCount' `
      -Value 5 `
      -PropertyType 'DWord'
      ```
   
    {% endlist %}

## Настройте роль Remote Desktop Session Host {#rdsh}

Установите роль Remote Desktop Session Host на сервер:

{% list tabs group=programming_language %}

- PowerShell {#powershell}

    ```powershell
    Install-WindowsFeature RDS-RD-Server -IncludeManagementTools
    Restart-Computer -Force
    ```

{% endlist %}


## Добавьте сервер в группу безопасности AD и зарегистрируйте его как SCP {#ad-sg-scp}

Добавьте сервер в Terminal Server License Servers, группу безопасности Active Directory, и зарегистрируйте его как точку подключения пользователей к сервису лицензирования (service connection point, SCP):

{% list tabs group=operating_system %}

- Windows Server {#windows}

  1. Нажмите **Start**.
  1. В поле поиска введите `Remote Desktop Licensing Manager`.
  1. Нажмите правой кнопкой мыши на сервер в списке и выберите **Review Configuration...**
  1. Напротив первого предупреждения, о группе `Terminal Server License Servers`, нажмите **Add to Group**, а затем — **Continue**.
  1. Напротив второго предупреждения, о точке подключения к сервису, нажмите **Register as SCP**.
  1. Нажмите **OK**.
  1. Перезапустите ВМ.

{% endlist %}


## Создайте пользователей {#create-users}

1. Создайте тестовых пользователей:

    {% list tabs group=programming_language %}
    
    - PowerShell {#powershell}
    
        ```powershell
        New-ADUser `
          -Name ru1 `
          -PasswordNeverExpires $true `
          -Enabled $true `
          -AccountPassword ("P@ssw0rd!1" | ConvertTo-SecureString -AsPlainText -Force )
        New-ADUser `
          -Name ru2 `
          -PasswordNeverExpires $true `
          -Enabled $true `
          -AccountPassword ("P@ssw0rd!1" | ConvertTo-SecureString -AsPlainText -Force )
        New-ADUser `
          -Name ru3 `
          -PasswordNeverExpires $true `
          -Enabled $true `
          -AccountPassword ("P@ssw0rd!1" | ConvertTo-SecureString -AsPlainText -Force )
        New-ADUser `
          -Name ru4 `
          -PasswordNeverExpires $true `
          -Enabled $true `
          -AccountPassword ("P@ssw0rd!1" | ConvertTo-SecureString -AsPlainText -Force )
        New-ADUser `
          -Name ru5 `
          -PasswordNeverExpires $true `
          -Enabled $true `
          -AccountPassword ("P@ssw0rd!1" | ConvertTo-SecureString -AsPlainText -Force )
        ```
      
    {% endlist %}

1. Выдайте пользователям права `Remote Desktop Users`:

    {% list tabs group=programming_language %}
    
    - PowerShell {#powershell}

        ```powershell
        Add-ADGroupMember -Members 'ru1' -Identity 'Remote Desktop Users'
        Add-ADGroupMember -Members 'ru2' -Identity 'Remote Desktop Users'
        Add-ADGroupMember -Members 'ru3' -Identity 'Remote Desktop Users'
        Add-ADGroupMember -Members 'ru4' -Identity 'Remote Desktop Users'
        Add-ADGroupMember -Members 'ru5' -Identity 'Remote Desktop Users'
        ```

    {% endlist %}

1. Настройте права доступа по RDP для группы `Remote Desktop Users`:

    {% list tabs group=programming_language %}
    
    - PowerShell {#powershell}
    
        ```powershell
        & secedit /export /cfg sec_conf_export.ini  /areas user_rights
        $secConfig = Get-Content sec_conf_export.ini
        $SID = 'S-1-5-32-555'
        $secConfig = $secConfig -replace '^SeRemoteInteractiveLogonRight .+', "`$0,*$SID"
        $secConfig | Set-Content sec_conf_import.ini
        & secedit /configure /db secedit.sdb /cfg sec_conf_import.ini /areas user_rights
        Remove-Item sec_conf_import.ini
        Remove-Item sec_conf_export.ini
        ```
      
    {% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Если вам больше не нужны созданные ресурсы, удалите [виртуальные машины](../operations/vm-control/vm-delete.md) и [сети](../../vpc/operations/network-delete.md).