---
title: Установка и развертывание Active Directory (AD) в облаке
description: Пошаговая инструкция процесса установки и развертывания Active Directory (AD) в облаке Yandex.Cloud. Чтобы развернуть инфраструктуру Active Directory (AD) необходимо подготовить облако, создать сеть и подсети, создать ВМ для Active Directory.
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

1. [Подготовьте облако к работе](#before-you-begin)
1. [Необходимые платные ресурсы](#paid-resources)
1. [Создайте облачную сеть и подсети](#create-network)
1. [Создайте скрипт для управления локальной учетной записью администратора](#admin-script)
1. [Создайте ВМ для Active Directory](#ad-vm)
1. [Создайте ВМ для бастионного хоста](#jump-server-vm)
1. [Установите и настройте Active Directory](#install-ad)
1. [Настройте второй контроллер домена](#install-ad-2)
1. [Проверьте работу Active Directory](#test-ad)
1. [Удалите созданные ресурсы](#clear-out)

## Подготовьте облако к работе {#before-you-begin}

Перед тем, как разворачивать серверы, нужно зарегистрироваться в {{ yandex-cloud }} и создать платежный аккаунт:

{% include [prepare-register-billing](includes/prepare-register-billing.md) %}

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать каталог, в котором будет работать ваша виртуальная машина, на [странице облака]{% if region == "int" %}(https://console.cloud.yandex.com/cloud){% else %}(https://console.cloud.yandex.ru/cloud){% endif %}.

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

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

     Чтобы создать облачную сеть, выполните команду:

     ```
     $ yc vpc network create --name ad-network
     ```

   {% endlist %}

1. Создайте три подсети в сети `ad-network`:

   {% list tabs %}

     - Консоль управления

       Чтобы создать подсеть:
       1. Откройте раздел **Virtual Private Cloud** в каталоге, где требуется создать подсеть.
       1. Нажмите на имя облачной сети.
       1. Нажмите кнопку **Добавить подсеть**.
       1. Заполните форму: введите имя подсети `ad-subnet-a`, выберите зону доступности `ru-central1-a` из выпадающего списка.
       1. Введите CIDR подсети: IP-адрес и маску подсети: `10.1.0.0/16`. Подробнее про диапазоны IP-адресов в подсетях читайте в разделе [Облачные сети и подсети](../../vpc/concepts/network.md).
       1. Нажмите кнопку **Создать подсеть**.

       Повторите шаги еще для двух подсетей `ad-subnet-b` и `ad-subnet-c` в зонах доступности `ru-central1-b` и `ru-central1-c` с CIDR `10.2.0.0/16` и `10.3.0.0/16` соответственно.

     - CLI

       Чтобы создать подсети, выполните команды:

       ```
       yc vpc subnet create \
         --name ad-subnet-a \
         --zone ru-central1-a \
         --network-name ad-network \
         --range 10.1.0.0/16

       yc vpc subnet create \
         --name ad-subnet-b \
         --zone ru-central1-b \
         --network-name ad-network \
         --range 10.2.0.0/16

       yc vpc subnet create \
         --name ad-subnet-c \
         --zone ru-central1-c \
         --network-name ad-network \
         --range 10.3.0.0/16
       ```

   {% endlist %}

## Создайте скрипт для управления локальной учетной записью администратора {#admin-script}

Создайте файл `setpass`, содержащий скрипт, который будет устанавливать пароль для локальной учетной записи администратора при создании виртуальных машин через CLI:

```
#ps1
Get-LocalUser | Where-Object SID -like *-500 | Set-LocalUser -Password (ConvertTo-SecureString "<ваш пароль>" -AsPlainText -Force)
```

Пароль должен соответствовать [требованиям к сложности]{% if region == "int" %}(https://docs.microsoft.com/en-us/windows/security/threat-protection/security-policy-settings/password-must-meet-complexity-requirements#справочник){% else %}(https://docs.microsoft.com/ru-ru/windows/security/threat-protection/security-policy-settings/password-must-meet-complexity-requirements#справочник){% endif %}.

Подробные рекомендации по защите Active Directory читайте на [сайте разработчика]{% if region == "int" %}(https://docs.microsoft.com/en-us/windows-server/identity/ad-ds/plan/security-best-practices/best-practices-for-securing-active-directory){% else %}(https://docs.microsoft.com/ru-ru/windows-server/identity/ad-ds/plan/security-best-practices/best-practices-for-securing-active-directory){% endif %}.

## Создайте ВМ для Active Directory {#ad-vm}

Создайте две виртуальных машины для контроллеров домена Active Directory. Эти машины не будут иметь доступа в интернет.

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

## Создайте ВМ для бастионного хоста {#jump-server-vm}

Для настройки машин с Active Directory будет использоваться файловый сервер с выходом в интернет.

{% list tabs %}

- Консоль управления

  1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **Создать ресурс** и выберите **Виртуальная машина**.
  1. В поле **Имя** введите имя виртуальной машины: `jump-server-vm`.
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
      --name jump-server-vm \
      --hostname jump-server-vm \
      --memory 4 \
      --cores 2 \
      --zone ru-central1-c \
      --network-interface subnet-name=exchange-subnet-c,nat-ip-version=ipv4 \
      --create-boot-disk image-folder-id=standard-images,image-family=windows-2016-gvlk \
      --metadata-from-file user-data=setpass
  ```

{% endlist %}

## Установите и настройте Active Directory {#install-ad}

У машин с Active Directory нет доступа в интернет, поэтому их следует настраивать через ВМ `jump-server-vm` с помощью RDP.

1. Подключитесь к ВМ `jump-server-vm` с помощью RDP. Используйте логин `Administrator` и ваш пароль.
1. Запустите RDP и подключитесь к виртуальной машине `ad-vm-a`.
1. Запустите PowerShell и задайте статический адрес:

   ```powershell
   netsh interface ip set address "Ethernet 2" static 10.1.0.3 255.255.255.0 10.1.0.1
   ```

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

1. Создайте лес Active Directory:

   ```powershell
   Install-ADDSForest -DomainName 'yantoso.net' -Force:$true
   ```

   Windows перезапустится автоматически. Снова откройте PowerShell.

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

1. Подключитесь к ВМ `jump-server-vm` с помощью RDP.
1. С помощью RDP подключитесь к виртуальной машине `ad-vm-b`. Используйте логин `Administrator` и ваш пароль.
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

   Windows перезапустится автоматически. Снова откройте PowerShell.

1. Укажите сервер переадресации DNS:

   ```powershell
   Set-DnsServerForwarder '10.2.0.2'
   ```

## Проверьте работу Active Directory {#test-ad}

1. Подключитесь к ВМ `jump-server-vm` с помощью RDP.
1. С помощью RDP подключитесь к виртуальной машине `ad-vm-b`. Используйте логин `Administrator` и ваш пароль. Запустите PowerShell.
1. Создайте тестового пользователя:

   ```powershell
   New-ADUser testUser
   ```
1. Убедитесь, что пользователь присутствует на обоих серверах:

   ```
   Get-ADUser testUser -Server yadc-b
   Get-ADUser testUser -Server yadc-a
   ```

## Удалите созданные ресурсы {#clear-out}

Чтобы перестать платить за развернутые серверы, достаточно удалить все созданные [виртуальные машины](../../compute/operations/vm-control/vm-delete.md).
