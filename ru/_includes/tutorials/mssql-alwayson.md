# Развертывание группы доступности Always On 

Сценарий описывает развертывание в {{ yandex-cloud }} группы доступности Always On. При выходе из строя одного или нескольких узлов группы система продолжит функционировать благодаря репликации и аварийному переключению базы данных, работающей на запись — таким образом обеспечивается высокая доступность СУБД. 

Чтобы создать и настроить группу доступности Always On:

1. [Подготовьте облако к работе](#before-begin).
1. [Необходимые платные ресурсы](#paid-resources).
1. [Создайте сетевую инфраструктуру](#prepare-network).
1. [Подготовьте виртуальные машины для группы доступности](#create-vms).
1. [Создайте файл с учетными данными администратора](#prepare-admin-credentials).
1. [Создайте виртуальные машины](#create-group-vms).
1. [Создайте ВМ для бастионного хоста](#create-jump-server).
1. [Создайте ВМ для Active Directory](#create-ad-controller).
1. [Создайте ВМ для сервером MSSQL](#create-ad-server).
1. [Установите и настройте Active Directory](#install-ad).
1. [Создайте пользователей и группы в Active Directory](#install-ad).
1. [Установите и настройте MSSQL](#install-mssql).
1. [Установите MSSQL на серверы баз данных](#mssql-nodes).
1. [Настройте Always On](#configure-always-on).
1. [Протестируйте группу доступности](#test).
1. [Добавьте бастионный хост в домен](#jump-server-domain).
1. [Протестируйте работу базы данных](#test-always-on).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

Перед тем, как разворачивать группу доступности, нужно зарегистрироваться в {{ yandex-cloud }} и создать платежный аккаунт:

{% include [prepare-register-billing](includes/prepare-register-billing.md) %}

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать каталог, в котором будет работать ваша виртуальная машина, на [странице облака](https://console.cloud.yandex.ru/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки группы доступности входят:

* плата за постоянно запущенные виртуальные машины (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование динамических или статических публичных IP-адресов (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).

Вы можете воспользоваться [мобильностью лицензий](../../compute/qa/licensing) и использовать собственную лицензию MSSQL Server в {{ yandex-cloud }}.

## Создайте сетевую инфраструктуру {#prepare-network}

У всех реплик группы будет несколько IP-адресов, трафик на которые будет направляться с помощью [статических маршрутов](../../vpc/concepts/static-routes.md). Подготовьте сетевую инфраструктуру для размещения группы доступности.

1. Создайте сеть с именем `ya-network`:

    {% list tabs %}

    - Консоль управления

       1. Откройте раздел **Virtual Private Cloud** в каталоге, где требуется создать облачную сеть.
       1. Нажмите кнопку **Создать сеть.**
       1. Задайте имя сети: `ya-network`.
       1. Нажмите кнопку **Создать сеть**.

    - Bash 
      
      [Установите](../../cli/operations/install-cli.md) интерфейс командной строки {{ yandex-cloud }}, чтобы использовать команды CLI в Bash. 

      ```
      $ yc vpc network create --name ya-network
      ```

    - PowerShell 

      [Установите](../../cli/operations/install-cli.md) интерфейс командной строки {{ yandex-cloud }}, чтобы использовать команды CLI в PowerShell. 

      ```
      yc vpc network create --name ya-network
      ```

    {% endlist %}

2. Создайте в новой сети таблицу маршрутизации `mssql` и добавьте в нее статические маршруты:

    {% list tabs %}
    
    - Консоль управления

       1. Откройте раздел **Virtual Private Cloud** в каталоге, где требуется создать статический маршрут.
       1. Выберите сеть `ya-network`.
       1. Нажмите кнопку ![image](../../_assets/plus.svg)**Создать таблицу маршрутизации**.
       1. Задайте имя таблицы маршрутизации: `mssql`.
       1. Нажмите кнопку **Добавить маршрут**.
       1. В открывшемся окне введите префикс подсети назначения в нотации CIDR: `10.0.0.20/32`.
       1. Укажите **next hop**: `10.0.0.19`.
       1. Нажмите кнопку **Добавить**.
       1. Добавьте еще пять маршрутов:
          * `10.0.0.21/32`, next hop `10.0.0.19`;
          * `10.0.0.36/32`, next hop `10.0.0.35`;
          * `10.0.0.37/32`, next hop `10.0.0.35`;
          * `10.0.0.52/32`, next hop `10.0.0.51`;
          * `10.0.0.53/32`, next hop `10.0.0.51`.
       1. Нажмите кнопку **Создать таблицу маршрутизации**.

    - Bash

       ```
       $ yc vpc route-table create \
          --name mssql \
          --route destination=10.0.0.20/32,next-hop=10.0.0.19 \
          --route destination=10.0.0.21/32,next-hop=10.0.0.19 \
          --route destination=10.0.0.36/32,next-hop=10.0.0.35 \
          --route destination=10.0.0.37/32,next-hop=10.0.0.35 \
          --route destination=10.0.0.52/32,next-hop=10.0.0.51 \
          --route destination=10.0.0.53/32,next-hop=10.0.0.51 \
          --network-name ya-network
       ```

    - PowerShell

       ```
       yc vpc route-table create `
        --name mssql `
        --route destination=10.0.0.20/32,next-hop=10.0.0.19 `
        --route destination=10.0.0.21/32,next-hop=10.0.0.19 `
        --route destination=10.0.0.36/32,next-hop=10.0.0.35 `
        --route destination=10.0.0.37/32,next-hop=10.0.0.35 `
        --route destination=10.0.0.52/32,next-hop=10.0.0.51 `
        --route destination=10.0.0.53/32,next-hop=10.0.0.51 `
        --network-name ya-network
       ```
    {% endlist %}

3. Создайте подсети, в которых будут размещаться виртуальные машины: 

  * подсеть `ya-subnet-general` для бастионного хоста и ВМ с инсталляцией Active Directory;
  * три подсети для размещения ВМ группы доступности Always On: `ya-subnet-alwayson1`, `ya-subnet-alwayson2` и `ya-subnet-alwayson3`. К каждой из подсетей будет привязана таблица маршрутизации `mssql`.

    {% list tabs %}

    - Консоль управления

      1. Откройте раздел **Virtual Private Cloud** в каталоге, где требуется создать подсети.
      1. Выберите сеть `ya-network`.
      1. Нажмите кнопку **Добавить подсеть**.
      1. Заполните форму: введите имя подсети `ya-subnet-general`, выберите зону доступности `ru-central1-a` из выпадающего списка.
      1. Введите CIDR подсети: IP-адрес и маску подсети: `10.0.0.0/28`.
      1. Нажмите кнопку **Создать подсеть**.

      Повторите шаги для подсетей со следующими именами и CIDR:

      * `ya-subnet-alwayson1` — `10.0.0.16/28`;
      * `ya-subnet-alwayson2` — `10.0.0.32/28`;
      * `ya-subnet-alwayson3` — `10.0.0.48/28`. 
    
      Чтобы использовать статические маршруты, необходимо привязать таблицу маршрутизации к подсети:

      1. В строке нужной подсети нажмите кнопку ![image](../../_assets/options.svg).
      1. В открывшемся меню выберите пункт **Привязать таблицу маршрутизации**.
      1. В открывшемся окне выберите созданную таблицу в списке.
      1. Нажмите кнопку **Добавить**.

    - Bash

      ```
      $ yc vpc subnet create \
         --name ya-subnet-general \
         --network-name ya-network \
         --zone ru-central1-a \
         --route-table-name mssql \
         --range 10.0.0.0/28
      ```

      ```
      $ yc vpc subnet create \
         --name ya-subnet-alwayson1 \
         --network-name ya-network \
         --zone ru-central1-a \
         --route-table-name mssql \
         --range 10.0.0.16/28
      ```

      ```
      $ yc vpc subnet create \
         --name ya-subnet-alwayson2 \
         --network-name ya-network \
         --zone ru-central1-a \
         --route-table-name mssql \
         --range 10.0.0.32/28
      ```

      ```
      $ yc vpc subnet create \
         --name ya-subnet-alwayson3 \
         --network-name ya-network \
         --zone ru-central1-a \
         --route-table-name mssql \
         --range 10.0.0.48/28
      ```

    - PowerShell

      ```
      yc vpc subnet create `
       --name ya-subnet-general `
       --network-name ya-network `
       --zone ru-central1-a `
       --route-table-name mssql `
       --range 10.0.0.0/28
      ```

      ```
      yc vpc subnet create `
       --name ya-subnet-alwayson1 `
       --network-name ya-network `
       --zone ru-central1-a `
       --route-table-name mssql `
       --range 10.0.0.16/28
      ```

      ```
      yc vpc subnet create `
       --name ya-subnet-alwayson2 `
       --network-name ya-network `
       --zone ru-central1-a `
       --route-table-name mssql `
       --range 10.0.0.32/28
      ```

      ```
      yc vpc subnet create `
       --name ya-subnet-alwayson3 `
       --network-name ya-network `
       --zone ru-central1-a `
       --route-table-name mssql `
       --range 10.0.0.48/28
      ```

    {% endlist %}

## Подготовьте виртуальные машины для группы доступности {#create-vms}

### Создайте файл с учетными данными администратора {#prepare-admin-credentials}

Создайте файл `setpass` со скриптом для установки пароля локальной учетной записи администратора. Этот скрипт будет выполняться при создании виртуальных машин через CLI.

{% list tabs %}

- PowerShell

    ```
    #ps1
    Get-LocalUser | Where-Object SID -like *-500 | Set-LocalUser -Password (ConvertTo-SecureString "QWErty123" -AsPlainText -Force)
    ```
{% endlist %}

{% note warning %}

Указанный пароль используется только для тестирования. Используйте собственный сложный пароль при развертывании кластера для работы в продуктовом окружении.

Пароль должен соответствовать [требованиям к сложности](https://docs.microsoft.com/ru-ru/windows/security/threat-protection/security-policy-settings/password-must-meet-complexity-requirements#справочник).

Подробные рекомендации по защите Active Directory читайте на [сайте разработчика](https://docs.microsoft.com/ru-ru/windows-server/identity/ad-ds/plan/security-best-practices/best-practices-for-securing-active-directory).

{% endnote %}

### Создайте виртуальные машины {#create-group-vms}

#### Создайте ВМ для бастионного хоста {#create-jump-server}

Создайте бастионный хост с публичным IP-адресом. Через этот хост будет осуществляться доступ ко всем остальным ВМ:

{% list tabs %}

- Bash

    ```
    $ yc compute instance create \
        --name jump-server-vm \
        --hostname jump-server-vm \
        --memory 4 \
        --cores 2 \
        --zone ru-central1-a \
        --network-interface subnet-name=ya-subnet-general,nat-ip-version=ipv4 \
        --create-boot-disk image-folder-id=standard-images,image-family=windows-2019-gvlk \
        --metadata-from-file user-data=setpass
    ```

- Powershell

    ```
    yc compute instance create `
      --name jump-server-vm `
      --hostname jump-server-vm `
      --memory 4 `
      --cores 2 `
      --zone ru-central1-a `
      --network-interface subnet-name=ya-subnet-general,nat-ip-version=ipv4 `
      --create-boot-disk image-folder-id=standard-images,image-family=windows-2019-gvlk `
      --metadata-from-file user-data=setpass `
    ```

{% endlist %}

#### Создайте ВМ для Active Directory {#create-ad-controller}

Создайте виртуальную машину для установки Active Directory:

{% list tabs %}

- Bash

    ```
    $ yc compute instance create \
       --name ya-ad \
       --hostname ya-ad \
       --zone ru-central1-a \
       --memory 6 \
       --cores 2 \
       --metadata-from-file user-data=setpass \
       --create-boot-disk \
         type=network-nvme,size=50,image-family=windows-2019-gvlk,image-folder-id=standard-images \
       --network-interface \
         subnet-name=ya-subnet-general,ipv4-address=10.0.0.3
    ```

- PowerShell

    ```
    yc compute instance create `
     --name ya-ad `
     --hostname ya-ad `
     --zone ru-central1-a `
     --memory 6 `
     --cores 2 `
     --metadata-from-file user-data=setpass `
     --create-boot-disk `
       type=network-nvme,size=50,image-family=windows-2019-gvlk,image-folder-id=standard-images `
     --network-interface `
       subnet-name=ya-subnet-general,ipv4-address=10.0.0.3
    ```

{% endlist %}

#### Создайте ВМ для серверов MSSQL {#create-ad-server}

Создайте три виртуальных машины для серверов MSSQL:

{% list tabs %}

- Bash

    ```
    $ yc compute instance create \
       --name ya-mssql1 \
       --hostname ya-mssql1 \
       --zone ru-central1-a \
       --memory 16 \
       --cores 4 \
       --metadata-from-file user-data=setpass \
       --create-boot-disk \
         type=network-nvme,size=50,image-family=windows-2019-gvlk,image-folder-id=standard-images \
       --create-disk \
         type=network-nvme,size=200 \
       --network-interface \
         subnet-name=ya-subnet-alwayson1,ipv4-address=10.0.0.19
    ```

    ```
    $ yc compute instance create \
       --name ya-mssql2 \
       --hostname ya-mssql2 \
       --zone ru-central1-a \
       --memory 16 \
       --cores 4 \
       --metadata-from-file user-data=setpass \
       --create-boot-disk \
         type=network-nvme,size=50,image-family=windows-2019-gvlk,image-folder-id=standard-images \
       --create-disk \
         type=network-nvme,size=200 \
       --network-interface \
         subnet-name=ya-subnet-alwayson2,ipv4-address=10.0.0.35
    ```

    ```
    $ yc compute instance create \
       --name ya-mssql3 \
       --hostname ya-mssql3 \
       --zone ru-central1-a \
       --memory 16 \
       --cores 4 \
       --metadata-from-file user-data=setpass \
       --create-boot-disk \
         type=network-nvme,size=50,image-family=windows-2019-gvlk,image-folder-id=standard-images \
       --create-disk \
         type=network-nvme,size=200 \
       --network-interface \
         subnet-name=ya-subnet-alwayson3,ipv4-address=10.0.0.51
    ```

- PowerShell

    ```
    yc compute instance create `
     --name ya-mssql1 `
     --hostname ya-mssql1 `
     --zone ru-central1-a `
     --memory 16 `
     --cores 4 `
     --metadata-from-file user-data=setpass `
     --create-boot-disk `
       type=network-nvme,size=50,image-family=windows-2019-gvlk,image-folder-id=standard-images `
     --create-disk `
       type=network-nvme,size=200 `
     --network-interface `
       subnet-name=ya-subnet-alwayson1,ipv4-address=10.0.0.19
    ```

    ```
    yc compute instance create `
       --name ya-mssql2 `
       --hostname ya-mssql2 `
       --zone ru-central1-a `
       --memory 16 `
       --cores 4 `
       --metadata-from-file user-data=setpass `
       --create-boot-disk `
         type=network-nvme,size=50,image-family=windows-2019-gvlk,image-folder-id=standard-images `
       --create-disk `
         type=network-nvme,size=200 `
       --network-interface `
         subnet-name=ya-subnet-alwayson2,ipv4-address=10.0.0.35
    ```

    ```
    yc compute instance create `
     --name ya-mssql3 `
     --hostname ya-mssql3 `
     --zone ru-central1-a `
     --memory 16 `
     --cores 4 `
     --metadata-from-file user-data=setpass `
     --create-boot-disk `
       type=network-nvme,size=50,image-family=windows-2019-gvlk,image-folder-id=standard-images `
     --create-disk `
       type=network-nvme,size=200 `
     --network-interface `
       subnet-name=ya-subnet-alwayson3,ipv4-address=10.0.0.51
    ```

{% endlist %}

### Установите и настройте Active Directory {#install-ad}

1. Подключитесь к ВМ `jump-server-vm` [с помощью RDP](../../compute/operations/vm-connect/rdp.md). Используйте логин `Administrator` и ваш пароль. 
1. Запустите RDP и подключитесь к виртуальной машине `ya-ad`.
1. Установите необходимые роли сервера. Запустите PowerShell и выполните следующую команду:

   {% list tabs %}

   - PowerShell

       ```
       Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
       ```

   {% endlist %}

1. Создайте лес Active Directory:

    {% list tabs %}

    - PowerShell

       ```
       Install-ADDSForest -DomainName 'yantoso.net' -Force:$true -SafeModeAdministratorPassword ('QWErty123' | ConvertTo-SecureString -AsPlainText -Force)
       ```
       
    {% endlist %}

   После этого ВМ перезапустится. 

1. Снова подключитесь к ВМ `ya-ad`.

1. Переименуйте сайт и добавьте в него созданные подсети:

    {% list tabs %}

    - PowerShell

       ```
       Get-ADReplicationSite 'Default-First-Site-Name' | Rename-ADObject -NewName 'ru-central1-a'
       New-ADReplicationSubnet -Name '10.0.0.0/28'  -Site 'ru-central1-a'
       New-ADReplicationSubnet -Name '10.0.0.16/28' -Site 'ru-central1-a'
       New-ADReplicationSubnet -Name '10.0.0.32/28' -Site 'ru-central1-a'
       New-ADReplicationSubnet -Name '10.0.0.48/28' -Site 'ru-central1-a'
       ```

    {% endlist %}

1. Укажите Forwarder для DNS-сервера:

    {% list tabs %}

    - PowerShell

       ```
       Set-DnsServerForwarder '10.0.0.2'
       ```

    {% endlist %}

1. Укажите адреса DNS-сервера:

    {% list tabs %}

    - PowerShell

       ```
       Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses "10.0.0.3,127.0.0.1"
       ```

    {% endlist %}

### Создайте пользователей и группы в Active Directory {#install-ad}

1. Создайте сервисную учетную запись `mssql-svc`:

    {% list tabs %}

    - PowerShell

       ```
       New-ADUser `
         -Name mssql-svc `
         -AccountPassword ('QWErty123' | ConvertTo-SecureString -AsPlainText -Force) `
         -CannotChangePassword $true `
         -PasswordNeverExpires $true `
         -Enabled $true
       ```

    {% endlist %}

1. Создайте группы для доступа к резервным копиям и серверам баз данных:

    {% list tabs %}

    - PowerShell

       ```
       New-AdGroup mssql-admins-grp -GroupScope:Global
       New-AdGroup mssql-backups-grp -GroupScope:Global
       ```

    {% endlist %} 

1. Добавьте учетную запись `Administrator` во все группы. В группу `mssql-backups-grp` добавьте сервисную учетную запись `mssql-svc`:

    {% list tabs %}

    - PowerShell

       ```
       Add-ADGroupMember mssql-admins-grp -Members Administrator
       Add-ADGroupMember mssql-backups-grp -Members Administrator
       Add-ADGroupMember mssql-backups-grp -Members mssql-svc
       ```

    {% endlist %}

1. Задайте [SPN](https://docs.microsoft.com/en-us/windows/win32/ad/service-principal-names) сервисной учетной записи:

    {% list tabs %}

    - PowerShell

       ```
       setspn -A MSSQLSvc/ya-mssql1.yantoso.net:1433 yantoso\mssql-svc
       setspn -A MSSQLSvc/ya-mssql1.yantoso.net yantoso\mssql-svc

       setspn -A MSSQLSvc/ya-mssql2.yantoso.net:1433 yantoso\mssql-svc
       setspn -A MSSQLSvc/ya-mssql2.yantoso.net yantoso\mssql-svc

       setspn -A MSSQLSvc/ya-mssql3.yantoso.net:1433 yantoso\mssql-svc
       setspn -A MSSQLSvc/ya-mssql3.yantoso.net yantoso\mssql-svc
       ```

    {% endlist %}

### Установите и настройте MSSQL {#install-mssql}

#### Установите MSSQL на серверы баз данных {#mssql-nodes}

1. Дайте ВМ сервера БД доступ в интернет:

    {% list tabs %}

    - Bash

       ```
       $ yc compute instance add-one-to-one-nat ya-mssql1 --network-interface-index 0
       $ yc compute instance add-one-to-one-nat ya-mssql2 --network-interface-index 0
       $ yc compute instance add-one-to-one-nat ya-mssql3 --network-interface-index 0
       ```

    - PowerShell

       ```
       yc compute instance add-one-to-one-nat ya-mssql1 --network-interface-index 0
       yc compute instance add-one-to-one-nat ya-mssql2 --network-interface-index 0
       yc compute instance add-one-to-one-nat ya-mssql3 --network-interface-index 0
       ```

    {% endlist %}

1. Запустите RDP и подключитесь к ВМ `ya-mssql1` с учетной записью `Administrator` и вашим паролем. Используйте публичный IP-адрес ВМ для подключения.
1. Запустите PowerShell и установите роль: 

    {% list tabs %}

    - PowerShell

       ```
       Install-WindowsFeature Failover-Clustering -IncludeManagementTools
       ```

    {% endlist %}

1. Перезагрузите ВМ и снова запустите PowerShell. 

1. Инициализируйте и отформатируйте второй логический диск:

    {% list tabs %}

    - PowerShell

       ```
       Get-Disk | `
       Where-Object PartitionStyle -Eq "RAW" | `
         Initialize-Disk -PassThru -PartitionStyle:GPT | `
           New-Partition -DriveLetter 'X' -UseMaximumSize | `
             Format-Volume `
               -FileSystem:NTFS `
               -AllocationUnitSize:64KB `
               -Force `
               -ShortFileNameSupport $false `
               -Confirm:$false
       ```
    {% endlist %}

    Появится запрос подтверждения форматирования диска. Нажмите кнопку **Format disk**. Нажмите кнопку **Start**. Нажмите кнопку **OK**. 

1. Подготовьте папки для резервного копирования, хранения баз данных, логов и временных файлов:

    {% list tabs %}

    - PowerShell

       ```
       mkdir C:\dist
       mkdir X:\BACKUP
       mkdir X:\TEMPDB
       mkdir X:\TEMPDBLOG
       mkdir X:\DB
       mkdir X:\DBLOG
       ```

    {% endlist %}

1. Загрузите в папку `C:\dist` дистрибутив MSSQL Server из интернета.
1. Установите модуль SqlServer:

    {% list tabs %}

    - PowerShell

       ```
       Install-Module -Name SqlServer
       ```
       
    {% endlist %}

1. Укажите адрес DNS-сервера:

    {% list tabs %}

    - PowerShell

       ```
       Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses "10.0.0.3"
       ```

    {% endlist %}

   Подготовьте данные для доступа к домену:

    {% list tabs %}

    - PowerShell

       ```
       $domain_credential = `
         New-Object System.Management.Automation.PSCredential (
           'yantoso\Administrator', `
           ('QWErty123' | ConvertTo-SecureString -AsPlainText -Force))
       ```
       
    {% endlist %}

   Добавьте сервер БД в домен:

    {% list tabs %}

    - PowerShell

       ```
       Add-Computer -DomainCredential $domain_credential -DomainName 'yantoso.net' -Restart -Force
       ```

    {% endlist %}
   
   ВМ автоматически перезапустится. 

1. После перезагрузки снова подключитесь к ВМ с логином `yantoso\Administrator`, откройте PowerShell.

1. Дайте необходимые права служебной учетной записи. 

    {% list tabs %}

    - PowerShell

       ```
       & secedit /export /cfg sec_conf_export.ini  /areas user_rights

       $secConfig = Get-Content sec_conf_export.ini | Select-Object -SkipLast 3
       $versionSection = Get-Content sec_conf_export.ini | Select-Object -Last 3

       $SID = Get-WmiObject `
         -Class Win32_UserAccount `
         -Filter "name='mssql-svc' and domain='yantoso'" | `
           Select-Object -ExpandProperty SID

       $isSeManageVolumePrivilegeDefined = $secConfig | `
         Select-String SeManageVolumePrivilege

       if ($isSeManageVolumePrivilegeDefined) {
         $secConfig = $secConfig -replace '^SeManageVolumePrivilege .+', "`$0,*$SID"
       } else {
         $secConfig = $secConfig + "SeManageVolumePrivilege = *$SID"
       }

       $isSeLockMemoryPrivilegeDefined = $secConfig | `
         Select-String SeLockMemoryPrivilege

       if ($isSeLockMemoryPrivilegeDefined) {
         $secConfig = $secConfig -replace '^SeLockMemoryPrivilege .+', "`$0,*$SID"
       } else {
         $secConfig = $secConfig + "SeLockMemoryPrivilege = *$SID"
       }

       $secConfig = $secConfig + $versionSection
       $secConfig | Set-Content sec_conf_import.ini

       secedit /configure /db secedit.sdb /cfg sec_conf_import.ini /areas user_rights

       Remove-Item sec_conf_import.ini
       Remove-Item sec_conf_export.ini
       ```

    {% endlist %}

1. Настройте файрвол: 
   
    {% list tabs %}

    - PowerShell

       ```
       New-NetFirewallRule `
        -Group "MSSQL" `
        -DisplayName "MSSQL Server Default" `
        -Name "MSSQLServer-In-TCP" `
        -LocalPort 1433 `
        -Action "Allow" `
        -Protocol "TCP"

       New-NetFirewallRule `
        -Group "MSSQL" `
        -DisplayName "MSSQL AAG Default" `
        -Name "MSSQLAAG-In-TCP" `
        -LocalPort 5022 `
        -Action "Allow" `
        -Protocol "TCP" 
        ```

    {% endlist %}

1. Установите MSSQL. Смонтируйте образ, выполните установку и отсоедините образ:

    {% list tabs %}

    - PowerShell

       ```
       Mount-DiskImage -ImagePath C:\dist\<имя образа MSSQL Server>.iso

       & D:\setup.exe /QUIET /INDICATEPROGRESS /IACCEPTSQLSERVERLICENSETERMS `
         /ACTION=INSTALL /FEATURES=SQLENGINE /INSTANCENAME=MSSQLSERVER `
         /SQLSVCACCOUNT="yantoso\mssql-svc" /SQLSVCPASSWORD="QWErty123" `
         /SQLSYSADMINACCOUNTS="yantoso\mssql-admins-grp" /UpdateEnabled=FALSE `
         /SQLBACKUPDIR="X:\BACKUP" /SQLTEMPDBDIR="X:\TEMPDB" /SQLTEMPDBLOGDIR="X:\TEMPDBLOG" `
         /SQLUSERDBDIR="X:\DB" /SQLUSERDBLOGDIR="X:\DBLOG"

       Dismount-DiskImage -ImagePath C:\dist\<имя образа MSSQL Server>.iso
       ```

    {% endlist %}

1. Повторите шаги 2-13 для ВМ `ya-mssql2` и `ya-mssql3`.

1. Отключите у ВМ доступ в интернет:

    {% list tabs %}

    - Bash

       ```
       $ yc compute instance remove-one-to-one-nat ya-mssql1 --network-interface-index 0
       $ yc compute instance remove-one-to-one-nat ya-mssql2 --network-interface-index 0
       $ yc compute instance remove-one-to-one-nat ya-mssql3 --network-interface-index 0
       ```
    - Powershell

       ```
       yc compute instance remove-one-to-one-nat ya-mssql1 --network-interface-index 0
       yc compute instance remove-one-to-one-nat ya-mssql2 --network-interface-index 0
       yc compute instance remove-one-to-one-nat ya-mssql3 --network-interface-index 0
       ```

    {% endlist %}

### Настройте группу доступности Always On {#configure-always-on}

1. Подключитесь к ВМ `jump-server-vm` с помощью RDP. Используйте логин Administrator и ваш пароль. Откройте RDP и подключитесь к ВМ `ya-mssql1`.
1. Для работы группы доступности Always On требуется настроенный Windows Server Failover Cluster. Для его создания необходимо протестировать все серверы БД:

    {% list tabs %}

    - PowerShell

       ```
       Test-Cluster -Node 'ya-mssql1.yantoso.net'
       Test-Cluster -Node 'ya-mssql2.yantoso.net'
       Test-Cluster -Node 'ya-mssql3.yantoso.net'
       ```

    {% endlist %}

1. Создайте кластер из трех серверов БД:

    {% list tabs %}

    - PowerShell

       ```
       New-Cluster -Name 'wsfc' -Node 'ya-mssql1.yantoso.net', 'ya-mssql2.yantoso.net', 'ya-mssql3.yantoso.net' -NoStorage -StaticAddress 10.0.0.20, 10.0.0.36, 10.0.0.52
       ```

    {% endlist %}

1. Импортируйте команды модуля SqlServer для PowerShell:

    {% list tabs %}

    - PowerShell

       ```
       Import-Module SqlServer
       ```

    {% endlist %}

1. Назначьте служебному пользователю `mssql-svc` разрешения на управление серверами:

    {% list tabs %}

    - PowerShell

       ```
       Add-SqlLogin -Path "SQLSERVER:\SQL\ya-mssql1.yantoso.net\Default" `
         -LoginName "yantoso\mssql-svc" `
         -LoginType "WindowsUser" `
         -Enable `
         -GrantConnectSql

       Add-SqlLogin -Path "SQLSERVER:\SQL\ya-mssql2.yantoso.net\Default" `
         -LoginName "yantoso\mssql-svc" `
         -LoginType "WindowsUser" `
         -Enable `
         -GrantConnectSql

       Add-SqlLogin -Path "SQLSERVER:\SQL\ya-mssql3.yantoso.net\Default" `
         -LoginName "yantoso\mssql-svc" `
         -LoginType "WindowsUser" `
         -Enable `
         -GrantConnectSql

       $mssql1 = Get-Item "SQLSERVER:\SQL\ya-mssql1.yantoso.net\Default"
       $mssql1.Roles['sysadmin'].AddMember('yantoso\mssql-svc')
       $mssql1.Roles['sysadmin'].Alter()

       $mssql2 = Get-Item "SQLSERVER:\SQL\ya-mssql2.yantoso.net\Default"
       $mssql2.Roles['sysadmin'].AddMember('yantoso\mssql-svc')
       $mssql2.Roles['sysadmin'].Alter()

       $mssql3 = Get-Item "SQLSERVER:\SQL\ya-mssql3.yantoso.net\Default"
       $mssql3.Roles['sysadmin'].AddMember('yantoso\mssql-svc')
       $mssql3.Roles['sysadmin'].Alter()
       ```

    {% endlist %}

1. По очереди подключитесь к каждому серверу и включите SqlAlwaysOn. При включении Always On сервис СУБД будет перезапускаться.

    {% list tabs %}

    - PowerShell

       ```
       Enable-SqlAlwaysOn -ServerInstance 'ya-mssql1.yantoso.net' -Force
       Enable-SqlAlwaysOn -ServerInstance 'ya-mssql2.yantoso.net' -Force
       Enable-SqlAlwaysOn -ServerInstance 'ya-mssql3.yantoso.net' -Force
       ```

    {% endlist %}


1. Создайте и запустите [эндпоинты HADR](https://docs.microsoft.com/en-us/powershell/module/sqlps/new-sqlhadrendpoint?view=sqlserver-ps#description):

    {% list tabs %}

    - PowerShell

       ```
       New-SqlHADREndpoint -Port 5022 -Owner sa `
        -Encryption Supported -EncryptionAlgorithm Aes `
        -Name AlwaysonEndpoint `
        -Path "SQLSERVER:\SQL\ya-mssql1.yantoso.net\Default"

       Set-SqlHADREndpoint -Path "SQLSERVER:\SQL\ya-mssql1.yantoso.net\Default\Endpoints\AlwaysonEndpoint" -State Started

       New-SqlHADREndpoint -Port 5022 -Owner sa `
           -Encryption Supported -EncryptionAlgorithm Aes `
           -Name AlwaysonEndpoint `
           -Path "SQLSERVER:\SQL\ya-mssql2.yantoso.net\Default"

       Set-SqlHADREndpoint -Path "SQLSERVER:\SQL\ya-mssql2.yantoso.net\Default\Endpoints\AlwaysonEndpoint" -State Started

       New-SqlHADREndpoint -Port 5022 -Owner sa `
           -Encryption Supported -EncryptionAlgorithm Aes `
           -Name AlwaysonEndpoint `
           -Path "SQLSERVER:\SQL\ya-mssql3.yantoso.net\Default"

       Set-SqlHADREndpoint -Path "SQLSERVER:\SQL\ya-mssql3.yantoso.net\Default\Endpoints\AlwaysonEndpoint" -State Started
       ```

    {% endlist %}

1. Создайте переменные с параметрами реплик. Основной репликой будет выступать `ya-mssql1`, второй и третьей — `ya-mssql2` и `ya-mssql3`. 

    {% list tabs %}

    - PowerShell

       ```
       $PrimaryReplica = New-SqlAvailabilityReplica `
        -Name ya-mssql1 `
        -EndpointUrl "TCP://ya-mssql1.yantoso.net:5022" `
        -FailoverMode "Automatic" `
        -AvailabilityMode "SynchronousCommit" `
        -AsTemplate -Version 13

       $SecondaryReplica = New-SqlAvailabilityReplica `
           -Name ya-mssql2 `
           -EndpointUrl "TCP://ya-mssql2.yantoso.net:5022" `
           -FailoverMode "Automatic" `
           -AvailabilityMode "SynchronousCommit" `
           -AsTemplate -Version 13

       $ThirdReplica = New-SqlAvailabilityReplica `
           -Name ya-mssql3 `
           -EndpointUrl "TCP://ya-mssql3.yantoso.net:5022" `
           -FailoverMode "Automatic" `
           -AvailabilityMode "SynchronousCommit" `
           -AsTemplate -Version 13
       ```

    {% endlist %}

1. Создайте из реплик группу доступности `MyAG` и добавьте туда первый сервер:

    {% list tabs %}

    - PowerShell

       ```
       New-SqlAvailabilityGroup `
           -Name 'MyAG' `
           -AvailabilityReplica @($PrimaryReplica, $SecondaryReplica, $ThirdReplica) `
           -Path "SQLSERVER:\SQL\ya-mssql1.yantoso.net\Default"
        ```

    {% endlist %}

1. Добавьте оставшиеся серверы в группу доступности:

    {% list tabs %}

    - PowerShell

       ```
       Join-SqlAvailabilityGroup -Path "SQLSERVER:\SQL\ya-mssql2.yantoso.net\Default" -Name 'MyAG'
       Join-SqlAvailabilityGroup -Path "SQLSERVER:\SQL\ya-mssql3.yantoso.net\Default" -Name 'MyAG'
       ```

    {% endlist %}

1. Создайте [Listener](https://docs.microsoft.com/en-us/powershell/module/sqlps/new-sqlavailabilitygrouplistener?view=sqlserver-ps#description):

    {% list tabs %}

    - PowerShell

       ```
       New-SqlAvailabilityGroupListener `
         -Name 'MyListener' `
         -Port 1433 `
         -StaticIp @("10.0.0.21/255.255.255.240","10.0.0.37/255.255.255.240","10.0.0.53/255.255.255.240") `
         -Path SQLSERVER:\Sql\ya-mssql1.yantoso.net\Default\AvailabilityGroups\MyAG
       ```

    {% endlist %}

1. Создайте базу данных на сервере `ya-mssql1`:

    {% list tabs %}

    - PowerShell

       ```
       Invoke-Sqlcmd -Query "CREATE DATABASE MyDatabase" -ServerInstance 'ya-mssql1.yantoso.net'
       ```

    {% endlist %}

1. Задайте настройки доступа к папке с резервными копиями на сервере:

    {% list tabs %}

    - PowerShell

       ```
       New-SMBShare -Name SQLBackup -Path "X:\BACKUP" -FullAccess "yantoso\mssql-backups-grp"

       $Acl = Get-Acl "X:\BACKUP"
       $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("yantoso\mssql-backups-grp","Read", "ContainerInherit, ObjectInherit", "None", "Allow")
       $Acl.AddAccessRule($AccessRule)

       $Acl | Set-Acl "X:\BACKUP"
       ```

    {% endlist %}

1. Создайте резервную копию базы `MyDatabase` на ВМ `ya-mssql1`:

    {% list tabs %}

    - PowerShell

       ```
       Backup-SqlDatabase `
           -Database "MyDatabase" -Initialize `
           -BackupFile "MyDatabase.bak" `
           -ServerInstance "ya-mssql1.yantoso.net"

       Backup-SqlDatabase `
           -Database "MyDatabase"  -Initialize `
           -BackupFile "MyDatabase.log" `
           -ServerInstance "ya-mssql1.yantoso.net" `
           -BackupAction Log
       ```

    {% endlist %}

1. Восстановите базу данных на сервере `ya-mssql2` из резервной копии: 

    {% list tabs %}

    - PowerShell

       ```
       Restore-SqlDatabase `
           -Database "MyDatabase" `
           -BackupFile "\\ya-mssql1.yantoso.net\SQLBackup\MyDatabase.bak" `
           -Path "SQLSERVER:\SQL\ya-mssql2.yantoso.net\Default" `
           -NORECOVERY

       Restore-SqlDatabase `
           -Database "MyDatabase" `
           -BackupFile "\\ya-mssql1.yantoso.net\SQLBackup\MyDatabase.log" `
           -Path "SQLSERVER:\SQL\ya-mssql2.yantoso.net\Default" `
           -RestoreAction Log `
           -NORECOVERY
       ```

    {% endlist %}

1. Восстановите базу данных на сервере `ya-mssql3` из резервной копии: 

    {% list tabs %}

    - PowerShell

       ```
       Restore-SqlDatabase `
           -Database "MyDatabase" `
           -BackupFile "\\ya-mssql1.yantoso.net\SQLBackup\MyDatabase.bak" `
           -Path "SQLSERVER:\SQL\ya-mssql3.yantoso.net\Default" `
           -NORECOVERY

       Restore-SqlDatabase `
           -Database "MyDatabase" `
           -BackupFile "\\ya-mssql1.yantoso.net\SQLBackup\MyDatabase.log" `
           -Path "SQLSERVER:\SQL\ya-mssql3.yantoso.net\Default" `
           -RestoreAction Log `
           -NORECOVERY
       ```

    {% endlist %}

1. Добавьте все базы данных в группу доступности:

    {% list tabs %}

    - PowerShell

       ```
       Add-SqlAvailabilityDatabase `
        -Path "SQLSERVER:\SQL\ya-mssql1.yantoso.net\Default\AvailabilityGroups\MyAG" `
        -Database "MyDatabase"

       Add-SqlAvailabilityDatabase `
           -Path "SQLSERVER:\SQL\ya-mssql2.yantoso.net\Default\AvailabilityGroups\MyAG" `
           -Database "MyDatabase"

       Add-SqlAvailabilityDatabase `
           -Path "SQLSERVER:\SQL\ya-mssql3.yantoso.net\Default\AvailabilityGroups\MyAG" `
           -Database "MyDatabase"
       ```

    {% endlist %}

## Протестируйте группу доступности {#test}

### Добавьте бастионный хост в домен {#jump-server-domain}

1. Подключитесь к ВМ `jump-server-vm` с помощью RDP и запустите PowerShell.
1. Укажите ВМ с контроллером домена в качестве DNS-сервера:

    {% list tabs %}

    - PowerShell

       ```
       Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses "10.0.0.3"
       ```
    {% endlist %}

1. Добавьте ВМ в домен: 

    {% list tabs %}

    - PowerShell

       ```
       $domain_credential = `
         New-Object System.Management.Automation.PSCredential (
           'yantoso\Administrator', `
           ('QWErty123' | ConvertTo-SecureString -AsPlainText -Force))

       Add-Computer -DomainCredential $domain_credential -DomainName 'yantoso.net' -Restart -Force
       ```

    {% endlist %}
    
    ВМ автоматически перезагрузится. 

1. После перезагрузки снова подключитесь к ВМ и войдите под учетной записью `yantoso\Administrator`.

### Протестируйте работу базы данных {#test-always-on}

1. Установите PowerShell-модуль `SqlServer`:

    {% list tabs %}

    - PowerShell

       ```
       install-Module -Name SqlServer
       ```

    {% endlist %}

1. Создайте таблицу в реплицируемой БД `MyDatabase`:

    {% list tabs %}

    - PowerShell

       ```
       Invoke-Sqlcmd -ServerInstance 'mylistner.yantoso.net' -Query @"
       CREATE TABLE MyDatabase.dbo.test (
         test_id INT IDENTITY(1,1) PRIMARY KEY,
         test_name VARCHAR(30) NOT NULL
       );
       "@
       ```

    {% endlist %}

1. Добавьте в таблицу БД новую строку:

    {% list tabs %}

    - PowerShell

       ```
       Invoke-Sqlcmd -ServerInstance 'mylistner.yantoso.net' -Query @"
       INSERT INTO MyDatabase.dbo.test (test_name) 
       VALUES ('one')
       "@
       ```

    {% endlist %}

1. Проверьте, появилась ли строка в таблице:

    {% list tabs %}

    - PowerShell

       ```
       Invoke-Sqlcmd -ServerInstance 'mylistner.yantoso.net' -Query "SELECT * FROM MyDatabase.dbo.test"
       ```
       ```
       test_id test_name
       ------- ---------
             1 one
       ```

    {% endlist %}

1. Проверьте имя основной реплики БД:

    {% list tabs %}

    - PowerShell

       ```
       Invoke-Sqlcmd -Query "SELECT @@SERVERNAME" -ServerInstance 'mylistener.yantoso.net'
       ```
       ```
       Column1
       -------
       YA-MSSQL1
       ```

    {% endlist %}


1. Выполните аварийное переключение на вторую реплику:

    {% list tabs %}

    - PowerShell

       ```
       Invoke-Sqlcmd -Query "ALTER AVAILABILITY GROUP MyAg FAILOVER" -ServerInstance 'ya-mssql2.yantoso.net'
       ```

    {% endlist %}

1. Через некоторое время снова проверьте имя основной реплики:

    {% list tabs %}

    - PowerShell

       ```
       Invoke-Sqlcmd -Query "SELECT @@SERVERNAME" -ServerInstance 'mylistener.yantoso.net'
       ```
       ```
       Column1
       -------
       YA-MSSQL2
       ```

    {% endlist %}

1. Добавьте еще одну строку в таблицу, чтобы проверить работу второй реплики на запись:

    {% list tabs %}

    - PowerShell

       ```
       Invoke-Sqlcmd -ServerInstance 'mylistner.yantoso.net' -Query @"
       INSERT INTO MyDatabase.dbo.test (test_name) 
       VALUES ('two')
       "@
       ```

    {% endlist %}

1. Убедитесь, что строка добавлена:

    {% list tabs %}

    - PowerShell

       ```
       Invoke-Sqlcmd -ServerInstance 'mylistner.yantoso.net' -Query "SELECT * FROM MyDatabase.dbo.test"
       ```
       ```
       test_id test_name
       ------- ---------
             1 one
             2 two
       ```

    {% endlist %}

## Удалите созданные ресурсы {#clear-out}

Чтобы перестать платить за развернутые серверы, [удалите](../../compute/operations/vm-control/vm-delete.md) созданные виртуальные машины: 

* `vm-jump-server`; 
* `ya-ad`;
* `ya-mssql1`;
* `ya-mssql2`;
* `ya-mssql3`. 
