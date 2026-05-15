# Сокращатель ссылок с помощью консоли управления


Чтобы создать [сокращатель ссылок](index.md) с помощью консоли управления Yandex Cloud:

1. [Подготовьте облако к работе](#before-begin).
1. [Настройте хостинг страницы сокращателя](#object-storage).
1. [Создайте сервисный аккаунт](#service-account).
1. [Создайте БД в Yandex Managed Service for YDB](#ydb).
1. [Настройте функцию в Yandex Cloud Functions](#function).
1. [Опубликуйте сервис через Yandex API Gateway](#api-gw).
1. [Проверьте работу сокращателя](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../../billing/quickstart/index.md) и [привяжите](../../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для сокращателя ссылок входят:
* плата за хранение данных (см. [тарифы Yandex Object Storage](../../../storage/pricing.md));
* плата за операции с [базой данных YDB](../../../ydb/concepts/resources.md#database) и хранение данных (см. [тарифы Managed Service for YDB](../../../ydb/pricing/serverless.md));
* плата за количество вызовов [функции](../../../functions/concepts/function.md), вычислительные ресурсы, выделенные для выполнения функции, и исходящий трафик (см. [тарифы Cloud Functions](../../../functions/pricing.md));
* плата за количество запросов к [API-шлюзу](../../../api-gateway/concepts/index.md) и исходящий трафик (см. [тарифы API Gateway](../../../api-gateway/pricing.md)).

## Настройте хостинг страницы сокращателя {#object-storage}

Чтобы создать бакет, разместить в нем HTML-страницу вашего сервиса и настроить бакет для хостинга статических сайтов:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите свой рабочий каталог.
  1. Выберите сервис **Object Storage**.
  1. Нажмите кнопку **Создать бакет**.
  1. На странице создания бакета:
     1. Введите имя бакета.

        {% note warning %}

        Имена бакетов уникальны для всего Object Storage, т. е. нельзя создать два бакета с одинаковыми именами даже в разных каталогах разных облаков.

        {% endnote %}

     1. Задайте максимальный размер `1 ГБ`.
     1. Выберите доступ на чтение объектов `Для всех`.
     1. Нажмите кнопку **Создать бакет** для завершения операции.
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
  1. Нажмите кнопку **Загрузить объекты**.
  1. Укажите подготовленный ранее файл `index.html`.
  1. Нажмите кнопку **Загрузить**.
  1. На панели слева выберите вкладку **Веб-сайт**.
  1. Выберите опцию **Хостинг**.
  1. Укажите главную страницу сайта — `index.html`.
  1. Нажмите кнопку **Сохранить**.

{% endlist %}

## Создайте сервисный аккаунт {#service-account}

Чтобы создать сервисный аккаунт для взаимодействия компонентов сервиса:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в свой рабочий каталог.
  1. В верхней части экрана перейдите на вкладку **Сервисные аккаунты**.
  1. Нажмите кнопку **Создать сервисный аккаунт**.
  1. Введите имя сервисного аккаунта `serverless-shortener`.
  1. Нажмите **Добавить роль** и выберите роль `editor`.
  1. Нажмите кнопку **Создать**.
  1. Нажмите на имя созданного сервисного аккаунта.

     Сохраните идентификатор созданного сервисного аккаунта, он понадобится на следующих шагах.

{% endlist %}

## Создайте БД в Managed Service for YDB {#ydb}

Чтобы создать базу данных Managed Service for YDB и настроить ее для хранения ссылок:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в свой рабочий каталог.
  1. В списке сервисов выберите **Managed Service for&nbsp;YDB**.
  1. Нажмите кнопку **Создать базу данных**.
  1. Введите имя базы `for-serverless-shortener`.
  1. Выберите тип базы данных **Serverless**.
  1. Нажмите кнопку **Создать базу данных**.
  1. Дождитесь запуска базы данных.

     В процессе создания база будет иметь статус `Provisioning`, а когда станет готова к использованию, статус изменится на `Running`.
  1. Нажмите на имя созданной БД.

     Сохраните значение поля **Эндпоинт**, оно понадобится на следующих шагах.
  1. На панели слева выберите вкладку **Навигация**.
  1. Выберите **Создать** → **Таблицу** в правой части страницы.
  1. Настройте параметры таблицы:
     * **Имя** таблицы — `links`.
     * **Тип таблицы** — `Строковая таблица`.
  1. Добавьте колонки:
     * имя колонки — `id`, тип данных — `Utf8` и установите **Первичный ключ**.
     * имя колонки — `link`, тип данных — `Utf8`.
  1. Нажмите кнопку **Создать таблицу**.

{% endlist %}

## Настройте функцию в Cloud Functions {#function}

Чтобы создать и настроить функцию сокращения URL:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в свой рабочий каталог.
  1. В списке сервисов выберите **Cloud Functions**.
  1. Нажмите кнопку **Создать функцию**.
  1. Введите имя `for-serverless-shortener`.
  1. Нажмите кнопку **Создать**.
  1. В выпадающем списке **Python** выберите среду выполнения `python312`.
  1. Нажмите кнопку **Продолжить**.
  1. Скопируйте код функции и вставьте его в файл `index.py` в блоке **Код функции**.

     {% cut "Код функции" %}

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

  1. В блоке **Код функции** создайте файл `requirements.txt` и вставьте в него следующий текст:

     ```text
     ydb
     ```

  1. Укажите точку входа `index.handler`.
  1. Задайте таймаут `5`.
  1. Выберите сервисный аккаунт `serverless-shortener`.
  1. Добавьте переменные окружения:
     * `endpoint` — введите первую часть сохраненного ранее поля **Эндпоинт** (часть до вхождения `/?database=`). Например, `grpcs://ydb.serverless.yandexcloud.net:2135`.
     * `database` — введите вторую часть сохраненного ранее поля **Эндпоинт** (часть после вхождения `/?database=`). Например, `/ru-central1/r1gra875baom********/g5n22e7ejfr1********`.
  1. Нажмите кнопку **Сохранить изменения**.
  1. В блоке **Обзор** включите опцию **Публичная функция**.

  Сохраните идентификатор созданной функции, он понадобится на следующих шагах.

{% endlist %}

## Опубликуйте сервис через API Gateway {#api-gw}

Чтобы опубликовать сервис через API Gateway:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в свой рабочий каталог.
  1. В списке сервисов выберите **API Gateway**.
  1. Нажмите кнопку **Создать API-шлюз**.
  1. В поле **Имя** введите `for-serverless-shortener`.
  1. Скопируйте и вставьте следующий код в блок **Спецификация**:

     {% cut "Спецификация API-шлюза" %}

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
             service_account: <service_account_id> # <-- идентификатор сервисного аккаунта
           operationId: static
       /shorten:
         post:
           x-yc-apigateway-integration:
             type: cloud_functions
             function_id: <function_id> # <-- идентификатор функции
           operationId: shorten
       /r/{id}:
         get:
           x-yc-apigateway-integration:
             type: cloud_functions
             function_id: <function_id> # <-- идентификатор функции
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
  1. Нажмите кнопку **Создать**.
  1. Нажмите на имя созданного API-шлюза.
  1. Скопируйте значение `url` из спецификации.

     Используйте этот URL, чтобы [проверить работу сокращателя ссылок](#test).

{% endlist %}

## Проверьте работу сокращателя {#test}

Чтобы проверить правильность взаимодействия компонентов сервиса:
1. Откройте в браузере скопированный ранее URL сокращателя.
1. В поле для ввода введите ссылку, которую вы хотите сократить.
1. Нажмите кнопку **Сократить**.

   Ниже отобразится сокращенная ссылка.
1. Перейдите по сокращенной ссылке — должна открыться та же страница, что и по ссылке до сокращения.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. [Удалите](../../../api-gateway/operations/api-gw-delete.md) API-шлюз `for-serverless-shortener`.
1. [Удалите](../../../functions/operations/function/function-delete.md) функцию `for-serverless-shortener`.
1. [Удалите](../../../ydb/operations/manage-databases.md#delete-db) базу данных YDB `for-serverless-shortener`.
1. [Удалите](../../../storage/operations/buckets/delete.md) бакет.

#### См. также {#see-also}

* [Сокращатель ссылок с помощью Terraform](terraform.md)