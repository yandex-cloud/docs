# Безопасная передача пароля в скрипт инициализации с помощью Terraform

Чтобы [создать ВМ и защитить конфиденциальную информацию в скрипте инициализации](index.md) с помощью Terraform:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Авторизуйтесь в ОС Windows](#login-windows).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входит:
* плата за постоянно запущенные [ВМ](../../../compute/concepts/vm.md) (см. [тарифы Yandex Compute Cloud](../../../compute/pricing.md));
* плата за использование [образа](../../../compute/concepts/image.md) (зависит от образа);
* плата за использование [ключа](../../../kms/concepts/key.md) KMS (см. [тарифы KMS](../../../kms/pricing.md));
* плата за использование [секрета](../../../lockbox/concepts/secret.md) (см. [тарифы Yandex Lockbox](../../../lockbox/pricing.md)).


## Создайте инфраструктуру {#deploy}

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

Для создания инфраструктуры с помощью Terraform:
1. [Установите Terraform](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера Yandex Cloud (раздел [Настройте провайдер](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

   {% list tabs group=infrastructure_description %}

   - Готовая конфигурация {#ready}

     1. Клонируйте репозиторий с конфигурационными файлами.

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-secured-password.git
        ```

     1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
        * `yc-secured-password.tf` — конфигурация создаваемой инфраструктуры.
        * `script.tpl` — шаблон скрипта создания учетных записей администратора и пользователей.
        * `yc-secured-password.auto.tfvars` — файл с пользовательскими данными.

   - Вручную {#manual}

     1. Создайте папку для конфигурационных файлов.
     1. Создайте в папке:
        1. Конфигурационный файл `yc-secured-password.tf`:

           {% cut "yc-secured-password.tf" %}

           ```hcl
           # Настройка провайдера
           
           terraform {
             required_providers {
               yandex = {
                 source  = "yandex-cloud/yandex"
                 version = ">= 0.47.0"
               }
             }
           }
           
           provider "yandex" {
             folder_id = var.folder_id
           }
           
           # Объявление переменных для конфиденциальных параметров
           
           variable "zone" {
             type = string
           }
           
           variable "folder_id" {
             type = string
           }
           
           variable "admin_pass" {
             type = string
             sensitive = true
           }
           
           variable "username" {
             type = string
           }
           
           variable "user_pass" {
             type = string
             sensitive = true
           }
           
           variable "image_family" {
             type = string
           }
           
           # Создание облачной сети и подсети
           
           resource "yandex_vpc_network" "network-1" {
             name = "win-network"
           }
           
           # Создание подсети
           
           resource "yandex_vpc_subnet" "subnet-a" {
             name           = "win-subnet"
             zone           = var.zone
             v4_cidr_blocks = ["192.168.1.0/24"]
             network_id     = yandex_vpc_network.network-1.id
           }
           
           # Создание группы безопасности
           
           resource "yandex_vpc_security_group" "vm-sg" {
             name        = "vm_security_group"
             network_id  = yandex_vpc_network.network-1.id
             egress {
               protocol       = "ANY"
               description    = "any"
               from_port      = 0
               to_port        =  65535
               v4_cidr_blocks = ["0.0.0.0/0"]
             }
             ingress {
               protocol       = "TCP"
               description    = "ext-http"
               v4_cidr_blocks = ["0.0.0.0/0"]
               port           = 80
             } 
             ingress {
               protocol       = "TCP"
               description    = "ext-https"
               v4_cidr_blocks = ["0.0.0.0/0"]
               port           = 443
             }
           
             ingress {
               protocol       = "TCP"
               description    = "ext-https"
               v4_cidr_blocks = ["0.0.0.0/0"]
               port           = 3389
             }
           }
           
           # Создание сервисного аккаунта
           
           resource "yandex_iam_service_account" "my-sa" {
             name = "win-secret-sa"
           }
           
           # Назначение прав сервисному аккаунту
           
           resource "yandex_resourcemanager_folder_iam_member" "view-keys" {
             folder_id = var.folder_id
             role      = "kms.keys.encrypterDecrypter"
             member    = "serviceAccount:${yandex_iam_service_account.my-sa.id}"
           }
           
           resource "yandex_resourcemanager_folder_iam_member" "view-payload" {
             folder_id = var.folder_id
             role      = "lockbox.payloadViewer"
             member    = "serviceAccount:${yandex_iam_service_account.my-sa.id}"
           }
           
           # Создание симметричного KMS-ключа шифрования
           
           resource "yandex_kms_symmetric_key" "key-a" {
             name                = "win-secret-key"
             default_algorithm   = "AES_128"
             rotation_period     = "8760h"
           }
           
           # Создание секрета
           
           resource "yandex_lockbox_secret" "win_secret" {
               name                = "win-secret"
               folder_id           = var.folder_id
               kms_key_id          = yandex_kms_symmetric_key.key-a.id
           }
           
           # Создание версии секрета
           
           resource "yandex_lockbox_secret_version_hashed" "win_secret_version" {
             secret_id = yandex_lockbox_secret.win_secret.id
             key_1        = "Administrator"
             text_value_1 = var.admin_pass
             key_2        = var.username
             text_value_2 = var.user_pass
           }
           
           # Создание загрузочного диска для ВМ
           
           data "yandex_compute_image" "default" {
             family = var.image_family
           }
           
           resource "yandex_compute_disk" "boot-disk" {
             type     = "network-ssd"
             zone     = var.zone
             size     = "100"
             image_id = data.yandex_compute_image.default.id
           }
           
           # Создание ВМ
           
           resource "yandex_compute_instance" "my-vm" {
             name               = "win-test"
             platform_id        = "standard-v2"
             zone               = var.zone
             service_account_id = yandex_iam_service_account.my-sa.id
           
             resources {
               cores  = "2"
               memory = "4"
             }
           
             boot_disk {
               disk_id = yandex_compute_disk.boot-disk.id
             }
           
             network_interface {
               subnet_id          = yandex_vpc_subnet.subnet-a.id
               nat                = true
               security_group_ids = ["${yandex_vpc_security_group.vm-sg.id}"]
             }
           
             metadata = {
               serial-port-enable = 1
               user-data = templatefile("script.tpl", { MYSECRET_ID = yandex_lockbox_secret.win_secret.id })
             } 
           }
           ```

           {% endcut %}

        1. `script.tpl` — шаблон скрипта создания учетных записей администратора и пользователей:

           {% cut "script.tpl" %}

           ```hcl
           #ps1

           # logging
           Start-Transcript -Path "$ENV:SystemDrive\provision2.txt" -IncludeInvocationHeader -Force
           "Bootstrap script started" | Write-Host

           # SECRET'S ID:
           $SecretID = "${MYSECRET_ID}"

           [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
           $SecretURL = "https://payload.lockbox.api.cloud.yandex.net/lockbox/v1/secrets/$SecretID/payload"

           "Secret ID is $SecretID"
           "Payload URL is $SecretURL"

           $YCToken = (Invoke-RestMethod -Headers @{'Metadata-Flavor'='Google'} -Uri "http://169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token").access_token
           if (!$YCToken) {
              throw "Service Account doesn't connected to VM. Please, add Service account with roles lockbox.payloadViewer and kms.key.encryptorDecryptor to VM and try again."
           }

           # Creating parameters for REST-invokations
           $Headers = @{
              Authorization="Bearer $YCToken"
           }

           $Params = @{
              Uri = $SecretURL
              Method = "GET"
              Headers = $Headers
           }

           # Getting secret via REST invoke
           $Secret = Invoke-RestMethod @Params
           $SecretAdministratorPlainTextPassword = $Secret.entries[0].textValue

           # inserting value's from terraform
           if (-not [string]::IsNullOrEmpty($SecretAdministratorPlainTextPassword)) {
              "Set local administrator password" | Write-Host
              $SecretAdministratorPassword = $SecretAdministratorPlainTextPassword | ConvertTo-SecureString -AsPlainText -Force
              # S-1-5-21domain-500 is a well-known SID for Administrator
              # https://docs.microsoft.com/en-us/troubleshoot/windows-server/identity/security-identifiers-in-windows
              $Administrator = Get-LocalUser | Where-Object -Property "SID" -like "S-1-5-21-*-500"
              $Administrator | Set-LocalUser -Password $SecretAdministratorPassword
           }

           # Creating new users if any
           if($Secret.entries.count -gt 1) {
              foreach($User in $Secret.entries[1..($Secret.entries.count-1)]){
                 $SecretUserPassword = $User.textValue | ConvertTo-SecureString -AsPlainText -Force
                 New-LocalUser -Name $User.key -Password $SecretUserPassword -FullName $User.key
                 Add-LocalGroupMember -Group Users -Member $User.key
                 Add-LocalGroupMember -Group "Remote Desktop Users" -Member $User.key
              }
           }

           "Bootstrap script ended" | Write-Host
           ```

           {% endcut %}

        1. Файл с пользовательскими данными `yc-secured-password.auto.tfvars`:

           ```hcl
           zone         = "<зона_доступности>"
           folder_id    = "<идентификатор_каталога>"
           admin_pass   = "<пароль_администратора>"
           username     = "<имя_пользователя>"
           user_pass    = "<пароль_пользователя>"
           image_family = "<семейство_образа>"
           ```

   {% endlist %}

   Более подробную информацию о параметрах используемых ресурсов в Terraform см. в документации провайдера:

   * [Облачная сеть](../../../vpc/concepts/network.md) — [yandex_vpc_network](../../../terraform/resources/vpc_network.md). 
   * [Подсеть](../../../vpc/concepts/network.md#subnet) — [yandex_vpc_subnet](../../../terraform/resources/vpc_subnet.md).
   * [Группа безопасности](../../../vpc/concepts/security-groups.md) — [yandex_vpc_security_group](../../../terraform/resources/vpc_security_group.md).
   * [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account](../../../terraform/resources/iam_service_account.md).
   * [Назначение прав](../../../iam/concepts/access-control/index.md#access-bindings) — [yandex_resourcemanager_folder_iam_member](../../../terraform/resources/resourcemanager_folder_iam_member.md).
   * [Симметричный ключ шифрования](../../../kms/concepts/key.md) — [yandex_kms_symmetric_key](../../../terraform/resources/kms_symmetric_key.md).
   * [Секрет](../../../lockbox/concepts/secret.md) — [yandex_lockbox_secret](../../../terraform/resources/lockbox_secret.md).
   * [Версия секрета](../../../lockbox/concepts/secret.md#version) — [yandex_lockbox_secret_version_hashed](../../../terraform/resources/lockbox_secret_version_hashed.md).
   * [Образ](../../../compute/concepts/image.md) — [yandex_compute_image](../../../terraform/resources/compute_image.md).
   * [Диск](../../../compute/concepts/disk.md) — [yandex_compute_disk](../../../terraform/resources/compute_disk.md).
   * [Виртуальная машина](../../../compute/concepts/vm.md) — [yandex_compute_instance](../../../terraform/resources/compute_instance.md).

1. В файле `yc-secured-password.auto.tfvars` задайте пользовательские параметры:
   * `zone` — [зона доступности](../../../overview/concepts/geo-scope.md).
   * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
   * `admin_pass` — пароль администратора.

       {% note warning %}
       
       При выборе пароля обязательно соблюдайте требования к безопасности пароля, иначе учетная запись для пользователя не будет создана.
       Пароль должен:
       
       * быть не короче восьми символов;
       * не содержать в себе имени учетной записи;
       * содержать знаки минимум трех из четырех групп:
          * латинские заглавные буквы (A-Z);
          * латинские строчные буквы (a-z);
          * цифры (0-9);
          * неалфавитные символы (!, ?, %, $, # и т. д.).
       
       {% endnote %}

   * `username` — имя пользователя.
   * `user_pass` — пароль пользователя.
   * `image_family` — семейство одного из [образов](../../../compute/concepts/image.md) ВМ с нужной версией ОС.

1. Создайте ресурсы:

   1. В терминале перейдите в директорию с конфигурационным файлом.
   1. Проверьте корректность конфигурации с помощью команды:
   
      ```bash
      terraform validate
      ```
   
      Если конфигурация является корректной, появится сообщение:
   
      ```bash
      Success! The configuration is valid.
      ```
   
   1. Выполните команду:
   
      ```bash
      terraform plan
      ```
   
      В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
   1. Примените изменения конфигурации:
   
      ```bash
      terraform apply
      ```
   
   1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

После создания инфраструктуры [авторизуйтесь в ОС Windows](#login-windows).


## Авторизуйтесь в ОС Windows {#login-windows}

Чтобы проверить, что данные из секрета были успешно использованы для создания пользователей, авторизуйтесь в ОС виртуальной машины:

1. В [консоли управления](https://console.yandex.cloud) выберите каталог, которому принадлежит виртуальная машина.
1. Перейдите в сервис **Compute Cloud**.
1. Выберите виртуальную машину `win-test`.
1. Перейдите на вкладку **Серийная консоль**.
1. В блоке **Серийная консоль** выберите `COM2` и нажмите кнопку **Подключиться**. В командной строке отобразится приглашение ввода команд:

    ```bash
    Computer is booting, SAC started and initialized.                               
                                                                                    
    Use the "ch -?" command for information about using channels.                   
    Use the "?" command for general help.                                           
                                                                                    
                                                                                    
    SAC>                                                                            
    EVENT: The CMD command is now available.                                         
    ```

1. Просмотрите список открытых каналов:

    ```bash
    SAC>ch
    Channel List

    (Use "ch -?" for information on using channels)

    # Status  Channel Name
    0 (AV)    SAC
    ```

1. При необходимости создайте новый канал с экземпляром командной оболочки:

    ```bash
    SAC>cmd
    The Command Prompt session was successfully launched.
    SAC>
    EVENT:   A new channel has been created.  Use "ch -?" for channel help.
    Channel: Cmd0001
    ```

1. Чтобы перейти на канал, нажмите сочетание клавиш **ESC** + **TAB** или выполните команду:

    ```bash
    SAC>ch -sn Cmd0001
    Name:                  Cmd0001
    Description:           Command
    Type:                  VT-UTF8
    Channel GUID:          e203fb79-d80d-11ea-87e3-c2679e14957d
    Application Type GUID: 63d02271-8aa4-11d5-bccf-00b0d014a2d0

    Press <esc><tab> for next channel.
    Press <esc><tab>0 to return to the SAC channel.
    Use any other key to view this channel.
    ```

1. Нажмите **Enter** и последовательно введите:

    * Имя пользователя.
    * Домен, если вход выполняется под доменной учетной записью. Иначе введите имя хоста либо оставьте пустым.
    * Пароль.

    ```bash
    Please enter login credentials.
    Username: Administrator
    Domain  :
    Password: ***************
    ```

1. Если авторизация прошла успешно, запустится экземпляр интерпретатора командной строки:

    ```bash
    C:\Windows\system32>
    ```

    Успешная авторизация означает, что данные из секрета были использованы при создании виртуальной машины.


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `yc-secured-password.tf` и удалите описание создаваемой инфраструктуры из файла.
1. Примените изменения:

    1. В терминале перейдите в директорию с конфигурационным файлом.
    1. Проверьте корректность конфигурации с помощью команды:
    
       ```bash
       terraform validate
       ```
    
       Если конфигурация является корректной, появится сообщение:
    
       ```bash
       Success! The configuration is valid.
       ```
    
    1. Выполните команду:
    
       ```bash
       terraform plan
       ```
    
       В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
    1. Примените изменения конфигурации:
    
       ```bash
       terraform apply
       ```
    
    1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.


#### Полезные ссылки {#see-also}

* [Безопасная передача пароля в скрипт инициализации с помощью консоли управления, CLI или API](console.md)