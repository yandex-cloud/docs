1. [Подготовьте облако к работе](#before-begin).
1. [Настройте хостинг страницы сокращателя](#object-storage).
1. [Создайте сервисный аккаунт](#service-account).
1. [Создайте БД в {{ ydb-full-name }}](#ydb).
1. [Настройте функцию в {{ sf-full-name }}](#function).
1. [Опубликуйте сервис через {{ api-gw-full-name }}](#api-gw).
1. [Проверьте работу сокращателя](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

{% include [serverless-paid-resources](../../_includes/serverless/serverless-url-shortener/paid-resources.md) %}

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

     {% include [serverless-index-html-config](../../_includes/serverless/serverless-url-shortener/html-config.md) %}

     {% endcut %}

  1. Нажмите на имя созданного бакета.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.button_empty-create }}**.
  1. Укажите подготовленный ранее файл `index.html`.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.button_upload }}**.
  1. На панели слева выберите вкладку **{{ ui-key.yacloud.storage.bucket.switch_website }}**.
  1. Выберите опцию **{{ ui-key.yacloud.storage.bucket.website.switch_hosting }}**.
  1. Укажите главную страницу сайта — `index.html`.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.website.button_save }}**.

{% endlist %}

## Создайте сервисный аккаунт {#service-account}

Чтобы создать сервисный аккаунт для взаимодействия компонентов сервиса:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите нужный каталог.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Введите имя [сервисного аккаунта](../../iam/concepts/users/service-accounts.md): `serverless-shortener`.
  1. Нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** и выберите `editor`.
  1. Нажмите **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
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

     В процессе создания база будет иметь статус `Provisioning`, а когда станет готова к использованию, статус изменится на `Running`.
  1. Нажмите на имя созданной БД.

     Сохраните значение поля **{{ ui-key.yacloud.ydb.overview.label_endpoint }}**, оно понадобится на следующих шагах.
  1. На панели слева выберите вкладку **{{ ui-key.yacloud.ydb.database.switch_browse }}**.
  1. Выберите **{{ ui-key.yacloud.ydb.browse.button_create }}** → **{{ ui-key.yacloud.ydb.browse.menu_table }}** в правой части страницы.
  1. Настройте параметры таблицы:
     * **{{ ui-key.yacloud.ydb.table.form.field_name }}** таблицы — `links`.
     * **{{ ui-key.yacloud.ydb.table.form.field_type }}** — `{{ ui-key.yacloud.ydb.table.form.label_row-table }}`.
  1. Добавьте колонки:
     * имя колонки — `id`, тип данных — `Utf8` и установите **{{ ui-key.yacloud.ydb.table.form.column_primary-key }}**.
     * имя колонки — `link`, тип данных — `Utf8`.
  1. Нажмите кнопку **{{ ui-key.yacloud.ydb.table.create.button_create }}**.

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

     {% include [serverless-index-function-config](../../_includes/serverless/serverless-url-shortener/function-config.md) %}

     {% endcut %}

  1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-source }}** создайте файл `requirements.txt` и вставьте в него следующий текст:

     {% include [serverless-requirements](../../_includes/serverless/serverless-url-shortener/requirements.md) %}

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
  1. В поле **{{ ui-key.yacloud.common.name }}** введите `for-serverless-shortener`.
  1. Скопируйте и вставьте следующий код в блок **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}**:

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
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.form.button_create-gateway }}**.
  1. Нажмите на имя созданного API-шлюза.
  1. Скопируйте значение `url` из спецификации.

     Используйте этот URL, чтобы [проверить работу сокращателя ссылок](#test).

{% endlist %}

## Проверьте работу сокращателя {#test}

{% include [serverless-test-shortener](../../_includes/serverless/serverless-url-shortener/test-shortener.md) %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
1. [Удалите](../../api-gateway/operations/api-gw-delete.md) API-шлюз `for-serverless-shortener`.
1. [Удалите](../../functions/operations/function/function-delete.md) функцию `for-serverless-shortener`.
1. [Удалите](../../ydb/operations/manage-databases.md#delete-db) базу данных YDB `for-serverless-shortener`.
1. [Удалите](../../storage/operations/buckets/delete.md) бакет.
