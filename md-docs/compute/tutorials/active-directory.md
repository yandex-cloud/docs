# Развертывание Active Directory


{% note warning %}

В Yandex Cloud продукты Microsoft можно использовать только с вашими собственными лицензиями и только на выделенных хостах. Подробнее см. [Использование своей лицензии для продуктов Microsoft](../../microsoft/byol.md).

{% endnote %}



В сценарии приводится пример развертывания Active Directory в Yandex Cloud.

Чтобы развернуть инфраструктуру Active Directory:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте облачную сеть и подсети](#create-network).
1. [Создайте скрипт для управления локальной учетной записью администратора](#admin-script).
1. [Создайте виртуальную машину для Active Directory](#ad-vm).
1. [Создайте ВМ для бастионного хоста](#jump-server-vm).
1. [Установите и настройте Active Directory](#install-ad).
1. [Настройте второй контроллер домена](#install-ad-2).
1. [Проверьте работу Active Directory](#test-ad).

Если инфраструктура вам больше не нужна, [удалите все используемые ею ресурсы](#clear-out).

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

В стоимость инсталляции Active Directory входят:
* Плата за постоянно запущенные [ВМ](../concepts/vm.md) (см. [тарифы Yandex Compute Cloud](../pricing.md)).
* Плата за использование динамических или статических [публичных IP-адресов](../../vpc/concepts/address.md#public-addresses) (см. [тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).
* Стоимость исходящего трафика из Yandex Cloud в интернет (см. [тарифы Compute Cloud](../pricing.md)).

## Создайте облачную сеть и подсети {#create-network}

Создайте [облачную сеть](../../vpc/concepts/network.md#network) `ad-network` с [подсетями](../../vpc/concepts/network.md#subnet) во всех [зонах доступности](../../overview/concepts/geo-scope.md), где будут находиться ВМ.
1. Создайте облачную сеть:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     Чтобы создать облачную сеть:
     1. Откройте раздел **Virtual Private Cloud** в [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder), где требуется создать облачную сеть.
     1. Нажмите кнопку **Создать сеть.**
     1. Задайте имя сети: `ad-network`.
     1. Нажмите кнопку **Создать сеть**.

   - CLI {#cli}

     Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

     По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

     Чтобы создать облачную сеть, выполните команду:

     ```bash
     yc vpc network create --name ad-network
     ```

   {% endlist %}

1. Создайте три подсети в сети `ad-network`:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

       Чтобы создать подсеть:
       1. Откройте раздел **Virtual Private Cloud** в каталоге, где требуется создать подсеть.
       1. Нажмите на имя облачной сети.
       1. Нажмите кнопку **Добавить подсеть**.
       1. Заполните форму: введите имя подсети `ad-subnet-a`, выберите зону доступности `ru-central1-a` из выпадающего списка.
       1. Введите CIDR подсети: IP-адрес и маску подсети `10.1.0.0/16`.
       1. Нажмите кнопку **Создать подсеть**.

       Повторите шаги еще для двух подсетей:
       * Название: `ad-subnet-b`. Зона доступности: `ru-central1-b`. CIDR: `10.2.0.0/16`.
       * Название: `ad-subnet-d`. Зона доступности: `ru-central1-d`. CIDR: `10.3.0.0/16`.

   - CLI {#cli}

       Чтобы создать подсети, выполните команды:

       ```bash
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
         --name ad-subnet-d \
         --zone ru-central1-d \
         --network-name ad-network \
         --range 10.3.0.0/16
       ```

   {% endlist %}

## Создайте скрипт для управления локальной учетной записью администратора {#admin-script}

При создании ВМ через CLI необходимо устанавливать пароль для локальной учетной записи администратора.

Для этого в корневой директории командной строки создайте файл с названием `setpass` и без расширения. Скопируйте в файл скрипт и укажите ваш пароль:

```powershell
#ps1
Get-LocalUser | Where-Object SID -like *-500 | Set-LocalUser -Password (ConvertTo-SecureString "<ваш пароль>" -AsPlainText -Force)
```

Пароль должен соответствовать [требованиям к сложности](https://docs.microsoft.com/ru-ru/windows/security/threat-protection/security-policy-settings/password-must-meet-complexity-requirements#справочник).

Подробные рекомендации по защите Active Directory читайте на [сайте разработчика](https://docs.microsoft.com/ru-ru/windows-server/identity/ad-ds/plan/security-best-practices/best-practices-for-securing-active-directory).

## Создайте ВМ для Active Directory {#ad-vm}

Создайте две ВМ для контроллеров домена Active Directory. Эти ВМ не будут иметь доступа в интернет.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице каталога в [консоли управления](https://console.yandex.cloud) нажмите кнопку **Создать ресурс** и выберите `Виртуальная машина`.

  1. В блоке **Образ загрузочного диска**:

      * Перейдите на вкладку **Пользовательский**.
      * Нажмите кнопку **Выбрать** и в открывшемся окне выберите **Создать**.
      * В поле **Наполнение** выберите `Образ` и в списке ниже выберите образ **Windows Server 2022 Datacenter**. Как загрузить свой образ для продуктов Microsoft подробнее см. в разделе [Импортировать нужный образ](../../microsoft/byol.md#how-to-import).
      * (Опционально) В поле **Дополнительно** включите опцию **Удалять вместе с виртуальной машиной**, если вы хотите автоматически удалять этот диск при удалении ВМ.
      * Нажмите кнопку **Добавить диск**.

  1. В блоке **Расположение** выберите зону доступности `ru-central1-a`.
  1. В блоке **Диски и файловые хранилища** задайте размер загрузочного [диска](../concepts/disk.md) `50 ГБ`.
  1. В блоке **Вычислительные ресурсы** перейдите на вкладку `Своя конфигурация` и укажите необходимую [платформу](../concepts/vm-platforms.md), количество vCPU и объем RAM:

      * **Платформа** — `Intel Ice Lake`.
      * **vCPU** — `4`.
      * **Гарантированная доля vCPU** — `100%`.
      * **RAM** — `8 ГБ`.
  1. В блоке **Сетевые настройки** укажите:

      * **Подсеть** — `ad-subnet-a`.
      * **Публичный IP-адрес** — `Без адреса`.
      * Разверните блок **Дополнительно** и в поле **Внутренний IPv4 адрес** выберите `Вручную`.
      * В появившемся поле для ввода укажите `10.1.0.3`.
  1. В блоке **Общая информация** задайте имя ВМ: `ad-vm-a`.
  1. Нажмите кнопку **Создать ВМ**.

  Дождитесь, когда статус ВМ сменится на `Running`, и сбросьте пароль:
  
  1. Выберите виртуальную машину.
  1. Нажмите кнопку **Сбросить пароль**.
  1. Укажите **Имя пользователя**, для которого нужно сбросить пароль. Если у ВМ не существует пользователя с таким именем, он будет создан с правами администратора.
  1. Нажмите кнопку **Сгенерировать пароль**.
  1. Сохраните **Новый пароль**. После закрытия окна он будет недоступен.

  Повторите шаги для ВМ с именем `ad-vm-b` в зоне доступности `ru-central1-b`, подключите ее к подсети `ad-subnet-b` и вручную укажите внутренний IP-адрес `10.2.0.3`.

- CLI {#cli}

  ```bash
  yc compute instance create \
    --name ad-vm-a \
    --hostname ad-vm-a \
    --memory 8 \
    --cores 4 \
    --zone ru-central1-a \
    --network-interface subnet-name=ad-subnet-a,ipv4-address=10.1.0.3 \
    --create-boot-disk image-folder-id=standard-images,image-family=windows-2022-dc-gvlk \
    --metadata-from-file user-data=setpass

  yc compute instance create \
    --name ad-vm-b \
    --hostname ad-vm-b \
    --memory 8 \
    --cores 4 \
    --zone ru-central1-b \
    --network-interface subnet-name=ad-subnet-b,ipv4-address=10.2.0.3 \
    --create-boot-disk image-folder-id=standard-images,image-family=windows-2022-dc-gvlk \
    --metadata-from-file user-data=setpass
  ```

  {% note info %}
  
  Команды [`yc compute instance create`](../../cli/cli-ref/compute/cli-ref/instance/create.md) | [`create-with-container`](../../cli/cli-ref/compute/cli-ref/instance/create-with-container.md) | [`update`](../../cli/cli-ref/compute/cli-ref/instance/update.md) | [`add-metadata`](../../cli/cli-ref/compute/cli-ref/instance/add-metadata.md) поддерживают подстановку в метаданные ВМ значений переменных окружения. Эти значения, заданные в ключе `user-data` в формате `$<имя_переменной>`, в момент выполнения команды Yandex Cloud CLI будут подставлены в метаданные ВМ из переменных окружения среды, в которой выполняется команда. 
  
  Чтобы изменить такое поведение, не подставлять значение переменной из среды выполнения команды CLI и передать в метаданные ВМ имя переменной в формате `$<имя_переменной>`, используйте синтаксис с двумя символами доллара. Например: `$$<имя_переменной>`.
  
  Подробнее в разделе [Особенности передачи переменных окружения в метаданных через CLI](../concepts/metadata/sending-metadata.md#environment-variables).
  
  {% endnote %}

{% endlist %}

## Создайте ВМ для бастионного хоста {#jump-server-vm}

Для настройки ВМ с Active Directory будет использоваться файловый сервер с выходом в интернет.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице каталога в [консоли управления](https://console.yandex.cloud) нажмите кнопку **Создать ресурс** и выберите `Виртуальная машина`.
  1. В блоке **Образ загрузочного диска**:

      * Перейдите на вкладку **Пользовательский**.
      * Нажмите кнопку **Выбрать** и в открывшемся окне выберите **Создать**.
      * В поле **Наполнение** выберите `Образ` и в списке ниже выберите образ **Windows Server 2022 Datacenter**. Как загрузить свой образ для продуктов Microsoft подробнее см. в разделе [Импортировать нужный образ](../../microsoft/byol.md#how-to-import).
      * (Опционально) В поле **Дополнительно** включите опцию **Удалять вместе с виртуальной машиной**, если вы хотите автоматически удалять этот диск при удалении ВМ.
      * Нажмите кнопку **Добавить диск**.
  
  1. В блоке **Расположение** выберите зону доступности `ru-central1-d`.
  1. В блоке **Диски и файловые хранилища** задайте размер загрузочного диска `50 ГБ`.
  1. В блоке **Вычислительные ресурсы** перейдите на вкладку `Своя конфигурация` и укажите необходимую платформу, количество vCPU и объем RAM:

      * **Платформа** — `Intel Ice Lake`.
      * **vCPU** — `2`.
      * **Гарантированная доля vCPU** — `100%`.
      * **RAM** — `4 ГБ`.
  1. В блоке **Сетевые настройки**:
  
      * В поле **Подсеть** выберите подсеть `ad-subnet-d`.
      * В поле **Публичный IP-адрес** оставьте значение `Автоматически`.

  1. В блоке **Общая информация** задайте имя ВМ: `jump-server-vm`.
  1. Нажмите кнопку **Создать ВМ**.

  Дождитесь, когда статус ВМ сменится на `Running`, и сбросьте пароль:
  
  1. Выберите виртуальную машину.
  1. Нажмите кнопку **Сбросить пароль**.
  1. Укажите **Имя пользователя**, для которого нужно сбросить пароль. Если у ВМ не существует пользователя с таким именем, он будет создан с правами администратора.
  1. Нажмите кнопку **Сгенерировать пароль**.
  1. Сохраните **Новый пароль**. После закрытия окна он будет недоступен.

- CLI {#cli}

  ```bash
  yc compute instance create \
    --name jump-server-vm \
    --hostname jump-server-vm \
    --memory 4 \
    --cores 2 \
    --zone ru-central1-d \
    --network-interface subnet-name=ad-subnet-d,nat-ip-version=ipv4 \
    --create-boot-disk image-folder-id=standard-images,image-family=windows-2022-dc-gvlk \
    --metadata-from-file user-data=setpass
  ```

{% endlist %}

## Установите и настройте Active Directory {#install-ad}

У машин с Active Directory нет доступа в интернет, поэтому их следует настраивать через ВМ `jump-server-vm` с помощью [RDP](https://ru.wikipedia.org/wiki/Remote_Desktop_Protocol).
1. [Подключитесь к ВМ](../operations/vm-connect/rdp.md) `jump-server-vm` с помощью RDP. Используйте логин `Administrator` и ваш пароль.
1. Запустите RDP и подключитесь к ВМ `ad-vm-a` — используйте ее локальный IP-адрес, имя пользователя `Administrator` и ваш пароль.
1. Запустите PowerShell и задайте статический IP-адрес:

   ```powershell
   netsh interface ip set address "eth0" static 10.1.0.3 255.255.255.0 10.1.0.1
   ```

1. Установите роли Active Directory:

   ```powershell
   Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
   ```

   Результат:

   ```text
   Success  Restart Needed  Exit Code  Feature Result
   -------  --------------  ---------  --------------
   True     No              Success    {Active Directory Domain Services, Group P...
   ```

1. Создайте лес Active Directory:

   ```powershell
   Install-ADDSForest -DomainName 'yantoso.net' -Force:$true
   ```

   Затем введите пароль и подтвердите его.

   Windows перезапустится автоматически. Снова подключитесь к `ad-vm-a` и откройте PowerShell.
1. Переименуйте сайт по умолчанию в `ru-central1-a`:

   ```powershell
   Get-ADReplicationSite 'Default-First-Site-Name' | Rename-ADObject -NewName 'ru-central1-a'
   ```

1. Создайте еще два сайта для других зон доступности:

   ```powershell
   New-ADReplicationSite 'ru-central1-b'
   New-ADReplicationSite 'ru-central1-d'
   ```

1. Создайте подсети и привяжите их к сайтам:

   ```powershell
   New-ADReplicationSubnet -Name '10.1.0.0/16' -Site 'ru-central1-a'
   New-ADReplicationSubnet -Name '10.2.0.0/16' -Site 'ru-central1-b'
   New-ADReplicationSubnet -Name '10.3.0.0/16' -Site 'ru-central1-d'
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
1. С помощью RDP подключитесь к ВМ `ad-vm-b` — используйте ее локальный IP-адрес, имя пользователя `Administrator` и ваш пароль.
1. Установите роли Active Directory:

   ```powershell
   Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
   ```

   Результат:

   ```text
   Success  Restart Needed  Exit Code       Feature Result
   -------  --------------  ---------       --------------
   True     No              NoChangeNeeded  {}
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

   Windows перезапустится автоматически. Снова подключитесь к `ad-vm-b` и откройте PowerShell.
1. Укажите сервер переадресации DNS:

   ```powershell
   Set-DnsServerForwarder '10.2.0.2'
   ```

## Проверьте работу Active Directory {#test-ad}

1. Подключитесь к ВМ `jump-server-vm` с помощью RDP.
1. С помощью RDP подключитесь к ВМ `ad-vm-b` — используйте ее локальный IP-адрес, имя пользователя `Administrator` и ваш пароль. Запустите PowerShell.
1. Создайте тестового пользователя:

   ```powershell
   New-ADUser testUser
   ```

1. Убедитесь, что пользователь присутствует на обоих серверах:

   ```powershell
   Get-ADUser testUser -Server 10.1.0.3
   Get-ADUser testUser -Server 10.2.0.3
   ```

   Результаты обеих команд должны совпадать:

   ```text
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

Чтобы перестать платить за развернутые серверы, достаточно удалить все созданные [ВМ](../operations/vm-control/vm-delete.md).