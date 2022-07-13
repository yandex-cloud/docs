---
title: Установка и развертывание Active Directory (AD) в облаке
description: Пошаговая инструкция процесса установки и развертывания Active Directory (AD) в облаке {{ yandex-cloud }}. Чтобы развернуть инфраструктуру Active Directory (AD) необходимо подготовить облако, создать сеть и подсети, создать ВМ для Active Directory.
keywords:
  - установка Active Directory
  - развертывание Active Directory
  - установка AD
  - active directory
  - active directory как запустить
  - планирование active directory
  - настройка ad
  - настройка active directory
---

# Развертывание Active Directory


В сценарии приводится пример развертывания Active Directory в {{ yandex-cloud }}.

Чтобы развернуть инфраструктуру Active Directory:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте облачную сеть и подсети](#create-network).
1. [Создайте скрипт для управления локальной учетной записью администратора](#admin-script).
1. [Создайте ВМ для Active Directory](#ad-vm).
1. [Создайте ВМ для бастионного хоста](#jump-server-vm).
1. [Установите и настройте Active Directory](#install-ad).
1. [Настройте второй контроллер домена](#install-ad-2).
1. [Проверьте работу Active Directory](#test-ad).

Если инфраструктура вам больше не нужна, [удалите все используемые ею ресурсы](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

{% include [ms-additional-data-note](../includes/ms-additional-data-note.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость инсталляции Active Directory входят:

* плата за постоянно запущенные виртуальные машины (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование динамических или статических публичных IP-адресов (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md));
* стоимость исходящего трафика из {{ yandex-cloud }} в интернет (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).


## Создайте облачную сеть и подсети {#create-network}

Создайте облачную сеть `ad-network` с подсетями во всех зонах доступности, где будут находиться виртуальные машины.

1. Создайте облачную сеть:

   {% list tabs %}

   - Консоль управления

     Чтобы создать [облачную сеть](../../vpc/concepts/network.md):
     1. Откройте раздел **Virtual Private Cloud** в каталоге, где требуется создать облачную сеть.
     1. Нажмите кнопку **Создать сеть.**
     1. Задайте имя сети: `ad-network`.
     1. Нажмите кнопку **Создать сеть**.

   - CLI

     {% include [cli-install](../../_includes/cli-install.md) %}

     {% include [default-catalogue](../../_includes/default-catalogue.md) %}

     Чтобы создать облачную сеть, выполните команду:

     ```powershell
     yc vpc network create --name ad-network
     ```

   {% endlist %}

1. Создайте три подсети в сети `ad-network`:

   {% list tabs %}

     - Консоль управления

       Чтобы создать подсеть:
       1. Откройте раздел **Virtual Private Cloud** в каталоге, где требуется создать подсеть.
       1. Нажмите на имя облачной сети.
       1. Нажмите кнопку **Добавить подсеть**.
       1. Заполните форму: введите имя подсети `ad-subnet-a`, выберите зону доступности `{{ region-id }}-a` из выпадающего списка.
       1. Введите CIDR подсети: IP-адрес и маску подсети: `10.1.0.0/16`. Подробнее про диапазоны IP-адресов в подсетях читайте в разделе [Облачные сети и подсети](../../vpc/concepts/network.md).
       1. Нажмите кнопку **Создать подсеть**.

       Повторите шаги еще для двух подсетей:

         * Название: `ad-subnet-b`. Зона доступности: `{{ region-id }}-b`. CIDR: `10.2.0.0/16`.
         * Название: `ad-subnet-c`. Зона доступности: `{{ region-id }}-c`. CIDR: `10.3.0.0/16`.

     - CLI

       Чтобы создать подсети, выполните команды:

       ```powershell
       yc vpc subnet create \
         --name ad-subnet-a \
         --zone {{ region-id }}-a \
         --network-name ad-network \
         --range 10.1.0.0/16

       yc vpc subnet create \
         --name ad-subnet-b \
         --zone {{ region-id }}-b \
         --network-name ad-network \
         --range 10.2.0.0/16

       yc vpc subnet create \
         --name ad-subnet-c \
         --zone {{ region-id }}-c \
         --network-name ad-network \
         --range 10.3.0.0/16
       ```

   {% endlist %}

## Создайте скрипт для управления локальной учетной записью администратора {#admin-script}

При создании виртуальных машин через CLI необходимо устанавливать пароль для локальной учетной записи администратора.

Для этого в корневой директории командной строки создайте файл с названием `setpass` и без расширения. Скопируйте в файл скрипт и укажите ваш пароль:

```powershell
#ps1
Get-LocalUser | Where-Object SID -like *-500 | Set-LocalUser -Password (ConvertTo-SecureString "<ваш пароль>" -AsPlainText -Force)
```

Пароль должен соответствовать [требованиям к сложности]({{ ms.docs }}/windows/security/threat-protection/security-policy-settings/password-must-meet-complexity-requirements#справочник).

Подробные рекомендации по защите Active Directory читайте на [сайте разработчика]({{ ms.docs }}/windows-server/identity/ad-ds/plan/security-best-practices/best-practices-for-securing-active-directory).

## Создайте ВМ для Active Directory {#ad-vm}

Создайте две виртуальных машины для контроллеров домена Active Directory. Эти машины не будут иметь доступа в интернет.

{% list tabs %}

- Консоль управления

  1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **Создать ресурс** и выберите **Виртуальная машина**.
  1. В поле **Имя** введите имя виртуальной машины: `ad-vm-a`.
  1. Выберите [зону доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-a`.
  1. В блоке **Выбор образа/загрузочного диска** → **{{ marketplace-name }}** нажмите кнопку **Посмотреть больше**. В открывшемся окне выберите образ [Windows Server 2019 Datacenter](/marketplace/products/yc/windows-server-2019-datacenter) и нажмите **Использовать**.
  1. В блоке **Диски** укажите размер загрузочного диска 50 ГБ.
  1. В блоке **Вычислительные ресурсы**:

      * Выберите [платформу](../../compute/concepts/vm-platforms.md) **Intel Ice Lake**.
      * Укажите необходимое количество vCPU и объем RAM:
         * **vCPU** — 4.
         * **Гарантированная доля vCPU** — 100%.
         * **RAM** — 8 ГБ.

  1. В блоке **Сетевые настройки**:
  
      * Выберите подсеть `ad-subnet-a`.
      * **Публичный адрес** — **Без адреса**.
      * **Внутренний адрес** — выберите **Вручную** и укажите `10.1.0.3`.

  1. В блоке **Доступ** в поле **Пароль** укажите ваш пароль.
  1. Нажмите кнопку **Создать ВМ**.

  Повторите операцию для ВМ с именем `ad-vm-b` в зоне доступности `{{ region-id }}-b`, подключите ее к подсети `ad-subnet-b` и вручную укажите внутренний адрес `10.2.0.3`.

- CLI

  ```powershell
  yc compute instance create \
    --name ad-vm-a \
    --hostname ad-vm-a \
    --memory 8 \
    --cores 4 \
    --zone {{ region-id }}-a \
    --network-interface subnet-name=ad-subnet-a,ipv4-address=10.1.0.3 \
    --create-boot-disk image-folder-id=standard-images,image-family=windows-2019-dc-gvlk \
    --metadata-from-file user-data=setpass

  yc compute instance create \
    --name ad-vm-b \
    --hostname ad-vm-b \
    --memory 8 \
    --cores 4 \
    --zone {{ region-id }}-b \
    --network-interface subnet-name=ad-subnet-b,ipv4-address=10.2.0.3 \
    --create-boot-disk image-folder-id=standard-images,image-family=windows-2019-dc-gvlk \
    --metadata-from-file user-data=setpass
  ```

{% endlist %}

## Создайте ВМ для бастионного хоста {#jump-server-vm}

Для настройки машин с Active Directory будет использоваться файловый сервер с выходом в интернет.

{% list tabs %}

- Консоль управления

  1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **Создать ресурс** и выберите **Виртуальная машина**.
  1. В поле **Имя** введите имя виртуальной машины: `jump-server-vm`.
  1. Выберите [зону доступности](../../overview/concepts/geo-scope.md) `{{ region-id }}-c`.
  1. В блоке **Выбор образа/загрузочного диска** → **{{ marketplace-name }}** нажмите кнопку **Посмотреть больше**. В открывшемся окне выберите образ [Windows Server 2019 Datacenter](/marketplace/products/yc/windows-server-2019-datacenter) и нажмите **Использовать**.
  1. В блоке **Диски** укажите размер загрузочного диска 50 ГБ.
  1. В блоке **Вычислительные ресурсы**:

      * Выберите [платформу](../../compute/concepts/vm-platforms.md): Intel Ice Lake.
      * Укажите необходимое количество vCPU и объем RAM:
         * **vCPU** — 2.
         * **Гарантированная доля vCPU** — 100%.
         * **RAM** — 4 ГБ.

  1. В блоке **Сетевые настройки** выберите подсеть `ad-subnet-c`. В блоке **Публичный адрес** выберите вариант **Автоматически**.
  1. В блоке **Доступ** в поле **Пароль** укажите ваш пароль.
  1. Нажмите кнопку **Создать ВМ**.

- CLI

  ```powershell
  yc compute instance create \
    --name jump-server-vm \
    --hostname jump-server-vm \
    --memory 4 \
    --cores 2 \
    --zone {{ region-id }}-c \
    --network-interface subnet-name=ad-subnet-c,nat-ip-version=ipv4 \
    --create-boot-disk image-folder-id=standard-images,image-family=windows-2019-dc-gvlk \
    --metadata-from-file user-data=setpass
  ```

{% endlist %}

## Установите и настройте Active Directory {#install-ad}

У машин с Active Directory нет доступа в интернет, поэтому их следует настраивать через ВМ `jump-server-vm` с помощью [RDP](https://ru.wikipedia.org/wiki/Remote_Desktop_Protocol).

1. [Подключитесь к ВМ](../../compute/operations/vm-connect/rdp.md) `jump-server-vm` с помощью RDP. Используйте логин `Administrator` и ваш пароль.
1. Запустите RDP и подключитесь к виртуальной машине `ad-vm-a` — используйте ее локальный IP адрес, имя пользователя `Administrator` и ваш пароль.
1. Запустите PowerShell и задайте статический адрес:

   ```powershell
   netsh interface ip set address "eth0" static 10.1.0.3 255.255.255.0 10.1.0.1
   ```

1. Установите роли Active Directory:

   ```powershell
   Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
   ```
   
   Результат:

   ```powershell
   Success Restart Needed Exit Code      Feature Result
   ------- -------------- ---------      --------------
   True    No             Success        {Active Directory Domain Services, Group P...
   ```

1. Создайте лес Active Directory:

   ```powershell
   Install-ADDSForest -DomainName 'yantoso.net' -Force:$true
   ```

   Затем введите пароль и подтвердите его.

   Windows перезапустится автоматически. Снова подключитесь к `ad-vm-a` и откройте PowerShell.

1. Переименуйте сайт по умолчанию в `{{ region-id }}-a`:

   ```powershell
   Get-ADReplicationSite 'Default-First-Site-Name' | Rename-ADObject -NewName '{{ region-id }}-a'
   ```

1. Создайте еще два сайта для других зон доступности:

   ```powershell
   New-ADReplicationSite '{{ region-id }}-b'
   New-ADReplicationSite '{{ region-id }}-c'
   ```

1. Создайте подсети и привяжите их к сайтам:

   ```powershell
   New-ADReplicationSubnet -Name '10.1.0.0/16' -Site '{{ region-id }}-a'
   New-ADReplicationSubnet -Name '10.2.0.0/16' -Site '{{ region-id }}-b'
   New-ADReplicationSubnet -Name '10.3.0.0/16' -Site '{{ region-id }}-c'
   ```

1. Переименуйте сайт-линк и настройте репликацию:

   ```powershell
   Get-ADReplicationSiteLink 'DEFAULTIPSITELINK' | `
       Set-ADReplicationSiteLink -SitesIncluded @{Add='{{ region-id }}-b'} -ReplicationFrequencyInMinutes 15 -PassThru | `
       Set-ADObject -Replace @{options = $($_.options -bor 1)} -PassThru | `
       Rename-ADObject -NewName '{{ region-id }}'
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

1. Подключитесь к ВМ `jump-server-vm` с помощью RDP.
1. С помощью RDP подключитесь к виртуальной машине `ad-vm-b` — используйте ее локальный IP адрес, имя пользователя `Administrator` и ваш пароль.
1. Установите роли Active Directory:

   ```powershell
   Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
   ```
   
   Результат:

   ```powershell
   Success Restart Needed Exit Code      Feature Result
   ------- -------------- ---------      --------------
   True    No             NoChangeNeeded {}
   ```

1. Настройте DNS-клиент:

   ```powershell
   Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses "10.1.0.3,127.0.0.1"
   ```

1. Настройте статический IP-адрес:

   ```powershell
   netsh interface ip set address "eth0" static 10.2.0.3 255.255.255.0 10.2.0.1
   ```

1. Добавьте контроллер в домен:

   ```powershell
   Install-ADDSDomainController `
       -Credential (Get-Credential "yantoso\Administrator") `
       -DomainName 'yantoso.net' `
       -Force:$true
   ```

   Затем введите пароль и подтвердите его.

   Windows перезапустится автоматически. Снова подключитесь к `ad-vm-a` и откройте PowerShell.

1. Укажите сервер переадресации DNS:

   ```powershell
   Set-DnsServerForwarder '10.2.0.2'
   ```

## Проверьте работу Active Directory {#test-ad}

1. Подключитесь к ВМ `jump-server-vm` с помощью RDP.
1. С помощью RDP подключитесь к виртуальной машине `ad-vm-b` — используйте ее локальный IP адрес, имя пользователя `Administrator` и ваш пароль. Запустите PowerShell.
1. Создайте тестового пользователя:

   ```powershell
   New-ADUser testUser
   ```
1. Убедитесь, что пользователь присутствует на обоих серверах:

   ```powershell
   Get-ADUser testUser -Server 10.1.0.3
   Get-ADUser testUser -Server 10.2.0.3
   ```

   Результат:

   ```powershell
   DistinguishedName : CN=testUser,CN=Users,DC=yantoso,DC=net
   Enabled           : False
   GivenName         :
   Name              : testUser
   ObjectClass       : user
   ObjectGUID        : 7202f41a-(...)-2d168ecd5271
   SamAccountName    : testUser
   SID               : S-1-5-21-(...)-1105
   Surname           :
   UserPrincipalName :

   DistinguishedName : CN=testUser,CN=Users,DC=yantoso,DC=net
   Enabled           : False
   GivenName         :
   Name              : testUser
   ObjectClass       : user
   ObjectGUID        : 7202f41a-(...)-2d168ecd5271
   SamAccountName    : testUser
   SID               : S-1-5-21-(...)-1105
   Surname           :
   UserPrincipalName :
   ```

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за развернутые серверы, достаточно удалить все созданные [виртуальные машины](../../compute/operations/vm-control/vm-delete.md).
