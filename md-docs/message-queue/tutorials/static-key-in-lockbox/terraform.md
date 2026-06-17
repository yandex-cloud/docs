# Использование секрета Yandex Lockbox для хранения статического ключа доступа с помощью Terraform

Чтобы [использовать статический ключ доступа](index.md), сохраненный в секрете Yandex Lockbox, с помощью Terraform:

1. [Подготовьте окружение](#prepare).
1. [Создайте инфраструктуру](#deploy).
1. [Используйте ключ из секрета Yandex Lockbox для работы с сервисом](#use-key).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).


### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры входят:

* плата за хранение одной версии секрета Yandex Lockbox ([тарифы Yandex Lockbox](../../../lockbox/pricing.md#secrets));
* плата за хранение данных в Object Storage, операции с ними и исходящий трафик (плата не будет взиматься, если в бакете не будут храниться данные, [тарифы Object Storage](../../../storage/pricing.md#rules)).


## Подготовьте окружение {#prepare}

[Установите](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) утилиту командной строки AWS CLI.

Настраивать утилиту на этом этапе не обязательно. Необходимые параметры, такие как идентификаторы и ключи доступа, будут описаны и использованы в командах и переменных окружения далее в этом руководстве.


## Создайте инфраструктуру {#deploy}

[Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

Для создания инфраструктуры c помощью Terraform:

1. [Установите Terraform](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера Yandex Cloud (раздел [Настройте провайдер](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файл с описанием инфраструктуры:

    {% list tabs group=infrastructure_description %}

    - Готовая конфигурация {#ready}

      1. Клонируйте репозиторий с конфигурационными файлами.

          ```bash
          git clone https://github.com/yandex-cloud-examples/yc-static-keys-in-lockbox
          ```

      1. Перейдите в директорию с репозиторием. В ней должен появиться файл `static-key-in-lockbox-config.tf` — конфигурация создаваемой инфраструктуры.

    - Вручную {#manual}

      1. Создайте папку для конфигурационных файлов.
      1. Создайте в папке конфигурационный файл `static-key-in-lockbox-config.tf`:

          {% cut "static-key-in-lockbox-config.tf" %}

          ```hcl
          # Объявление пользовательских переменных
          
          locals {
            zone      = "<зона_доступности>"
            folder_id = "<идентификатор_каталога>"
          }
          
          terraform {
            required_providers {
              yandex = {
                source  = "yandex-cloud/yandex"
                version = ">= 0.47.0"
              }
            }
          }
          
          # Настройка провайдера
          
          provider "yandex" {
            zone = local.zone
          }
          
          # Создание сервисного аккаунта и назначение ролей
          
          resource "yandex_iam_service_account" "sa" {
            folder_id = local.folder_id
            name      = "storage-bucket-sa"
          }
          
          resource "yandex_resourcemanager_folder_iam_member" "sa-admin" {
            folder_id = local.folder_id
            role      = "storage.admin"
            member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
          }
          
          resource "yandex_resourcemanager_folder_iam_member" "lockboxview" {
            folder_id = local.folder_id
            role      = "lockbox.payloadViewer"
            member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
          }
          
          # Создание секрета
          
          resource "yandex_lockbox_secret" "my_secret" {
            name                = "static-key"
            folder_id           = local.folder_id
            deletion_protection = true
          }
          
          # Создание статического ключа доступа
          
          resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
            service_account_id = yandex_iam_service_account.sa.id
            description        = "static access key for object storage"
            output_to_lockbox {
              secret_id            = yandex_lockbox_secret.my_secret.id
              entry_for_access_key = "key_id"
              entry_for_secret_key = "key"
            }
          }
          
          # Источник данных версии секрета
          
          data "yandex_lockbox_secret_version" "my_secret_version" {
            secret_id  = yandex_lockbox_secret.my_secret.id
            version_id = yandex_iam_service_account_static_access_key.sa-static-key.output_to_lockbox_version_id
            depends_on = [
              yandex_lockbox_secret.my_secret
            ]
          }
          
          # Выходные переменные
          
          output "key_id" {
            value = data.yandex_lockbox_secret_version.my_secret_version.entries[1].text_value
          }
          
          output "key" {
            value = data.yandex_lockbox_secret_version.my_secret_version.entries[0].text_value
          }
          ```

          {% endcut %}

    {% endlist %}

    Более подробную информацию о параметрах используемых ресурсов в Terraform см. в документации провайдера:

    * [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account](../../../terraform/resources/iam_service_account.md).
    * Назначение [роли](../../../iam/concepts/access-control/roles.md) сервисному аккаунту — [yandex_resourcemanager_folder_iam_member](../../../terraform/resources/resourcemanager_folder_iam_member.md).
    * [Секрет](../../../lockbox/concepts/secret.md) — [yandex_lockbox_secret](../../../terraform/resources/lockbox_secret.md).
    * [Статический ключ доступа](../../../iam/concepts/authorization/access-key.md) — [yandex_iam_service_account_static_access_key](../../../terraform/resources/iam_service_account_static_access_key.md).
    * [Версия секрета](../../../lockbox/concepts/secret.md#version) — [yandex_lockbox_secret_version](../../../terraform/resources/lockbox_secret_version.md).

1. В файле `static-key-in-lockbox-config.tf` задайте пользовательские параметры:
    * `zone_id` — [зона доступности](../../../overview/concepts/geo-scope.md).
    * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).

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

После создания инфраструктуры, [используйте ключ из секрета для работы с сервисом](#use-key).


## Используйте ключ из секрета Yandex Lockbox для работы с сервисом {#use-key}

Пример ниже разработан для выполнения в операционных системах MacOS и Linux. Чтобы выполнить его в системе Windows, [ознакомьтесь](../../../overview/concepts/console-syntax-guide.md) с особенностями работы с Bash в Microsoft Windows.

Используйте ключ из секрета Yandex Lockbox и создайте бакет в Object Storage:

1. Сохраните идентификатор ключа, секретный ключ и значение региона размещения в переменные окружения AWS CLI:

    ```bash
    AWS_ACCESS_KEY_ID=$(terraform output key_id)
    AWS_SECRET_ACCESS_KEY=$(terraform output key)
    AWS_DEFAULT_REGION="ru-central1"
    ```

    AWS CLI будет использовать созданные переменные окружения для аутентификации при выполнении операций с ресурсами сервиса.

1. Создайте бакет в Object Storage, указав в команде уникальное [имя бакета](../../../storage/concepts/bucket.md#naming):

    {% list tabs group=instructions %}
    
    - AWS CLI {#aws-cli}
    
      ```bash
      aws --endpoint-url=https://storage.yandexcloud.net \
        s3 mb s3://<имя_бакета>
      ```
    
      Результат:
    
      ```bash
      make_bucket: my-first-bucket
      ```
    
    {% endlist %}
    
    В результате будет создан новый бакет в Object Storage. При создании бакета используется статический ключ доступа, полученный из секрета Yandex Lockbox и сохраненный в переменные окружения.
    
    Вы также передать значения идентификатора ключа, секретного ключа и региона размещения непосредственно в каждой команде AWS CLI:

    {% list tabs group=instructions %}

    - AWS CLI {#aws-cli}

      ```bash
      AWS_ACCESS_KEY_ID=$(terraform output key_id) \
      AWS_SECRET_ACCESS_KEY=$(terraform output key) \
      AWS_DEFAULT_REGION="ru-central1" \
      aws --endpoint-url=https://storage.yandexcloud.net \
        s3 mb s3://<имя_бакета>
      ```

      Результат:

      ```bash
      make_bucket: my-first-bucket
      ```

    {% endlist %}


## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите](../../../storage/operations/buckets/delete.md) бакет.
1. Откройте конфигурационный файл `static-key-in-lockbox-config.tf` и удалите описание создаваемой инфраструктуры из файла.
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

* [Использование секрета Yandex Lockbox для хранения статического ключа доступа с помощью CLI](console.md)