

Узнайте, как с помощью serverless-технологий и Java Servlet API создать небольшое веб-приложение для управления списком задач.

Чтобы создать веб-приложение:

1. [Подготовьте облако к работе](#before-begin).
1. [Подготовьте окружение](#prepare).
1. [Создайте бакет {{ objstorage-full-name }}](#create-bucket).
1. [Создайте базу данных {{ ydb-short-name }}](#create-db).
1. [Создайте функции {{ sf-full-name }}](#create-functions).
1. [Создайте API-шлюз](#create-api-gw).
1. [Протестируйте приложение](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость ресурсов поддержки веб-приложения входят:

* Плата за количество запросов к API-шлюзу и исходящий трафик (см. [тарифы {{ api-gw-full-name }}](../../api-gateway/pricing.md)).
* Плата за операции с {{ ydb-short-name }} и хранение данных (см. [тарифы {{ ydb-full-name }}](../../ydb/pricing/serverless.md)).
* Плата за количество вызовов функции, вычислительные ресурсы, выделенные для выполнения функции, и исходящий трафик (см. [тарифы {{ sf-name }}](../../functions/pricing.md)).

## Подготовьте окружение {#prepare}

1. [Создайте](../../iam/operations/sa/create.md#create-sa) сервисный аккаунт и [назначьте](../../iam/operations/roles/grant.md#cloud-or-folder) ему роль `{{ roles-editor }}` на ваш каталог.
1. Склонируйте [репозиторий](https://github.com/yandex-cloud-examples/yc-serverless-servlet) c проектом:

    ```bash
    git clone https://github.com/yandex-cloud-examples/yc-serverless-servlet
    ```
1. Добавьте содержимое склонированного локального репозитория `yc-serverless-servlet` в ZIP-архив `servlet.zip`. Архив потребуется позднее для создания функций {{ sf-full-name }}.


## Создайте бакет {{ objstorage-name }} {#create-bucket}

Создайте [бакет](../../storage/concepts/bucket.md) и загрузите в него файл `index.html`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать бакет.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. На странице создания бакета:
     1. Введите имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).
     1. При необходимости ограничьте максимальный размер бакета.
     1. В полях **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}**, **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}** и **{{ ui-key.yacloud.storage.bucket.settings.field_access-config-read }}** выберите `{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}`.
     1. Выберите [класс хранилища](../../storage/concepts/storage-class.md) по умолчанию.
     1. Нажмите кнопку **{{ ui-key.yacloud.storage.buckets.create.button_create }}** для завершения операции.
  1. Выберите созданный бакет.
  1. Нажмите кнопку **{{ ui-key.yacloud.storage.bucket.button_upload }}** и выберите в папке с проектом файл `src/main/resources/index.html`.
  1. Выберите [класс хранилища](../../storage/concepts/storage-class.md) для файла и нажмите кнопку **{{ ui-key.yacloud.storage.bucket.button_upload }}**.

{% endlist %}

## Создайте базу данных {{ ydb-name }} {#create-db}

1. Создайте базу данных в [режиме Serverless](../../ydb/concepts/serverless-and-dedicated.md#serverless):

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создали бакет.
     1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
     1. Нажмите кнопку **{{ ui-key.yacloud.ydb.databases.button_create }}**.
     1. Введите **{{ ui-key.yacloud.ydb.forms.label_field_name }}** базы. Требования к имени:

        {% include [name-format](../../_includes/name-format.md) %}

     1. В блоке **{{ ui-key.yacloud.ydb.forms.label_field_database-type }}** выберите `{{ ui-key.yacloud.ydb.forms.label_serverless-type }}`.
     1. Нажмите кнопку **{{ ui-key.yacloud.ydb.forms.button_create-database }}**.
     1. Дождитесь запуска базы данных. В процессе создания база будет иметь статус `Provisioning`, а когда станет готова к использованию, статус изменится на `Running`.
     1. Выберите созданную БД.
     1. В блоке **{{ ui-key.yacloud.ydb.overview.section_connection }}** найдите поле **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** и сохраните его значение. Оно понадобится при создании функций.

   {% endlist %}

1. Создайте таблицу с именем `Tasks`:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создали базу данных.
     1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
     1. На странице **{{ ui-key.yacloud.ydb.databases.label_title }}** выберите базу.
     1. Чтобы открыть корневую директорию базы, перейдите на вкладку **{{ ui-key.yacloud.ydb.database.switch_browse }}**.
     1. Для создания запроса к базе в правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.ydb.browse.button_sql-query }}**. Откроется страница **{{ ui-key.yacloud.ydb.sql.label_query }}**.
     1. В поле **{{ ui-key.yacloud.ydb.sql.label_query }}** введите:

        ```sql
        CREATE TABLE Tasks (
          TaskId Utf8,
          Name Utf8,
          Description Utf8,
          CreatedAt Datetime,
          PRIMARY KEY (TaskId)
        );
        ```

     1. Нажмите кнопку **{{ ui-key.yacloud.ydb.sql.button_run }}**.

   - CLI {#cli}

     Выполните запрос:

     ```bash
     ydb -e grpcs://<YDB_эндпоинт> -d <имя_БД> \
     scripting yql -s \
     "CREATE TABLE Tasks
     (
       TaskId Utf8,
       Name Utf8,
       Description Utf8,
       CreatedAt Datetime,
       PRIMARY KEY (TaskId)
     );"
     ```

   {% endlist %}

## Создайте функции {{ sf-name }} {#create-functions}

Создайте [функцию](../../functions/concepts/function.md) для каждого сервлета:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором создали бакет и базу данных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
  1. Введите имя `add-task` и описание функции.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}** выберите среду выполнения `java21`, выключите опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** и нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
  1. Подготовьте код функции. Для этого в поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}** выберите `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}`.
  1. В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_file }}** нажмите кнопку **Прикрепить файл** и выберите созданный ранее архив `servlet.zip`.
  1. В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** введите `yandex.cloud.examples.serverless.todo.AddTaskServlet`.
  1. В поле **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** установите значение `10`.
  1. В поле **{{ ui-key.yacloud.forms.label_service-account-select }}** укажите аккаунт, созданный при [подготовке окружения](#prepare).
  1. Добавьте переменные окружения:
     * `ENDPOINT` — введите первую часть сохраненного при [создании базы данных {{ ydb-short-name }}](#create-db) значения поля **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** (часть между вхождениями `grpcs://` и `/?database=`). Например, `ydb.serverless.yandexcloud.net:2135`.
     * `DATABASE` — введите вторую часть сохраненного при [создании базы данных {{ ydb-short-name }}](#create-db) значения поля **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** (часть после вхождения `/?database=`). Например, `/{{ region-id }}/r1gra875baom********/g5n22e7ejfr1********`.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.
  1. На странице **{{ ui-key.yacloud.serverless-functions.item.overview.label_title }}** включите опцию **{{ ui-key.yacloud.serverless-functions.item.overview.label_all-users-invoke }}**.
  1. Повторите шаги 3-14 и создайте функцию с именем `list-tasks` и точкой входа `yandex.cloud.examples.serverless.todo.ListTasksServlet`.
  1. Повторите шаги 3-14 и создайте функцию с именем `delete-task` и точкой входа `yandex.cloud.examples.serverless.todo.DeleteTaskServlet`.

- CLI {#cli}

  1. Создайте функцию с именем `add-task`:

     ```bash
     yc serverless function create --name=add-task
     ```

     Результат:

     ```text
     id: d4ejb1799eko********
     folder_id: aoek49ghmknn********
     created_at: "2021-03-08T14:07:32.134Z"
     name: add-task
     log_group_id: eolm8aoq9vcp********
     http_invoke_url: https://{{ sf-url }}/d4ejb1799eko********
     status: ACTIVE
     ```

  1. Создайте версию функции `add-task`:

     ```bash
     yc serverless function version create \
       --function-name=add-task \
       --runtime java21 \
       --entrypoint yandex.cloud.examples.serverless.todo.AddTaskServlet \
       --memory 128m \
       --execution-timeout 10s \
       --source-path ./servlet.zip \
       --environment DATABASE=<имя_БД>,ENDPOINT=<YDB_эндпоинт>
     ```

     Где:

     * `--function-name` — имя функции, версию которой вы хотите создать.
     * `--runtime` — среда выполнения.
     * `--entrypoint` — точка входа, указывается в формате `<имя_файла_с_функцией>`.`<имя_обработчика>`.
     * `--memory` — объем RAM.
     * `--execution-timeout` — максимальное время выполнения функции до таймаута.
     * `--source-path` — путь к созданному ранее ZIP-архиву `servlet.zip` с кодом функции и необходимыми зависимостями.
     * `--environment` — переменные окружения в формате `key=value`.

     Результат:

     ```text
     done (1s)
     id: d4evvn8obisa********
     function_id: d4ejb1799eko********
     ...
     tags:
     - $latest
     log_group_id: ckg3qh8h363p********
     ```

  1. Сделайте функцию публичной:

     ```bash
     yc serverless function allow-unauthenticated-invoke add-task
     ```

     Результат:

     ```text
     done (1s)
     ```

  1. Повторите шаги 1-3 и создайте функцию с именем `list-tasks` и точкой входа `yandex.cloud.examples.serverless.todo.ListTasksServlet`.
  1. Повторите шаги 1-3 и создайте функцию с именем `delete-task` и точкой входа `yandex.cloud.examples.serverless.todo.DeleteTaskServlet`.

- API {#api}

  Воспользуйтесь API методами [create](../../functions/functions/api-ref/Function/create), [createVersion](../../functions/functions/api-ref/Function/createVersion) и [setAccessBindings](../../functions/functions/api-ref/Function/setAccessBindings) для ресурса [Function](../../functions/functions/api-ref/Function).


{% endlist %}

## Создайте API-шлюз {#create-api-gw}

Для обеспечения взаимодействия между сервисами создайте API-шлюз:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создали бакет, базу данных и функции.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.list.button_create }}**.
  1. Введите имя шлюза и описание.
  1. В поле **{{ ui-key.yacloud.serverless-functions.gateways.form.field_spec }}** добавьте спецификацию:

     ```yaml
     openapi: 3.0.0
     info:
       title: ToDo list
       version: 1.0.0
     paths:
       /:
         get:
           x-yc-apigateway-integration:
             type: object-storage
             bucket: <бакет>
             object: index.html
             presigned_redirect: false
             service_account: <сервисный_аккаунт>
           operationId: static
       /add:
          post:
            x-yc-apigateway-integration:
              type: cloud-functions
              function_id: <идентификатор_add-task>
            operationId: addTask
       /list:
         get:
           x-yc-apigateway-integration:
             type: cloud-functions
             function_id: <идентификатор_list-tasks>
           operationId: listTasks
       /delete:
         delete:
           x-yc-apigateway-integration:
             type: cloud-functions
             function_id: <идентификатор_delete-task>
           operationId: deleteTask
       ```

       Где:

       * `bucket` — имя бакета, в котором лежит файл `index.html`.
       * `service_account` — идентификатор сервисного аккаунта, созданного при [подготовке окружения](#prepare).
       * Блок `/add`, параметр `function_id` — идентификатор функции `add-task`.
       * Блок `/list`, параметр `function_id` — идентификатор функции `list-tasks`.
       * Блок `/delete`, параметр `function_id` — идентификатор функции `delete-task`.

  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.form.button_create-gateway }}**.

- CLI {#cli}

  1. Сохраните следующую спецификацию в файл `todo.yaml`:

     ```yaml
     openapi: 3.0.0
     info:
       title: ToDo list
       version: 1.0.0
     paths:
       /:
         get:
           x-yc-apigateway-integration:
             type: object-storage
             bucket: <бакет>
             object: index.html
             presigned_redirect: false
             service_account: <сервисный_аккаунт>
           operationId: static
       /add:
         post:
           x-yc-apigateway-integration:
             type: cloud-functions
             function_id: <идентификатор_add-task>
           operationId: addTask
       /list:
         get:
           x-yc-apigateway-integration:
             type: cloud-functions
             function_id: <идентификатор_list-tasks>
           operationId: listTasks
       /delete:
         delete:
           x-yc-apigateway-integration:
             type: cloud-functions
             function_id: <идентификатор_delete-task>
           operationId: deleteTask
     ```

     Где:

     * `bucket` — имя бакета, в котором лежит файл `index.html`.
     * `service_account` — идентификатор сервисного аккаунта, созданного при [подготовке окружения](#prepare).
     * Блок `/add`, параметр `function_id` — идентификатор функции `add-task`.
     * Блок `/list`, параметр `function_id` — идентификатор функции `list-tasks`.
     * Блок `/delete`, параметр `function_id` — идентификатор функции `delete-task`.

  1. Создайте API-шлюз:

     ```bash
     yc serverless api-gateway create \
       --name todo-list \
       --spec=todo.yaml \
       --description "simple todo list"
     ```

     Результат:

     ```text
     done (41s)
     id: d5delqeel34q********
     folder_id: b1g86q4m5vej********
     created_at: "2021-03-08T14:07:32.134Z"
     name: todo-list
     description: simple todo list
     status: ACTIVE
     domain: {{ api-host-apigw }}
     log_group_id: ckg2hdmevnvc********
     ```


{% endlist %}

## Проверьте работу приложения {#test}

Чтобы открыть приложение, перейдите по ссылке, указанной в поле **{{ ui-key.yacloud.serverless-functions.gateways.overview.label_domain }}** созданного API-шлюза.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

* [Удалите бакет](../../storage/operations/buckets/delete.md).
* [Удалите базу данных](../../ydb/operations/manage-databases.md#delete-db).
* [Удалите функции](../../functions/operations/function/function-delete.md).
* [Удалите API-шлюз](../../api-gateway/operations/api-gw-delete.md).
