# Развертывание группы доступности Always On с внутренним сетевым балансировщиком

Сценарий описывает развертывание в {{ yandex-cloud }} группы доступности Always On с балансировкой нагрузки между узлами с помощью внутреннего сетевого балансировщика. Несколько подсетей будут объединены в одну общую подсеть путем настройки сетевых интерфейсов. Благодаря этому не потребуется использование [Multisubnet Failover]({{ ms.docs }}/sql/sql-server/failover-clusters/windows/sql-server-multi-subnet-clustering-sql-server?view=sql-server-ver15). Основной IP-адрес будет назначаться реплике, в которую ведется запись. У этой же реплики будет открыт порт, на который балансировщик будет направлять трафик. Поскольку порт, указанный для подключения к балансировщику, становится недоступным, для приема трафика будет использоваться дополнительный нестандартный порт.

Чтобы создать и настроить группу доступности Always On с внутренним сетевым балансировщиком:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте сетевую инфраструктуру](#prepare-network).
1. [Создайте внутренний сетевой балансировщик](#create-load-balancer).
1. [Подготовьте виртуальные машины для группы доступности](#create-vms).
1. [Протестируйте группу доступности](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](./_tutorials_includes/before-you-begin.md) %}

{% if product == "yandex-cloud" %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки группы доступности входят:

* плата за постоянно запущенную виртуальную машину (см. [тарифы {{ compute-full-name }}](../compute/pricing.md));
* плата за использование сетевого балансировщика (см. [тарифы {{ network-load-balancer-full-name }}](../network-load-balancer/pricing.md));
* плата за использование динамического или статического публичного IP-адреса (см. [тарифы {{ vpc-full-name }}](../vpc/pricing.md)).

Вы можете воспользоваться [мобильностью лицензий](../compute/qa/licensing.md) и использовать собственную лицензию MSSQL Server в {{ yandex-cloud }}.

{% endif %}

## Создайте сетевую инфраструктуру {#prepare-network}

Подготовьте сетевую инфраструктуру для размещения группы доступности.

1. Создайте сеть с именем `ya-network`:

    {% list tabs %}

    - Консоль управления

       1. Откройте раздел **Virtual Private Cloud** в каталоге, где требуется создать облачную сеть.
       1. Нажмите кнопку **Создать сеть.**
       1. Задайте имя сети: `ya-network`.
       1. Нажмите кнопку **Создать сеть**.

    - Bash 
      
	  {% include [cli-install](../_includes/cli-install.md) %}
  
      {% include [default-catalogue](../_includes/default-catalogue.md) %}

      ```
      yc vpc network create --name ya-network
      ```

    - PowerShell 

      [Установите](../cli/operations/install-cli.md) интерфейс командной строки {{ yandex-cloud }}, чтобы использовать команды CLI в PowerShell. 

      ```
	  yc vpc network create --name ya-network
      ```

    {% endlist %}

1. Создайте подсети, в которых будут размещаться виртуальные машины и сетевой балансировщик: 

   * Три подсети для размещения ВМ SQLServer: `ya-sqlserver-rc1a`, `ya-sqlserver-rc1b` и `ya-sqlserver-rc1c`. К каждой подсети будет привязана таблица маршрутизации `mssql`.
   * Подсеть `ya-ilb-rc1a` для сетевого балансировщика.
   * Подсеть `ya-ad-rc1a` для Active Directory.


    {% list tabs %}

    - Консоль управления

      1. Откройте раздел **Virtual Private Cloud** в каталоге, где требуется создать подсети.
      1. Выберите сеть `ya-network`.
      1. Нажмите кнопку ![image](../_assets/plus.svg)**Добавить подсеть**.
      1. Заполните форму: введите имя подсети `ya-sqlserver-rc1a`, выберите зону доступности `{{ region-id }}-a` из выпадающего списка.
      1. Введите CIDR подсети: IP-адрес и маску подсети: `192.168.1.0/28`.
      1. Нажмите кнопку **Создать подсеть**.

      Повторите шаги для подсетей со следующими именами и CIDR:

      * `ya-sqlserver-rc1b` в зоне доступности `{{ region-id }}-b` — `192.168.1.16/28`;
      * `ya-sqlserver-rc1c` в зоне доступности `{{ region-id }}-c` — `192.168.1.32/28`;
      * `ya-ilb-rc1a` в зоне доступности `{{ region-id }}-a` — `192.168.1.48/28`;
      * `ya-ad-rc1a` в зоне доступности `{{ region-id }}-a` — `10.0.0.0/28`.

    - Bash

      ```
      yc vpc subnet create \
         --name ya-sqlserver-rc1a \
         --zone {{ region-id }}-a \
         --range 192.168.1.0/28 \
         --network-name ya-network
      ```

      ```
      yc vpc subnet create \
		 --name ya-sqlserver-rc1b \
         --zone {{ region-id }}-b \
         --range 192.168.1.16/28 \
         --network-name ya-network
      ```

      ```
      yc vpc subnet create \
         --name ya-sqlserver-rc1c \
         --zone {{ region-id }}-c \
         --range 192.168.1.32/28 \
         --network-name ya-network
      ```

      ```
      yc vpc subnet create \
         --name ya-ilb-rc1a \
         --zone {{ region-id }}-a \
         --range 192.168.1.48/28 \
         --network-name ya-network
      ```

      ```
      yc vpc subnet create \
		 --name ya-ad-rc1a \
         --zone {{ region-id }}-a \
         --range 10.0.0.0/28 \
         --network-name ya-network
      ```

    - PowerShell

      ```
      yc vpc subnet create `
         --name ya-sqlserver-rc1a `
         --zone {{ region-id }}-a `
         --range 192.168.1.0/28 `
         --network-name ya-network
      ```

      ```
      yc vpc subnet create `
         --name ya-sqlserver-rc1b `
         --zone {{ region-id }}-b `
         --range 192.168.1.16/28 `
         --network-name ya-network
      ```

      ```
      yc vpc subnet create `
         --name ya-sqlserver-rc1c `
         --zone {{ region-id }}-c `
         --range 192.168.1.32/28 `
         --network-name ya-network
      ```

      ```
      yc vpc subnet create `
         --name ya-ilb-rc1a `
         --zone {{ region-id }}-a `
         --range 192.168.1.48/28 `
         --network-name ya-network
      ```

      ```
      yc vpc subnet create `
		 --name ya-ad-rc1a `
         --zone {{ region-id }}-a `
         --range 10.0.0.0/28 `
         --network-name ya-network
      ```

    {% endlist %}

## Создайте внутренний сетевой балансировщик {#create-load-balancer}

{% list tabs %}

- Bash

  ```
  yc load-balancer network-load-balancer create \
     --name ya-loadbalancer \
     --type internal
  ```

- PowerShell
  
  ```
  yc load-balancer network-load-balancer create `
     --name ya-loadbalancer `
	 --type internal
  ```

{% endlist %}

### Создайте обработчик {#create-listener}

{% list tabs %}

- Bash 
  
  Получите идентификатор подсети:

  ```
  yc vpc subnet get --name ya-ilb-rc1a
  ```
  
  Создайте обработчик, указав идентификатор подсети:

  ```
  yc load-balancer network-load-balancer add-listener \
     --name ya-loadbalancer \
     --listener name=ya-listener,port=1433,target-port=14333,protocol=tcp,internal-subnet-id=<идентификатор_подсети>
  ```

- PowerShell

  ```
  $inlbSubnet = yc vpc subnet get `
     --name ya-ilb-rc1a `
	 --format json | ConvertFrom-Json
  ```

  ```
  yc load-balancer network-load-balancer add-listener `
	 --name ya-loadbalancer `
	 --listener name=ya-listener,port=1433,target-port=14333,protocol=tcp,internal-subnet-id=$($inlbSubnet.id)
  ```

{% endlist %}

### Создайте и подключите целевую группу к балансировщику {#create-target-group}

{% list tabs %}

- Bash

  ```
  yc load-balancer target-group create \
     --name ya-tg \
     --target address=192.168.1.3,subnet-name=ya-sqlserver-rc1a \
     --target address=192.168.1.19,subnet-name=ya-sqlserver-rc1b \
     --target address=192.168.1.35,subnet-name=ya-sqlserver-rc1c
  ```
  
  Скопируйте из ответа идентификатор целевой группы и выполните команду:

  ```
  yc load-balancer network-load-balancer attach-target-group \
	 --name ya-loadbalancer \
	 --target-group target-group-id=<идентификатор_целевой_группы>,healthcheck-name=listener,healthcheck-tcp-port=59999
  ```

- PowerShell

  ```
  yc load-balancer target-group create `
     --name ya-tg `
     --target address=192.168.1.3,subnet-name=ya-sqlserver-rc1a `
     --target address=192.168.1.19,subnet-name=ya-sqlserver-rc1b `
     --target address=192.168.1.35,subnet-name=ya-sqlserver-rc1c
  ```
  
  ```
  $TargetGroup = yc load-balancer target-group get `
     --name ya-tg `
     --format json | ConvertFrom-Json
  ```

  ```
  yc load-balancer network-load-balancer attach-target-group `
     --name ya-loadbalancer `
     --target-group target-group-id=$($TargetGroup.id),healthcheck-name=listener,healthcheck-tcp-port=59999
  ```

{% endlist %}

## Подготовьте виртуальные машины для группы доступности {#create-vms}

### Создайте файл с учетными данными администратора {#prepare-admin-credentials}

Создайте файл `setpass` со скриптом для установки пароля локальной учетной записи администратора. Этот скрипт будет выполняться при создании виртуальных машин через CLI.

{% note alert %}

Файл `setpass` должен быть в кодировке UTF-8.

{% endnote %}

{% list tabs %}

- Bash

  ```
  touch ~/setpass
  ```
  
  ```
  echo '#ps1' >> ~/setpass
  ```
  
  ```
  echo 'Get-LocalUser | Where-Object SID -like *-500 | Set-LocalUser -Password (ConvertTo-SecureString "YaQWErty123" -AsPlainText -Force)' >> ~/setpass
  cd
  ```

- PowerShell

  ```
  ni ~/setpass
  ```
  
  ```
  echo '#ps1' >> ~/setpass
  ```
  
  ```
  echo 'Get-LocalUser | Where-Object SID -like *-500 | Set-LocalUser -Password (ConvertTo-SecureString "YaQWErty123" -AsPlainText -Force)' >> ~/setpass
  ```

{% endlist %}

{% note warning %}

Указанный пароль используется только для тестирования. Используйте собственный сложный пароль при развертывании кластера для работы в продуктовом окружении.

Пароль должен соответствовать [требованиям к сложности]({{ ms.docs }}/windows/security/threat-protection/security-policy-settings/password-must-meet-complexity-requirements#справочные-материалы).

Подробные рекомендации по защите Active Directory читайте [на сайте разработчика]({{ ms.docs }}/windows-server/identity/ad-ds/plan/security-best-practices/best-practices-for-securing-active-directory).

{% endnote %}

### Создайте виртуальные машины {#create-group-vms}

#### Создайте ВМ для бастионного хоста {#create-jump-server}

Создайте бастионный хост с публичным IP-адресом для доступа к остальным ВМ:

{% list tabs %}

- Bash

  ```
  yc compute instance create \
     --name ya-jump1 \
     --hostname ya-jump1 \
     --zone {{ region-id }}-a \
     --memory 4 \
     --cores 2 \
     --metadata-from-file user-data=setpass \
     --create-boot-disk \
       type=network-ssd,size=50,image-family=windows-2019-gvlk,image-folder-id=standard-images \
     --network-interface \
       subnet-name=ya-ad-rc1a,nat-ip-version=ipv4 \
     --async
  ```

- PowerShell

  ```
  yc compute instance create `
     --name ya-jump1 `
     --hostname ya-jump1 `
     --zone {{ region-id }}-a `
     --memory 4 `
     --cores 2 `
     --metadata-from-file user-data=setpass `
     --create-boot-disk `
       type=network-ssd,size=50,image-family=windows-2019-gvlk,image-folder-id=standard-images `
     --network-interface `
       subnet-name=ya-ad-rc1a,nat-ip-version=ipv4 `
     --async
  ```

{% endlist %}

#### Создайте ВМ для Active Directory {#create-ad-controller}

{% list tabs %}

- Bash

  ```
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
       subnet-name=ya-ad-rc1a,ipv4-address=10.0.0.3 \
     --async
  ```

- PowerShell

  ```
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
       subnet-name=ya-ad-rc1a,ipv4-address=10.0.0.3 `
     --async
  ```

{% endlist %}

#### Создайте ВМ для серверов MSSQL {#create-ad-server}

Создайте три виртуальных машины для серверов MSSQL:

{% list tabs %}

- Bash

  ```
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
       subnet-name=ya-sqlserver-rc1a,ipv4-address=192.168.1.3 \
     --async
  ```

  ```
  yc compute instance create \
     --name ya-mssql2 \
     --hostname ya-mssql2 \
     --zone {{ region-id }}-b \
     --memory 16 \
     --cores 4 \
     --metadata-from-file user-data=setpass \
     --create-boot-disk \
       type=network-ssd,size=50,image-family=windows-2019-gvlk,image-folder-id=standard-images \
     --create-disk \
       type=network-ssd,size=200 \
     --network-interface \
       subnet-name=ya-sqlserver-rc1b,ipv4-address=192.168.1.19 \
     --async
  ```

  ```
  yc compute instance create \
     --name ya-mssql3 \
     --hostname ya-mssql3 \
     --zone {{ region-id }}-c \
     --memory 16 \
     --cores 4 \
     --metadata-from-file user-data=setpass \
     --create-boot-disk \
       type=network-ssd,size=50,image-family=windows-2019-gvlk,image-folder-id=standard-images \
     --create-disk \
       type=network-ssd,size=200 \
     --network-interface \
       subnet-name=ya-sqlserver-rc1c,ipv4-address=192.168.1.35 \
     --async
  ```

- PowerShell

  ```
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
       subnet-name=ya-sqlserver-rc1a,ipv4-address=192.168.1.3 `
     --async
  ```

  ```
  yc compute instance create `
     --name ya-mssql2 `
     --hostname ya-mssql2 `
     --zone {{ region-id }}-b `
     --memory 16 `
     --cores 4 `
     --metadata-from-file user-data=setpass `
     --create-boot-disk `
       type=network-ssd,size=50,image-family=windows-2019-gvlk,image-folder-id=standard-images `
     --create-disk `
       type=network-ssd,size=200 `
     --network-interface `
       subnet-name=ya-sqlserver-rc1b,ipv4-address=192.168.1.19 `
     --async
  ```

  ```
  yc compute instance create `
     --name ya-mssql3 `
     --hostname ya-mssql3 `
     --zone {{ region-id }}-c `
     --memory 16 `
     --cores 4 `
     --metadata-from-file user-data=setpass `
     --create-boot-disk `
       type=network-ssd,size=50,image-family=windows-2019-gvlk,image-folder-id=standard-images `
     --create-disk `
       type=network-ssd,size=200 `
     --network-interface `
       subnet-name=ya-sqlserver-rc1c,ipv4-address=192.168.1.35 `
     --async
  ```
  
{% endlist %}

### Установите и настройте Active Directory {#install-ad}

1. Подключитесь к ВМ `ya-jump1` [с помощью RDP](../compute/operations/vm-connect/rdp.md). Используйте логин `Administrator` и ваш пароль. 
1. С ВМ `ya-jump1` подключитесь к ВМ `ya-ad` с помощью RDP и той же учетной записи.
1. На ВМ `ya-ad` запустите PowerShell и установите необходимые роли сервера:

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
       Install-ADDSForest `
         -DomainName 'yantoso.net' `
         -Force:$true `
         -SafeModeAdministratorPassword `
           ('YaP@ssw0rd!11' | ConvertTo-SecureString -AsPlainText -Force)
       ```
       
    {% endlist %}

   После этого ВМ перезапустится. 

1. Снова подключитесь к ВМ `ya-ad`.

1. Переименуйте сайт и добавьте в него созданные подсети:

    {% list tabs %}

    - PowerShell

       ```
       Get-ADReplicationSite 'Default-First-Site-Name' | Rename-ADObject -NewName '{{ region-id }}'
       New-ADReplicationSubnet -Name '10.0.0.0/28'  -Site '{{ region-id }}'
       New-ADReplicationSubnet -Name '192.168.1.0/28'  -Site '{{ region-id }}'
       New-ADReplicationSubnet -Name '192.168.1.16/28' -Site '{{ region-id }}'
       New-ADReplicationSubnet -Name '192.168.1.32/28' -Site '{{ region-id }}'
       New-ADReplicationSubnet -Name '192.168.1.48/28' -Site '{{ region-id }}'
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

### Создайте пользователей и группы в Active Directory {#create-ad-users-groups}

1. Подключитесь к ВМ `ya-jump1` [с помощью RDP](../compute/operations/vm-connect/rdp.md). Используйте логин `Administrator` и ваш пароль.

1. С ВМ `ya-jump1` подключитесь к ВМ `ya-ad` с помощью RDP и той же учетной записи.

1. На ВМ `ya-ad` запустите PowerShell и создайте сервисную учетную запись `mssql-svc`:

    {% list tabs %}

    - PowerShell

       ```
       New-ADUser `
         -Name mssql-svc `
         -AccountPassword ('YaQWErty123' | ConvertTo-SecureString -AsPlainText -Force) `
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

Установите MSSQL на серверы баз данных:

1. Настройте на ВМ с серверами БД доступ в интернет:

    {% list tabs %}

    - Bash

       ```
       yc compute instance add-one-to-one-nat <идентификатор_ВМ_ya-mssql1> --network-interface-index 0
       yc compute instance add-one-to-one-nat <идентификатор_ВМ_ya-mssql2> --network-interface-index 0
       yc compute instance add-one-to-one-nat <идентификатор_ВМ_ya-mssql3> --network-interface-index 0
       ```

    - PowerShell

       ```
       yc compute instance add-one-to-one-nat <идентификатор_ВМ_ya-mssql1> --network-interface-index 0
       yc compute instance add-one-to-one-nat <идентификатор_ВМ_ya-mssql2> --network-interface-index 0
       yc compute instance add-one-to-one-nat <идентификатор_ВМ_ya-mssql3> --network-interface-index 0
       ```

    {% endlist %}
	
1. Запустите RDP и подключитесь к ВМ `ya-mssql1` с учетной записью `Administrator` и вашим паролем. Для подключения используйте публичный IP-адрес ВМ.

1. Запустите PowerShell и установите роль: 

    {% list tabs %}

    - PowerShell

       ```
       Install-WindowsFeature Failover-Clustering -IncludeManagementTools
       ```

    {% endlist %}

1. [Перезапустите ВМ](../compute/operations/vm-control/vm-stop-and-start.md#restart).

1. Снова подключитесь к ВМ `ya-mssql1` и запустите PowerShell.

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

    Появится запрос подтверждения форматирования диска. Нажмите кнопку **Format disk**. Нажмите кнопку **Start**. После завершения форматирования нажмите кнопку **OK**. 
    
1. Подготовьте папки для дистрибутива, резервного копирования, хранения баз данных, логов и временных файлов:

    {% list tabs %}

    - PowerShell

       ```
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

       ```
       Install-Module -Name SqlServer
       ```
       
    {% endlist %}
	
1. При запросе подтверждения установки введите `Y`.

1. Импортируйте команды модуля SqlServer для PowerShell:

    {% list tabs %}

    - PowerShell

       ```
       Import-Module SQLServer
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
             ('YaQWErty123' | ConvertTo-SecureString -AsPlainText -Force))
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

1. После перезапуска снова подключитесь к ВМ с логином `yantoso\Administrator`, откройте PowerShell.

1. Настройте необходимые права служебной учетной записи: 

    {% list tabs %}

    - PowerShell

       ```
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
         -DisplayName "MSSQL Server AAG Custom" `
         -Name "MSSQLAAG-In-TCP" `
		 -LocalPort 14333 `
         -Action "Allow" `
         -Protocol "TCP"

       New-NetFirewallRule `
         -Group "MSSQL" `
         -DisplayName "MSSQL HADR Default" `
         -Name "MSSQLHADR-In-TCP" `
         -LocalPort 5022 `
         -Action "Allow" `
         -Protocol "TCP"

       New-NetFirewallRule `
         -Group "MSSQL" `
         -DisplayName "MSSQL NLB Probe" `
         -Name "MSSQLAAG-NLB-In-TCP" `
         -LocalPort 59999 `
         -Action "Allow" `
         -Protocol "TCP"
        ```

    {% endlist %}

1. Установите MSSQL. Смонтируйте образ, выполните установку и отсоедините образ:

   {% list tabs %}

   - PowerShell

      ```
      Mount-DiskImage -ImagePath C:\dist\<имя_образа_MSSQL_Server>.iso
	  ```
	  
	  ```
      & D:\setup.exe /QUIET /INDICATEPROGRESS /IACCEPTSQLSERVERLICENSETERMS `
        /ACTION=INSTALL /FEATURES=SQLENGINE /INSTANCENAME=MSSQLSERVER `
        /SQLSVCACCOUNT="yantoso\mssql-svc" /SQLSVCPASSWORD="YaQWErty123" `
        /SQLSYSADMINACCOUNTS="yantoso\mssql-admins-grp" /UpdateEnabled=FALSE `
        /SQLBACKUPDIR="X:\BACKUP" /SQLTEMPDBDIR="X:\TEMPDB" /SQLTEMPDBLOGDIR="X:\TEMPDBLOG" `
        /SQLUSERDBDIR="X:\DB" /SQLUSERDBLOGDIR="X:\DBLOG"
	  ```
	  
	  ```
      Dismount-DiskImage -ImagePath C:\dist\<имя_образа_MSSQL_Server>.iso
      ```

   {% endlist %}

1. Повторите шаги 2-16 для ВМ `ya-mssql2` и `ya-mssql3`. 

1. Отключите у ВМ доступ в интернет:

    {% list tabs %}

    - Bash

       ```
       yc compute instance remove-one-to-one-nat <идентификатор_ВМ_ya-mssql1> --network-interface-index 0
       yc compute instance remove-one-to-one-nat <идентификатор_ВМ_ya-mssql2> --network-interface-index 0
       yc compute instance remove-one-to-one-nat <идентификатор_ВМ_ya-mssql3> --network-interface-index 0
       ```
    - PowerShell

       ```
       yc compute instance remove-one-to-one-nat <идентификатор_ВМ_ya-mssql1> --network-interface-index 0
       yc compute instance remove-one-to-one-nat <идентификатор_ВМ_ya-mssql2> --network-interface-index 0
       yc compute instance remove-one-to-one-nat <идентификатор_ВМ_ya-mssql3> --network-interface-index 0
       ```

    {% endlist %}

1. Подключитесь к ВМ `ya-jump1` [с помощью RDP](../compute/operations/vm-connect/rdp.md). Используйте логин `Administrator` и ваш пароль.

1. С ВМ `ya-jump1` подключитесь к ВМ `ya-mssql1` с помощью RDP и той же учетной записи. Настройте статический адрес со своей маской подсети:

   ```
   $IPAddress = Get-NetAdapter | Get-NetIPAddress -AddressFamily IPv4 | Select-Object -ExpandProperty IPAddress
   $InterfaceName = Get-NetAdapter | Select-Object -ExpandProperty Name
   $Gateway = Get-NetIPConfiguration | Select-Object -ExpandProperty IPv4DefaultGateway | Select-Object -ExpandProperty NextHop

   netsh interface ip set address $InterfaceName static $IPAddress 255.255.255.192 $Gateway
   ```

1. Повторите шаги 19-20 для ВМ `ya-mssql2` и `ya-mssql3`.

1. Для работы группы доступности Always On требуется настроенный Windows Server Failover Cluster. Для его создания необходимо протестировать серверы БД. На любой из ВМ кластера выполните:

    {% list tabs %}

    - PowerShell

       ```
       Test-Cluster -Node 'ya-mssql1.yantoso.net'
       Test-Cluster -Node 'ya-mssql2.yantoso.net'
       Test-Cluster -Node 'ya-mssql3.yantoso.net'
       ```

    {% endlist %}

### Создайте Windows Server Failover Cluster {#configure-failover-cluster}

1. Подключитесь к ВМ `ya-jump1` с [помощью RDP](../compute/operations/vm-connect/rdp.md). Используйте логин `Administrator` и ваш пароль.
1. С ВМ `ya-jump1` подключитесь к ВМ `ya-mssql1` с помощью RDP и учетной записи `yantoso\Administrator`.
1. Создайте кластер из трех серверов БД:

    {% list tabs %}

    - PowerShell

       ```
       New-Cluster `
         -Name 'wsfc' `
         -Node 'ya-mssql1.yantoso.net','ya-mssql2.yantoso.net','ya-mssql3.yantoso.net' `
         -NoStorage `
         -StaticAddress 192.168.1.4

       Test-Cluster

       Get-ClusterResource -Name 'Cluster IP Address' | `
         Stop-ClusterResource

       Get-ClusterResource -Name 'Cluster IP Address' | `
         Set-ClusterParameter -Multiple `
           @{
             "Address"="169.254.1.1";
             "SubnetMask"="255.255.255.255";
             "OverrideAddressMatch"=1;
             "EnableDhcp"=0
           }

       Get-ClusterResource -Name 'Cluster Name' | Start-ClusterResource -Wait 60
       ```

    {% endlist %}

1. Включите на всех ВМ TCP/IP и добавьте порт `14333` для получения трафика:

    {% list tabs %}

    - PowerShell

       ```
       $nodes = @('ya-mssql1.yantoso.net','ya-mssql2.yantoso.net','ya-mssql3.yantoso.net')

       foreach ($node in $nodes) {
         $smo = [Microsoft.SqlServer.Management.Smo.Wmi.ManagedComputer]::new($node)
         $np = $smo.GetSmoObject("ManagedComputer[@Name=`'$node`']/ServerInstance[@Name='MSSQLSERVER']/ServerProtocol[@Name='NP']")
         $tcp = $smo.GetSmoObject("ManagedComputer[@Name=`'$node`']/ServerInstance[@Name='MSSQLSERVER']/ServerProtocol[@Name='Tcp']")
         $ipall = $smo.GetSmoObject("ManagedComputer[@Name=`'$node`']/ServerInstance[@Name='MSSQLSERVER']/ServerProtocol[@Name='Tcp']/IPAddress[@Name='IPAll']")

         if (-not $ipall.IPAddressProperties['TcpPort'].Value -ne '1433,14333') {
           $ipall.IPAddressProperties['TcpPort'].Value = '1433,14333'
           $tcp.Alter()
           $altered = $true
         }

         if (-not $tcp.IsEnabled) {
           $tcp.IsEnabled = $true
           $tcp.Alter()
           $altered = $true
         }
         if (-not $np.IsEnabled) {
           $np.IsEnabled = $true
           $np.Alter()
           $altered = $true
         }

         if ($altered) {
           Get-Service -Name 'MSSQLSERVER' -ComputerName $node | Restart-Service -Force
           Start-Sleep -Seconds 60
         }
       }
       ```
    
    {% endlist %}

1. Назначьте служебному пользователю `mssql-svc` разрешения на управление серверами:

    {% list tabs %}

    - PowerShell

       ```
       Add-SqlLogin -Path "SQLSERVER:\SQL\ya-mssql1\Default" `
         -LoginName "yantoso\mssql-svc" `
         -LoginType "WindowsUser" `
         -Enable `
         -GrantConnectSql

       Add-SqlLogin -Path "SQLSERVER:\SQL\ya-mssql2\Default" `
         -LoginName "yantoso\mssql-svc" `
         -LoginType "WindowsUser" `
         -Enable `
         -GrantConnectSql

       Add-SqlLogin -Path "SQLSERVER:\SQL\ya-mssql3\Default" `
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

### Настройте Always On {#configure-always-on}

1. По очереди подключитесь к каждому серверу и включите SqlAlwaysOn:

    {% list tabs %}

    - PowerShell

       ```
       Enable-SqlAlwaysOn -ServerInstance 'ya-mssql1.yantoso.net' -Force
       Enable-SqlAlwaysOn -ServerInstance 'ya-mssql2.yantoso.net' -Force
       Enable-SqlAlwaysOn -ServerInstance 'ya-mssql3.yantoso.net' -Force

       Get-Service -Name 'MSSQLSERVER' -ComputerName 'ya-mssql1.yantoso.net' | Restart-Service
       Get-Service -Name 'MSSQLSERVER' -ComputerName 'ya-mssql2.yantoso.net' | Restart-Service
       Get-Service -Name 'MSSQLSERVER' -ComputerName 'ya-mssql3.yantoso.net' | Restart-Service
       Start-Sleep -Seconds 30
       ```

    {% endlist %}
	
    При включении Always On сервис СУБД будет перезапускаться.


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
       $NLBIPAddress = '192.168.1.62'

       Get-Cluster | `
         Add-ClusterResource -Name 'MyAG Network Name' -Group 'MyAG' -ResourceType 'Network Name'
       Get-ClusterResource -Name 'MyAG Network Name' | `
         Set-ClusterParameter -Multiple `
           @{
             Name = 'MyAGlistener'
             DnsName = 'MyAGlistener'
           }

       Get-Cluster | `
         Add-ClusterResource -Name 'My AG listener IP Address' -Group 'MyAG' -ResourceType 'IP Address'
       Get-ClusterResource -Name 'My AG listener IP Address' | `
         Set-ClusterParameter -Multiple `
           @{
             Address=$NLBIPAddress
             ProbePort=59999
             SubnetMask="255.255.255.255"
             Network="Cluster Network 1"
             EnableDhcp=0
           }

       Add-ClusterResourceDependency `
         -Resource 'MyAG Network Name' `
         -Provider 'My AG listener IP Address'

       Stop-ClusterResource 'MyAG'

       Add-ClusterResourceDependency `
         -Resource 'MyAG' `
         -Provider 'MyAG Network Name'

       Start-ClusterResource 'MyAG'
       ```

    {% endlist %}

1. Назначьте порт `14333` обработчику:

    {% list tabs %}

    - PowerShell

      ```
      Set-SqlAvailabilityGroupListener `
        -Port 14333 `
        -Path "SQLSERVER:\Sql\ya-mssql1.yantoso.net\Default\AvailabilityGroups\MyAG\AvailabilityGroupListeners\MyAGlistener"
      ```

    {% endlist %}

1. Откройте порт `14333` на всех ВМ кластера:

    {% list tabs %}

    - PowerShell

      ```
      $nodes = @('ya-mssql1.yantoso.net','ya-mssql2.yantoso.net','ya-mssql3.yantoso.net')

      foreach ($node in $nodes) {
        $smo = [Microsoft.SqlServer.Management.Smo.Wmi.ManagedComputer]::new($node)
        $tcp = $smo.GetSmoObject("ManagedComputer[@Name=`'$node`']/ServerInstance[@Name='MSSQLSERVER']/ServerProtocol[@Name='Tcp']")
        $np = $smo.GetSmoObject("ManagedComputer[@Name=`'$node`']/ServerInstance[@Name='MSSQLSERVER']/ServerProtocol[@Name='NP']")
        $ipall = $smo.GetSmoObject("ManagedComputer[@Name=`'$node`']/ServerInstance[@Name='MSSQLSERVER']/ServerProtocol[@Name='Tcp']/IPAddress[@Name='IPAll']")

        if (-not $ipall.IPAddressProperties['TcpPort'].Value -ne '1433,14333') {
          $ipall.IPAddressProperties['TcpPort'].Value = '1433,14333'
          $tcp.Alter()
          $altered = $true
        }

        if (-not $tcp.IsEnabled) {
          $tcp.IsEnabled = $true
          $tcp.Alter()
          $altered = $true
		  
        }
        if (-not $np.IsEnabled) {
          $np.IsEnabled = $true
          $np.Alter()
          $altered = $true
        }

        if ($altered) {
          Get-Service -Name 'MSSQLSERVER' -ComputerName $node | Restart-Service
          Start-Sleep -Seconds 60
        }
      }
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
         -Database "MyDatabase" -Initialize `
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

Тестирование работы базы данных можно провести на любой из доменных ВМ. Для входа используйте учетную запись `yantoso\Administrator`.

1. Создайте таблицу в реплицируемой БД `MyDatabase`:

    {% list tabs %}

    - PowerShell

       ```
       Invoke-Sqlcmd -ServerInstance 'MyAGlistener.yantoso.net' -Query @"
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
       Invoke-Sqlcmd -ServerInstance 'MyAGlistener.yantoso.net' -Query @"
       INSERT INTO MyDatabase.dbo.test (test_name) 
       VALUES ('one')
       "@
       ```

    {% endlist %}

1. Проверьте, появилась ли строка в таблице:

    {% list tabs %}

    - PowerShell

       ```
       Invoke-Sqlcmd -ServerInstance 'MyAGlistener.yantoso.net' -Query @"
       SELECT *
       FROM MyDatabase.dbo.test;
       "@
       ```
	   
	   Результат:
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
       Invoke-Sqlcmd -Query "SELECT @@SERVERNAME" -ServerInstance 'MyAGlistener.yantoso.net'
       ```
	   
	   Результат:
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

1. Снова проверьте имя основной реплики:

    {% list tabs %}

    - PowerShell

       ```
       Invoke-Sqlcmd -Query "SELECT @@SERVERNAME" -ServerInstance 'MyAGlistener.yantoso.net'
       ```
	   
	   Результат:
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
       Invoke-Sqlcmd -ServerInstance 'MyAGlistener.yantoso.net' -Query @"
       INSERT INTO MyDatabase.dbo.test (test_name) 
       VALUES ('two')
       "@
       ```

    {% endlist %}

1. Убедитесь, что строка добавлена:

    {% list tabs %}

    - PowerShell

       ```
       Invoke-Sqlcmd -ServerInstance 'MyAGlistener.yantoso.net' -Query "SELECT * FROM MyDatabase.dbo.test"
       ```
	   
	   Результат:
       ```
       test_id test_name
       ------- ---------
             1 one
             2 two
       ```

    {% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы, [удалите](../compute/operations/vm-control/vm-delete.md) созданные виртуальные машины и балансировщик: 

* `ya-jump1`; 
* `ya-ad`;
* `ya-mssql1`;
* `ya-mssql2`;
* `ya-mssql3`; 
* `ya-loadbalancer`.
