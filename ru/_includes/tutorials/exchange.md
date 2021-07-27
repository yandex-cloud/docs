# Развертывание Microsoft Exchange

В сценарии описывается развертывание серверов Microsoft Exchange в {{ yandex-cloud }}. Инсталляция Microsoft Exchange будет состоять из двух почтовых серверов, двух серверов Active Directory и двух серверов Edge Transport в зонах доступности `ru-central1-a` и `ru-central1-b`. Нагрузка будет распределяться по серверам с помощью сетевого балансировщика нагрузки. Управление всеми серверами будет осуществляться через отдельную ВМ с доступом в интернет в зоне доступности `ru-central1-c`.

1. Подготовьтесь к развертыванию:
   1. [Подготовьте облако к работе](#before-you-begin)
   1. [Создайте облачную сеть и подсети](#create-network)
   1. [Создайте скрипт для управления локальной учетной записью администратора](#admin-script)
1. Установите и настройте Active Directory на ВМ:
   1. [Создайте ВМ для Active Directory](#ad-vm)
   1. [Создайте ВМ для File Share Witness](#ad-fsw-vm)
   1. [Установите и настройте Active Directory](#install-ad)
   1. [Настройте второй контроллер домена](#install-ad-2)
1. Установите и настройте Microsoft Exchange:
   1. [Установите Microsoft Exchange](#install-exchange)
   1. [Создайте сервера Microsoft Exchange](#create-ms-exchange-servers)
   1. [Создайте Database Availability Group](#create-dag)
   1. [Создайте диски для баз данных на виртуальных машинах](#create-db-disks)
   1. [Настройте Database Availability Group](#dag-configuration)
   1. [Настройте Client Access](#configure-access)
1. [Настройте сетевой балансировщик нагрузки](#set-up-load-balancer)
1. [Настройте Accepted Domains и Email Address Policy](#set-up-accepted-domains)
1. [Создайте и настройте ВМ для серверов Edge Transport](#create-edge-vm)
   1. [Настройте серверы Edge Transport](#set-up-edge-transport)
   1. [Настройте сервер Edge Transport в зоне ru-central1-a](#edge-a)
   1. [Настройте сервер Edge Transport в зоне ru-central1-b](#edge-b)
   1. [Добавьте серверы Edge Transport в Exchange](#add-edges-to-exchange)
   1. [Настройте подписку на сервере vm-edge-a](#subscribe-vm-edge-a)
   1. [Настройте подписку на сервере vm-edge-b](#subscribe-vm-edge-b)
1. [Удалите созданные облачные ресурсы, если они больше не нужны](#clear-out)

## Подготовьте облако к работе {#before-you-begin}

Перед тем, как разворачивать серверы, нужно зарегистрироваться в {{ yandex-cloud }} и создать платежный аккаунт:

{% include [prepare-register-billing](includes/prepare-register-billing.md) %}

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать каталог, в котором будет работать ваша виртуальная машина, на [странице облака](https://console.cloud.yandex.ru/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость инсталляции Microsoft Exchange входят:

* плата за постоянно запущенные виртуальные машины (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за балансировку трафика (см. [тарифы {{ network-load-balancer-full-name }}](../../network-load-balancer/pricing.md));
* плата за использование динамических или статических публичных IP-адресов (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md));
* стоимость исходящего трафика из {{ yandex-cloud }} в интернет (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).

## Создайте облачную сеть и подсети {#create-network}

Создайте облачную сеть `exchange-network` с подсетями во всех зонах доступности, где будут находиться виртуальные машины.

1. Создайте облачную сеть:

   {% list tabs %}

   - Консоль управления

     Чтобы создать [облачную сеть](../../vpc/concepts/network.md):
     1. Откройте раздел **Virtual Private Cloud** в каталоге, где требуется создать облачную сеть.
     1. Нажмите кнопку **Создать сеть.**
     1. Задайте имя сети: `exchange-network`.
     1. Нажмите кнопку **Создать сеть**.

   - CLI

     Чтобы создать облачную сеть, выполните команду:

     ```
     $ yc vpc network create --name exchange-network
     ```

   {% endlist %}

1. Создайте три подсети в сети `exchange-network`:

   {% list tabs %}

     - Консоль управления

       Чтобы создать подсеть:
       1. Откройте раздел **Virtual Private Cloud** в каталоге, где требуется создать подсеть.
       1. Нажмите на имя облачной сети.
       1. Нажмите кнопку **Добавить подсеть**.
       1. Заполните форму: введите имя подсети `exchange-subnet-a`, выберите зону доступности `ru-central1-a` из выпадающего списка.
       1. Введите CIDR подсети: IP-адрес и маску подсети: `10.1.0.0/16`. Подробнее про диапазоны IP-адресов в подсетях читайте в разделе [Облачные сети и подсети](../../vpc/concepts/network.md).
       1. Нажмите кнопку **Создать подсеть**.

       Повторите шаги еще для двух подсетей `exchange-subnet-b` и `exchange-subnet-c` в зонах доступности `ru-central1-b` и `ru-central1-c` с CIDR `10.2.0.0/16` и `10.3.0.0/16` соответственно.

     - CLI

       Чтобы создать подсети, выполните команды:

       ```
       yc vpc subnet create \
         --name exchange-subnet-a \
         --zone ru-central1-a \
         --network-name exchange-network \
         --range 10.1.0.0/16

       yc vpc subnet create \
         --name exchange-subnet-b \
         --zone ru-central1-b \
         --network-name exchange-network \
         --range 10.2.0.0/16

       yc vpc subnet create \
         --name exchange-subnet-c \
         --zone ru-central1-c \
         --network-name exchange-network \
         --range 10.3.0.0/16
       ```

   {% endlist %}


## Создайте скрипт для управления локальной учетной записью администратора {#admin-script}

Создайте файл `setpass`, содержащий скрипт, который будет устанавливать пароль для локальной учетной записи администратора при создании виртуальных машин через CLI:

```
#ps1
Get-LocalUser | Where-Object SID -like *-500 | Set-LocalUser -Password (ConvertTo-SecureString "<ваш пароль>" -AsPlainText -Force)
```

Пароль должен соответствовать [требованиям к сложности](https://docs.microsoft.com/ru-ru/windows/security/threat-protection/security-policy-settings/password-must-meet-complexity-requirements#reference).

Подробные рекомендации по защите Active Directory читайте на [сайте разработчика](https://docs.microsoft.com/ru-ru/windows-server/identity/ad-ds/plan/security-best-practices/best-practices-for-securing-active-directory).

## Создайте ВМ для Active Directory {#ad-vm}

Создайте две виртуальных машины для Active Directory. Эти машины не будут иметь доступа в интернет.

{% list tabs %}

- Консоль управления

  1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **Создать ресурс** и выберите **Виртуальная машина**.
  1. В поле **Имя** введите имя виртуальной машины: `ad-vm-a`.
  1. Выберите [зону доступности](../../overview/concepts/geo-scope.md) `ru-central1-a`.
  1. В блоке **Образы из {{ marketplace-name }}** нажмите кнопку **Выбрать**. В открывшемся окне выберите образ **2016 Datacenter**.
  1. В блоке **Диски** укажите размер загрузочного диска 35 ГБ.
  1. В блоке **Вычислительные ресурсы**:
      - Выберите [платформу](../../compute/concepts/vm-platforms.md): Intel Cascade Lake.
      - Укажите необходимое количество vCPU и объем RAM:
         * **vCPU** — 4.
         * **Гарантированная доля vCPU** — 100%.
         * **RAM** — 8 ГБ.

  1. В блоке **Сетевые настройки** нажмите кнопку **Добавить сеть** и выберите сеть `exchange-network`. Выберите подсеть `exchange-subnet-a`. В блоке **Публичный адрес** выберите вариант **Без адреса**.
  1. В блоке **Доступ** укажите данные для доступа на виртуальную машину:
      - В поле **Пароль** укажите ваш пароль.
  1. Нажмите кнопку **Создать ВМ**.

  Повторите операцию для ВМ с именем `ad-vm-b` в зоне доступности `ru-central1-a` и подключите ее к подсети `exchange-subnet-b`

- CLI

  ```
  $ yc compute instance create \
      --name ad-vm-a \
      --hostname ad-vm-a \
      --memory 8 \
      --cores 4 \
      --zone ru-central1-a \
      --network-interface subnet-name=exchange-subnet-a,ipv4-address=10.1.0.3 \
      --create-boot-disk image-folder-id=standard-images,image-family=windows-2016-gvlk \
      --metadata-from-file user-data=setpass

  $ yc compute instance create \
      --name ad-vm-b \
      --hostname ad-vm-b \
      --memory 8 \
      --cores 4 \
      --zone ru-central1-b \
      --network-interface subnet-name=exchange-subnet-b,ipv4-address=10.2.0.3 \
      --create-boot-disk image-folder-id=standard-images,image-family=windows-2016-gvlk \
      --metadata-from-file user-data=setpass
  ```

{% endlist %}

## Создайте ВМ для File Share Witness {#ad-fsw-vm}

Для настройки машин с Active Directory будет использоваться файловый сервер с выходом в интернет.

{% list tabs %}

- Консоль управления

  1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **Создать ресурс** и выберите **Виртуальная машина**.
  1. В поле **Имя** введите имя виртуальной машины: `fsw-vm`.
  1. Выберите [зону доступности](../../overview/concepts/geo-scope.md) `ru-central1-c`.
  1. В блоке **Образы из {{ marketplace-name }}** нажмите кнопку **Выбрать**. В открывшемся окне выберите образ **2016 Datacenter**.
  1. В блоке **Диски** укажите размер загрузочного диска 35 ГБ.
  1. В блоке **Вычислительные ресурсы**:
      - Выберите [платформу](../../compute/concepts/vm-platforms.md): Intel Cascade Lake.
      - Укажите необходимое количество vCPU и объем RAM:
         * **vCPU** — 2.
         * **Гарантированная доля vCPU** — 100%.
         * **RAM** — 4 ГБ.

  1. В блоке **Сетевые настройки** нажмите кнопку **Добавить сеть** и выберите сеть `exchange-network`. Выберите подсеть `exchange-subnet-c`. В блоке **Публичный адрес** выберите вариант **Без адреса**.
  1. В блоке **Доступ** укажите данные для доступа на виртуальную машину:
      - В поле **Пароль** укажите ваш пароль.
  1. Нажмите кнопку **Создать ВМ**.

- CLI

  ```
  $ yc compute instance create \
      --name fsw-vm \
      --hostname fsw-vm \
      --memory 4 \
      --cores 2 \
      --zone ru-central1-c \
      --network-interface subnet-name=exchange-subnet-c,nat-ip-version=ipv4 \
      --create-boot-disk image-folder-id=standard-images,image-family=windows-2016-gvlk \
      --metadata-from-file user-data=setpass
  ```

{% endlist %}

## Установите и настройте Active Directory {#install-ad}

У машин с Active Directory нет доступа в интернет, поэтому их следует настраивать через ВМ `fsw-vm` с помощью RDP.

1. Подключитесь к ВМ `fsw-vm` [с помощью RDP](../../compute/operations/vm-connect/rdp.md). Используйте логин `Administrator` и ваш пароль.
1. На ВМ `fsw-vm` запустите RDP и подключитесь к виртуальной машине `ad-vm-a`. Используйте логин `Administrator` и ваш пароль.
1. На ВМ `ad-vm-a` запустите PowerShell и задайте статический адрес:

   ```powershell
   netsh interface ip set address "Ethernet 2" static 10.1.0.3 255.255.255.0 10.1.0.1
   ```

1. Создайте временную папку:

   ```powershell
   mkdir C:\Windows\temp
   ```

1. Установите роли Active Directory:

   ```powershell
   Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

   Success Restart Needed Exit Code      Feature Result
   ------- -------------- ---------      --------------
   True    No             Success        {Active Directory Domain Services, Group P...
   ```

1. Создайте лес Active Directory:

   ```powershell
   Install-ADDSForest -DomainName 'yantoso.net' -Force:$true
   ```

   Windows перезапустится автоматически. Снова подключитесь к ВМ `ad-vm-a`. Используйте логин `yantoso\Administrator` и ваш пароль. Снова откройте PowerShell.

1. Переименуйте сайт по умолчанию в `ru-central1-a`:

   ```powershell
   Get-ADReplicationSite 'Default-First-Site-Name' | Rename-ADObject -NewName 'ru-central1-a'
   ```

1. Создайте еще два сайта для других зон доступности:

   ```powershell
   New-ADReplicationSite 'ru-central1-b'
   New-ADReplicationSite 'ru-central1-c'
   ```

1. Создайте подсети и привяжите их к сайтам:

   ```powershell
   New-ADReplicationSubnet -Name '10.1.0.0/16' -Site 'ru-central1-a'
   New-ADReplicationSubnet -Name '10.2.0.0/16' -Site 'ru-central1-b'
   New-ADReplicationSubnet -Name '10.3.0.0/16' -Site 'ru-central1-c'
   ```

1. Переименуйте сайт-линк и настройте репликацию:

   ```powershell
   Get-ADReplicationSiteLink 'DEFAULTIPSITELINK' | `
       Set-ADReplicationSiteLink -SitesIncluded @{Add='ru-central1-b'} -ReplicationFrequencyInMinutes 15 -PassThru | `
       Set-ADObject -Replace @{options = $($_.options -bor 1)} -PassThru | `
       Rename-ADObject -NewName 'ru-central1'
   ```

1. Укажите сервер переадресации DNS:

   ```powershell
   Set-DnsServerForwarder '10.1.0.2'
   ```

1. Настройте DNS-клиент:

   ```powershell
   Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses "10.2.0.3,127.0.0.1"
   ```

## Настройте второй контроллер домена {#install-ad-2}

1. Подключитесь к ВМ `fsw-vm` [с помощью RDP](../../compute/operations/vm-connect/rdp.md). Используйте логин `Administrator` и ваш пароль.
1. На ВМ `fsw-vm` запустите RDP и подключитесь к виртуальной машине `ad-vm-b`. Используйте логин `Administrator` и ваш пароль.
1. Создайте временную папку:

   ```
   mkdir C:\Windows\temp
   ```

1. Установите роли Active Directory:

   ```powershell
   Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

   Success Restart Needed Exit Code      Feature Result
   ------- -------------- ---------      --------------
   True    No             Success        {Active Directory Domain Services, Group P...
   ```

1. Настройте DNS-клиент:

   ```powershell
   Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses "10.1.0.3,127.0.0.1"
   ```

1. Настройте статический IP-адрес:

   ```powershell
   netsh interface ip set address "Ethernet 2" static 10.2.0.3 255.255.255.0 10.2.0.1
   ```

1. Добавьте контроллер в домен:

   ```powershell
   Install-ADDSDomainController `
       -Credential (Get-Credential "yantoso\Administrator") `
       -DomainName 'yantoso.net' `
       -Force:$true
   ```

   Windows перезапустится автоматически. Снова подключитесь к ВМ `ad-vm-b`. Используйте логин `yantoso\Administrator` и ваш пароль. Снова откройте PowerShell.

1. Укажите сервер переадресации DNS:

   ```powershell
   Set-DnsServerForwarder '10.2.0.2'
   ```

## Установите Microsoft Exchange {#install-exchange}

1. Подключитесь с помощью RDP к ВМ `fsw-vm` и запустите PowerShell.
1. Настройте DNS-клиент:

   ```powershell
   Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses "10.1.0.3,10.2.0.3"
   ```

1. Добавьте сервер в домен:

   ```powershell
   $Credentials = Get-Credential # yantoso\Administrator
   Add-Computer -DomainName yantoso.net -DomainCredential $Credentials -Force -Restart
   ```

   Windows перезапустится автоматически. Снова подключитесь к ВМ `fsw-vm`. Используйте логин `yantoso\Administrator` и ваш пароль. Снова откройте PowerShell.

1. Создайте папку `distrib`:

   ```powershell
   mkdir c:\distrib
   ```

1. Загрузите [дистрибутив Exchange Server](https://docs.microsoft.com/ru-ru/exchange/new-features/updates?view=exchserver-2016) и необходимые зависимости:
   1. [.NET Framework 4.7.1](https://go.microsoft.com/fwlink/p/?linkid=863265).
   1. [Visual C++ Redistributable Package for Visual Studio 2012](https://go.microsoft.com/fwlink/?linkid=327788). Переименуйте скачанный файл в `vcredist_x64_2012.exe`.
   1. [Visual C++ Redistributable Package for Visual Studio 2013](https://go.microsoft.com/fwlink/?linkid=2002913). Переименуйте скачанный файл в `vcredist_x64_2013.exe`.
   1. [Microsoft Unified Communications Managed API 4.0, Core Runtime 64-bit](https://go.microsoft.com/fwlink/p/?linkId=258269).

   Поместите дистрибутивы в директорию `C:\distrib`.

1. Предоставьте общей доступ из домена к папке с дистрибутивами:

   ```powershell
   New-SmbShare -ReadAccess 'yantoso\domain users' -Path 'c:\distrib' -Name 'distrib'
   ```

## Создайте сервера Microsoft Exchange {#create-ms-exchange-servers}

### Создайте первый сервер Exchange {#create-exchange-vm-a}

1. Создайте ВМ `vm-exchange-a`:

   {% list tabs %}

   - Консоль управления

     1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **Создать ресурс** и выберите **Виртуальная машина**.
     1. В поле **Имя** введите имя виртуальной машины: `vm-exchange-a`.
     1. Выберите [зону доступности](../../overview/concepts/geo-scope.md) `ru-central1-a`.
     1. В блоке **Образы из {{ marketplace-name }}** нажмите кнопку **Выбрать**. В открывшемся окне выберите образ **2016 Datacenter**.
     1. В блоке **Диски** укажите размер загрузочного диска 100 ГБ.
     1. Добавьте еще один SSD-диск размером 250 ГБ с именем `db`.
     1. В блоке **Вычислительные ресурсы**:
         - Выберите [платформу](../../compute/concepts/vm-platforms.md): Intel Cascade Lake.
         - Укажите необходимое количество vCPU и объем RAM:
            * **vCPU** — 8.
            * **Гарантированная доля vCPU** — 100%.
            * **RAM** — 32 ГБ.

     1. В блоке **Сетевые настройки** нажмите кнопку **Добавить сеть** и выберите сеть `exchange-network`. Выберите подсеть `exchange-subnet-a`. В блоке **Публичный адрес** выберите вариант **Без адреса**.
     1. В блоке **Доступ** укажите данные для доступа на виртуальную машину:
         - В поле **Пароль** укажите ваш пароль.
     1. Нажмите кнопку **Создать ВМ**.

   - CLI

     ```
     yc compute instance create \
       --name vm-exchange-a \
       --hostname vm-exchange-a \
       --memory 32 \
       --cores 8 \
       --zone ru-central1-a \
       --network-interface subnet-name=exchange-subnet-a \
       --create-boot-disk size=100,image-folder-id=standard-images,image-family=windows-2016-gvlk \
       --create-disk type=network-ssd,size=250,auto-delete=false \
       --metadata-from-file user-data=setpass
     ```

   {% list tabs %}

1. Подключитесь к ВМ `fsw-vm` с помощью RDP.
1. На ВМ `fsw-vm` запустите RDP и подключитесь к ВМ `vm-exchange-a` с помощью RDP. Используйте логин `Administrator` и ваш пароль. Запустите PowerShell.
1. Настройте DNS-клиент:

   ```powershell
   Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses "10.1.0.3"
   ```

1. Добавьте ВМ `vm-exchange-a` в домен:

   ```powershell
   $Credentials = Get-Credential # yantoso\Administrator
   Add-Computer -DomainName yantoso.net -DomainCredential $Credentials -Force -Restart
   ```

   После перезагрузки зайдите на ВМ, используя учетную `yantoso\Administrator` и ваш пароль. Снова откройте PowerShell.

1. Установите загруженные зависимости по порядку:
   1. `& \\fsw-vm\distrib\vcredist_x64_2012.exe /install /passive /norestart`
   1. `& \\fsw-vm\distrib\vcredist_x64_2013.exe /install /passive /norestart`
   1. `& \\fsw-vm\distrib\UcmaRuntimeSetup.exe /install /passive /norestart`
   1. `& \\fsw-vm\distrib\NDP472-KB4054530-x86-x64-AllOS-ENU.exe /install /passive /norestart`
1. Перезапустите VM: `Restart-Computer -Force`.

   После перезагрузки зайдите на ВМ, используя учетную `yantoso\Administrator` и ваш пароль. Снова откройте PowerShell.

1. Установите Exchange Mailbox Server на `vm-exchange-a`. Смонитруйте образ дистрибутива из общей папки с дистрибутивами:

   ```powershell
   Mount-DiskImage \\fsw-vm\distrib\ExchangeServer2016-x64-cu13.iso
   ```

1. Запустите установку Exchange Mailbox Server:

   ```powershell
   & D:\Setup.exe /Mode:Install /InstallWindowsComponents /Role:Mailbox /IAcceptExchangeServerLicenseTerms /OrganizationName:MyOrg
   Restart-Computer -Force
   ```

   После установки ВМ перезапустится автоматически.

### Создайте второй сервер Exchange {#create-exchange-vm-b}

1. Создайте ВМ `vm-exchange-b`:

   {% list tabs %}

   - Консоль управления

     1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **Создать ресурс** и выберите **Виртуальная машина**.
     1. В поле **Имя** введите имя виртуальной машины: `vm-exchange-b`.
     1. Выберите [зону доступности](../../overview/concepts/geo-scope.md) `ru-central1-b`.
     1. В блоке **Образы из {{ marketplace-name }}** нажмите кнопку **Выбрать**. В открывшемся окне выберите образ **2016 Datacenter**.
     1. В блоке **Диски** укажите размер загрузочного диска 100 ГБ.
     1. Добавьте еще один SSD-диск размером 250 ГБ с именем `db`.
     1. В блоке **Вычислительные ресурсы**:
         - Выберите [платформу](../../compute/concepts/vm-platforms.md): Intel Cascade Lake.
         - Укажите необходимое количество vCPU и объем RAM:
            * **vCPU** — 8.
            * **Гарантированная доля vCPU** — 100%.
            * **RAM** — 32 ГБ.

     1. В блоке **Сетевые настройки** нажмите кнопку **Добавить сеть** и выберите сеть `exchange-network`. Выберите подсеть `exchange-subnet-b`. В блоке **Публичный адрес** выберите вариант **Без адреса**.
     1. В блоке **Доступ** укажите данные для доступа на виртуальную машину:
         - В поле **Пароль** укажите ваш пароль.
     1. Нажмите кнопку **Создать ВМ**.

   - CLI

     ```
     yc compute instance create \
       --name vm-exchange-b \
       --hostname vm-exchange-b \
       --memory 32 \
       --cores 8 \
       --zone ru-central1-b \
       --network-interface subnet-name=exchange-subnet-b \
       --create-boot-disk size=100,image-folder-id=standard-images,image-family=windows-2016-gvlk \
       --create-disk type=network-ssd,size=250,auto-delete=false \
       --metadata-from-file user-data=setpass
     ```

   {% endlist %}

1. Подключитесь к ВМ `fsw-vm` с помощью RDP.
1. На ВМ `fsw-vm` запустите RDP и подключитесь к ВМ `vm-exchange-b` с помощью RDP. Используйте логин `Administrator` и ваш пароль. Запустите PowerShell.
1. Настройте DNS-клиент:

   ```powershell
   Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses "10.1.0.3"
   ```

1. Добавьте ВМ `vm-exchange-a` в домен:

   ```powershell
   $Credentials = Get-Credential # yantoso\Administrator
   Add-Computer -DomainName yantoso.net -DomainCredential $Credentials -Force -Restart
   ```

   После перезагрузки зайдите на ВМ, используя учетную `yantoso\Administrator` и ваш пароль. Снова откройте PowerShell.

1. Установите загруженные зависимости по порядку:
   1. `& \\fsw-vm\distrib\vcredist_x64_2012.exe /install /passive /norestart`
   1. `& \\fsw-vm\distrib\vcredist_x64_2013.exe /install /passive /norestart`
   1. `& \\fsw-vm\distrib\UcmaRuntimeSetup.exe /install /passive /norestart`
   1. `& \\fsw-vm\distrib\NDP472-KB4054530-x86-x64-AllOS-ENU.exe /install /passive /norestart`

1. Перезапустите VM: `Restart-Computer -Force`.

   После перезагрузки зайдите на ВМ, используя учетную `yantoso\Administrator` и ваш пароль. Снова откройте PowerShell.

1. Установите Exchange Mailbox Server на `vm-exchange-b`. Смонитруйте образ дистрибутива из общей папки с дистрибутивами:

   ```powershell
   Mount-DiskImage \\fsw-vm\distrib\ExchangeServer2016-x64-cu13.iso
   ```

1. Запустите установку Exchange Mailbox Server:

   ```powershell
   & D:\Setup.exe /Mode:Install /InstallWindowsComponents /Role:Mailbox /IAcceptExchangeServerLicenseTerms /OrganizationName:MyOrg
   Restart-Computer -Force
   ```

   После установки ВМ перезапустится автоматически.

## Создайте Database Availability Group {#create-dag}

Database Availability Group обеспечивает отказоусточивасть почтовых серверов с помощью репликации баз данных и автоматического переключения баз при неполадках.

1. Подключитесь к ВМ `fsw-vm` с помощью RDP.
1. Дайте группе `yantoso\Exchange Trusted Subsystem` администраторские права на ВМ `fsw-vm`:

   ```powershell
   Add-LocalGroupMember -Group 'Administrators' -Member 'yantoso\Exchange Trusted Subsystem'
   ```

### Создайте диски для баз данных на виртуальных машинах {#create-db-disks}

1. На ВМ `fsw-vm` запустите RDP и подключитесь к ВМ `vm-exchange-a` с помощью RDP. Используйте логин `yantoso\Administrator` и ваш пароль.
1. Создайте дополнительный диск и отформатируйте его:

   ```powershell
   Get-Disk | `
       Where-Object PartitionStyle -eq raw | `
       Initialize-Disk -PartitionStyle GPT -PassThru | `
       New-Partition -DriveLetter 'Z' -UseMaximumSize | `
       Format-Volume -FileSystem NTFS -NewFileSystemLabel "mdb" -Confirm:$false -AllocationUnitSize 65536
   ```

1. Установите роль `Failover-Clustering`:

   ```powershell
   Install-WindowsFeature -Name 'Failover-Clustering' -IncludeManagementTools
   ```

Повторите команды для виртуальной машины `vm-exchange-b`.

### Настройте Database Availability Group {#dag-configuration}

1. На ВМ `fsw-vm` запустите RDP и подключитесь к ВМ `vm-exchange-a` с помощью RDP. Используйте логин `yantoso\Administrator` и ваш пароль.
1. Запустите Exchange Management Shell.
1. Создайте Database Availability Group:

   ```powershell
   New-DatabaseAvailabilityGroup `
       -Name ycdag `
       -WitnessServer fsw-vm `
       -DatabaseAvailabilityGroupIpAddresses 255.255.255.255
   ```

1. Добавьте серверы `vm-exchange-a` и `vm-exchange-b` в DAG:

   ```powershell
   Add-DatabaseAvailabilityGroupServer -Identity yadag -MailboxServer vm-exchange-a
   Add-DatabaseAvailabilityGroupServer -Identity yadag -MailboxServer vm-exchange-b
   ```

1. Проверьте состояние серверов, оба сервера должны находиться в графе Operational Servers:

   ```powershell
   Get-DatabaseAvailabilityGroup -Status

   Name             Member Servers                                      Operational Servers
   ----             --------------                                      -------------------
   ycdag            {VM-EXCHANGE-A, VM-EXCHANGE-B}                    {VM-EXCHANGE-A, VM-EXCHANGE-B}
   ```

1. Создайте базу данных почтовых серверов:

   ```powershell
   New-MailboxDatabase -Name yamdb -EdbFilePath 'Z:\MDB\yamdb\yamdb.edb' -LogFolderPath 'Z:\MDB\yamdb\log' -Server vm-exchange-a
   ```

1. Смонтируйте базу данных:

   ```powershell
   Mount-Database yamdb
   ```

1. Создайте копию базы данных на втором сервере:

   ```powershell
   Add-MailboxDatabaseCopy -Identity yamdb -MailboxServer vm-exchange-b -SeedingPostponed
   Update-MailboxDatabasecopy yamdb\vm-exchange-b –CatalogOnly
   ```

1. Проверьте состояния баз данных:

   ```powershell
   Get-MailboxDatabaseCopyStatus -Server vm-exchange-a
   Get-MailboxDatabaseCopyStatus -Server vm-exchange-b
   ```

## Настройте Client Access {#configure-access}

Для работы с различными клиентскими приложениями требуется создать виртуальные директории.

1. Задайте почтовый домен:

   ```powershell
   $MailDomain = "mail.yantoso.net"
   ```

1. ECP:

   ```powershell
   Get-EcpVirtualDirectory | Set-EcpVirtualDirectory -ExternalUrl "https://$MailDomain/ecp"
   ```

1. EWS:

   ```powershell
   Get-WebServicesVirtualDirectory | Set-WebServicesVirtualDirectory -ExternalUrl "https://$MailDomain/ews/exchange.asmx"
   ```

1. Active Sync:

   ```powershell
   Get-ActiveSyncVirtualDirectory | Set-ActiveSyncVirtualDirectory -ExternalUrl "https://$MailDomain/Microsoft-Server-ActiveSync"
   ```

1. OAB:

   ```powershell
   Get-OabVirtualDirectory | Set-OabVirtualDirectory -ExternalUrl "https://$MailDomain/OAB"
   ```

1. OWA:

   ```powershell
   Get-OwaVirtualDirectory | Set-OwaVirtualDirectory -ExternalUrl "https://$MailDomain/owa"
   ```

1. PowerShell:

   ```powershell
   Get-PowerShellVirtualDirectory | Set-PowerShellVirtualDirectory -ExternalUrl "https://$MailDomain/powershell"
   ```

1. MAPI:

   ```powershell
   Get-MapiVirtualDirectory | Set-MapiVirtualDirectory -ExternalUrl "https://$MailDomain/mapi"
   ```

## Настройте сетевой балансировщик нагрузки {#set-up-load-balancer}

Балансировщик будет распределять нагрузку по серверам Exchange в разных зонах доступности.

{% list tabs %}

- Консоль управления

  Чтобы создать [сетевой балансировщик](../../network-load-balancer/concepts/index.md):
  1. Откройте раздел **Load Balancer** в каталоге, где требуется создать балансировщик.
  1. Нажмите кнопку **Создать балансировщик**.
  1. Задайте имя балансировщика: `exchange-lb`.
  1. В блоке **Обработчики** выберите автоматический публичный адрес и нажмите кнопку **Добавить обработчик**.
  1. Введите имя обработчика: `yassl`
  1. Укажите порт обработчика: `443` и нажмите кнопку **Добавить**.
  1. Нажмите переключатель **Целевые группы**.
  1. Введите имя целевой группы: `exchange-tg`.
  1. Отметьте виртуальные машины `vm-exchange-a` и `vm-exchange-b`.
  1. В блоке **Проверка состояния** введите имя проверки состояния: `exchange-hc`.
  1. Выберите тип проверки **TCP**.
  1. Укажите порт `443`.
  1. Оставьте остальные параметры по умолчанию.
  1. Нажмите кнопку **Создать балансировщик**.

- UI

  1. Создайте сетевой балансировщик:

     ```
     $ yc lb nlb create --name exchange-lb
     ```

  1. Создайте целевую группу:

     ```
     $ yc lb tg create --name exchange-tg
     ```

  1. Получите сведения о почтовых серверах:

     ```
     $ yc compute instance get vm-exchange-a
     $ yc compute instance get vm-exchange-b
     ```

     Скопируйте IP-адреса и идентификаторы подсетей ВМ.

  1. Добавьте серверы в целевую группу:

     ```
     $ yc lb tg update --name exchange-tg \
         --target address=10.2.0.4,subnet-id=e2lkh054nic9h3nckbrs \
         --target address=10.1.0.24,subnet-id=e9bkdrnv156ctcp14p5q
     ```

  1. Добавьте обработчик к балансировщику:

     ```
     $ yc lb nlb add-listener --name exchange-lb --listener name=yassl,port=443,target-port=443,external-ip-version=ipv4
     ```

  1. Получите сведения о целевых группах:

     ```
     $ yc lb tg list
     ```

     Скопируйте идентификатор созданной целевой группы.

  1. Подключите целевую группу к балансировщику, используя идентификатор целевой группы:

     ```
     $ yc lb nlb attach-target-group \
         --name exchange-lb \
         --target-group target-group-id=b7ruh2aqg7pr6ahus4an,healthcheck-name=exchange-hc,healthcheck-tcp-port=443
     ```

{% endlist %}

## Настройте Accepted Domains и Email Address Policy {#set-up-accepted-domains}

Домен создается по умолчанию. Если требуется изменить домен, используйте команду:

```powershell
New-AcceptedDomain -Name yantoso.net -DomainName yantoso.net
```

Отредактируйте Email Address Policy:

```powershell
Get-EmailAddressPolicy | Set-EmailAddressPolicy -EnabledPrimarySMTPAddressTemplate '@yantoso.net'
```

Всем новым почтовым ящикам будет автоматически добавляться псевдоним с доменом `@yantoso.net`.

## Создайте ВМ для серверов Edge Transport {#create-edge-vm}

Серверы Edge Transport будут принимать основную пользовательскую нагрузку: принимать письма из интернета, отсеивать спам и перенаправлять сообщения на внутренние почтовые серверы Exchange.

### Создайте ВМ для сервера vm-edge-a {#create-edge-a}

Создайте ВМ `vm-edge-a`:

{% list tabs %}

- Консоль управления

  1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **Создать ресурс** и выберите **Виртуальная машина**.
  1. В поле **Имя** введите имя виртуальной машины: `vm-edge-a`.
  1. Выберите [зону доступности](../../overview/concepts/geo-scope.md) `ru-central1-a`.
  1. В блоке **Образы из {{ marketplace-name }}** нажмите кнопку **Выбрать**. В открывшемся окне выберите образ **2016 Datacenter**.
  1. В блоке **Диски** укажите размер загрузочного диска 50 ГБ.
  1. В блоке **Вычислительные ресурсы**:
      - Выберите [платформу](../../compute/concepts/vm-platforms.md): Intel Cascade Lake.
      - Укажите необходимое количество vCPU и объем RAM:
         * **vCPU** — 4.
         * **Гарантированная доля vCPU** — 100%.
         * **RAM** — 8 ГБ.

  1. В блоке **Сетевые настройки** нажмите кнопку **Добавить сеть** и выберите сеть `exchange-network`. Выберите подсеть `exchange-subnet-a`. В блоке **Публичный адрес** выберите вариант **Автоматически** или выберите адрес из списка зарезервированных.
  1. В блоке **Доступ** укажите данные для доступа на виртуальную машину:
      - В поле **Пароль** укажите ваш пароль.
  1. Нажмите кнопку **Создать ВМ**.

- CLI

  ```
  $ yc compute instance create \
      --name vm-edge-a \
      --hostname vm-edge-a \
      --memory 8 \
      --cores 4 \
      --zone ru-central1-a \
      --network-interface subnet-name=exchange-subnet-a,nat-ip-version=ipv4 \
      --create-boot-disk size=50,image-folder-id=standard-images,image-family=windows-2016-gvlk \
      --metadata-from-file user-data=setpass
  ```

 {% endlist %}

### Создайте ВМ для сервера vm-edge-b {#create-edge-b}

Создайте ВМ `vm-edge-b`:

{% list tabs %}

- Консоль управления

  1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **Создать ресурс** и выберите **Виртуальная машина**.
  1. В поле **Имя** введите имя виртуальной машины: `vm-edge-b`.
  1. Выберите [зону доступности](../../overview/concepts/geo-scope.md) `ru-central1-b`.
  1. В блоке **Образы из {{ marketplace-name }}** нажмите кнопку **Выбрать**. В открывшемся окне выберите образ **2016 Datacenter**.
  1. В блоке **Диски** укажите размер загрузочного диска 50 ГБ.
  1. В блоке **Вычислительные ресурсы**:
      - Выберите [платформу](../../compute/concepts/vm-platforms.md): Intel Cascade Lake.
      - Укажите необходимое количество vCPU и объем RAM:
         * **vCPU** — 4.
         * **Гарантированная доля vCPU** — 100%.
         * **RAM** — 8 ГБ.

  1. В блоке **Сетевые настройки** нажмите кнопку **Добавить сеть** и выберите сеть `exchange-network`. Выберите подсеть `exchange-subnet-b`. В блоке **Публичный адрес** выберите вариант **Автоматически** или выберите адрес из списка зарезервированных.
  1. В блоке **Доступ** укажите данные для доступа на виртуальную машину:
      - В поле **Пароль** укажите ваш пароль.
  1. Нажмите кнопку **Создать ВМ**.

- CLI

  ```
  $ yc compute instance create \
      --name vm-edge-b \
      --hostname vm-edge-b \
      --memory 8 \
      --cores 4 \
      --zone ru-central1-b \
      --network-interface subnet-name=yasn-b,nat-ip-version=ipv4 \
      --create-boot-disk size=50,image-folder-id=standard-images,image-family=windows-2016-gvlk \
      --metadata-from-file user-data=setpass
  ```

{% endlist %}

## Настройте серверы Edge Transport {#set-up-edge-transport}

### Настройте сервер Edge Transport в зоне ru-central1-a {#edge-a}

1. Подключитесь к ВМ `fsw-vm` с помощью RDP.
1. Подключитесь к ВМ `vm-edge-a` с помощью RDP. Используйте логин `Administrator` и ваш пароль. Запустите PowerShell.
1. Создайте временную папку:

   ```
   mkdir C:\Windows\temp
   ```

1. Установите роли ADLDS на сервер:

   ```powershell
   Install-WindowsFeature ADLDS
   ```

1. Настройте DNS-клиент:

   ```powershell
   Get-NetAdapter | `
       Set-DnsClientServerAddress -ServerAddresses "10.1.0.3,10.2.0.3"
   ```

1. Настройте удаленный доступ к папке с дистрибутивами, находящейся на сервере `fsw-vm`:

   ```powershell
   $Credential = Get-Credential # Username: yantoso\Administrator

   New-PSDrive -Name 'fsw-vm' -PSProvider:FileSystem -Root '\\fsw-vm.ru-central1.internal\distrib' -Credential $Credential
   ```

   Введите логин `yantoso\Administrator` и ваш пароль.

1. Установите зависимости:

   ```powershell
   & fsw-vm:\vcredist_x64_2012.exe /install /passive /norestart
   & fsw-vm:\NDP472-KB4054530-x86-x64-AllOS-ENU.exe /install /passive /norestart
   ```

1. Скопируйте дистрибутив Microsoft Exchange на сервер `vm-edge-a`:

   ```powershell
   copy-item fsw-vm:\ExchangeServer2016-x64-cu13.iso c:\windows\temp\ExchangeServer2016-x64-cu13.iso
   ```

1. Укажите основной суффикс DNS:

   ```powershell
   $Suffix = 'ru-central1.internal'

   Set-ItemProperty -path HKLM:\system\CurrentControlSet\Services\tcpip\parameters -Name Domain -Value $Suffix

   Set-ItemProperty -path HKLM:\system\CurrentControlSet\Services\tcpip\parameters -Name 'NV Domain' -Value $Suffix
   ```

1. Перезагрузите ВМ:

   ```powershell
   Restart-Computer -Force
   ```

   Снова подключитесь к ВМ `vm-edge-a` через RDP и запустите PowerShell.

1. Смонтируйте дистрибутив Exchange Server:

   ```powershell
   Mount-DiskImage c:\windows\temp\ExchangeServer2016-x64-cu13.iso
   ```

1. Установите Edge Transport Server на сервер `vm-edge-a`:

   ```powershell
   & D:\Setup.exe /Mode:Install /InstallWindowsComponents /Role:EdgeTransport /IAcceptExchangeServerLicenseTerms /OrganizationName:MyOrg
   ```

### Настройте сервер Edge Transport в зоне ru-central1-b {#edge-b}

1. Подключитесь к ВМ `fsw-vm` с помощью RDP.
1. Подключитесь к ВМ `vm-edge-b` с помощью RDP. Используйте логин `Administrator` и ваш пароль. Запустите PowerShell.
1. Создайте временную папку:

   ```powershell
   mkdir C:\Windows\temp
   ```

1. Установите роли ADLDS на сервер:

   ```powershell
   Install-WindowsFeature ADLDS
   ```

1. Настройте DNS-клиент:

   ```powershell
   Get-NetAdapter | `
       Set-DnsClientServerAddress -ServerAddresses "10.2.0.3,10.1.0.3"
   ```

1. Настройте удаленный доступ к папке с дистрибутивами, находящейся на сервере `fsw-vm`:

   ```powershell
   $Credential = Get-Credential # Username: yantoso\Administrator

   New-PSDrive -Name 'fsw-vm' -PSProvider:FileSystem -Root '\\fsw-vm.ru-central1.internal\distrib' -Credential $Credential
   ```

   Введите логин `yantoso\Administrator` и ваш пароль.

1. Установите зависимости:

   ```powershell
   & fsw-vm:\vcredist_x64_2012.exe /install /passive /norestart
   & fsw-vm:\NDP472-KB4054530-x86-x64-AllOS-ENU.exe /install /passive /norestart
   ```

1. Скопируйте дистрибутив Microsoft Exchange на сервер `vm-edge-b`:

   ```powershell
   copy-item fsw-vm:\ExchangeServer2016-x64-cu13.iso c:\windows\temp\ExchangeServer2016-x64-cu13.iso
   ```

1. Укажите основной суффикс DNS:

   ```powershell
   $Suffix = 'ru-central1.internal'

   Set-ItemProperty -path HKLM:\system\CurrentControlSet\Services\tcpip\parameters -Name Domain -Value $Suffix

   Set-ItemProperty -path HKLM:\system\CurrentControlSet\Services\tcpip\parameters -Name 'NV Domain' -Value $Suffix
   ```

1. Перезагрузите ВМ:

   ```powershell
   Restart-Computer -Force
   ```

   Снова подключитесь к ВМ `vm-edge-b` через RDP и запустите PowerShell.

1. Смонтируйте дистрибутив Exchange Server:

   ```powershell
   Mount-DiskImage c:\windows\temp\ExchangeServer2016-x64-cu13.iso
   ```

1. Установите Edge Transport Server на сервер `vm-edge-b`:

   ```powershell
   & D:\Setup.exe /Mode:Install /InstallWindowsComponents /Role:EdgeTransport /IAcceptExchangeServerLicenseTerms /OrganizationName:MyOrg
   ```

## Добавьте серверы Edge Transport в Exchange {#add-edges-to-exchange}

Каждый из серверов Edge Transport требуется подписать на сайт в своей зоне доступности.

### Настройте подписку на сервере vm-edge-a {#subscribe-vm-edge-a}

1. Создайте папку `subscribe`:

   ```powershell
   mkdir c:\subscribe
   ```

1. Запустите Exchange Management Shell. Создайте файл подписки на сервере `vm-edge-a`:

   ```powershell
   New-EdgeSubscription -FileName "C:\subscribe\$(hostname).xml"
   ```

1. Скопируйте файл `C:\subscribe\vm-edge-a.xml` на сервер `vm-exchange-a` в папку `C:\root\vm-edge-a.xml`.

1. Зайдите на сервер `vm-exchange-a` и запустите Exchange Management Shell.

1. Подпишите Edge Transport сервера `vm-edge-a` на сайт `ru-central1-a`:

   ```powershell
   New-EdgeSubscription -FileData ([byte[]]$(Get-Content -Path "C:\root\vm-edge-a.xml" -Encoding Byte -ReadCount 0)) -Site "ru-central1-a"
   ```

1. Убедитесь, что подписка создана, с помощью команды:

   ```powershell
   Get-EdgeSubscription

   Name            Site                 Domain
   ----            ----                 ------
   vm-edge-a       yantoso.net/Confi... ru-central1.internal
   ```

1. Проверьте статус синхронизации:

   ```powershell
   Test-EdgeSynchronization
   ```

   Параметр `SyncStatus` должен перейти в состояние `Normal`.


### Настройте подписку на сервере vm-edge-b {#subscribe-vm-edge-b}

1. Создайте папку `subscribe`:

   ```powershell
   mkdir c:\subscribe
   ```

1. Запустите Exchange Management Shell. Создайте файл подписки на сервере `vm-edge-b`:

   ```powershell
   New-EdgeSubscription -FileName "C:\subscribe\$(hostname).xml"
   ```

1. Скопируйте файл `C:\subscribe\vm-edge-b.xml` на сервер `vm-exchange-b` в папку `C:\root\vm-edge-b.xml`.

1. Зайдите на сервер `vm-exchange-b` и запустите Exchange Management Shell.

1. Подпишите Edge Transport сервера `vm-edge-b` на сайт `ru-central1-b`:

   ```powershell
   New-EdgeSubscription -FileData ([byte[]]$(Get-Content -Path "C:\root\vm-edge-b.xml" -Encoding Byte -ReadCount 0)) -Site "ru-central1-b"
   ```

1. Убедитесь, что подписка создана, с помощью команды:

   ```powershell
   Get-EdgeSubscription

   Name            Site                 Domain
   ----            ----                 ------
   vm-edge-a       yantoso.net/Confi... ru-central1.internal
   vm-edge-b       yantoso.net/Confi... ru-central1.internal
   ```

1. Проверьте статус синхронизации:

   ```powershell
   Test-EdgeSynchronization
   ```

   Параметр `SyncStatus` должен перейти в состояние `Normal`.

## Удалите созданные ресурсы {#clear-out}

Чтобы перестать платить за развернутые серверы, достаточно удалить все созданные [виртуальные машины](../../compute/operations/vm-control/vm-delete.md) и [балансировщик](../../network-load-balancer/operations/load-balancer-delete.md):

* `fsw-vm`
* `ad-vm-a`
* `ad-vm-b`
* `vm-exchange-a`
* `vm-exchange-b`
* `vm-edge-a`
* `vm-edge-b`
* балансировщик `exchange-lb`
