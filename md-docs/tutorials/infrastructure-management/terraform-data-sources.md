# Источники данных Terraform

[Источники данных (Data Sources)](https://developer.hashicorp.com/terraform/language/data-sources) Terraform позволяют получать актуальную информацию о существующих облачных ресурсах и использовать эти данные в конфигурации вашей инфраструктуры.

С помощью [Terraform-провайдера Yandex Cloud](../../terraform/index.md) вы можете получить информацию о различных облачных ресурсах: [виртуальных машинах](../../compute/concepts/vm.md), [дисках](../../compute/concepts/disk.md), [облачных сетях](../../vpc/concepts/network.md) и других облачных ресурсах.

Источники данных доступны только для чтения — это гарантирует, что вы не измените внешние ресурсы.

Получим с помощью источников данных Terraform идентификатора образа [Ubuntu 22.04 LTS](https://yandex.cloud/ru/marketplace/products/yc/ubuntu-22-04-lts) из Cloud Marketplace.

Чтобы получить идентификатор образа `Ubuntu 22.04 LTS` с помощью Terraform:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Установите и настройте Terraform](#prepare-terraform).
1. [Опишите источник данных](#prepare-plan).
1. [Проверьте результат](#check).

## Подготовьте облако к работе {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

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

Также вы можете использовать Terraform от имени [аккаунта на Яндексе](../../iam/concepts/users/accounts.md#passport), [федеративного](../../iam/concepts/users/accounts.md#saml-federation) или [локального](../../iam/concepts/users/accounts.md#local) пользователя, однако этот способ является менее безопасным. Подробности см. в конце раздела.

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

## Опишите источник данных {#prepare-plan}

{% note tip %}

Источники данных определяются в коде Terraform с использованием блока `data`.

{% endnote %}

1. В файле конфигурации после настроек провайдера добавьте:

    ```hcl
    data "yandex_compute_image" "my_image" {
      family = "ubuntu-2204-lts"
    }

    output "my_image_id" {
      value = data.yandex_compute_image.my_image.id
    }
    ```

    Где:

    * `data "yandex_compute_image"` — описание образа диска в качестве источника данных:
        * `family` — [семейство образов](../../compute/concepts/image.md#family).
    * `output "resource_active"` — выходная переменная, которая содержит информацию о текущем идентификаторе образа для указанного семейства:
        * `value` — возвращаемое значение.

    Более подробно о параметрах источника данных `yandex_compute_image` см. в [документации провайдера](../../terraform/data-sources/compute_image.md).

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

    Terraform создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале.

## Проверьте результат {#check}

Чтобы проверить результат, выполните команду:

```bash
terraform output
```

Результат:

```text
my_image_id = "fd8li2lvvfc6bdj4c787"
```

Далее вы можете использовать полученный идентификатор для [создания ВМ](../../compute/operations/images-with-pre-installed-software/create.md), например:

```hcl
resource "yandex_compute_disk" "boot-disk" {
  name     = "<имя_диска>"
  type     = "<тип_диска>"
  zone     = "<зона_доступности>"
  size     = "<размер_диска>"
  image_id = data.yandex_compute_image.my_image.id
}

...
```

## Полезные ссылки {#see-also}

* [Начало работы с Terraform](terraform-quickstart.md).
* [Загрузка состояний Terraform в Object Storage](terraform-state-storage.md).
* [Блокировка состояний Terraform с помощью Managed Service for YDB](terraform-state-lock.md).
* [Использование модулей Yandex Cloud в Terraform](terraform-modules.md).