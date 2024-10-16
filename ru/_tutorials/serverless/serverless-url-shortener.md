# Сокращатель ссылок


С помощью этого сценария вы создадите сервис для сокращения URL, используя serverless-технологии, доступные в {{ yandex-cloud }}.

Сервис принимает обращения пользователей через публичный [API-шлюз](../../api-gateway/concepts/index.md). Пользователь получает с [хостинга](../../storage/concepts/hosting.md) HTML-страницу с полем для ввода URL. [Функция](../../functions/concepts/function.md) отправляет введенный URL на хранение в [serverless-базу данных](../../ydb/concepts/serverless-and-dedicated.md#serverless), сокращает его и возвращает пользователю. При обращении пользователя по сокращенному URL, функция находит в БД полный URL и перенаправляет на него запрос пользователя.

Чтобы настроить и протестировать сервис:
1. [Подготовьте облако к работе](#before-begin).
1. [Настройте хостинг страницы сокращателя](#object-storage).
1. [Создайте сервисный аккаунт](#service-account).
1. [Создайте БД в {{ ydb-full-name }}](#ydb).
1. [Настройте функцию в {{ sf-full-name }}](#function).
1. [Опубликуйте сервис через {{ api-gw-full-name }}](#api-gw).
1. [Проверьте работу сокращателя](#test-shortener).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Необходимые платные ресурсы {#paid-resources}

В стоимость ресурсов для сценария входят:
* Плата за использование хранилища (см. [тарифы {{ objstorage-full-name }}](../../storage/pricing.md)).
* Плата за обращения к базе данных (см. [тарифы {{ ydb-name }}](../../ydb/pricing/serverless.md)).
* Плата за вызовы функции (см. [тарифы {{ sf-name }}](../../functions/pricing.md)).
* Плата за запросы к API-шлюзу (см. [тарифы {{ api-gw-name }}](../../api-gateway/pricing.md)).


## Настройте хостинг страницы сокращателя {#object-storage}

Чтобы создать бакет, разместить в нем HTML-страницу вашего сервиса и настроить бакет для хостинга статических сайтов:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите свой рабочий каталог.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. На странице создания бакета:
     1. Введите имя бакета.

        {% note warning %}

        Имена бакетов уникальны для всего {{ objstorage-name }}, т. е. нельзя создать два бакета с одинаковыми именами даже в разных каталогах разных облаков.

        {% endnote %}

     1. Задайте максимальный размер `1 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
     1. Выберите доступ на чтение объектов `{{ ui-key.yacloud.storage.bucket.settings.access_value_public }}`.
     1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.create.button_create }}** для завершения операции.
  1. Скопируйте HTML-код и вставьте его в файл `index.html`:

     {% cut "HTML-код" %}

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

  1. Нажмите на имя созданного бакета.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.button_empty-create }}**.
  1. Укажите подготовленный ранее файл `index.html`.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.button_upload }}**.
  1. На панели слева выберите **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
  1. На вкладке **{{ ui-key.yacloud.storage.bucket.switch_website }}**:
        * Выберите `{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}`.
        * Укажите главную страницу сайта — `index.html`.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.

{% endlist %}

## Создайте сервисный аккаунт {#service-account}

Чтобы создать сервисный аккаунт для взаимодействия компонентов сервиса:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в свой рабочий каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя сервисного аккаунта `serverless-shortener`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите роль `editor`.
  1. Нажмите кнопку **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
  1. Нажмите на имя созданного сервисного аккаунта.

     Сохраните идентификатор созданного сервисного аккаунта, он понадобится на следующих шагах.

{% endlist %}

## Создайте БД в {{ ydb-name }} {#ydb}

Чтобы создать базу данных {{ ydb-name }} и настроить ее для хранения ссылок:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в свой рабочий каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.ydb.databases.button_create }}**.
  1. Введите имя базы `for-serverless-shortener`.
  1. Выберите тип базы данных **{{ ui-key.yacloud.ydb.forms.label_serverless-type }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.ydb.forms.button_create-database }}**.
  1. Дождитесь запуска базы данных.

     В процессе создания база будет иметь статус `Provisioning`, а когда станет готова к использованию — статус изменится на `Running`.
  1. Нажмите на имя созданной БД.

     Сохраните значение поля **{{ ui-key.yacloud.ydb.overview.label_endpoint }}**, оно понадобится на следующих шагах.
  1. На панели слева выберите вкладку **{{ ui-key.yacloud.ydb.database.switch_browse }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.ydb.browse.button_sql-query }}**.
  1. Скопируйте SQL-запрос и вставьте его в поле **{{ ui-key.yacloud.ydb.sql.label_query }}**:

     ```sql
     CREATE TABLE links
     (
       id Utf8,
       link Utf8,
       PRIMARY KEY (id)
     );
     ```

  1. Нажмите кнопку **{{ ui-key.yacloud.ydb.sql.button_run }}**.

{% endlist %}

## Настройте функцию в {{ sf-name }} {#function}

Чтобы создать и настроить функцию сокращения URL:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в свой рабочий каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
  1. Введите имя `for-serverless-shortener`.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. В выпадающем списке **Python** выберите среду выполнения `python312`.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
  1. Скопируйте код функции и вставьте его в файл `index.py` в блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-source }}**.

     {% cut "Код функции" %}

     ```py
     import ydb

     import urllib.parse
     import hashlib
     import base64
     import json
     import os


     def decode(event, body):
       # Тело запроса может быть закодировано.
       is_base64_encoded = event.get('isBase64Encoded')
       if is_base64_encoded:
         body = str(base64.b64decode(body), 'utf-8')
       return body

     def response(statusCode, headers, isBase64Encoded, body):
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
         raise AssertionError("Нужно указать обе переменные окружения")
       credentials = ydb.iam.MetadataUrlCredentials()
       return ydb.DriverConfig(endpoint, database, credentials=credentials)

     def execute(config, query, params):
       with ydb.Driver(config) as driver:
         try:
           driver.wait(timeout=5, fail_fast=True)
         except TimeoutError:
           print("Connect failed to YDB")
           print("Last reported errors by discovery:")
           print(driver.discovery_debug_details())
           return None

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
       print(id)
       config = get_config()
       query = """
         DECLARE $id AS Utf8;

         SELECT link FROM links where id=$id;
         """
       params = {'$id': id}
       result_set = execute(config, query, params)

       if not result_set or not result_set[0].rows:
         return None

       return result_set[0].rows[0].link

     def shorten(event):
       body = event.get('body')

       if body:
         body = decode(event, body)
         original_host = event.get('headers').get('Origin')
         link_id = hashlib.sha256(body.encode('utf8')).hexdigest()[:6]
         # В ссылке могут быть закодированные символы, например, %. Это помешает работе API Gateway при редиректе,
         # поэтому следует избавиться от них вызовом urllib.parse.unquote.
         insert_link(link_id, urllib.parse.unquote(body))
         return response(200, {'Content-Type': 'application/json'}, False, json.dumps({'url': f'{original_host}/r/{link_id}'}))
       return response(400, {}, False, 'В теле запроса отсутствует параметр url')

     def redirect(event):
       link_id = event.get('pathParams').get('id')
       redirect_to = find_link(link_id)

       if redirect_to:
         return response(302, {'Location': redirect_to}, False, '')

       return response(404, {}, False, 'Данной ссылки не существует')

     # Эти проверки нужны, поскольку функция у нас одна.
     # В идеале сделать по функции на каждый путь в API Gateway.
     def get_result(url, event):
       if url == "/shorten":
         return shorten(event)
       if url.startswith("/r/"):
         return redirect(event)

       return response(404, {}, False, 'Данного пути не существует')

     def handler(event, context):
       url = event.get('url')
       if url:
         # Из API Gateway URL может прийти со знаком вопроса на конце.
         if url[-1] == '?':
           url = url[:-1]
         return get_result(url, event)

       return response(404, {}, False, 'Эту функцию следует вызывать при помощи API Gateway.')
     ```

     {% endcut %}

  1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-source }}** создайте файл `requirements.txt` и вставьте в него следующий текст:

     ```txt
     ydb
     ```

  1. Укажите точку входа `index.handler`.
  1. Задайте таймаут `5`.
  1. Выберите сервисный аккаунт `serverless-shortener`.
  1. Добавьте переменные окружения:
     * `endpoint` — введите первую часть сохраненного ранее поля **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** (часть до вхождения `/?database=`). Например, `{{ ydb.ep-serverless }}`.
     * `database` — введите вторую часть сохраненного ранее поля **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** (часть после вхождения `/?database=`). Например, `/{{ region-id }}/r1gra875baom********/g5n22e7ejfr1********`.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.item.overview.label_title }}** включите опцию **{{ ui-key.yacloud.serverless-functions.item.overview.label_all-users-invoke }}**.

  Сохраните идентификатор созданной функции, он понадобится на следующих шагах.

{% endlist %}

## Опубликуйте сервис через {{ api-gw-name }} {#api-gw}

Чтобы опубликовать сервис через {{ api-gw-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в свой рабочий каталог.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**.
  1. В поле **{{ ui-key.yacloud.serverless-functions.gateways.form.field_name }}** введите `for-serverless-shortener`.
  1. Скопируйте и вставьте следующий код в блок **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}**:

     {% cut "Спецификация" %}

     ```yaml
     openapi: 3.0.0
     info:
       title: for-serverless-shortener
       version: 1.0.0
     paths:
       /:
         get:
           x-yc-apigateway-integration:
             type: object_storage
             bucket: <имя_бакета> # <-- имя бакета
             object: index.html # <-- имя html-файла
             presigned_redirect: false
             service_account: <service_account_id> # <-- ID сервисного аккаунта
           operationId: static
       /shorten:
         post:
           x-yc-apigateway-integration:
             type: cloud_functions
             function_id: <function_id> # <-- ID функции
           operationId: shorten
       /r/{id}:
         get:
           x-yc-apigateway-integration:
             type: cloud_functions
             function_id: <function_id> # <-- ID функции
           operationId: redirect
           parameters:
           - description: id of the url
             explode: false
             in: path
             name: id
             required: true
             schema:
               type: string
             style: simple
     ```

     {% endcut %}

     Внесите правки в код спецификации:
     * Замените `<service_account_id>` на идентификатор созданного ранее сервисного аккаунта.
     * Замените `<function_id>` на идентификатор созданной ранее функции.
     * Замените `<имя_бакета>` на имя созданного ранее бакета.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.form.button_create-gateway }}**.
  1. Нажмите на имя созданного API-шлюза.
  1. Скопируйте значение `url` из спецификации.

     Используйте этот URL для работы с созданным сервисом.

{% endlist %}

## Проверьте работу сокращателя {#test-shortener}

Чтобы проверить правильность взаимодействия компонентов сервиса:
1. Откройте в браузере скопированный URL.
1. В поле для ввода введите ссылку, которую вы хотите сократить.
1. Нажмите кнопку **Сократить**.

   Ниже отобразится сокращенная ссылка.
1. Перейдите по сокращенной ссылке, должна открыться та же страница, что и по ссылке до сокращения.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. [Удалите API-шлюз](../../api-gateway/operations/api-gw-delete.md).
1. [Удалите функцию](../../functions/operations/function/function-delete.md).
1. [Удалите базу данных](../../ydb/operations/manage-databases.md#delete-db).
1. [Удалите бакет](../../storage/operations/buckets/delete.md).
1. [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md).