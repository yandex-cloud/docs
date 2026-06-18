# Загрузка состояний Terraform в Yandex Object Storage


[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).


Подробнее о Terraform [читайте в документации](terraform-quickstart.md#install-terraform).

В инструкции описываются шаги загрузки состояния Terraform в [Object Storage](../../storage/index.md).

Состояние Terraform описывает текущую развернутую инфраструктуру и хранится в файлах с расширением `.tfstate`. Файл состояния создается после развертывания инфраструктуры и может быть сразу загружен в Object Storage. Загруженный файл состояния будет обновляться после изменений созданной инфраструктуры.

В этом примере сохраненное состояние позволит другим пользователям получить идентификатор одной из созданных [подсетей](../../vpc/concepts/network.md#subnet), чтобы подключить к ней новую [виртуальную машину](../../compute/concepts/vm.md).

Чтобы настроить хранение состояний Terraform в Object Storage и использовать его для создания новых ресурсов:
1. [Подготовьте облако к работе](#before-you-begin).
1. [Необходимые платные ресурсы](#paid-resources).
1. [Установите и настройте Terraform](#install-terraform).
1. [Настройте бэкенд](#set-up-backend).
1. [Разверните конфигурацию](#deploy).
1. [Проверьте сохраненное состояние](#check-condition).
1. [Получите состояние из бэкенда](#retrieve-state).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для загрузки состояний Terraform в Yandex Object Storage входит плата за хранение данных ([тарифы Object Storage](../../storage/pricing.md#prices-storage)).

В качестве примера инфраструктуры, разворачиваемой через Terraform, в руководстве будут созданы три [ВМ](../../compute/concepts/vm.md) с [публичными IP-адресами](../../vpc/concepts/address.md#public-addresses), виртуальная [сеть](../../vpc/concepts/network.md#network) и две [подсети](../../vpc/concepts/network.md#subnet). В стоимость поддержки этой инфраструктуры входят:
* Плата за [диски](../../compute/concepts/disk.md) и постоянно запущенные ВМ ([тарифы Yandex Compute Cloud](../../compute/pricing.md)).
* Плата за использование динамических публичных IP-адресов ([тарифы Yandex Virtual Private Cloud](../../vpc/pricing.md)).

## Создайте сервисный аккаунт и статический ключ доступа {#create-service-account}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с [ролью](../../iam/concepts/access-control/roles.md) [editor](../../iam/roles-reference.md#editor) на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), указанный в настройках провайдера.
1. [Получите статический ключ доступа](../../iam/operations/authentication/manage-access-keys.md#create-access-key). Сохраните идентификатор ключа и секретный ключ — они понадобятся в следующих разделах инструкции.

### Создайте бакет {#create-service-account}

[Создайте бакет](../../storage/operations/buckets/create.md) с ограниченным доступом. В нем будет храниться файл состояния Terraform.

## Установите и настройте Terraform {#prepare-terraform}

## Установите и настройте Terraform {#prepare-terraform}

### Установите Terraform {#install-terraform}

{% list tabs group=operating_system %}

- Windows {#windows}

  Используйте один из способов:
  * [Скачайте дистрибутив Terraform](https://www.terraform.io/downloads.html) и установите его согласно [инструкции](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started).
  * Установите Terraform с помощью пакетного менеджера [Chocolatey](https://chocolatey.org/install), используя команду:

    ```bash
    choco install terraform
    ```

- Linux {#linux}

  [Скачайте дистрибутив Terraform](https://www.terraform.io/downloads.html) и установите его согласно [инструкции](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started).

- macOS {#macos}

  Используйте один из способов:
  * [Скачайте дистрибутив Terraform](https://www.terraform.io/downloads.html) и установите его согласно [инструкции](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started).
  * Установите Terraform с помощью пакетного менеджера [Homebrew](https://brew.sh), используя команду:

    ```bash
    brew install terraform
    ```

{% endlist %}

### Получите данные для аутентификации {#get-credentials}

Чтобы управлять инфраструктурой Yandex Cloud с помощью Terraform, используйте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md). Это позволит гибко настраивать права доступа к ресурсам.

Также вы можете использовать Terraform от имени [аккаунта на Яндексе](../../iam/concepts/users/accounts.md#passport), [федеративного](../../iam/concepts/users/accounts.md#saml-federation) или [локального](../../iam/concepts/users/accounts.md#local) пользователя, однако этот способ является менее безопасным. Подробности смотрите в конце раздела.

1. Если у вас еще нет интерфейса командной строки Yandex Cloud, [установите](../../cli/quickstart.md#install) его.

1. Настройте профиль CLI для выполнения операций от имени сервисного аккаунта:

    {% list tabs group=instructions %}

    - CLI {#cli}

      1. Создайте [авторизованный ключ](../../iam/concepts/authorization/key.md) для сервисного аккаунта и запишите его файл:

          ```bash
          yc iam key create \
            --service-account-id <идентификатор_сервисного_аккаунта> \
            --folder-name <имя_каталога_с_сервисным_аккаунтом> \
            --output key.json
          ```

          Где:
          * `service-account-id` — идентификатор сервисного аккаунта.
          * `folder-name` — имя каталога, в котором создан сервисный аккаунт.
          * `output` — имя файла с авторизованным ключом.

          Результат:

          ```text
          id: aje8nn871qo4********
          service_account_id: ajehr0to1g8b********
          created_at: "2022-09-14T09:11:43.479156798Z"
          key_algorithm: RSA_2048
          ```

      1. Создайте профиль CLI для выполнения операций от имени сервисного аккаунта. Укажите имя профиля:

          ```bash
          yc config profile create <имя_профиля>
          ```

          Результат:

          ```text
          Profile 'sa-terraform' created and activated
          ```

      1. Задайте конфигурацию профиля:

          ```bash
          yc config set service-account-key key.json
          yc config set cloud-id <идентификатор_облака>
          yc config set folder-id <идентификатор_каталога>
          ```

          Где:
          * `service-account-key` — файл с авторизованным ключом сервисного аккаунта.
          * `cloud-id` — [идентификатор облака](../../resource-manager/operations/cloud/get-id.md).
          * `folder-id` — [идентификатор каталога](../../resource-manager/operations/folder/get-id.md).

    {% endlist %}

1. Добавьте аутентификационные данные в переменные окружения:

    {% list tabs group=programming_language %}
    
    - Bash {#bash}
    
      ```bash
      export YC_TOKEN=$(yc iam create-token)
      export YC_CLOUD_ID=$(yc config get cloud-id)
      export YC_FOLDER_ID=$(yc config get folder-id)
      ```
    
      Где:
      * `YC_TOKEN` — [IAM-токен](../../iam/concepts/authorization/iam-token.md).
      * `YC_CLOUD_ID` — идентификатор облака.
      * `YC_FOLDER_ID` — идентификатор каталога.
    
    - PowerShell {#powershell}
    
      ```powershell
      $Env:YC_TOKEN=$(yc iam create-token)
      $Env:YC_CLOUD_ID=$(yc config get cloud-id)
      $Env:YC_FOLDER_ID=$(yc config get folder-id)
      ```
    
      Где:
      * `YC_TOKEN` — [IAM-токен](../../iam/concepts/authorization/iam-token.md).
      * `YC_CLOUD_ID` — идентификатор облака.
      * `YC_FOLDER_ID` — идентификатор каталога.
    
    {% endlist %}
    
    {% note info %}
    
    [Время жизни](../../iam/concepts/authorization/iam-token.md#lifetime) IAM-токена — не больше 12 часов, но рекомендуется запрашивать его чаще, например каждый час.
    
    Для автоматического перевыпуска IAM-токена можно использовать скрипт `export IAM_TOKEN=$(yc iam create-token)`.
    
    {% endnote %}

{% cut "Управление ресурсами от имени аккаунта на Яндексе, локального или федеративного аккаунта" %}

{% note warning %}

Управление ресурсами от имени [аккаунта на Яндексе](../../iam/concepts/users/accounts.md#passport), [локального](../../iam/concepts/users/accounts.md#local) или [федеративного аккаунта](../../iam/concepts/users/accounts.md#saml-federation) пользователя является менее безопасным, чем использование [сервисного аккаунта](../../iam/concepts/users/service-accounts.md).

{% endnote %}

Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

Если вы используете федеративный или локальный аккаунт, аутентифицируйтесь в [CLI](../../cli/index.md):

* [от имени федеративного пользователя](../../cli/operations/authentication/federated-user.md);
* [от имени локального пользователя](../../cli/operations/authentication/local-user.md).

Добавьте аутентификационные данные в переменные окружения:

{% list tabs group=programming_language %}

- Bash {#bash}

  ```bash
  export YC_TOKEN=$(yc iam create-token)
  export YC_CLOUD_ID=$(yc config get cloud-id)
  export YC_FOLDER_ID=$(yc config get folder-id)
  ```

  Где:
  * `YC_TOKEN` — [IAM-токен](../../iam/concepts/authorization/iam-token.md).
  * `YC_CLOUD_ID` — идентификатор облака.
  * `YC_FOLDER_ID` — идентификатор каталога.

- PowerShell {#powershell}

  ```powershell
  $Env:YC_TOKEN=$(yc iam create-token)
  $Env:YC_CLOUD_ID=$(yc config get cloud-id)
  $Env:YC_FOLDER_ID=$(yc config get folder-id)
  ```

  Где:
  * `YC_TOKEN` — [IAM-токен](../../iam/concepts/authorization/iam-token.md).
  * `YC_CLOUD_ID` — идентификатор облака.
  * `YC_FOLDER_ID` — идентификатор каталога.

{% endlist %}

{% note info %}

[Время жизни](../../iam/concepts/authorization/iam-token.md#lifetime) IAM-токена — не больше 12 часов, но рекомендуется запрашивать его чаще, например каждый час.

Для автоматического перевыпуска IAM-токена можно использовать скрипт `export IAM_TOKEN=$(yc iam create-token)`.

{% endnote %}

{% endcut %}

### Создайте файл конфигурации Terraform {#configure-terraform}

1. Создайте директорию с произвольным названием, например `cloud-terraform`. В ней будут храниться конфигурационные файлы Terraform.
1. Создайте в этой директории конфигурационный файл с расширением `.tf`, например `example.tf`.

### Настройте провайдер {#configure-provider}

{% note info %}

Настройки применимы для Terraform `0.13` и более поздних версий. Рекомендуется использовать последнюю стабильную версию Terraform.

{% endnote %}

1. Если раньше у вас был настроен провайдер из реестра HashiCorp, сохраните его настройки:

   {% list tabs group=operating_system %}

   - Linux/macOS {#linux-macos}

     ```bash
     mv ~/.terraformrc ~/.terraformrc.old
     ```

   - Windows {#windows}

     ```powershell
     mv $env:APPDATA/terraform.rc $env:APPDATA/terraform.rc.old
     ```

   {% endlist %}

1. Укажите источник, из которого будет устанавливаться провайдер.

   {% list tabs group=operating_system %}

   - Linux/macOS {#linux-macos}

     Откройте файл конфигурации Terraform CLI:

     ```bash
     nano ~/.terraformrc
     ```

     {% note info %}
     
     Файл `.terraformrc` должен располагаться в корне домашней папки пользователя, например, `/home/user/` или `/User/user/`.
     
     {% endnote %}

   - Windows {#windows}

     Откройте файл конфигурации Terraform CLI `terraform.rc` в папке `%APPDATA%` вашего пользователя.

     Чтобы узнать абсолютный путь к папке `%APPDATA%`, выполните команду `echo %APPDATA%` для cmd или `$env:APPDATA` для PowerShell.

   {% endlist %}

   Добавьте в него следующий блок:

   ```hcl
   provider_installation {
     network_mirror {
       url = "https://terraform-mirror.yandexcloud.net/"
       include = ["registry.terraform.io/*/*"]
     }
     direct {
       exclude = ["registry.terraform.io/*/*"]
     }
   }
   ```

   Подробнее о настройках зеркал в [документации](https://www.terraform.io/cli/config/config-file#explicit-installation-method-configuration).
1. В начале конфигурационного файла `.tf` добавьте следующие блоки:

   
   ```hcl
   terraform {
     required_providers {
       yandex = {
         source = "yandex-cloud/yandex"
       }
     }
     required_version = ">= 0.13"
   }

   provider "yandex" {
     zone = "<зона_доступности_по_умолчанию>"
   }
   ```



   Где:
   * `source` — глобальный [адрес источника](https://www.terraform.io/docs/language/providers/requirements.html#source-addresses) провайдера.
   * `required_version` — минимальная версия Terraform, с которой совместим провайдер.
   * `provider` — название провайдера.
   * `zone` — [зона доступности](../../overview/concepts/geo-scope.md), в которой по умолчанию будут создаваться все облачные ресурсы.
1. Выполните команду `terraform init` в папке с конфигурационным файлом `.tf`. Эта команда инициализирует провайдеров, указанных в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.

Если провайдер не установился, создайте обращение в [поддержку](https://center.yandex.cloud/support) с именем и версией провайдера.

Если вы использовали файл `.terraform.lock.hcl`, перед инициализацией выполните команду `terraform providers lock`, указав адрес зеркала, откуда будет загружаться провайдер, и платформы, на которых будет использоваться конфигурация:

```bash
terraform providers lock -net-mirror=https://terraform-mirror.yandexcloud.net -platform=<название_платформы_1> -platform=<название_платформы_2> yandex-cloud/yandex
```

Где:
* `-net-mirror` — адрес зеркала, откуда будет загружаться провайдер.
* `-platform` — платформы, на которых будет использоваться конфигурация. Возможные значения:
  * `windows_amd64` — 64-bit Windows.
  * `linux_amd64` — 64-bit Linux.
  * `darwin_arm64` — 64-bit macOS.

Если вы использовали [модули Terraform](terraform-modules.md), сначала выполните `terraform init`, затем удалите lock-файл, а затем выполните команду `terraform providers lock`.

Подробнее о команде `terraform providers lock` в [документации Terraform](https://developer.hashicorp.com/terraform/cli/commands/providers/lock).

## Настройте бэкенд {#set-up-backend}

{% note info %}

Настройки бэкенда применимы для Terraform `1.6.3` и более поздних версий.

{% endnote %}

1. Добавьте в переменные окружения идентификатор ключа и секретный ключ, [полученные ранее](#create-service-account):

   {% list tabs group=programming_language %}

   - Bash {#bash}

     ```bash
     export ACCESS_KEY="<идентификатор_ключа>"
     export SECRET_KEY="<секретный_ключ>"
     ```

   - PowerShell {#powershell}

     ```powershell
     $ACCESS_KEY="<идентификатор_ключа>"
     $SECRET_KEY="<секретный_ключ>"
     ```

   {% endlist %}

1. Добавьте в конфигурационный файл настройки провайдера и бэкенда:

   
   ```hcl
   terraform {
     required_providers {
       yandex = {
         source = "yandex-cloud/yandex"
       }
     }

     backend "s3" {
       endpoints = {
         s3 = "https://storage.yandexcloud.net"
       }
       bucket = "<имя_бакета>"
       region = "ru-central1"
       key    = "<путь_к_файлу_состояния_в_бакете>/<имя_файла_состояния>.tfstate"

       skip_region_validation      = true
       skip_credentials_validation = true
       skip_requesting_account_id  = true # Необходимая опция Terraform для версии 1.6.1 и старше.
       skip_s3_checksum            = true # Необходимая опция при описании бэкенда для Terraform версии 1.6.3 и старше.

     }
   }

   provider "yandex" {
     zone      = "<зона_доступности_по_умолчанию>"
   }
   ```



   Подробнее о бэкенде для хранения состояний читайте на [сайте Terraform](https://www.terraform.io/docs/backends/types/s3.html).
1. В папке с конфигурационным файлом выполните команду:

   ```bash
   terraform init -backend-config="access_key=$ACCESS_KEY" -backend-config="secret_key=$SECRET_KEY"
   ```

## Разверните конфигурацию {#deploy}

В этом примере будут созданы две [виртуальные машины](../../compute/concepts/vm.md): `terraform1` и `terraform2`. Они будут подключены к [подсети](../../vpc/concepts/network.md#subnet) `subnet-1` в [зоне доступности](../../overview/concepts/geo-scope.md) `ru-central1-d`. Подсеть будет принадлежать [облачной сети](../../vpc/concepts/network.md#network) `network-1`.

У ВМ будут разные [количества ядер и объемы памяти](../../compute/concepts/vm-platforms.md): 1 ядро и 2 ГБ оперативной памяти у `terraform1` и 2 ядра и 4 ГБ оперативной памяти у `terraform2`. ВМ автоматически получат [публичные IP-адреса](../../vpc/concepts/address.md#public-addresses) и [внутренние IP-адреса](../../vpc/concepts/address.md#internal-addresses) из диапазона `192.168.10.0/24` в подсети `subnet-1`. На ВМ будет установлена операционная система Ubuntu и размещена публичная часть ключа для доступа к ВМ по [SSH](../../glossary/ssh-keygen.md).
1. Сохраните следующую конфигурацию в файл `example.tf`:

   ```hcl
   terraform {
     required_providers {
       yandex = {
         source = "yandex-cloud/yandex"
       }
     }

     backend "s3" {
       endpoints = {
         s3 = "storage.yandexcloud.net"
       }
       bucket = "<имя_бакета>"
       region = "ru-central1"
       key    = "<путь_к_файлу_состояния_в_бакете>/<имя_файла_состояния>.tfstate"

       skip_region_validation      = true
       skip_credentials_validation = true
       skip_requesting_account_id  = true # необходимая опция при описании бэкенда для Terraform версии 1.6.1 и старше.
       skip_s3_checksum            = true # необходимая опция при описании бэкенда для Terraform версии 1.6.3 и старше.

     }
   }

   provider "yandex" {
     zone      = "ru-central1-d"
   }

   resource "yandex_compute_image" "ubuntu_2004" {
     source_family = "ubuntu-2004-lts"
   }

   resource "yandex_compute_disk" "boot-disk-vm1" {
     name     = "boot-disk-1"
     type     = "network-hdd"
     zone     = "ru-central1-d"
     size     = "20"
     image_id = yandex_compute_image.ubuntu_2004.id
   }

   resource "yandex_compute_disk" "boot-disk-vm2" {
     name     = "boot-disk-2"
     type     = "network-hdd"
     zone     = "ru-central1-d"
     size     = "20"
     image_id = yandex_compute_image.ubuntu_2004.id
   }

   resource "yandex_compute_instance" "vm-1" {
     name = "terraform1"

     resources {
       cores  = 2
       memory = 2
     }

     boot_disk {
       disk_id = yandex_compute_disk.boot-disk-vm1.id
     }

     network_interface {
       subnet_id = yandex_vpc_subnet.subnet-1.id
       nat       = true
     }

     metadata = {
       ssh-keys = "ubuntu:${file("<путь_к_публичному_SSH-ключу>")}"
     }
   }

   resource "yandex_compute_instance" "vm-2" {
     name = "terraform2"

     resources {
       cores  = 2
       memory = 4
     }

     boot_disk {
       disk_id = yandex_compute_disk.boot-disk-vm2.id
     }

     network_interface {
       subnet_id = yandex_vpc_subnet.subnet-1.id
       nat       = true
     }

     metadata = {
       ssh-keys = "ubuntu:${file("<путь_к_публичному_SSH-ключу>")}"
     }
   }

   resource "yandex_vpc_network" "network-1" {
     name = "network1"
   }

   resource "yandex_vpc_subnet" "subnet-1" {
     name           = "subnet1"
     zone           = "ru-central1-d"
     network_id     = yandex_vpc_network.network-1.id
     v4_cidr_blocks = ["192.168.10.0/24"]
   }

   output "internal_ip_address_vm_1" {
     value = yandex_compute_instance.vm-1.network_interface.0.ip_address
   }

   output "internal_ip_address_vm_2" {
     value = yandex_compute_instance.vm-2.network_interface.0.ip_address
   }

   output "external_ip_address_vm_1" {
     value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
   }

   output "external_ip_address_vm_2" {
     value = yandex_compute_instance.vm-2.network_interface.0.nat_ip_address
   }

   output "subnet-1" {
     value = yandex_vpc_subnet.subnet-1.id
   }
   ```

   Где:
   * `bucket` — имя [бакета](../../storage/concepts/bucket.md).
   * `key` — ключ объекта в бакете: путь и имя к файлу состояния Terraform в бакете.
   * `ssh-keys` — путь к файлу с открытым SSH-ключом для аутентификации пользователя на ВМ. Подробнее в разделе [Создание пары ключей SSH](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
1. Проверьте конфигурацию с помощью команды `terraform plan`.
1. Разверните конфигурацию с помощью команды `terraform apply`.

## Проверьте сохраненное состояние {#check-condition}

Убедитесь, что файл состояния загружен в [Yandex Object Storage](../../storage/index.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления](https://console.yandex.cloud) и выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится созданный [бакет](../../storage/concepts/bucket.md).
  1. Перейдите в сервис **Object Storage**.
  1. В списке бакетов выберите тот, в котором должно было сохраниться состояние Terraform.
  1. Убедитесь, что в бакете появился файл состояния.

{% endlist %}

## Получите состояние из бэкенда {#retrieve-state}

Сохраненное в Object Storage состояние Terraform можно запросить из другой конфигурации и дополнить уже созданную инфраструктуру.

Создайте еще одну конфигурацию и используйте сохраненное состояние, чтобы создать еще одну ВМ в одной из заранее созданных подсетей:
1. Создайте директорию `remote-state`.
1. Перейдите в созданную директорию и создайте конфигурацию `remote-state.tf`:

   
   ```hcl
   terraform {
     required_providers {
       yandex = {
         source = "yandex-cloud/yandex"
       }
     }
   }

   provider "yandex" {
     zone      = "ru-central1-d"
   }

   data "terraform_remote_state" "vpc" {
     backend = "s3"
     config  = {
       endpoints = {
         s3 = "https://storage.yandexcloud.net"
       }
       bucket = "<имя_бакета>"
       region = "ru-central1"
       key    = "<путь_к_файлу_состояния_в_бакете>/<имя_файла_состояния>.tfstate"

       skip_region_validation      = true
       skip_credentials_validation = true
       skip_requesting_account_id  = true # Необходимая опция при описании бэкенда для Terraform версии старше 1.6.1.

       access_key = "<идентификатор_ключа>"
       secret_key = "<секретный_ключ>"

      }
    }

   resource "yandex_compute_image" "ubuntu_2004" {
     source_family = "ubuntu-2004-lts"
   }

   resource "yandex_compute_disk" "boot-disk-vm3" {
     name     = "boot-disk-3"
     type     = "network-hdd"
     zone     = "ru-central1-d"
     size     = "20"
     image_id = yandex_compute_image.ubuntu_2004.id
   }

   resource "yandex_compute_instance" "vm-3" {
     name = "terraform3"

     resources {
       cores  = 2
       memory = 2
     }

     boot_disk {
       disk_id = yandex_compute_disk.boot-disk-vm3.id
     }

     network_interface {
       subnet_id = data.terraform_remote_state.vpc.outputs.subnet-1
       nat       = true
     }

     metadata = {
       ssh-keys = "ubuntu:${file("<путь_к_публичному_SSH-ключу>")}"
     }
   }
   ```



   Где:
   * `bucket` — имя бакета.
   * `key` — ключ объекта в бакете: путь и имя к файлу состояния Terraform в бакете.
   * `access_key` — [идентификатор секретного ключа](#create-service-account) [сервисного аккаунта](../../iam/concepts/users/service-accounts.md), для доступа к бакету.
   * `secret_key` — значение секретного ключа сервисного аккаунта.
1. Выполните команду `terraform init`.
1. Выполните команду `terraform plan`. В терминале должен отобразиться план создания одной ВМ.
1. Выполните команду `terraform apply`.
1. Перейдите в консоль управления и убедитесь, что в разделе Compute Cloud появилась ВМ `terraform3`.

## Удалите созданные ресурсы {#clear-out}

Чтобы удалить созданные ресурсы, выполните команду `terraform destroy` сначала во второй конфигурации, а затем в первой.

## Полезные ссылки {#see-also}

* [Начало работы с Terraform](terraform-quickstart.md).
* [Блокировка состояний Terraform с помощью Managed Service for YDB](terraform-state-lock.md).
* [Использование модулей Yandex Cloud в Terraform](terraform-modules.md).
* [Источники данных Terraform](terraform-data-sources.md).