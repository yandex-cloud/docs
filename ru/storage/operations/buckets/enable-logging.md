# Работа с механизмом логирования действий с бакетом

Чтобы отслеживать работу с [бакетом](../../concepts/bucket.md), включите [механизм логирования](../../concepts/server-logs.md). Подробная информация о запросах к _исходному_ бакету будет сохранена в [объекте](../../concepts/object.md) в _целевом_ бакете. Однако {{ objstorage-name }} [не гарантирует](../../concepts/server-logs.md) полноту и своевременность записи логов.

По умолчанию механизм логирования отключен. После его включения, {{ objstorage-name }} будет записывать информацию о действиях с бакетом раз в час.

## Включите механизм логирования {#enable}

Чтобы логировать обращения к бакету:

1. Используйте существующий или создайте новый целевой бакет. В этот бакет будут записываться логи.

   {% cut "Как создать бакет" %}

   {% include [create-bucket](../../../_includes/storage/create-bucket.md) %}

   {% endcut %}

   {% include [target-backet-note](../../../_includes/storage/target-bucket-note.md) %}

1. Включите механизм логирования в исходном бакете, который вы хотите отслеживать.

   {% list tabs group=instructions %}

   - AWS CLI {#cli}

     Чтобы включить логирование с помощью [AWS CLI](../../tools/aws-cli.md):

     1. Создайте файл с настройками логирования в формате JSON. Например:

         ```json
         {
            "LoggingEnabled": {
               "TargetBucket": "<имя_целевого_бакета>",
               "TargetPrefix": "<префикс_ключа>"
            }
         }
         ```

         Где:

         * `TargetBucket` — имя целевого бакета, в который будут записываться логи.
         * `TargetPrefix` — [префикс ключа](../../concepts/server-logs.md#key-prefix) для объектов с логами, например, `logs/`.
     
     1. Включите логирование в бакете:

         ```bash
         aws s3api put-bucket-logging \
           --bucket <имя_исходного_бакета> \
           --endpoint-url https://{{ s3-storage-host }} \
           --bucket-logging-status file://<путь_к_файлу_настроек>
         ```

         Где:

         * `--bucket` — имя исходного бакета, для которого нужно включить логирование действий.
         * `--bucket-logging-status` — путь к файлу с настройками логирования.

   - {{ TF }} {#tf}

     {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

     
     {% include [terraform-install](../../../_includes/terraform-install.md) %}


     Чтобы включить механизм логирования в бакете, который вы хотите отслеживать:

     1. Откройте файл конфигурации {{ TF }} и добавьте блок `logging` во фрагмент с описанием бакета.

        ```hcl
        resource "yandex_storage_bucket" "log_bucket" {
          access_key = "<идентификатор_статического_ключа>"
          secret_key = "<секретный_ключ>"
          bucket     = "<имя_бакета_для_хранения_логов>"
        }

        resource "yandex_storage_bucket" "bucket" {
          access_key = "<идентификатор_статического_ключа>"
          secret_key = "<секретный_ключ>"
          bucket     = "<имя_исходного_бакета>"
          acl        = "private"

          logging {
            target_bucket = yandex_storage_bucket.log_bucket.id
            target_prefix = "log/"
          }
        }
        ```

        Где:
        * `access_key` — идентификатор статического ключа доступа.
        * `secret_key` — значение секретного ключа доступа.
        * `target_bucket` — указание на бакет для хранения логов.
        * `target_prefix` — [префикс ключа](../../concepts/server-logs.md#key-prefix) для объектов с логами, например `logs/`.

        Более подробную информацию о параметрах ресурса `yandex_storage_bucket` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/storage_bucket#enable-logging).



        {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

        После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

   - API {#api}

     Чтобы включить механизм логирования в бакете, воспользуйтесь методом S3 API [putBucketLogging](../../s3/api-ref/bucket/putBucketLogging.md).

     Пример тела HTTP-запроса:

     ```xml
     <BucketLoggingStatus xmlns="http://doc.s3.amazonaws.com/2006-03-01">
       <LoggingEnabled>
         <TargetBucket>имя целевого бакета</TargetBucket>
         <TargetPrefix>префикс ключа</TargetPrefix>
       </LoggingEnabled>
     </BucketLoggingStatus>
     ```

     Где:

     * `TargetBucket` – имя целевого бакета;
     * `TargetPrefix` – [префикс ключа](../../concepts/server-logs.md#key-prefix) для объектов с логами, например `logs/`.

   {% endlist %}

## Получите настройки логирования {#get-settings}

Чтобы получить имя целевого бакета и префикс ключа объекта с логами, выполните следующее действие:

{% list tabs group=instructions %}

- AWS CLI {#cli}

   Чтобы получить настройки логирования с помощью [AWS CLI](../../tools/aws-cli.md):

   Выполните команду:

   ```bash
   aws s3api get-bucket-logging \
     --bucket <имя_бакета> \
     --output json \
     --endpoint-url https://{{ s3-storage-host }}
   ```

   Результат:

   ```json
   {
       "LoggingEnabled": {
         "TargetBucket": "<имя_бакета>",
         "TargetPrefix": "<префикс_ключа>"
       }
   }
   ```

- API {#api}

  Воспользуйтесь методом S3 API [getBucketLogging](../../s3/api-ref/bucket/getBucketLogging.md).

  Пример тела HTTP-ответа:

  ```xml
  HTTP/1.1 200
  <?xml version="1.0" encoding="UTF-8"?>
  <BucketLoggingStatus>
     <LoggingEnabled>
        <TargetBucket>имя целевого бакета</TargetBucket>
        <TargetPrefix>logs/</TargetPrefix>
     </LoggingEnabled>
  </BucketLoggingStatus>
  ```

{% endlist %}

## Получите логи {#get-logs}

Чтобы получить логи, скачайте из целевого бакета объект с префиксом `logs/`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где находится целевой бакет с логами.
  1. Выберите сервис **{{ objstorage-name }}**.
  1. Нажмите на имя целевого бакета с логами.
  1. Нажмите на имя объекта с префиксом `logs/`.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.file.button_download }}**.

{% endlist %}

## Выключить механизм логирования {#stop-logging}

Чтобы выключить логирование, выполните следующее действие:

{% list tabs group=instructions %}

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}


  Чтобы выключить механизм логирования:

  1. Откройте файл конфигураций {{ TF }} и удалите блок `logging` во фрагменте с описанием бакета.

      {% cut "Пример описания бакета в конфигурации {{ TF }}" %}

      ```hcl
      ...
      resource "yandex_storage_bucket" "log_bucket" {
        access_key = "<идентификатор_статического_ключа>"
        secret_key = "<секретный_ключ>"
        bucket     = "<имя_бакета_для_хранения_логов>"
      }

      resource "yandex_storage_bucket" "bucket" {
        access_key = "<идентификатор_статического_ключа>"
        secret_key = "<секретный_ключ>"
        bucket     = "<имя_исходного_бакета>"
        acl        = "private"

        logging {
          target_bucket = yandex_storage_bucket.log_bucket.id
          target_prefix = "log/"
        }
      }
      ...
      ```

      {% endcut %}

  {% include [terraform-validate-plan-apply](../../../_tutorials/terraform-validate-plan-apply.md) %}

  Проверить изменения можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Воспользуйтесь методом S3 API [putBucketLogging](../../s3/api-ref/bucket/putBucketLogging.md). В теле запроса передайте параметр `<BucketLoggingStatus>` с пустым значением.

  Пример тела HTTP-запроса:

  ```xml
  <BucketLoggingStatus xmlns="http://doc.s3.amazonaws.com/2006-03-01" />
  ```

{% endlist %}
