# Развертывание группы доступности Always On 

При выходе из строя одного или нескольких узлов группы система продолжит функционировать благодаря репликации и аварийному переключению базы данных, работающей на запись — таким образом обеспечивается высокая доступность СУБД. 

Чтобы создать и настроить группу доступности Always On:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте сетевую инфраструктуру](#prepare-network).
1. [Подготовьте виртуальные машины для группы доступности](#create-vms).
1. [Протестируйте группу доступности](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% include [ms-additional-data-note](../includes/ms-additional-data-note.md) %}

{% if product == "yandex-cloud" %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки группы доступности входят:

* плата за постоянно запущенные виртуальные машины (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование динамического или статического публичного IP-адреса (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md)).

Вы можете воспользоваться [перемещением лицензий](../../compute/qa/licensing) и использовать собственную лицензию MSSQL Server в {{ yandex-cloud }}.

{% endif %}

## Создайте сетевую инфраструктуру {#prepare-network}

У всех реплик группы будет несколько IP-адресов, трафик на которые будет направляться с помощью [статических маршрутов](../../vpc/concepts/static-routes.md).

Подготовьте сетевую инфраструктуру для размещения группы доступности:

1. Создайте сеть с именем `ya-network`:

    {% list tabs %}

    - Консоль управления

       1. Откройте раздел **Virtual Private Cloud** в каталоге, где требуется создать облачную сеть.
       1. Нажмите кнопку **Создать сеть.**
       1. Задайте имя сети: `ya-network`.
       1. Выключите опцию **Создать подсети**.
       1. Нажмите кнопку **Создать сеть**.

    - Bash 
      
      {% include [cli-install](../../_includes/cli-install.md) %}
  
      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      ```bash
      yc vpc network create --name ya-network
      ```

    - PowerShell 

      [Установите](../../cli/operations/install-cli.md) интерфейс командной строки {{ yandex-cloud }}, чтобы использовать команды CLI в PowerShell. 

      ```powershell
      yc vpc network create --name ya-network
      ```

    {% endlist %}

1. Создайте в новой сети таблицу маршрутизации `mssql` со статическими маршрутами:

    {% list tabs %}
    
    - Консоль управления

       1. Откройте раздел **Virtual Private Cloud** в каталоге, где требуется создать статический маршрут.
       1. Выберите сеть `ya-network`.
       1. Перейдите в раздел **Таблицы маршрутизации**.
       1. Нажмите кнопку **Создать таблицу маршрутизации**.
       1. Задайте имя таблицы маршрутизации: `mssql`.
       1. Нажмите кнопку **Добавить маршрут**.
       1. В открывшемся окне введите префикс подсети назначения в нотации CIDR: `10.0.0.20/32`.
       1. Укажите **Next hop**: `10.0.0.19`.
       1. Нажмите кнопку **Добавить**.
       1. Добавьте еще пять маршрутов:
          * `10.0.0.21/32`, next hop `10.0.0.19`;
          * `10.0.0.36/32`, next hop `10.0.0.35`;
          * `10.0.0.37/32`, next hop `10.0.0.35`;
          * `10.0.0.52/32`, next hop `10.0.0.51`;
          * `10.0.0.53/32`, next hop `10.0.0.51`.
       1. Нажмите кнопку **Создать таблицу маршрутизации**.

    - Bash

       ```bash
       yc vpc route-table create \
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

       ```powershell
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

1. Создайте подсети, в которых будут размещаться виртуальные машины: 

    * подсеть `ya-subnet-general` для бастионного хоста и ВМ с инсталляцией Active Directory;
    * три подсети для размещения ВМ группы доступности Always On: `ya-subnet-alwayson1`, `ya-subnet-alwayson2` и `ya-subnet-alwayson3`. К каждой из подсетей будет привязана таблица маршрутизации `mssql`.

    {% list tabs %}

    - Консоль управления

      1. Откройте раздел **Virtual Private Cloud** в каталоге, где требуется создать подсети.
      1. Выберите сеть `ya-network`.
      1. Нажмите кнопку ![image](../../_assets/plus.svg)**Добавить подсеть**.
      1. Заполните форму: введите имя подсети `ya-subnet-general`, выберите зону доступности `{{ region-id }}-a` из выпадающего списка.
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
      1. Нажмите кнопку **Привязать**.

    - Bash

      ```bash
      yc vpc subnet create \
         --name ya-subnet-general \
         --network-name ya-network \
         --zone {{ region-id }}-a \
         --route-table-name mssql \
         --range 10.0.0.0/28
      ```

      ```bash
      yc vpc subnet create \
         --name ya-subnet-alwayson1 \
         --network-name ya-network \
         --zone {{ region-id }}-a \
         --route-table-name mssql \
         --range 10.0.0.16/28
      ```

      ```bash
      yc vpc subnet create \
         --name ya-subnet-alwayson2 \
         --network-name ya-network \
         --zone {{ region-id }}-a \
         --route-table-name mssql \
         --range 10.0.0.32/28
      ```

      ```bash
      yc vpc subnet create \
         --name ya-subnet-alwayson3 \
         --network-name ya-network \
         --zone {{ region-id }}-a \
         --route-table-name mssql \
         --range 10.0.0.48/28
      ```

    - PowerShell

      ```powershell
      yc vpc subnet create `
         --name ya-subnet-general `
         --network-name ya-network `
         --zone {{ region-id }}-a `
         --route-table-name mssql `
         --range 10.0.0.0/28
      ```

      ```powershell
      yc vpc subnet create `
         --name ya-subnet-alwayson1 `
         --network-name ya-network `
         --zone {{ region-id }}-a `
         --route-table-name mssql `
         --range 10.0.0.16/28
      ```

      ```powershell
      yc vpc subnet create `
         --name ya-subnet-alwayson2 `
         --network-name ya-network `
         --zone {{ region-id }}-a `
         --route-table-name mssql `
         --range 10.0.0.32/28
      ```

      ```powershell
      yc vpc subnet create `
         --name ya-subnet-alwayson3 `
         --network-name ya-network `
         --zone {{ region-id }}-a `
         --route-table-name mssql `
         --range 10.0.0.48/28
      ```

    {% endlist %}

## Подготовьте виртуальные машины для группы доступности {#create-vms}

### Создайте файл с учетными данными администратора {#prepare-admin-credentials}

Создайте файл `setpass` со скриптом для установки пароля локальной учетной записи администратора. Этот скрипт будет выполняться при создании виртуальных машин через CLI.

{% note info %}

Файл `setpass` должен быть в кодировке UTF-8.

{% endnote %}

{% list tabs %}

- Bash

  ```bash
  touch ~/setpass
  ```
  
  ```bash
  echo '#ps1' >> ~/setpass
  ```
  
  ```bash
  echo 'Get-LocalUser | Where-Object SID -like *-500 | Set-LocalUser -Password (ConvertTo-SecureString "YaQWErty123" -AsPlainText -Force)' >> ~/setpass
  cd
  ```

- PowerShell

  ```powershell
  ni ~/setpass
  ```
  
  ```powershell
  echo '#ps1' >> ~/setpass
  ```
  
  ```powershell
  echo 'Get-LocalUser | Where-Object SID -like *-500 | Set-LocalUser -Password (ConvertTo-SecureString "YaQWErty123" -AsPlainText -Force)' >> ~/setpass
  ```

{% endlist %}

{% note warning %}

Указанный пароль используется только для тестирования. Используйте собственный сложный пароль при развертывании кластера для работы в продуктовом окружении.

Пароль должен соответствовать [требованиям к сложности]({{ ms.docs }}/windows/security/threat-protection/security-policy-settings/password-must-meet-complexity-requirements#справочник).

Подробные рекомендации по защите Active Directory читайте на [сайте разработчика]({{ ms.docs }}/windows-server/identity/ad-ds/plan/security-best-practices/best-practices-for-securing-active-directory).

{% endnote %}

### Создайте виртуальные машины {#create-group-vms}

#### Создайте ВМ для бастионного хоста {#create-jump-server}

Создайте бастионный хост с ОС [Windows Server 2019 Datacenter](/marketplace/products/yc/windows-server-2019-datacenter) из {{ marketplace-name }} с публичным IP-адресом для доступа к остальным ВМ:

{% list tabs %}

- Bash

    ```bash
    yc compute instance create \
        --name jump-server-vm \
        --hostname jump-server-vm \
        --memory 4 \
        --cores 2 \
        --zone {{ region-id }}-a \
        --network-interface subnet-name=ya-subnet-general,nat-ip-version=ipv4 \
        --create-boot-disk image-folder-id=standard-images,image-family=windows-2019-gvlk \
        --metadata-from-file user-data=setpass
    ```

- PowerShell

    ```powershell
    yc compute instance create `
      --name jump-server-vm `
      --hostname jump-server-vm `
      --memory 4 `
      --cores 2 `
      --zone {{ region-id }}-a `
      --network-interface subnet-name=ya-subnet-general,nat-ip-version=ipv4 `
      --create-boot-disk image-folder-id=standard-images,image-family=windows-2019-gvlk `
      --metadata-from-file user-data=setpass
    ```

{% endlist %}

#### Создайте ВМ для Active Directory {#create-ad-controller}

Создайте виртуальную машину с ОС [Windows Server 2019 Datacenter](/marketplace/products/yc/windows-server-2019-datacenter) из {{ marketplace-name }} для установки Active Directory:

{% list tabs %}

- Bash

    ```bash
    yc compute instance create \
       --name ya-ad \
       --hostname ya-ad \
       --zone {{ region-id }}-a \
       --memory 6 \
       --cores 2 \
       --metadata-from-file user-data=setpass \
       --create-boot-disk \
         type=network-ssd,size=50,image-family=windows-2019-gvlk,image-folder-id=standard-images \
       --network-interface \
         subnet-name=ya-subnet-general,ipv4-address=10.0.0.3
    ```

- PowerShell

    ```powershell
    yc compute instance create `
       --name ya-ad `
       --hostname ya-ad `
       --zone {{ region-id }}-a `
       --memory 6 `
       --cores 2 `
       --metadata-from-file user-data=setpass `
       --create-boot-disk `
         type=network-ssd,size=50,image-family=windows-2019-gvlk,image-folder-id=standard-images `
       --network-interface `
         subnet-name=ya-subnet-general,ipv4-address=10.0.0.3
    ```

{% endlist %}

#### Создайте ВМ для серверов MSSQL {#create-ad-server}

Создайте три виртуальные машины с ОС [Windows Server 2019 Datacenter](/marketplace/products/yc/windows-server-2019-datacenter) из {{ marketplace-name }} для серверов MSSQL:

{% list tabs %}

- Bash

    ```bash
    yc compute instance create \
       --name ya-mssql1 \
       --hostname ya-mssql1 \
       --zone {{ region-id }}-a \
       --memory 16 \
       --cores 4 \
       --metadata-from-file user-data=setpass \
       --create-boot-disk \
         type=network-ssd,size=50,image-family=windows-2019-gvlk,image-folder-id=standard-images \
       --create-disk \
         type=network-ssd,size=200 \
       --network-interface \
         subnet-name=ya-subnet-alwayson1,ipv4-address=10.0.0.19
    ```

    ```
    yc compute instance create \
       --name ya-mssql2 \
       --hostname ya-mssql2 \
       --zone {{ region-id }}-a \
       --memory 16 \
       --cores 4 \
       --metadata-from-file user-data=setpass \
       --create-boot-disk \
         type=network-ssd,size=50,image-family=windows-2019-gvlk,image-folder-id=standard-images \
       --create-disk \
         type=network-ssd,size=200 \
       --network-interface \
         subnet-name=ya-subnet-alwayson2,ipv4-address=10.0.0.35
    ```

    ```
    yc compute instance create \
       --name ya-mssql3 \
       --hostname ya-mssql3 \
       --zone {{ region-id }}-a \
       --memory 16 \
       --cores 4 \
       --metadata-from-file user-data=setpass \
       --create-boot-disk \
         type=network-ssd,size=50,image-family=windows-2019-gvlk,image-folder-id=standard-images \
       --create-disk \
         type=network-ssd,size=200 \
       --network-interface \
         subnet-name=ya-subnet-alwayson3,ipv4-address=10.0.0.51
    ```

- PowerShell

    ```powershell
    yc compute instance create `
     --name ya-mssql1 `
     --hostname ya-mssql1 `
     --zone {{ region-id }}-a `
     --memory 16 `
     --cores 4 `
     --metadata-from-file user-data=setpass `
     --create-boot-disk `
       type=network-ssd,size=50,image-family=windows-2019-gvlk,image-folder-id=standard-images `
     --create-disk `
       type=network-ssd,size=200 `
     --network-interface `
       subnet-name=ya-subnet-alwayson1,ipv4-address=10.0.0.19
    ```

    ```powershell
    yc compute instance create `
       --name ya-mssql2 `
       --hostname ya-mssql2 `
       --zone {{ region-id }}-a `
       --memory 16 `
       --cores 4 `
       --metadata-from-file user-data=setpass `
       --create-boot-disk `
         type=network-ssd,size=50,image-family=windows-2019-gvlk,image-folder-id=standard-images `
       --create-disk `
         type=network-ssd,size=200 `
       --network-interface `
         subnet-name=ya-subnet-alwayson2,ipv4-address=10.0.0.35
    ```

    ```powershell
    yc compute instance create `
     --name ya-mssql3 `
     --hostname ya-mssql3 `
     --zone {{ region-id }}-a `
     --memory 16 `
     --cores 4 `
     --metadata-from-file user-data=setpass `
     --create-boot-disk `
       type=network-ssd,size=50,image-family=windows-2019-gvlk,image-folder-id=standard-images `
     --create-disk `
       type=network-ssd,size=200 `
     --network-interface `
       subnet-name=ya-subnet-alwayson3,ipv4-address=10.0.0.51
    ```

{% endlist %}

### Установите и настройте Active Directory {#install-ad}

1. Подключитесь к ВМ `jump-server-vm` [с помощью RDP](../compute/operations/vm-connect/rdp.md). Используйте логин `Administrator` и ваш пароль. 
1. С ВМ `jump-server-vm` подключитесь к ВМ `ya-ad` с помощью RDP и той же учетной записи.
1. На ВМ `ya-ad` запустите PowerShell и установите необходимые роли сервера:

   {% list tabs %}

   - PowerShell

       ```powershell
       Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
       ```

   {% endlist %}

1. Создайте лес Active Directory:

    {% list tabs %}

    - PowerShell

       ```powershell
       Install-ADDSForest -DomainName 'yantoso.net' -Force:$true -SafeModeAdministratorPassword ('QWErty123' | ConvertTo-SecureString -AsPlainText -Force)
       ```
       
    {% endlist %}

   После этого ВМ перезапустится. 

1. Снова подключитесь к ВМ `ya-ad` и запустите PowerShell.

1. Переименуйте сайт и добавьте в него созданные подсети:

    {% list tabs %}

    - PowerShell

       ```powershell
       Get-ADReplicationSite 'Default-First-Site-Name' | Rename-ADObject -NewName '{{ region-id }}-a'
       New-ADReplicationSubnet -Name '10.0.0.0/28'  -Site '{{ region-id }}-a'
       New-ADReplicationSubnet -Name '10.0.0.16/28' -Site '{{ region-id }}-a'
       New-ADReplicationSubnet -Name '10.0.0.32/28' -Site '{{ region-id }}-a'
       New-ADReplicationSubnet -Name '10.0.0.48/28' -Site '{{ region-id }}-a'
       ```

    {% endlist %}

1. Укажите Forwarder для DNS-сервера:

    {% list tabs %}

    - PowerShell

       ```powershell
       Set-DnsServerForwarder '10.0.0.2'
       ```

    {% endlist %}

1. Укажите адреса DNS-сервера:

    {% list tabs %}

    - PowerShell

       ```powershell
       Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses "10.0.0.3,127.0.0.1"
       ```

    {% endlist %}

### Создайте пользователей и группы в Active Directory {#create-ad-users-groups}

1. Подключитесь к ВМ `jump-server-vm` [с помощью RDP](../compute/operations/vm-connect/rdp.md). Используйте логин `Administrator` и ваш пароль.

1. С ВМ `jump-server-vm` подключитесь к ВМ `ya-ad` с помощью RDP и той же учетной записи.

1. На ВМ `ya-ad` запустите PowerShell и создайте сервисную учетную запись `mssql-svc`:

    {% list tabs %}

    - PowerShell

       ```powershell
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

       ```powershell
       New-AdGroup mssql-admins-grp -GroupScope:Global
       New-AdGroup mssql-backups-grp -GroupScope:Global
       ```

    {% endlist %} 

1. Добавьте учетную запись `Administrator` во все группы. В группу `mssql-backups-grp` добавьте сервисную учетную запись `mssql-svc`:

    {% list tabs %}

    - PowerShell

       ```powershell
       Add-ADGroupMember mssql-admins-grp -Members Administrator
       Add-ADGroupMember mssql-backups-grp -Members Administrator
       Add-ADGroupMember mssql-backups-grp -Members mssql-svc
       ```

    {% endlist %}

1. Задайте [SPN](https://docs.microsoft.com/en-us/windows/win32/ad/service-principal-names) сервисной учетной записи:

    {% list tabs %}

    - PowerShell

       ```powershell
       setspn -A MSSQLSvc/ya-mssql1.yantoso.net:1433 yantoso\mssql-svc
       setspn -A MSSQLSvc/ya-mssql1.yantoso.net yantoso\mssql-svc

       setspn -A MSSQLSvc/ya-mssql2.yantoso.net:1433 yantoso\mssql-svc
       setspn -A MSSQLSvc/ya-mssql2.yantoso.net yantoso\mssql-svc

       setspn -A MSSQLSvc/ya-mssql3.yantoso.net:1433 yantoso\mssql-svc
       setspn -A MSSQLSvc/ya-mssql3.yantoso.net yantoso\mssql-svc
       ```

    {% endlist %}

### Установите и настройте MSSQL {#install-mssql}

Установите MSSQL на серверы баз данных:

1. Настройте на ВМ с серверами БД доступ в интернет:

    {% list tabs %}

    - Bash

       ```bash
       yc compute instance add-one-to-one-nat ya-mssql1 --network-interface-index 0
       yc compute instance add-one-to-one-nat ya-mssql2 --network-interface-index 0
       yc compute instance add-one-to-one-nat ya-mssql3 --network-interface-index 0
       ```

    - PowerShell

       ```powershell
       yc compute instance add-one-to-one-nat ya-mssql1 --network-interface-index 0
       yc compute instance add-one-to-one-nat ya-mssql2 --network-interface-index 0
       yc compute instance add-one-to-one-nat ya-mssql3 --network-interface-index 0
       ```

    {% endlist %}

1. Запустите RDP и подключитесь к ВМ `ya-mssql1` с учетной записью `Administrator` и вашим паролем. Используйте публичный IP-адрес ВМ для подключения.
1. Запустите PowerShell и установите роль: 

    {% list tabs %}

    - PowerShell

       ```powershell
       Install-WindowsFeature Failover-Clustering -IncludeManagementTools
       ```

    {% endlist %}

1. [Перезапустите ВМ](../../compute/operations/vm-control/vm-stop-and-start.md/#restart).

1. Снова подключитесь к ВМ `ya-mssql1` и запустите PowerShell. 

1. Инициализируйте и отформатируйте второй логический диск:

    {% list tabs %}

    - PowerShell

       ```powershell
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

    Появится запрос подтверждения форматирования диска. Нажмите кнопку **Format disk**. Нажмите кнопку **Start**. Нажмите кнопку **OK**. После завершения форматирования нажмите кнопку **OK** и закройте окно настройки форматирования.

1. Подготовьте папки для дистрибутива, резервного копирования, хранения баз данных, логов и временных файлов:

    {% list tabs %}

    - PowerShell

       ```powershell
       mkdir C:\dist
       mkdir X:\BACKUP
       mkdir X:\DB
       mkdir X:\DBLOG
       mkdir X:\TEMPDB
       mkdir X:\TEMPDBLOG
       ```

    {% endlist %}

1. Загрузите в папку `C:\dist` англоязычный образ MSSQL Server 2019 из интернета.

1. Установите модуль SqlServer:

    {% list tabs %}

    - PowerShell

       ```powershell
       Install-Module -Name SqlServer
       ```
       
    {% endlist %}

1. При запросе подтверждения установки введите `y`.

1. Импортируйте команды модуля SqlServer для PowerShell:

    {% list tabs %}

    - PowerShell

      ```powershell
      Import-Module SQLServer
      ```

    {% endlist %} 

1. Укажите адрес DNS-сервера:

    {% list tabs %}

    - PowerShell

       ```powershell
       Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses "10.0.0.3"
       ```

    {% endlist %}

   Подготовьте данные для доступа к домену:

    {% list tabs %}

    - PowerShell

       ```powershell
       $domain_credential = `
         New-Object System.Management.Automation.PSCredential (
           'yantoso\Administrator', `
           ('QWErty123' | ConvertTo-SecureString -AsPlainText -Force))
       ```
       
    {% endlist %}

1. Перезапустите ВМ и снова подключитесь к ВМ с логином `Administrator`.

1. Запустите PowerShell и добавьте сервер БД в домен:

    {% list tabs %}

    - PowerShell

       ```powershell
       Add-Computer -DomainCredential $domain_credential -DomainName 'yantoso.net' -Restart -Force
       ```

    {% endlist %}
   
   При запросе авторизации укажите логин `Administrator` и пароль из файла `setpass`.

   ВМ автоматически перезапустится. 

1. После перезапуска снова подключитесь к ВМ с логином `yantoso\Administrator`.

1. Запустите PowerShell и настройте необходимые права служебной учетной записи:

    {% list tabs %}

    - PowerShell

       ```powershell
       & secedit /export /cfg sec_conf_export.ini /areas user_rights

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

       ```powershell
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

       ```powershell
       Mount-DiskImage -ImagePath C:\dist\<имя образа MSSQL Server>.iso
       ```

       ```powershell
       & D:\setup.exe /QUIET /INDICATEPROGRESS /IACCEPTSQLSERVERLICENSETERMS `
         /ACTION=INSTALL /FEATURES=SQLENGINE /INSTANCENAME=MSSQLSERVER `
         /SQLSVCACCOUNT="yantoso\mssql-svc" /SQLSVCPASSWORD="QWErty123" `
         /SQLSYSADMINACCOUNTS="yantoso\mssql-admins-grp" /UpdateEnabled=FALSE `
         /SQLBACKUPDIR="X:\BACKUP" /SQLTEMPDBDIR="X:\TEMPDB" /SQLTEMPDBLOGDIR="X:\TEMPDBLOG" `
         /SQLUSERDBDIR="X:\DB" /SQLUSERDBLOGDIR="X:\DBLOG"
       ```

       ```powershell
       Dismount-DiskImage -ImagePath C:\dist\<имя образа MSSQL Server>.iso
       ```

    {% endlist %}

1. Повторите шаги 2-16 для ВМ `ya-mssql2` и `ya-mssql3`.

1. Отключите у ВМ доступ в интернет:

    {% list tabs %}

    - Bash

       ```bash
       yc compute instance remove-one-to-one-nat ya-mssql1 --network-interface-index 0
       yc compute instance remove-one-to-one-nat ya-mssql2 --network-interface-index 0
       yc compute instance remove-one-to-one-nat ya-mssql3 --network-interface-index 0
       ```

    - PowerShell

       ```powershell
       yc compute instance remove-one-to-one-nat ya-mssql1 --network-interface-index 0
       yc compute instance remove-one-to-one-nat ya-mssql2 --network-interface-index 0
       yc compute instance remove-one-to-one-nat ya-mssql3 --network-interface-index 0
       ```

    {% endlist %}

### Настройте группу доступности Always On {#configure-always-on}

1. Подключитесь к ВМ `jump-server-vm` с [помощью RDP](../compute/operations/vm-connect/rdp.md). Используйте логин `Administrator` и ваш пароль.
1. С ВМ `jump-server-vm` подключитесь к ВМ `ya-mssql1` с помощью RDP и той же учетной записи.
1. Для работы группы доступности Always On требуется настроенный Windows Server Failover Cluster. Для его создания необходимо протестировать серверы БД. На любой из ВМ кластера выполните:

    {% list tabs %}

    - PowerShell

       ```powershell
       Test-Cluster -Node 'ya-mssql1.yantoso.net'
       Test-Cluster -Node 'ya-mssql2.yantoso.net'
       Test-Cluster -Node 'ya-mssql3.yantoso.net'
       ```

    {% endlist %}

1. Создайте кластер из трех серверов БД:

    {% list tabs %}

    - PowerShell

       ```powershell
       New-Cluster -Name 'wsfc' -Node 'ya-mssql1.yantoso.net', 'ya-mssql2.yantoso.net', 'ya-mssql3.yantoso.net' -NoStorage -StaticAddress 10.0.0.20, 10.0.0.36, 10.0.0.52
       ```

    {% endlist %}

1. Назначьте служебному пользователю `mssql-svc` разрешения на управление серверами:

    {% list tabs %}

    - PowerShell

       ```powershell
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

1. По очереди подключитесь к каждому серверу и включите SqlAlwaysOn:

    {% list tabs %}

    - PowerShell

       ```powershell
       Enable-SqlAlwaysOn -ServerInstance 'ya-mssql1.yantoso.net' -Force
       Enable-SqlAlwaysOn -ServerInstance 'ya-mssql2.yantoso.net' -Force
       Enable-SqlAlwaysOn -ServerInstance 'ya-mssql3.yantoso.net' -Force
       ```

    {% endlist %}

   При включении Always On сервис СУБД будет перезапускаться.

1. Создайте и запустите [эндпоинты HADR](https://docs.microsoft.com/en-us/powershell/module/sqlps/new-sqlhadrendpoint?view=sqlserver-ps#description):

    {% list tabs %}

    - PowerShell

       ```powershell
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

       ```powershell
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

       ```powershell
       New-SqlAvailabilityGroup `
           -Name 'MyAG' `
           -AvailabilityReplica @($PrimaryReplica, $SecondaryReplica, $ThirdReplica) `
           -Path "SQLSERVER:\SQL\ya-mssql1.yantoso.net\Default"
        ```

    {% endlist %}

1. Перезапустите ВМ `ya-mssql2` и `ya-mssql3`.

1. Добавьте оставшиеся серверы в группу доступности:

    {% list tabs %}

    - PowerShell

       ```powershell
       Join-SqlAvailabilityGroup -Path "SQLSERVER:\SQL\ya-mssql2.yantoso.net\Default" -Name 'MyAG'
       Join-SqlAvailabilityGroup -Path "SQLSERVER:\SQL\ya-mssql3.yantoso.net\Default" -Name 'MyAG'
       ```

    {% endlist %}

1. Создайте [Listener](https://docs.microsoft.com/en-us/powershell/module/sqlps/new-sqlavailabilitygrouplistener?view=sqlserver-ps#description):

    {% list tabs %}

    - PowerShell

       ```powershell
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

       ```powershell
       Invoke-Sqlcmd -Query "CREATE DATABASE MyDatabase" -ServerInstance 'ya-mssql1.yantoso.net'
       ```

    {% endlist %}

1. Задайте настройки доступа к папке с резервными копиями на сервере:

    {% list tabs %}

    - PowerShell

       ```powershell
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

       ```powershell
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

       ```powershell
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

       ```powershell
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

       ```powershell
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

       ```powershell
       Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses "10.0.0.3"
       ```

    {% endlist %}

1. Добавьте ВМ в домен: 

    {% list tabs %}

    - PowerShell

       ```powershell
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

1. Создайте таблицу в реплицируемой БД `MyDatabase`:

    {% list tabs %}

    - PowerShell

       ```powershell
       Invoke-Sqlcmd -ServerInstance 'mylistener.yantoso.net' -Query @"
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

       ```powershell
       Invoke-Sqlcmd -ServerInstance 'mylistener.yantoso.net' -Query @"
       INSERT INTO MyDatabase.dbo.test (test_name) 
       VALUES ('one')
       "@
       ```

    {% endlist %}

1. Проверьте, появилась ли строка в таблице:

    {% list tabs %}

    - PowerShell

       ```powershell
       Invoke-Sqlcmd -ServerInstance 'mylistener.yantoso.net' -Query "SELECT * FROM MyDatabase.dbo.test"
       ```

       Результат:
       ```powershell
       test_id test_name
       ------- ---------
             1 one
       ```

    {% endlist %}

1. Проверьте имя основной реплики БД:

    {% list tabs %}

    - PowerShell

       ```powershell
       Invoke-Sqlcmd -Query "SELECT @@SERVERNAME" -ServerInstance 'mylistener.yantoso.net'
       ```
       
      Результат:
      ```powershell
       Column1
       -------
       YA-MSSQL1
       ```

    {% endlist %}


1. Выполните аварийное переключение на вторую реплику:

    {% list tabs %}

    - PowerShell

       ```powershell
       Invoke-Sqlcmd -Query "ALTER AVAILABILITY GROUP MyAg FAILOVER" -ServerInstance 'ya-mssql2.yantoso.net'
       ```

    {% endlist %}

1. Снова проверьте имя основной реплики:

    {% list tabs %}

    - PowerShell

       ```powershell
       Invoke-Sqlcmd -Query "SELECT @@SERVERNAME" -ServerInstance 'mylistener.yantoso.net'
       ```

       Результат:
       ```powershell
       Column1
       -------
       YA-MSSQL2
       ```

    {% endlist %}

1. Добавьте еще одну строку в таблицу, чтобы проверить работу второй реплики на запись:

    {% list tabs %}

    - PowerShell

       ```powershell
       Invoke-Sqlcmd -ServerInstance 'mylistener.yantoso.net' -Query @"
       INSERT INTO MyDatabase.dbo.test (test_name) 
       VALUES ('two')
       "@
       ```

    {% endlist %}

1. Убедитесь, что строка добавлена:

    {% list tabs %}

    - PowerShell

       ```powershell
       Invoke-Sqlcmd -ServerInstance 'mylistener.yantoso.net' -Query "SELECT * FROM MyDatabase.dbo.test"
       ```

       Результат:
       ```powershell
       test_id test_name
       ------- ---------
             1 one
             2 two
       ```

    {% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы, [удалите](../../compute/operations/vm-control/vm-delete.md) их: 

* `jump-server-vm`;
* `ya-ad`;
* `ya-mssql1`;
* `ya-mssql2`;
* `ya-mssql3`.
