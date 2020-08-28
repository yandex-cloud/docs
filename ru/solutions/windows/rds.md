# Развертывание Microsoft Remote Desktop Services

В сценарии описывается развертывание Microsoft Windows Server 2019 Datacenter с предустановленной службой Remote Desktop Services в {{ yandex-cloud }}. Инсталляция Microsoft Windows Server with Remote Desktop Services будет состоять из одного сервера, на котором будут установлены службы Remote Desktop Services и Active Directory. Образы представлены с подготовленными квотами на 5/10/25/50/100/250/500 пользователей. Выберите версию с необходимой квотой. Все примеры приводятся для сервера с квотой на 5 пользователей.

{% note warning %}

Для увеличения квоты необходимо пересоздать ВМ.

{% endnote %}

Чтобы развернуть инфраструктуру Remote Desktop Services:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Необходимые платные ресурсы](#paid-resources).
1. [Создайте облачную сеть и подсети](#create-network).
1. [Создайте скрипт для управления локальной учетной записью администратора](#admin-script).
1. [Создайте ВМ для Remote Desktop Services](#add-vm).
1. [Установите и настройте службу контроллера домена (Active Directory)](#install-ad).
1. [Настройте правила файрвола](#firewall).
1. [Настройте сервер лицензирования в домене](#license-server).
1. [Настройте роль Remote Desktop Session Host](#rdsh).
1. [Создайте пользователей](#create-users).

## Подготовьте облако к работе {#before-you-begin}

Перед тем, как разворачивать серверы, нужно зарегистрироваться в {{ yandex-cloud }} и создать платежный аккаунт:

{% include [prepare-register-billing](../_solutions_includes/prepare-register-billing.md) %}

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать каталог, в котором будет работать ваша виртуальная машина, на [странице облака](https://console.cloud.yandex.ru/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость инсталляции Microsoft Windows Server with Remote Desktop Services входят:

* плата за постоянно запущенные виртуальные машины (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md));
* плата за использование динамических или статических публичных IP-адресов (см. [тарифы {{ vpc-full-name }}](../../vpc/pricing.md));
* стоимость исходящего трафика из {{ yandex-cloud }} в интернет (см. [тарифы {{ compute-full-name }}](../../compute/pricing.md)).

## Создайте облачную сеть и подсети {#create-network}

Создайте облачную сеть `my-network` с подсетями во всех зонах доступности, где будут находиться виртуальные машины.

1. Создайте облачную сеть:

   {% list tabs %}

   - Консоль управления

     Чтобы создать [облачную сеть](../../vpc/concepts/network.md):
     1. Откройте раздел **Virtual Private Cloud** в каталоге, где требуется создать облачную сеть.
     1. Нажмите кнопку **Создать сеть.**
     1. Задайте имя сети: `my-network`.
     1. Нажмите кнопку **Создать сеть**.

   - CLI

     Чтобы создать облачную сеть, выполните команду:

     ```
     $ yc vpc network create --name my-network
     ```

   {% endlist %}

2. Создайте три подсети в сети `my-network`:

   {% list tabs %}

     - Консоль управления

       Чтобы создать подсеть:
       1. Откройте раздел **Virtual Private Cloud** в каталоге, где требуется создать подсеть.
       1. Нажмите на имя облачной сети.
       1. Нажмите кнопку **Добавить подсеть**.
       1. Заполните форму: введите имя подсети `my-subnet-a`, выберите зону доступности `ru-central1-a` из выпадающего списка.
       1. Введите CIDR подсети: IP-адрес и маску подсети: `10.1.0.0/16`. Подробнее про диапазоны IP-адресов в подсетях читайте в разделе [Облачные сети и подсети](../../vpc/concepts/network.md).
       1. Нажмите кнопку **Создать подсеть**.

       Повторите шаги еще для двух подсетей `my-subnet-b` и `my-subnet-c` в зонах доступности `ru-central1-b` и `ru-central1-c` с CIDR `10.2.0.0/16` и `10.3.0.0/16` соответственно.

     - CLI

       Чтобы создать подсети, выполните команды:

       ```
       yc vpc subnet create \
         --name my-subnet-a \
         --zone ru-central1-a \
         --network-name my-network \
         --range 10.1.0.0/16

       yc vpc subnet create \
         --name my-subnet-b \
         --zone ru-central1-b \
         --network-name my-network \
         --range 10.2.0.0/16

       yc vpc subnet create \
         --name my-subnet-c \
         --zone ru-central1-c \
         --network-name my-network \
         --range 10.3.0.0/16
       ```

   {% endlist %}


## Создайте скрипт для управления локальной учетной записью администратора {#admin-script}

Создайте файл `setpass`, содержащий скрипт, который будет устанавливать пароль для локальной учетной записи администратора при создании виртуальных машин через CLI:

{% list tabs %}

- PowerShell

    ```
    #ps1
    Get-LocalUser | Where-Object SID -like *-500 | Set-LocalUser -Password (ConvertTo-SecureString "<ваш пароль>" -AsPlainText -Force)
    ```
{% endlist %}

Пароль должен соответствовать [требованиям к сложности](https://docs.microsoft.com/ru-ru/windows/security/threat-protection/security-policy-settings/password-must-meet-complexity-requirements#справочник).

Подробные рекомендации по защите Active Directory читайте на [сайте разработчика](https://docs.microsoft.com/ru-ru/windows-server/identity/ad-ds/plan/security-best-practices/best-practices-for-securing-active-directory).

## Создайте ВМ для Windows Server with Remote Desktop Services {#add-vm}

Создайте виртуальную машину для Windows Server with Remote Desktop Services. Эта машина будет иметь доступ в интернет.

{% list tabs %}

- Консоль управления

  1. На странице каталога в [консоли управления]({{ link-console-main }}) нажмите кнопку **Создать ресурс** и выберите **Виртуальная машина**.
  1. В поле **Имя** введите имя виртуальной машины: `my-rds-vm`.
  1. Выберите [зону доступности](../../overview/concepts/geo-scope.md) `ru-central1-a`.
  1. В блоке **Образы из {{ marketplace-name }}** нажмите кнопку **Выбрать**. В открывшемся окне выберите образ **Windows RDS**.
  1. В блоке **Диски** укажите размер загрузочного диска 50 ГБ.
  1. В блоке **Вычислительные ресурсы**:
      - Выберите [платформу](../../compute/concepts/vm-platforms.md): Intel Cascade Lake.
      - Укажите необходимое количество vCPU и объем RAM:
         * **vCPU** — 4.
         * **Гарантированная доля vCPU** — 100%.
         * **RAM** — 8 ГБ.

  1. В блоке **Сетевые настройки** нажмите кнопку **Добавить сеть** и выберите сеть `my-network`. Выберите подсеть `my-subnet-a`. В блоке **Публичный адрес** выберите вариант **Без адреса**.
  1. В блоке **Доступ** укажите данные для доступа на виртуальную машину:
      - В поле **Пароль** укажите ваш пароль.
  1. Нажмите кнопку **Создать ВМ**.

- CLI

  ```
   yc compute instance create \
      --name my-rds-vm \
      --hostname my-rds-vm \
      --memory 8 \
      --cores 4 \
      --zone ru-central1-a \
      --network-interface subnet-name=my-subnet-a,ipv4-address=10.1.0.3,nat-ip-version=ipv4 \
      --create-boot-disk image-folder-id=standard-images,image-family=windows-2019-dc-gvlk-rds-5 \
      --metadata-from-file user-data=setpass
  ```

{% endlist %}

## Установите и настройте службу контроллера домена (Active Directory) {#install-ad}

1. Подключитесь к ВМ `my-rds-vm` [с помощью RDP](../../compute/operations/vm-connect/rdp.md). Используйте логин `Administrator` и ваш пароль.
1. Установите роли Active Directory:

    {% list tabs %}
    
    - PowerShell

        ```powershell
        Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
        Restart-Computer -Force
        ```
      
    {% endlist %}

1. Создайте лес Active Directory:

    {% list tabs %}
    
    - PowerShell

        ```powershell
        Install-ADDSForest -DomainName 'yantoso.net' -Force:$true
        ```
      
    {% endlist %}

   Windows перезапустится автоматически. Снова подключитесь к ВМ `my-rds-vm`. Используйте логин `yantoso\Administrator` и ваш пароль. Снова откройте PowerShell.

## Настройте правила файрвола {#firewall}

1. Добавьте правила файрвола, защищающие службу Active Directory от запросов из внешних сетей:
    
    {% list tabs %}
    
    - PowerShell

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

1. Авторизуйте сервер лицензирования в домене. 
    
    Роль находится на контроллере домена, поэтому в `BUILTIN` группу необходимо добавить `Network Service`:
    
    {% list tabs %}
    
    - PowerShell

        ```powershell
        net localgroup "Terminal Server License Servers" /Add 'Network Service'
        ```
      
    {% endlist %}
   
1. Установите тип лицензирования.
    
    {% note info %}
    
    Доступны только `User CAL` лицензии.
    
    {% endnote %}

    {% list tabs %}
    
    - PowerShell

        ```powershell
        New-ItemProperty `
        -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services' `
        -Name 'LicensingMode' `
        -Value 4 `
        -PropertyType 'DWord'
        ```
      
    {% endlist %}
    
1. Укажите службу лицензирования RDS:

    {% list tabs %}
    
    - PowerShell

        ```powershell
        New-ItemProperty `
        -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services' `
        -Name 'LicenseServers' `
        -Value 'localhost' `
        -PropertyType 'String'
        ```
      
    {% endlist %}

1. (Опционально) Ограничьте количество разрешенных одновременных сессий к серверу:

    {% list tabs %}
    
    - PowerShell
        
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

{% list tabs %}

- PowerShell

    ```powershell
    Install-WindowsFeature RDS-RD-Server -IncludeManagementTools
    Restart-Computer -Force
    ```

{% endlist %}

## Создайте пользователей {#create-users}

1. Создайте тестовых пользователей:

    {% list tabs %}
    
    - PowerShell
    
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

    {% list tabs %}
    
    - PowerShell

        ```powershell
        Add-ADGroupMember -Members 'ru1' -Identity 'Remote Desktop Users'
        Add-ADGroupMember -Members 'ru2' -Identity 'Remote Desktop Users'
        Add-ADGroupMember -Members 'ru3' -Identity 'Remote Desktop Users'
        Add-ADGroupMember -Members 'ru4' -Identity 'Remote Desktop Users'
        Add-ADGroupMember -Members 'ru5' -Identity 'Remote Desktop Users'
        ```

    {% endlist %}

1. Настройте права доступа по RDP для группы `Remote Desktop Users`:

    {% list tabs %}
    
    - PowerShell
    
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
