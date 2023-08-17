Узнайте, как с помощью serverless-технологий и Java Servlet API создать небольшое веб-приложение для управления списком задач.

Чтобы создать веб-приложение:
1. [Подготовьте облако к работе](#before-begin).
1. [Подготовьте окружение](#preare).
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

1. [Скачайте](https://{{ s3-storage-host }}/doc-files/servlet.zip) архив с файлами проекта.
1. [Создайте](../../iam/operations/sa/create.md#create-sa) сервисный аккаунт и [назначьте](../../iam/operations/roles/grant.md#access-to-sa) ему роли `viewer` и `editor` на ваш каталог.

## Создайте бакет {{ objstorage-name }} {#create-bucket}

Создайте [бакет](../../storage/concepts/bucket.md) и загрузите в него файл `index.html`:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать бакет.
  1. Выберите сервис **{{ objstorage-name }}**.
  1. Нажмите кнопку **Создать бакет**.
  1. На странице создания бакета:
     1. Введите имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).
     1. При необходимости ограничьте максимальный размер бакета.
     1. В полях **Доступ на чтение объектов**, **Доступ к списку объектов** и **Доступ на чтение настроек** выберите **Ограниченный**.
     1. Выберите [класс хранилища](../../storage/concepts/storage-class.md) по умолчанию.
     1. Нажмите кнопку **Создать бакет** для завершения операции.
  1. Выберите созданный бакет.
  1. Нажмите кнопку **Загрузить**.
  1. В появившемся окне выберите в папке с проектом файл `src/main/resources/index.html` и нажмите кнопку **Открыть**.
  1. Выберите [класс хранилища](../../storage/concepts/storage-class.md) для файла и нажмите кнопку **Загрузить**.

{% endlist %}

## Создайте базу данных {{ ydb-name }} {#create-db}

1. Создайте базу данных в [режиме Serverless](../../ydb/concepts/serverless-and-dedicated.md#serverless):

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создали бакет.
     1. Выберите сервис **{{ ydb-name }}**.
     1. Нажмите кнопку **Создать базу данных**.
     1. Введите **Имя** базы. Требования к имени:

        {% include [name-format](../../_includes/name-format.md) %}

     1. В блоке **Тип базы данных** выберите **Serverless**.
     1. Нажмите кнопку **Создать базу данных**.
     1. Дождитесь запуска базы данных. В процессе создания база будет иметь статус `Provisioning`, а когда станет готова к использованию, статус изменится на `Running`.
     1. Выберите созданную БД.
     1. В блоке **Соединение** найдите поля **Эндпоинт** и **Размещение базы данных** и сохраните их значения. Они понадобятся при создании функций.

   {% endlist %}

1. Создайте таблицу с именем `Tasks`:

   {% list tabs %}

   - Консоль управления

     1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создали базу данных.
     1. Выберите сервис **{{ ydb-name }}**.
     1. На странице **Базы данных** выберите базу.
     1. Чтобы открыть корневую директорию базы, перейдите на вкладку **Навигация**.
     1. Для создания запроса к базе в правом верхнем углу нажмите кнопку **SQL-запрос**. Откроется страница **Запрос**.
     1. В поле **Запрос** введите:

        ```sql
        CREATE TABLE Tasks (
          TaskId Utf8,
          Name Utf8,
          Description Utf8,
          CreatedAt Datetime,
          PRIMARY KEY (TaskId)
        );
        ```

     1. Нажмите кнопку **Выполнить**.

   - CLI

     Выполните запрос:

     ```bash
     ydb -e grpcs://<YDB эндпоинт> -d <база данных> \
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

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором создали бакет и базу данных.
  1. Выберите сервис **{{ sf-name }}**.
  1. Нажмите кнопку **Создать функцию**.
  1. Введите имя `add-task` и описание функции.
  1. Нажмите кнопку **Создать**.
  1. В блоке **Редактор** выберите среду выполнения **Java 11** и нажмите кнопку **Продолжить**.
  1. Подготовьте код функции. Для этого в поле **Способ** выберите **ZIP-архив**, укажите путь к скачанному архиву `servlet.zip` и нажмите кнопку **Открыть**.
  1. В поле **Точка входа** введите `yandex.cloud.examples.serverless.todo.AddTaskServlet`.
  1. В поле **Таймаут, с** установите значение `5`.
  1. В поле **Сервисный аккаунт** укажите аккаунт, созданный при [подготовке окружения](#prepare).
  1. Добавьте переменные окружения:
     * `ENDPOINT` — введите значение поля **Эндпоинт**, сохраненное при [создании базы данных {{ ydb-short-name }}](#create-db).
     * `DATABASE` — введите значение поля **Размещение базы данных**, также сохраненное при [создании базы данных {{ ydb-short-name }}](#create-db).
  1. Нажмите кнопку **Создать версию**.
  1. Повторите шаги 3-12 и создайте функцию с именем `list-tasks` и точкой входа `yandex.cloud.examples.serverless.todo.ListTasksServlet`.
  1. Повторите шаги 3-12 и создайте функцию с именем `delete-task` и точкой входа `yandex.cloud.examples.serverless.todo.DeleteTaskServlet`.

- CLI

  1. Создайте функцию с именем `add-task`:

     ```bash
     yc serverless function create --name=add-task
     ```

     Результат:

     ```bash
     id: d4ejb1799eko********
     folder_id: aoek49ghmknn********
     created_at: "2021-03-08T14:07:32.134Z"
     name: add-task
     log_group_id: eolm8aoq9vcp********
     http_invoke_url: https://functions.yandexcloud.net/d4ejb1799eko********
     status: ACTIVE
     ```

  1. Создайте версию функции `add-task`:

     ```bash
     yc serverless function version create \
       --function-name=add-task \
       --runtime java11 \
       --entrypoint yandex.cloud.examples.serverless.todo.AddTaskServlet \
       --memory 128m \
       --execution-timeout 5s \
       --source-path ./servlet.zip \
       --environment DATABASE=<база данных>,ENDPOINT=<YDB эндпоинт>
     ```

     Где:
     * `function-name` — имя функции, версию которой вы хотите создать.
     * `runtime` — среда выполнения.
     * `entrypoint` — точка входа, указывается в формате \<имя файла с функцией>.\<имя обработчика>.
     * `memory` — объем RAM.
     * `execution-timeout` — максимальное время выполнения функции до таймаута.
     * `source-path` — ZIP-архив с кодом функции и необходимыми зависимостями.
     * `environment` — переменные окружения в формате key=value.

     Результат:

     ```bash
     done (1s)
     id: d4evvn8obisa********
     function_id: d4ejb1799eko********
     ...
     tags:
     - $latest
     log_group_id: ckg3qh8h363p********
     ```

  1. Повторите шаги 1-2 и создайте функцию с именем `list-tasks` и точкой входа `yandex.cloud.examples.serverless.todo.ListTasksServlet`.
  1. Повторите шаги 1-2 и создайте функцию с именем `delete-task` и точкой входа `yandex.cloud.examples.serverless.todo.DeleteTaskServlet`.

- API

  Воспользуйтесь API методами [create](../../functions/functions/api-ref/Function/create) и [createVersion](../../functions/functions/api-ref/Function/createVersion).

- {{ yandex-cloud }} Toolkit

  Создать функцию и ее версию можно с помощью [плагина {{ yandex-cloud }} Toolkit](https://github.com/yandex-cloud/ide-plugin-jetbrains) для семейства IDE на [платформе IntelliJ](https://www.jetbrains.com/ru-ru/opensource/idea/) от [JetBrains](https://www.jetbrains.com/).

{% endlist %}

## Создайте API-шлюз {#create-api-gw}

Для обеспечения взаимодействия между сервисами создайте API-шлюз:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором создали бакет, базу данных и функции.
  1. Выберите сервис **{{ api-gw-name }}**.
  1. Нажмите кнопку **Создать API-шлюз**.
  1. Введите имя шлюза и описание.
  1. В поле **Спецификация** добавьте спецификацию:

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
             service_account: <сервисный аккаунт>
           operationId: static
       /add:
          post:
            x-yc-apigateway-integration:
              type: cloud-functions
              function_id: <идентификатор add-task>
            operationId: addTask
       /list:
         get:
           x-yc-apigateway-integration:
             type: cloud-functions
             function_id: <идентификатор list-tasks>
           operationId: listTasks
       /delete:
         delete:
           x-yc-apigateway-integration:
             type: cloud-functions
             function_id: <идентификатор delete-task>
           operationId: deleteTask
       ```

       Где:
       * `bucket` — имя бакета, в котором лежит файл `index.html`.
       * `service_account` — идентификатор сервисного аккаунта, созданного при [подготовке окружения](#prepare).
       * Блок `/add`, параметр `function_id` — идентификатор функции `add-task`.
       * Блок `/list`, параметр `function_id` — идентификатор функции `list-tasks`.
       * Блок `/delete`, параметр `function_id` — идентификатор функции `delete-task`.
  1. Нажмите кнопку **Создать**.

- CLI

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
             service_account: <сервисный аккаунт>
           operationId: static
       /add:
         post:
           x-yc-apigateway-integration:
             type: cloud-functions
             function_id: <идентификатор add-task>
           operationId: addTask
       /list:
         get:
           x-yc-apigateway-integration:
             type: cloud-functions
             function_id: <идентификатор list-tasks>
           operationId: listTasks
       /delete:
         delete:
           x-yc-apigateway-integration:
             type: cloud-functions
             function_id: <идентификатор delete-task>
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

     ```bash
     done (41s)
     id: d5delqeel34q********
     folder_id: b1g86q4m5vej********
     created_at: "2021-03-08T14:07:32.134Z"
     name: todo-list
     description: simple todo list
     status: ACTIVE
     domain: d5delqeel34q********.apigw.yandexcloud.net
     log_group_id: ckg2hdmevnvc********
     ```

- {{ yandex-cloud }} Toolkit

  Создать API-шлюз можно с помощью [плагина {{ yandex-cloud }} Toolkit](https://github.com/yandex-cloud/ide-plugin-jetbrains) для семейства IDE на [платформе IntelliJ](https://www.jetbrains.com/ru-ru/opensource/idea/) от [JetBrains](https://www.jetbrains.com/).

{% endlist %}

## Проверьте работу приложения {#test}

Чтобы открыть приложение, перейдите по ссылке, указанной в поле **Служебный домен** созданного API-шлюза.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:
* [Удалите бакет](../../storage/operations/buckets/delete.md).
* [Удалите базу данных](../../ydb/operations/manage-databases.md#delete-db).
* [Удалите функции](../../functions/operations/function/function-delete.md).
* [Удалите API-шлюз](../../api-gateway/operations/api-gw-delete.md).
