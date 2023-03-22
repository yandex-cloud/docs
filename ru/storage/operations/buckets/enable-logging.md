# Работа с механизмом логирования действий с бакетом

Чтобы отслеживать работу с [бакетом](../../concepts/bucket.md), включите [механизм логирования](../../concepts/server-logs.md). Подробная информация о запросах к _исходному_ бакету будет сохранена в [объекте](../../concepts/object.md) в _целевом_ бакете. Однако {{ objstorage-name }} [не гарантирует](../../concepts/server-logs.md) полноту и своевременность записи логов.

По умолчанию механизм логирования отключен. После его включения, {{ objstorage-name }} будет записывать информацию о действиях с бакетом раз в час.

## Включите механизм логирования {#enable}

Чтобы логировать обращения к бакету:

1. Используйте существующий или создайте новый целевой бакет с именем, например,`bucket-logs`. В этот бакет будут записываться логи.

   {% cut "Как создать бакет" %}

   {% include [create-bucket](../../../_includes/storage/create-bucket.md) %}

   {% endcut %}

1. Включите механизм логирования в исходном бакете, который вы хотите отслеживать.

   {% list tabs %}

   - {{ TF }}

     {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

     
     Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
 

     Чтобы включить механизм логирования в бакете, который вы хотите отслеживать:

     1. Откройте файл конфигурации {{ TF }} и добавьте блок `logging` во фрагмент с описанием бакета.

        ```hcl
        resource "yandex_storage_bucket" "log_bucket" {
          access_key = "<идентификатор_статического_ключа>"
          secret_key = "<секретный_ключ>"
          bucket     = "my-tf-log-bucket"
        }

        resource "yandex_storage_bucket" "b" {
          access_key = "<идентификатор_статического_ключа>"
          secret_key = "<секретный_ключ>"
          bucket     = "my-tf-test-bucket"
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
        * `target_bucket` — целевой бакет.
	    * `target_prefix` — префикс ключа для объектов с логами.

        Более подробную информацию о параметрах ресурса `yandex_storage_bucket` в {{ TF }} см. в [документации провайдера]({{ tf-provider-link }}/storage_bucket#enable-logging).

     1. Проверьте корректность конфигурационных файлов.

        1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
        1. Выполните проверку с помощью команды:

           ```
           terraform plan
           ```

        Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

     1. Разверните облачные ресурсы.

        1. Если в конфигурации нет ошибок, выполните команду:

           ```
           terraform apply
           ```

        1. Подтвердите создание ресурсов: введите в терминал слово `yes` и нажмите **Enter**.

           После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

   - API

     Отправьте запрос методом [putBucketLogging](../../s3/api-ref/bucket/putBucketLogging.md).

     Пример тела HTTP-запроса:

     ```xml
     <BucketLoggingStatus xmlns="http://doc.s3.amazonaws.com/2006-03-01">
       <LoggingEnabled>
         <TargetBucket>bucket-logs</TargetBucket>
         <TargetPrefix>logs/</TargetPrefix>
       </LoggingEnabled>
     </BucketLoggingStatus>
     ```

     Где:

     * `<TargetBucket>` – имя целевого бакета;
     * `<TargetPrefix>` – префикс, который будет использоваться со всеми [ключами](../../concepts/object.md#key) объектов с логами. Должен заканчиваться знаком `/`, например, `logs/`. Необязательный параметр.

   {% endlist %}

## Получите настройки логирования {#get-settings}

Чтобы получить имя целевого бакета и префикс ключа объекта с логами, выполните следующее действие:

{% list tabs %}

- API

  Отправьте запрос методом [getBucketLogging](../../s3/api-ref/bucket/getBucketLogging.md).

  Пример тела HTTP-ответа:

  ```xml
  HTTP/1.1 200
  <?xml version="1.0" encoding="UTF-8"?>
  <BucketLoggingStatus>
     <LoggingEnabled>
        <TargetBucket>bucket-logs</TargetBucket>
        <TargetPrefix>logs/</TargetPrefix>
     </LoggingEnabled>
  </BucketLoggingStatus>
  ```

{% endlist %}

## Получите логи {#get-logs}

Чтобы получить логи, скачайте из бакета `bucket-logs` объект с префиксом `logs/`:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где находится бакет `bucket-logs`.
  1. Выберите сервис **{{ objstorage-name }}**.
  1. Нажмите на имя бакета `bucket-logs`.
  1. Нажмите на имя объекта с префиксом `logs/`.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.file.button_download }}**.

{% endlist %}

## Выключить механизм логирования {#stop-logging}

Чтобы выключить логирование, выполните следующее действие:

{% list tabs %}

- {{ TF }}

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  
  Подробнее о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


  Чтобы выключить механизм логирования:

  1. Откройте файл конфигураций {{ TF }} и удалите блок `logging` во фрагменте с описанием бакета.

     {% cut "Пример описания бакета в конфигурации {{ TF }}" %}

     ```hcl
     ...
     resource "yandex_storage_bucket" "log_bucket" {
       access_key = "FCAJEJj8ZjyMLr3ZNuNEn7jmO"
       secret_key = "FTR_JbXncjTugRfqsWiiW7c7qnldb5ZEdxbpZkma"
       bucket     = "my-tf-log-bucket"
     }

     resource "yandex_storage_bucket" "b" {
       access_key = "YCAJEJh8ZjyMLr3ZNuCOn7hrO"
       secret_key = "YCM_JbXncjTugRfqsWiiW7c7wcbgb5ZEdxbpZkcf"
       bucket     = "my-tf-test-bucket"
       acl        = "private"

       logging {
         target_bucket = yandex_storage_bucket.log_bucket.id
         target_prefix = "log/"
       }
     }
     ...
     ```

     {% endcut %}

  1. В командной строке перейдите в папку, где расположен файл конфигурации {{ TF }}.

  1. Проверьте конфигурацию командой:

     ```
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:

     ```
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:

     ```
     terraform apply
     ```

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменения можно в [консоли управления]({{ link-console-main }}).

- API

  Отправьте запрос методом [putBucketLogging](../../s3/api-ref/bucket/putBucketLogging.md). В теле запроса передайте параметр `<BucketLoggingStatus>` с пустым значением.

  Пример тела HTTP-запроса:

  ```xml
  <BucketLoggingStatus xmlns="http://doc.s3.amazonaws.com/2006-03-01" />
  ```

{% endlist %}
