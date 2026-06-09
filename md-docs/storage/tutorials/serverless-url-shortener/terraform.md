# Сокращатель ссылок с помощью {{ TF }}


Чтобы создать [сокращатель ссылок](index.md) с помощью {{ TF }}:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте инфраструктуру](#deploy).
1. [Проверьте работу сокращателя](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для сокращателя ссылок входят:
* плата за хранение данных (см. [тарифы {{ objstorage-full-name }}](../../pricing.md));
* плата за операции с [базой данных YDB](../../../ydb/concepts/resources.md#database) и хранение данных (см. [тарифы {{ ydb-name }}](../../../ydb/pricing/serverless.md));
* плата за количество вызовов [функции](../../../functions/concepts/function.md), вычислительные ресурсы, выделенные для выполнения функции, и исходящий трафик (см. [тарифы {{ sf-name }}](../../../functions/pricing.md));
* плата за количество запросов к [API-шлюзу](../../../api-gateway/concepts/index.md) и исходящий трафик (см. [тарифы {{ api-gw-name }}](../../../api-gateway/pricing.md)).

## Создайте инфраструктуру {#deploy}

[{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.

{{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).

Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

Для создания инфраструктуры с помощью {{ TF }}:
1. [Установите {{ TF }}](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform), [получите данные для аутентификации](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) и укажите источник для установки провайдера {{ yandex-cloud }} (раздел [{#T}](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider), шаг 1).
1. Подготовьте файлы с описанием инфраструктуры:

   {% list tabs group=infrastructure_description %}

   - Готовая конфигурация {#ready}

     1. Клонируйте репозиторий с конфигурационными файлами.

        ```bash
        git clone https://github.com/yandex-cloud-examples/yc-serverless-url-shortener.git
        ```

     1. Перейдите в директорию с репозиторием. В ней должны появиться файлы:
         * `serverless-url-shortener.tf` — конфигурация создаваемой инфраструктуры;
         * `serverless-url-shortener.auto.tfvars` — файл с пользовательскими данными;
         * `index.html` — HTML-страница вашего сервиса;
         * `function.zip` — архив с кодом функции {{ sf-name }}.

   - Вручную {#manual}

     1. Создайте папку для конфигурационных файлов.
     1. Создайте в папке:
        1. Конфигурационный файл `serverless-url-shortener.tf`:

           {% cut "serverless-url-shortener.tf" %}

           ```hcl
           # Объявление переменных для конфиденциальных параметров
           
           variable "cloud_id" {
             type = string
           }
           
           variable "folder_id" {
             type = string
           }
           
           variable "bucket_name" {
             type = string
           }
           
           # Настройка провайдера
           
           terraform {
             required_providers {
               yandex = {
                 source = "yandex-cloud/yandex"
               }
             }
           }
           
           provider "yandex" {
             cloud_id  = var.cloud_id
             folder_id = var.folder_id
           }
           
           # Создание сервисного аккаунта
           
           resource "yandex_iam_service_account" "shortener_sa" {
             name        = "serverless-shortener"
             description = "Service account for the URL shortener"
           }
           
           # Назначение роли сервисному аккаунту
           
           resource "yandex_resourcemanager_folder_iam_member" "shortener_role" {
             folder_id = var.folder_id
             role      = "editor"
             member    = "serviceAccount:${yandex_iam_service_account.shortener_sa.id}"
           }
           
           # Создание статического ключа
           
           resource "yandex_iam_service_account_static_access_key" "shortener_sa_key" {
             service_account_id = yandex_iam_service_account.shortener_sa.id
             description        = "Static access key for the service account"
           }
           
           # Создание бакета
           
           resource "yandex_storage_bucket" "shortener_bucket" {
             bucket     = var.bucket_name
             access_key = yandex_iam_service_account_static_access_key.shortener_sa_key.access_key
             secret_key = yandex_iam_service_account_static_access_key.shortener_sa_key.secret_key
             max_size = 1073741824
             anonymous_access_flags {
               read        = true
               list        = false
               config_read = false
             }
           
             website {
               index_document = "index.html"
             }
           }
           
           # Загрузка объекта в бакет
           
           resource "yandex_storage_object" "shortener_index" {
             bucket        = yandex_storage_bucket.shortener_bucket.bucket
             key           = "index.html"
             source        = "index.html"
             acl           = "public-read"
             access_key    = yandex_iam_service_account_static_access_key.shortener_sa_key.access_key
             secret_key    = yandex_iam_service_account_static_access_key.shortener_sa_key.secret_key
             content_type  = "text/html"
           }
           
           # Создание базы данных YDB
           
           resource "yandex_ydb_database_serverless" "shortener_db" {
             name        = "shortener-ydb-main"
             location_id = "{{ region-id }}"
           }
           
           
           # Создание таблицы YDB
           
           resource "yandex_ydb_table" "test_table" {
             path              = "links"
             connection_string = yandex_ydb_database_serverless.shortener_db.ydb_full_endpoint
             column {
               name     = "id"
               type     = "Utf8"
               not_null = true
             }
             column {
               name     = "link"
               type     = "Utf8"
               not_null = true
             }
             primary_key = ["id"]
             
             depends_on = [ yandex_ydb_database_serverless.shortener_db ]
             }
           
           # Создание функции
           
           resource "yandex_function" "shortener_function" {
             name               = "shortener-function-main"
             description        = "Function for the URL shortener"
             runtime            = "python312"
             entrypoint         = "index.handler"
             memory             = 256
             execution_timeout  = 5
             service_account_id = yandex_iam_service_account.shortener_sa.id
           
             content {
               zip_filename = "function.zip"
             }
           
             user_hash = filesha256("function.zip")
           
             environment = {
               endpoint = "grpcs://${yandex_ydb_database_serverless.shortener_db.ydb_api_endpoint}"
               database = yandex_ydb_database_serverless.shortener_db.database_path
             }
           }
           
           resource "yandex_function_iam_binding" "public_invoker" {
             function_id = yandex_function.shortener_function.id
             role        = "functions.functionInvoker"
             members     = ["system:allUsers"]
           }
           
           # Создание API-шлюза
           
           resource "yandex_api_gateway" "shortener_gateway" {
             name = "shortener-gateway-main"
           
             spec = jsonencode({
               openapi = "3.0.0"
               info = {
                 title   = "Shortener API Gateway"
                 version = "1.0.0"
               }
               paths = {
                 "/" = {
                   get = {
                     "x-yc-apigateway-integration" = {
                       type               = "object_storage"
                       bucket             = yandex_storage_bucket.shortener_bucket.bucket
                       object             = "index.html"
                       presigned_redirect = false
                       service_account_id = yandex_iam_service_account.shortener_sa.id
                     }
                     operationId = "static"
                   }
                 }
                 "/shorten" = {
                   post = {
                     "x-yc-apigateway-integration" = {
                       type        = "cloud_functions"
                       function_id = yandex_function.shortener_function.id
                     }
                     operationId = "shorten"
                   }
                 }
                 "/r/{id}" = {
                   get = {
                     "x-yc-apigateway-integration" = {
                       type        = "cloud_functions"
                       function_id = yandex_function.shortener_function.id
                     }
                     operationId = "redirect"
                     parameters = [
                       {
                         description = "ID of the shortened link"
                         explode     = false
                         in          = "path"
                         name        = "id"
                         required    = true
                         schema = {
                           type = "string"
                         }
                         style = "simple"
                       }
                     ]
                   }
                 }
               }
             })
           }
           
           # URL для работы с сокращателем ссылок
           
           output "url" {
             value = "https://${yandex_api_gateway.shortener_gateway.domain}"
           }
           ```

           {% endcut %}

        1. Файл с пользовательскими данными `serverless-url-shortener.auto.tfvars`:

           {% cut "serverless-url-shortener.auto.tfvars" %}

           ```hcl
           cloud_id    = "<идентификатор_облака>" 
           folder_id   = "<идентификатор_каталога>"
           bucket_name = "<имя_бакета>"
           ```

           {% endcut %}

        1. HTML-страница вашего сервиса `index.html`:

           {% cut "index.html" %}

           ```html
           <!DOCTYPE html>
           <html lang="en">
           
           <head>
             <meta charset="UTF-8">
             <title>Сокращатель URL</title>
             <!-- предостережет от лишнего GET запроса на адрес /favicon.ico -->
             <link rel="icon" href="data:;base64,iVBORw0KGgo=">
           </head>
           
           <body>
             <h1>Добро пожаловать</h1>
             <form action="javascript:shorten()">
               <label for="url">Введите ссылку:</label><br>
               <input id="url" name="url" type="text"><br>
               <input type="submit" value="Сократить">
             </form>
             <p id="shortened"></p>
           </body>
           
           <script>
             function shorten() {
               const link = document.getElementById("url").value
               fetch("/shorten", {
                 method: 'POST',
                 headers: {
                   'Content-Type': 'application/json'
                 },
                 body: link
               })
               .then(response => response.json())
               .then(data => {
                 const url = data.url
                 document.getElementById("shortened").innerHTML = `<a href=${url}>${url}</a>`
               })
               .catch(error => {
                 document.getElementById("shortened").innerHTML = `<p>Произошла ошибка ${error}, попробуйте еще раз</p>`
               })
             }
           </script>
           
           </html>
           ```

           {% endcut %}

        1. Файл с кодом функции {{ sf-name }} `index.py`:

           {% cut "index.py" %}

           ```py
           import ydb
           import urllib.parse
           import hashlib
           import base64
           import json
           import os
           import traceback
           
           def decode(event, body):
               is_base64_encoded = event.get('isBase64Encoded')
               if is_base64_encoded:
                   body = str(base64.b64decode(body), 'utf-8')
               return body
           
           def response(statusCode, headers, isBase64Encoded, body):
               # Всегда отдаём строку в body
               if not isinstance(body, str):
                   body = json.dumps(body, ensure_ascii=False)
               return {
                   'statusCode': statusCode,
                   'headers': headers,
                   'isBase64Encoded': isBase64Encoded,
                   'body': body,
               }
           
           def get_config():
               endpoint = os.getenv("endpoint")
               database = os.getenv("database")
               if endpoint is None or database is None:
                   raise AssertionError("Нужно указать обе переменные окружения: endpoint и database")
               credentials = ydb.iam.MetadataUrlCredentials()
               return ydb.DriverConfig(endpoint, database, credentials=credentials)
           
           def execute(config, query, params):
               with ydb.Driver(config) as driver:
                   try:
                       driver.wait(timeout=5, fail_fast=True)
                   except Exception as e:
                       print("Connect failed to YDB:", e)
                       print(driver.discovery_debug_details())
                       raise
           
                   session = driver.table_client.session().create()
                   prepared_query = session.prepare(query)
                   return session.transaction(ydb.SerializableReadWrite()).execute(
                       prepared_query,
                       params,
                       commit_tx=True
                   )
           
           def insert_link(id, link):
               config = get_config()
               query = """
               DECLARE $id AS Utf8;
               DECLARE $link AS Utf8;
           
               UPSERT INTO links (id, link) VALUES ($id, $link);
               """
               params = {'$id': id, '$link': link}
               execute(config, query, params)
           
           def find_link(id):
               config = get_config()
               query = """
               DECLARE $id AS Utf8;
           
               SELECT link FROM links where id=$id;
               """
               params = {'$id': id}
               result_set = execute(config, query, params)
           
               if not result_set or not result_set[0].rows:
                   return None
           
               # Учитываем структуру результата от ydb
               return result_set[0].rows[0].link
           
           def shorten(event):
               try:
                   body = event.get('body')
                   if body is None:
                       return response(400, {'Content-Type': 'application/json'}, False,
                                       {'error': 'В теле запроса отсутствует тело'})
           
                   body = decode(event, body)
           
                   # Попробуем распарсить JSON с ключом url, иначе считаем body как plain string
                   url_value = None
                   try:
                       parsed = json.loads(body)
                       if isinstance(parsed, dict):
                           url_value = parsed.get('url')
                       else:
                           # если отправили не-объект JSON, игнорируем
                           url_value = None
                   except Exception:
                       # body не JSON — считаем, что это plain URL
                       url_value = body
           
                   if not url_value:
                       return response(400, {'Content-Type': 'application/json'}, False,
                                       {'error': 'Ожидался параметр url в теле запроса'})
           
                   # Очищаем URL от эвентуальных кодированных символов
                   clean_url = urllib.parse.unquote(url_value).strip()
                   if not clean_url:
                       return response(400, {'Content-Type': 'application/json'}, False,
                                       {'error': 'Пустой url'})
           
                   link_id = hashlib.sha256(clean_url.encode('utf8')).hexdigest()[:6]
                   insert_link(link_id, clean_url)
           
                   # Возвращаем относительный путь — фронт сам допишет origin
                   return response(200, {'Content-Type': 'application/json'}, False,
                                   {'url': f'/r/{link_id}'})
               except Exception as e:
                   print("Exception in shorten():", e)
                   traceback.print_exc()
                   return response(500, {'Content-Type': 'application/json'}, False,
                                   {'error': 'internal server error'})
           
           def redirect(event):
               try:
                   # защитно доставать path params
                   path_params = event.get('pathParams') or event.get('pathParameters') or {}
                   link_id = path_params.get('id')
                   if not link_id:
                       # возможно пришёл полный путь в event['url'] или ['path']
                       url = event.get('url') or event.get('path') or ''
                       if url and url.startswith('/r/'):
                           link_id = url.split('/r/')[-1].split('?')[0]
           
                   if not link_id:
                       return response(400, {'Content-Type': 'application/json'}, False, {'error': 'id отсутствует'})
           
                   redirect_to = find_link(link_id)
           
                   if redirect_to:
                       return response(302, {'Location': redirect_to}, False, '')
                   return response(404, {'Content-Type': 'application/json'}, False, {'error': 'Данной ссылки не существует'})
               except Exception as e:
                   print("Exception in redirect():", e)
                   traceback.print_exc()
                   return response(500, {'Content-Type': 'application/json'}, False, {'error': 'internal server error'})
           
           def get_result(url, event):
               if url == "/shorten" or url.startswith("/shorten"):
                   return shorten(event)
               if url.startswith("/r/"):
                   return redirect(event)
               return response(404, {'Content-Type': 'application/json'}, False, {'error': 'Данного пути не существует'})
           
           def handler(event, context):
               url = event.get('url') or event.get('path') or ''
               if url:
                   # Иногда URL из шлюза приходит с вопросительным знаком на конце
                   if url.endswith('?'):
                       url = url[:-1]
                   return get_result(url, event)
               return response(404, {'Content-Type': 'application/json'}, False, {'error': 'Функция должна вызываться через API Gateway.'})
           ```

           {% endcut %}

        1. Файл с параметрами окружения функции {{ sf-name }} `requirements.txt`:

           ```text
           ydb
           ```

     1. Создайте в папке архив `function.zip`, содержащий файлы `index.py` и `requirements.txt`.

     1. В файле `serverless-url-shortener.auto.tfvars` задайте пользовательские параметры:

          * `cloud_id` — [идентификатор облака](../../../resource-manager/operations/cloud/get-id.md).
          * `folder_id` — [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md).
          * `bucket_name` — имя [бакета](../../concepts/bucket.md), в котором будут создаваться ресурсы.

   {% endlist %}
   
   Более подробную информацию о параметрах используемых ресурсов в {{ TF }} см. в документации провайдера:
   
   * [Сервисный аккаунт](../../../iam/concepts/users/service-accounts.md) — [yandex_iam_service_account]({{ tf-provider-resources-link }}/iam_service_account).
   * [Статический ключ](../../../iam/concepts/authorization/access-key.md) — [yandex_iam_service_account_static_access_key]({{ tf-provider-resources-link }}/iam_service_account_static_access_key).
   * [Бакет](../../concepts/bucket.md) — [yandex_storage_bucket]({{ tf-provider-resources-link }}/storage_bucket).
   * [Объект](../../concepts/object.md) — [yandex_storage_object]({{ tf-provider-resources-link }}/storage_object).
   * [База данных {{ ydb-name }}](../../../ydb/concepts/resources.md#database) — [yandex_ydb_database_serverless]({{ tf-provider-resources-link }}/ydb_database_serverless).
   * [Таблица {{ ydb-name }}](../../../ydb/concepts/dynamodb-tables.md) — [yandex_ydb_table]({{ tf-provider-resources-link }}/ydb_table).
   * [Функция](../../../functions/concepts/function.md) — [yandex_function]({{ tf-provider-resources-link }}/function).
   * [API-шлюз](../../../api-gateway/concepts/index.md) — [yandex_api_gateway]({{ tf-provider-resources-link }}/api_gateway).

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
   
      В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
   1. Примените изменения конфигурации:
   
      ```bash
      terraform apply
      ```
   
   1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

1. Скопируйте `URL`, полученный в результате создания инфраструктуры, чтобы [проверить работу сокращателя ссылок](#test).

## Проверьте работу сокращателя ссылок {#test}

Чтобы проверить правильность взаимодействия компонентов сервиса:
1. Откройте в браузере скопированный ранее URL сокращателя.
1. В поле для ввода введите ссылку, которую вы хотите сократить.
1. Нажмите кнопку **Сократить**.

   Ниже отобразится сокращенная ссылка.
1. Перейдите по сокращенной ссылке — должна открыться та же страница, что и по ссылке до сокращения.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. Откройте конфигурационный файл `serverless-url-shortener.tf` и удалите описание создаваемой инфраструктуры из файла.
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
    
       В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
    1. Примените изменения конфигурации:
    
       ```bash
       terraform apply
       ```
    
    1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

#### См. также {#see-also}

* [{#T}](console.md)