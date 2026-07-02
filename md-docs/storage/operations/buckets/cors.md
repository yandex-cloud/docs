[Документация Yandex Cloud](../../../index.md) > [Yandex Object Storage](../../index.md) > [Пошаговые инструкции](../index.md) > Бакеты > Управление конфигурацией CORS

# Настройка CORS

Object Storage позволяет управлять [конфигурацией CORS](../../concepts/cors.md) в бакете.


{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог.
  1. Перейдите в сервис **Object Storage**.
  1. Выберите бакет, для которого хотите настроить CORS.
  1. На панели слева выберите ![image](../../../_assets/console-icons/persons-lock.svg) **Безопасность**.
  1. Выберите вкладку **CORS**.
  1. Нажмите **Настроить**.
  1. Заполните открывшуюся форму. Вы можете добавлять, удалять и редактировать правила конфигурации.
     
     Чтобы создать правило:
     
     1. Заполните поля:
        * **Описание** — описание правила в произвольной форме.
        * **Allowed Origins** — перечень доменов, разделенных запятыми. Каждый домен записывается в отдельное поле `AllowedOrigin` конфигурации CORS. Пример: `http://*.example.com, http://some.another.dom`.
        * **Allowed Methods** — HTTP-методы, разрешенные в запросе к объекту, разделенные запятыми. Каждый метод записывается в отдельное поле `AllowedMethod` конфигурации CORS. Пример: `GET, PUT, HEAD, POST, DELETE`.
        * **Allowed Headers** — разрешенные заголовки в запросе к объекту, разделенные запятыми. Каждый заголовок записывается в отдельное поле `AllowedHeader` конфигурации CORS. Пример: `X-Request-Id, X-Request-With`.
        * **Expose Headers** — заголовки, разрешенные к показу в JavaScript-приложении в браузере, разделенные запятыми. Каждый заголовок записывается в отдельное поле `ExposeHeader` конфигурации CORS. Пример: `X-Amz-Request-Id`.
        * **MaxAgeSeconds** — время в секундах, в течение которого браузер сохраняет в кеше результат запроса к объекту методом `OPTIONS`.
     1. Нажмите **Сохранить**.
     
     Вы можете добавить одновременно несколько правил. Чтобы добавить новое правило, нажмите **Добавить правило** и повторите предыдущие шаги.
  
     Подробное описание полей конфигурации смотрите в разделе [CORS-конфигурация бакетов](../../s3/api-ref/cors/xml-config.md).

- Yandex Cloud CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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
  1. Выполните команду:

      ```bash
      yc storage bucket update \
        --name <имя_бакета> \
        --cors <параметр_CORS>='[<набор_значений>]',<параметр_CORS>='[<набор_значений>]',...
      ```

      Где:
      * `--name` — имя бакета, в котором нужно настроить конфигурацию CORS.
      * `--cors` — параметры CORS:
        * `allowed-methods` — список методов. Возможные значения: `method-get`, `method-put`, `method-post`, `method-delete`, `method-head`. Обязательный параметр.
        * `allowed-origins` — список сайтов, с которых разрешены кросс-доменные запросы к бакету. Обязательный параметр.
        * `allowed-headers` — список разрешенных заголовков. Необязательный параметр.
        * `expose-headers` — список заголовков, которые разрешено показывать в JavaScript-приложении в браузере. Необязательный параметр.
        * `max-age-seconds` — время в секундах, в течение которого браузер сохраняет в кеше результат запроса к объекту. Необязательный параметр.

        Значения параметров указываются в кавычках и квадратных скобках. Элементы списков в значениях перечисляются через запятую без пробелов. Например, `--cors allowed-methods='[method-get,method-head]',allowed-origins='[example.com]'`.

        Разрешения, указанные в команде, перезаписывают настройки CORS, которые уже есть у бакета. Получить текущие разрешения можно с помощью команды `yc storage bucket get <имя_бакета> --full`.

        Результат:

        ```text
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

- AWS CLI {#aws-cli}

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
       --endpoint-url=https://storage.yandexcloud.net
     ```

- Terraform {#tf}

  {% note info %}
  
  Если вы работаете с Object Storage через Terraform от имени [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту нужную [роль](../../security/index.md#roles-list), например `storage.admin`, на каталог, в котором будут создаваться ресурсы.
  
  {% endnote %}

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../../terraform/authentication.md) соответствующим способом.

  Получите [статические ключи доступа](../../../iam/operations/authentication/manage-access-keys.md#create-access-key) — секретный ключ и идентификатор ключа, используемые для аутентификации в Object Storage.

  {% note info %}
  
  Кроме статических ключей доступа для аутентификации в Object Storage можно использовать IAM-токен. Подробнее смотрите в разделе [Создание бакета](create.md) и в [документации провайдера](../../../terraform/resources/storage_object.md). 
  
  {% endnote %}


  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     ```hcl
     provider "yandex" {
       cloud_id  = "<идентификатор_облака>"
       folder_id = "<идентификатор_каталога>"
       zone      = "<зона_доступности>"
     }

     resource "yandex_iam_service_account" "sa" {
       name = "<имя_сервисного_аккаунта>"
     }

     // Назначение роли сервисному аккаунту
     resource "yandex_resourcemanager_folder_iam_member" "sa-admin" {
       folder_id = "<идентификатор_каталога>"
       role      = "storage.admin"
       member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
     }

     // Создание статического ключа доступа
     resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
       service_account_id = yandex_iam_service_account.sa.id
       description        = "static access key for object storage"
     }

     resource "yandex_storage_bucket" "b" {
       bucket = "s3-website-test.hashicorp.com"
       acl    = "public-read"

       access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
       secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key

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
     * `server_side_encryption_configuration` — конфигурация шифрования бакета на стороне сервера. Необязательный параметр.

     Более подробная информация о параметрах ресурса `yandex_storage_bucket` в Terraform приведена в [документации провайдера](../../../terraform/resources/storage_bucket.md).

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

     Проверить изменения можно в [консоли управления](https://console.yandex.cloud).

- API {#api}

  Чтобы управлять конфигурацией CORS в бакете, воспользуйтесь методом REST API [update](../../api-ref/Bucket/update.md) для ресурса [Bucket](../../api-ref/Bucket/index.md), вызовом gRPC API [BucketService/Update](../../api-ref/grpc/Bucket/update.md) или методом S3 API [upload](../../s3/api-ref/cors/upload.md).

{% endlist %}