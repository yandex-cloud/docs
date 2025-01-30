# Управление ключами

С помощью {{ kms-name }} вы можете создавать, ротировать и удалять симметричные ключи шифрования.

## Создать ключ {#create}

Чтобы создать новый ключ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Войдите в [консоль управления]({{ link-console-main }}).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.kms.symmetric-keys.button_empty-create }}** и задайте атрибуты ключа:

     * Имя и опциональное описание в свободной форме.
     * Алгоритм шифрования, например `AES-256`.
     * Период [ротации](../concepts/index.md#rotation) (частота смены версии ключа по умолчанию).
     * (Опционально) Включите защиту от удаления.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

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
  * `--default-algorithm` — алгоритм шифрования: `aes-128`, `aes-192` или `aes-256`.
  * `--rotation-period` — период ротации ключа. Чтобы создать ключ без автоматической ротации, не указывайте параметр `--rotation-period`.
  * `--deletion-protection` — защита от удаления ключа. Чтобы создать ключ без защиты от удаления, не указывайте параметр `--deletion-protection`.

  Вместе с ключом создается его первая версия. Она указана в поле `primary_version`.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  {% include [terraform-key-create](../../_includes/kms/terraform-key-create.md) %}

- API {#api}

  Воспользуйтесь методом REST API [create](../../kms/api-ref/SymmetricKey/create.md) для ресурса [SymmetricKey](../../kms/api-ref/SymmetricKey/index.md) или вызовом gRPC API [SymmetricKeyService/Create](../../kms/api-ref/grpc/SymmetricKey/create.md).

{% endlist %}

## Изменить ключ {#update}

После создания ключа вы можете изменить любой из его атрибутов. Если вы измените алгоритм шифрования, то новый алгоритм будет использоваться начиная со следующей версии ключа. Чтобы сразу создать новую версию и сделать ее версией по умолчанию, ротируйте ключ.

Чтобы изменить ключ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Войдите в [консоль управления]({{ link-console-main }}).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
  1. В строке с нужным ключом нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. Изменив атрибуты ключа, нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

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
  * `--default-algorithm` — алгоритм шифрования: `aes-128`, `aes-192` или `aes-256`.
  * `--rotation-period` — период ротации ключа. Чтобы отключить автоматическую ротацию измененного ключа, не указывайте параметр `--rotation-period`.
  * `--deletion-protection` — защита от удаления ключа. Чтобы отключить защиту от удаления, вместо этого укажите параметр `--no-deletion-protection`.

- {{ TF }} {#tf}

  Чтобы изменить ключ:
  1. Откройте файл конфигурации {{ TF }} и измените необходимые параметры ресурса `yandex_kms_symmetric_key`.

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

     Более подробную информацию о параметрах ресурса `yandex_kms_symmetric_key` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/kms_symmetric_key).
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

     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Примените изменения конфигурации:

     ```bash
     terraform apply
     ```

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменение ключа можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc kms symmetric-key get <имя_ключа>
     ```

- API {#api}

  Воспользуйтесь методом REST API [update](../../kms/api-ref/SymmetricKey/update.md) для ресурса [SymmetricKey](../../kms/api-ref/SymmetricKey/index.md) или вызовом gRPC API [SymmetricKeyService/Update](../../kms/api-ref/grpc/SymmetricKey/update.md).

{% endlist %}

## Ротировать ключ {#rotate}

При ротации ключа генерируется новая версия, которая сразу назначается версией по умолчанию. Вы можете настроить автоматическую периодическую ротацию, но также можете ротировать ключ вручную в любой момент.

Чтобы ротировать ключ:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Войдите в [консоль управления]({{ link-console-main }}).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
  1. В строке с нужным ключом нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.kms.symmetric-keys.button_action-rotate }}**.
  1. Подтвердите ротацию (убедитесь, что смена версии по умолчанию не повредит вашей работе).

- CLI {#cli}

  Выполните команду, указав идентификатор или имя ключа:

  ```bash
  yc kms symmetric-key rotate example-key
  ```

- API {#api}

  Воспользуйтесь методом REST API [rotate](../../kms/api-ref/SymmetricKey/rotate.md) для ресурса [SymmetricKey](../../kms/api-ref/SymmetricKey/index.md) или вызовом gRPC API [SymmetricKeyService/Rotate](../../kms/api-ref/grpc/SymmetricKey/rotate.md).

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

  1. Войдите в [консоль управления]({{ link-console-main }}).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
  1. В строке с нужным ключом нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  Выполните команду, указав идентификатор или имя ключа:

  ```bash
  yc kms symmetric-key delete example-key
  ```

- {{ TF }} {#tf}

  Чтобы удалить ключ, созданный с помощью {{ TF }}:
  1. Откройте файл конфигураций {{ TF }} и удалите фрагмент с описанием ключа.

     Пример описания ключа в конфигурации {{ TF }}:

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

  1. В командной строке перейдите в папку, где расположен файл конфигурации {{ TF }}.
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

     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Примените изменения конфигурации:

     ```bash
     terraform apply
     ```

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команд [CLI](../../cli/quickstart.md):

     ```bash
     yc kms symmetric-key list
     ```

- API {#api}

  Воспользуйтесь методом REST API [delete](../../kms/api-ref/SymmetricKey/delete.md) для ресурса [SymmetricKey](../../kms/api-ref/SymmetricKey/index.md) или вызовом gRPC API [SymmetricKeyService/Delete](../../kms/api-ref/grpc/SymmetricKey/delete.md).

{% endlist %}

## См. также {#see-also}

* [Управление ключами {{ kms-name }} с {{ TF }}](../../kms/tutorials/terraform-key.md).