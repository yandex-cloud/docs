# Управление ключами

С помощью Key Management Service вы можете создавать, ротировать и удалять симметричные ключи шифрования.

## Создать ключ {#create}

Чтобы создать новый ключ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Войдите в [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Key Management Service**.
  1. На панели слева выберите ![image](../../_assets/console-icons/key.svg) **Симметричные ключи**.
  1. Нажмите кнопку **Создать ключ** и задайте атрибуты ключа:

     * Имя и опциональное описание в свободной форме.
     * [Алгоритм шифрования](../concepts/key.md#parameters), например `AES-256`.
     * Период [ротации](../concepts/index.md#rotation) (частота смены версии ключа по умолчанию).
     * (Опционально) Включите защиту от удаления.

  1. Нажмите кнопку **Создать**.

  Вместе с ключом создается его первая версия: нажмите на ключ в списке, чтобы открыть страницу с его атрибутами.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc kms symmetric-key create \
    --name example-key \
    --default-algorithm aes-256 \
    --rotation-period 24h \
    --deletion-protection
  ```

  Где:

  * `--name` — имя ключа.
  * `--default-algorithm` — [алгоритм шифрования](../concepts/key.md#parameters): `aes-128`, `aes-192`, `aes-256`, `aes-256-hsm`, `gost-r-3412-2015-k`.
  * `--rotation-period` — период ротации ключа. Чтобы создать ключ без автоматической ротации, не указывайте параметр `--rotation-period`.
  * `--deletion-protection` — защита от удаления ключа. Чтобы создать ключ без защиты от удаления, не указывайте параметр `--deletion-protection`.

  Вместе с ключом создается его первая версия. Она указана в поле `primary_version`.

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы создать новый ключ:
  
  1. Опишите в конфигурационном файле параметры ресурса `yandex_kms_symmetric_key`:
  
     ```hcl
     resource "yandex_kms_symmetric_key" "key-a" {
       name                = "<имя_ключа>"
       description         = "<описание_ключа>"
       default_algorithm   = "AES_128"
       rotation_period     = "8760h"
       deletion_protection = true
       lifecycle {
         prevent_destroy = true
       }
     }
     ```
  
     Где:
  
     * `name` — имя ключа. Формат имени:
  
        * длина — от 3 до 63 символов;
        * может содержать строчные буквы латинского алфавита, цифры и дефисы;
        * первый символ — буква, последний — не дефис.
  
     * `description` — описание ключа.
     * `default_algorithm` — алгоритм шифрования. Возможные значения: `AES-128`, `AES-192` или `AES-256`.
     * `rotation_period` — период [ротации](../concepts/version.md#rotate-key) (частота смены версии ключа по умолчанию). Чтобы создать ключ без автоматической ротации, не указывайте параметр `rotation_period`.
     * `deletion_protection` — защита от удаления ключа. Чтобы создать ключ без защиты от удаления, не указывайте параметр `deletion_protection`.
     * `lifecycle.prevent_destroy` — защита от удаления ключа при выполнении команд Terraform. Чтобы создать ключ без такой защиты, не указывайте блок `lifecycle`.
  
     {% note warning %}
  
     Удаление ключа KMS равносильно уничтожению всех зашифрованных с его помощью данных — без ключа восстановить данные не получится. Параметр `deletion_protection` и блок `lifecycle` необходимы, чтобы обезопасить ключ от удаления (например, командой `terraform destroy`).
  
     {% endnote %}
  
     Более подробную информацию о параметрах ресурсов в Terraform смотрите в [документации провайдера](../../terraform/resources/kms_symmetric_key.md).
  
  1. Проверьте конфигурацию командой:
  
     ```bash
     terraform validate
     ```
  
     Если конфигурация является корректной, появится сообщение:
  
     ```text
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
  
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.
  
     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления](https://console.yandex.cloud) или с помощью команд [CLI](../../cli/quickstart.md):
  
     ```bash
     yc kms symmetric-key list
     ```

- API {#api}

  Воспользуйтесь методом REST API [create](../api-ref/SymmetricKey/create.md) для ресурса [SymmetricKey](../api-ref/SymmetricKey/index.md) или вызовом gRPC API [SymmetricKeyService/Create](../api-ref/grpc/SymmetricKey/create.md).

{% endlist %}

## Изменить ключ {#update}

После создания ключа вы можете изменить любой из его атрибутов. Если вы измените алгоритм шифрования, то новый алгоритм будет использоваться начиная со следующей версии ключа. Чтобы сразу создать новую версию и сделать ее версией по умолчанию, [ротируйте ключ](#rotate).

Чтобы изменить ключ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Войдите в [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Key Management Service**.
  1. На панели слева выберите ![image](../../_assets/console-icons/key.svg) **Симметричные ключи**.
  1. В строке с нужным ключом нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
  1. Изменив атрибуты ключа, нажмите кнопку **Сохранить**.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc kms symmetric-key update \
    --name example-key \
    --new-name example-key-2 \
    --default-algorithm aes-128 \
    --rotation-period 48h \
    --deletion-protection
  ```

  Где:

  * `--name` — имя ключа. Если в каталоге есть несколько ключей с одинаковыми именами, используйте идентификатор ключа.
  * `--new-name` — новое имя ключа.
  * `--default-algorithm` — [алгоритм шифрования](../concepts/key.md#parameters): `aes-128`, `aes-192`, `aes-256`, `aes-256-hsm`, `gost-r-3412-2015-k`.
  * `--rotation-period` — период ротации ключа. Чтобы отключить автоматическую ротацию измененного ключа, не указывайте параметр `--rotation-period`.
  * `--deletion-protection` — защита от удаления ключа. Чтобы отключить защиту от удаления, вместо этого укажите параметр `--no-deletion-protection`.

- Terraform {#tf}

  Чтобы изменить ключ:
  1. Откройте файл конфигурации Terraform и измените необходимые параметры ресурса `yandex_kms_symmetric_key`.

     Пример структуры конфигурационного файла:

     ```hcl
     ...
     resource "yandex_kms_symmetric_key" "key-a" {
       name                = "example-symmetric-key"
       description         = "description for key"
       default_algorithm   = "AES_128"
       rotation_period     = "8760h"
       deletion_protection = true
     }
     ...
     ```

     Подробнее о параметрах ресурса `yandex_kms_symmetric_key` в [документации провайдера](../../terraform/resources/kms_symmetric_key.md).
  1. Проверьте конфигурацию командой:

     ```bash
     terraform validate
     ```

     Если конфигурация является корректной, появится сообщение:

     ```text
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

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение ключа можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc kms symmetric-key get <имя_ключа>
     ```

- API {#api}

  Воспользуйтесь методом REST API [update](../api-ref/SymmetricKey/update.md) для ресурса [SymmetricKey](../api-ref/SymmetricKey/index.md) или вызовом gRPC API [SymmetricKeyService/Update](../api-ref/grpc/SymmetricKey/update.md).

{% endlist %}

## Активировать и деактивировать ключ {#active-inactive}

После создания ключа вы можете изменить текущий [статус ключа](../concepts/key.md#parameters).

{% note info %}

Деактивация ключа (изменение статуса ключа с `Active` на `Inactive`) относится к [eventually consistent](../concepts/consistency.md) операциям. Изменения, вызванные такими операциями, вступают в силу с задержкой до трех часов.

{% endnote %}

Чтобы изменить статус ключа:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Войдите в [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Key Management Service**.
  1. На панели слева выберите ![image](../../_assets/console-icons/key.svg) **Симметричные ключи**.
  1. Чтобы деактивировать ключ, в строке с нужным ключом в статусе `Active` нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Деактивировать**.
  1. Чтобы активировать ключ, в строке с нужным ключом в статусе `Inactive` нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Активировать**.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc kms symmetric-key update \
    --name example-key \
    --status active
  ```

  Где:

  * `--name` — имя ключа. Если в каталоге есть несколько ключей с одинаковыми именами, используйте идентификатор ключа в параметре `--id`.
  * `--status` — новый статус ключа. Возможные значения: `active`, `inactive`.

- Terraform {#tf}

  1. Откройте файл конфигурации Terraform и добавьте к описанию ресурса `yandex_kms_symmetric_key` параметр `status` со значением `ACTIVE` или `INACTIVE`.

     Пример структуры конфигурационного файла:

     ```hcl
     ...
     resource "yandex_kms_symmetric_key" "key-a" {
       name                = "example-symmetric-key"
       description         = "description for key"
       ...
       status              = "INACTIVE"
     }
     ...
     ```

     Подробнее о параметрах ресурса `yandex_kms_symmetric_key` в [документации провайдера](../../terraform/resources/kms_symmetric_key.md).

  1. Проверьте конфигурацию командой:

     ```bash
     terraform validate
     ```

     Если конфигурация является корректной, появится сообщение:

     ```text
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

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

  Проверить изменение статуса ключа можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc kms symmetric-key get <имя_ключа>
     ```

- API {#api}

  Воспользуйтесь методом REST API [update](../api-ref/SymmetricKey/update.md) для ресурса [SymmetricKey](../api-ref/SymmetricKey/index.md) или вызовом gRPC API [SymmetricKeyService/Update](../api-ref/grpc/SymmetricKey/update.md).

{% endlist %}

## Ротировать ключ {#rotate}

При ротации ключа генерируется новая версия, которая сразу назначается версией по умолчанию. Вы можете настроить автоматическую периодическую ротацию, но также можете ротировать ключ вручную в любой момент.

{% note info %}

Ротация ключа относится к [eventually consistent](../concepts/consistency.md) операциям. Изменения, вызванные такими операциями, вступают в силу с задержкой до трех часов.

{% endnote %}

Чтобы ротировать ключ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Войдите в [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Key Management Service**.
  1. На панели слева выберите ![image](../../_assets/console-icons/key.svg) **Симметричные ключи**.
  1. В строке с нужным ключом нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Ротировать**.
  1. Подтвердите ротацию (убедитесь, что смена версии по умолчанию не повредит вашей работе).

- CLI {#cli}

  Выполните команду, указав идентификатор или имя ключа:

  ```bash
  yc kms symmetric-key rotate example-key
  ```

- API {#api}

  Воспользуйтесь методом REST API [rotate](../api-ref/SymmetricKey/rotate.md) для ресурса [SymmetricKey](../api-ref/SymmetricKey/index.md) или вызовом gRPC API [SymmetricKeyService/Rotate](../api-ref/grpc/SymmetricKey/rotate.md).

{% endlist %}

## Удалить ключ {#delete}

При удалении ключа также удаляются все его версии. Ключ невозможно удалить сразу: версии помеченного на удаление ключа переходят в статус `Scheduled For Destruction` на 3 дня. В это время версии ключей продолжают [тарифицироваться](../pricing.md). В течение этих 3 дней по запросу в техническую поддержку можно восстановить ключ вместе с его версиями.

{% note alert %}

Через 3 дня после запроса на удаление ключа сам ключ и его версии удаляются безвозвратно: если у вас остались зашифрованные с помощью этого ключа данные, расшифровать их будет невозможно.

{% endnote %}

Если у ключа включена защита от удаления, предварительно [отключите](#update) ее.

Чтобы удалить ключ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Войдите в [консоль управления](https://console.yandex.cloud).
  1. Перейдите в сервис **Key Management Service**.
  1. На панели слева выберите ![image](../../_assets/console-icons/key.svg) **Симметричные ключи**.
  1. В строке с нужным ключом нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **Удалить**.
  1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI {#cli}

  Выполните команду, указав идентификатор или имя ключа:

  ```bash
  yc kms symmetric-key delete example-key
  ```

- Terraform {#tf}

  Чтобы удалить ключ, созданный с помощью Terraform:
  1. Откройте файл конфигураций Terraform и удалите фрагмент с описанием ключа.

     Пример описания ключа в конфигурации Terraform:

     ```hcl
     ...
     resource "yandex_kms_symmetric_key" "key-a" {
       name              = "example-symmetric-key"
       description       = "description for key"
       default_algorithm = "AES_128"
       rotation_period   = "8760h"
     }
     ...
     ```

  1. В командной строке перейдите в папку, где расположен файл конфигурации Terraform.
  1. Проверьте конфигурацию командой:

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

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменения можно в [консоли управления](https://console.yandex.cloud) или с помощью команд [CLI](../../cli/quickstart.md):

     ```bash
     yc kms symmetric-key list
     ```

- API {#api}

  Воспользуйтесь методом REST API [delete](../api-ref/SymmetricKey/delete.md) для ресурса [SymmetricKey](../api-ref/SymmetricKey/index.md) или вызовом gRPC API [SymmetricKeyService/Delete](../api-ref/grpc/SymmetricKey/delete.md).

{% endlist %}

{% note info %}

Удаление ключа относится к [eventually consistent](../concepts/consistency.md) операциям. Изменения, вызванные такими операциями, вступают в силу с задержкой до трех часов.

{% endnote %}

#### Полезные ссылки {#see-also}

[Управление ключами Key Management Service с Terraform](../tutorials/terraform-key.md)