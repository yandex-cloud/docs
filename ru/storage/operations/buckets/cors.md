# Настройка CORS

{{ objstorage-name }} позволяет управлять [конфигурацией CORS](../../concepts/cors.md) в бакете.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в бакет, для которого хотите настроить CORS.
  1. В левой панели выберите **{{ ui-key.yacloud.storage.bucket.cors.label_title }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.cors.button_cors_empty-create }}**.
  1. Откроется страница, на которой вы сможете добавлять, удалять и редактировать правила конфигурации. Подробное описание полей конфигурации смотрите в разделе [{#T}](../../s3/api-ref/cors/xml-config.md).

- {{ yandex-cloud }} CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для изменения бакета:

      ```bash
      yc storage bucket update --help
      ```
  
  1. Получите список бакетов в каталоге по умолчанию:

      ```bash
      yc storage bucket list
      ```

      Результат:

      ```text
      +------------------+----------------------+-------------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       |  MAX SIZE   | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      | first-bucket     | b1gmit33ngp6******** | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      ```
   
  1. Сохраните имя бакета (столбец `NAME`), в котором нужно настроить конфигурацию CORS.
  1. Выполните следующую команду:

      ```bash
      yc storage bucket update
        --name <имя_бакета> \
        --cors <параметр_CORS>=<значение>,<параметр_CORS>=<значение>,...
      ```

      Где:
      * `--name` — имя бакета, в котором нужно настроить конфигурацию CORS.
      * `--cors` — параметры CORS:
        * `allowed-methods` — список методов. Возможные значения: `method-get`, `method-put`, `method-post`, `method-delete`, `method-head`. Обязательный параметр.
        * `allowed-origins` — список сайтов, с которых разрешены кросс-доменные запросы к бакету. Обязательный параметр.
        * `allowed-headers` — список разрешенных заголовков. Необязательный параметр.
        * `expose-headers` — список заголовков, которые разрешено показывать в JavaScript-приложении в браузере. Необязательный параметр.
        * `max-age-seconds` — время в секундах, в течение которого браузер сохраняет в кеше результат запроса к объекту. Необязательный параметр.
        
        Списки обособляются квадратными скобками, элементы в них перечисляются через запятую без пробелов. Например, `allowed-methods=[method-get,method-head],allowed-origins=[example.com]`.

        Разрешения, указанные в команде, перезаписывают настройки CORS, которые уже есть у бакета. Получить текущие разрешения можно с помощью команды `yc storage bucket get <имя_бакета> --full`.

        Результат:

        ```yaml
        name: first-bucket
        folder_id: b1gmit33ngp6********
        default_storage_class: STANDARD
        versioning: VERSIONING_DISABLED
        max_size: "53687091200"
        acl: {}
        created_at: "2022-11-25T11:48:42.024638Z"     
        ```

  Чтобы удалить конфигурацию CORS, выполните команду:

  ```bash
  yc storage bucket update \
    --name <имя_бакета> \    
    --remove-cors
  ```

- AWS CLI

  Чтобы загрузить конфигурацию с помощью [AWS CLI](../../tools/aws-cli.md):

  1. Опишите конфигурацию CORS объектов в формате JSON. Например:

     ```json
     {
       "CORSRules": [
         {
           "AllowedHeaders": ["*"],
           "AllowedMethods": ["GET", "HEAD", "PUT", "DELETE"],
           "MaxAgeSeconds": 3000,
           "AllowedOrigins": ["*"]
         }
       ]
     }
     ```

     Готовую конфигурацию можно поместить в файл, например, `cors.json`.

  1. Загрузите конфигурацию в бакет, например, `shared-bucket`:

     ```bash
     aws s3api put-bucket-cors \
       --bucket shared-bucket \
       --cors-configuration file://cors.json \
       --endpoint-url=https://{{ s3-storage-host }}
     ```

- {{ TF }}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Получите [статические ключи доступа](../../../iam/operations/sa/create-access-key.md) — секретный ключ и идентификатор ключа, используемые для аутентификации в {{ objstorage-short-name }}.

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     
     ```hcl
     provider "yandex" {
       cloud_id  = "<идентификатор облака>"
       folder_id = "<идентификатор каталога>"
       zone      = "<зона доступности>"
       token     = "<OAuth-токен>"
       }

     resource "yandex_storage_bucket" "b" {
       bucket = "s3-website-test.hashicorp.com"
       acl    = "public-read"

       access_key = "<идентификатор ключа>"
       secret_key = "<секретный ключ>"

       cors_rule {
         allowed_headers = ["*"]
         allowed_methods = ["PUT", "POST"]
         allowed_origins = ["https://s3-website-test.hashicorp.com"]
         expose_headers  = ["ETag"]
         max_age_seconds = 3000
       }
     }
     ```



     Где:

     * `access_key` — идентификатор статического ключа доступа.
     * `secret_key` — значение секретного ключа доступа.
     * `bucket` — имя бакета. Обязательный параметр.
     * `acl` — применяемая политика ACL. Необязательный параметр.

     Параметры `CORS`:
     * `allowed_headers` — разрешенные заголовки. Необязательный параметр.
     * `allowed_methods` — разрешенные методы. Возможные значения: `GET`, `PUT`, `POST`, `DELETE` или `HEAD`. Обязательный параметр.
     * `allowed_origins` — сайт, с которого разрешены кросс-доменные запросы к бакету. Обязательный параметр.
     * `expose_headers` — заголовок, разрешенный к показу в JavaScript-приложении в браузере. Необязательный параметр. 
     * `max_age_seconds` — Время в секундах, в течение которого браузер сохраняет в кеше результат запроса к объекту. Необязательный параметр.
     * `server_side_encryption_configuration` - конфигурация шифрования бакета на стороне сервера. Необязательный параметр.

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/).

  1. Проверьте корректность конфигурационных файлов.
     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     1. Выполните проверку с помощью команды:

        ```bash
        terraform plan
        ```

     Если конфигурация описана верно, в терминале отобразится список создаваемых ресурсов и их параметров. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Разверните облачные ресурсы.
     1. Если в конфигурации нет ошибок, выполните команду:

        ```bash
        terraform apply
        ```
  
     1. Подтвердите создание ресурсов.
  
     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

- API

  Чтобы управлять конфигурацией CORS в бакете, воспользуйтесь методом REST API [update](../../api-ref/Bucket/update.md) для ресурса [Bucket](../../api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Update](../../api-ref/grpc/bucket_service.md#Update) или методом S3 API [upload](../../s3/api-ref/cors/upload.md).

{% endlist %}
