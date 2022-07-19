# Настройка CORS

{{ objstorage-name }} позволяет управлять [конфигурацией CORS](../../concepts/cors.md) в бакете.

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в бакет, для которого хотите настроить CORS.
  1. В левой панели выберите **CORS**.
  1. Нажмите кнопку **Настроить**.
  1. Откроется страница, на которой вы сможете добавлять, удалять и редактировать правила конфигурации. Подробное описание полей конфигурации смотрите в разделе [{#T}](../../s3/api-ref/cors/xml-config.md).

- AWS CLI

  Чтобы загрузить конфигурацию с помощью AWS CLI:
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

  Получите {% if audience != "internal" %}[статические ключи доступа](../../../iam/operations/sa/create-access-key.md){% else %}статические ключи доступа{% endif %} — секретный ключ и идентификатор ключа, используемые для аутентификации в {{ objstorage-short-name }}.

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     {% if product == "yandex-cloud" %}

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

     {% endif %}

     {% if product == "cloud-il" %}

     ```hcl
     provider "yandex" {
       cloud_id  = "<идентификатор облака>"
       folder_id = "<идентификатор каталога>"
       zone      = "<зона доступности>"
       endpoint  = "{{ api-host }}:443"
       token     = "<статический ключ сервисного аккаунта>"
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

     {% endif %}

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

{% endlist %}