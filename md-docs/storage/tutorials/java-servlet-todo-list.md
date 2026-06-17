# Развертывание веб-приложения с использованием Java Servlet API

# Развертывание веб-приложения с использованием Java Servlet API


Узнайте, как с помощью serverless-технологий и Java Servlet API создать небольшое веб-приложение для управления списком задач.

Чтобы создать веб-приложение:

1. [Подготовьте облако к работе](#before-begin).
1. [Подготовьте окружение](#prepare).
1. [Создайте бакет Yandex Object Storage](#create-bucket).
1. [Создайте базу данных YDB](#create-db).
1. [Создайте функции Yandex Cloud Functions](#create-functions).
1. [Создайте API-шлюз](#create-api-gw).
1. [Протестируйте приложение](#test).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-begin}

Зарегистрируйтесь в Yandex Cloud и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления](https://console.yandex.cloud), затем войдите в Yandex Cloud или зарегистрируйтесь.
1. На странице **[Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts)** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака](https://console.yandex.cloud/cloud).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

В стоимость ресурсов поддержки веб-приложения входят:

* Плата за количество запросов к API-шлюзу и исходящий трафик ([тарифы Yandex API Gateway](../../api-gateway/pricing.md)).
* Плата за операции с YDB и хранение данных ([тарифы Yandex Managed Service for YDB](../../ydb/pricing/serverless.md)).
* Плата за количество вызовов функции, вычислительные ресурсы, выделенные для выполнения функции, и исходящий трафик ([тарифы Cloud Functions](../../functions/pricing.md)).

## Подготовьте окружение {#prepare}

1. [Создайте](../../iam/operations/sa/create.md#create-sa) сервисный аккаунт и [назначьте](../../iam/operations/roles/grant.md#cloud-or-folder) ему роль `editor` на ваш каталог.
1. Склонируйте [репозиторий](https://github.com/yandex-cloud-examples/yc-serverless-servlet) c проектом:

    ```bash
    git clone https://github.com/yandex-cloud-examples/yc-serverless-servlet
    ```
1. Добавьте содержимое склонированного локального репозитория `yc-serverless-servlet` в ZIP-архив `servlet.zip`. Архив потребуется позднее для создания функций Yandex Cloud Functions.


## Создайте бакет Object Storage {#create-bucket}

Создайте [бакет](../concepts/bucket.md) и загрузите в него файл `index.html`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать бакет.
  1. Перейдите в сервис **Object Storage**.
  1. Нажмите кнопку **Создать бакет**.
  1. На странице создания бакета:
     1. Введите имя бакета в соответствии с [правилами именования](../concepts/bucket.md#naming).
     1. При необходимости ограничьте максимальный размер бакета.
     1. В полях **Чтение объектов**, **Чтение списка объектов** и **Чтение настроек** выберите `С авторизацией`.
     1. Выберите [класс хранилища](../concepts/storage-class.md) по умолчанию.
     1. Нажмите кнопку **Создать бакет** для завершения операции.
  1. Выберите созданный бакет.
  1. Нажмите кнопку **Загрузить** и выберите в папке с проектом файл `src/main/resources/index.html`.
  1. Выберите [класс хранилища](../concepts/storage-class.md) для файла и нажмите кнопку **Загрузить**.

{% endlist %}

## Создайте базу данных Managed Service for YDB {#create-db}

1. Создайте базу данных в [режиме Serverless](../../ydb/concepts/serverless-and-dedicated.md#serverless):

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором создали бакет.
     1. Перейдите в сервис **Managed Service for&nbsp;YDB**.
     1. Нажмите кнопку **Создать базу данных**.
     1. Введите **Имя** базы. Требования к имени:

        * длина — от 3 до 63 символов;
        * может содержать строчные буквы латинского алфавита, цифры и дефисы;
        * первый символ — буква, последний — не дефис.

     1. В блоке **Тип базы данных** выберите `Serverless`.
     1. Нажмите кнопку **Создать базу данных**.
     1. Дождитесь запуска базы данных. В процессе создания база будет иметь статус `Provisioning`, а когда станет готова к использованию, статус изменится на `Running`.
     1. Выберите созданную БД.
     1. В блоке **Соединение** найдите поле **Эндпоинт** и сохраните его значение. Оно понадобится при создании функций.

   {% endlist %}

1. Создайте таблицу с именем `Tasks`:

   {% list tabs group=instructions %}

   - Консоль управления {#console}

     1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором создали базу данных.
     1. Перейдите в сервис **Managed Service for&nbsp;YDB**.
     1. На странице **Базы данных** выберите базу.
     1. Чтобы открыть корневую директорию базы, перейдите на вкладку **Навигация**.
     1. Для создания запроса к базе в правом верхнем углу нажмите кнопку **Новый SQL-запрос**. Откроется страница **Запрос**.
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

## Создайте функции Cloud Functions {#create-functions}

Создайте [функцию](../../functions/concepts/function.md) для каждого сервлета:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором создали бакет и базу данных.
  1. Перейдите в сервис **Cloud Functions**.
  1. Нажмите кнопку **Создать функцию**.
  1. Введите имя `add-task` и описание функции.
  1. Нажмите кнопку **Создать**.
  1. В блоке **Редактор** выберите среду выполнения `java21`, выключите опцию **Добавить файлы с примерами кода** и нажмите кнопку **Продолжить**.
  1. Подготовьте код функции. Для этого в поле **Источник кода** выберите `ZIP-архив`.
  1. В поле **Файл** нажмите кнопку **Прикрепить файл** и выберите созданный ранее архив `servlet.zip`.
  1. В поле **Точка входа** введите `yandex.cloud.examples.serverless.todo.AddTaskServlet`.
  1. В поле **Таймаут** установите значение `10`.
  1. В поле **Сервисный аккаунт** укажите аккаунт, созданный при [подготовке окружения](#prepare).
  1. Добавьте переменные окружения:
     * `ENDPOINT` — введите первую часть сохраненного при [создании базы данных YDB](#create-db) значения поля **Эндпоинт** (часть между вхождениями `grpcs://` и `/?database=`). Например, `ydb.serverless.yandexcloud.net:2135`.
     * `DATABASE` — введите вторую часть сохраненного при [создании базы данных YDB](#create-db) значения поля **Эндпоинт** (часть после вхождения `/?database=`). Например, `/ru-central1/r1gra875baom********/g5n22e7ejfr1********`.
  1. Нажмите кнопку **Сохранить изменения**.
  1. На странице **Обзор** включите опцию **Публичная функция**.
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
     http_invoke_url: https://functions.yandexcloud.net/d4ejb1799eko********
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

  Воспользуйтесь API методами [create](../../functions/functions/api-ref/Function/create.md), [createVersion](../../functions/functions/api-ref/Function/createVersion.md) и [setAccessBindings](../../functions/functions/api-ref/Function/setAccessBindings.md) для ресурса [Function](../../functions/functions/api-ref/Function/index.md).


{% endlist %}

## Создайте API-шлюз {#create-api-gw}

Для обеспечения взаимодействия между сервисами создайте API-шлюз:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором создали бакет, базу данных и функции.
  1. Перейдите в сервис **API Gateway**.
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
             service_account_id: <идентификатор_сервисного_аккаунта>
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
       * `service_account_id` — идентификатор сервисного аккаунта, созданного при [подготовке окружения](#prepare).
       * Блок `/add`, параметр `function_id` — идентификатор функции `add-task`.
       * Блок `/list`, параметр `function_id` — идентификатор функции `list-tasks`.
       * Блок `/delete`, параметр `function_id` — идентификатор функции `delete-task`.

  1. Нажмите кнопку **Создать**.

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
             service_account_id: <идентификатор_сервисного_аккаунта>
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
     * `service_account_id` — идентификатор сервисного аккаунта, созданного при [подготовке окружения](#prepare).
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
     domain: d5dm1lba80md********.i9******.apigw.yandexcloud.net
     log_group_id: ckg2hdmevnvc********
     ```


{% endlist %}

## Проверьте работу приложения {#test}

Чтобы открыть приложение, перейдите по ссылке, указанной в поле **Служебный домен** созданного API-шлюза.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

* [Удалите бакет](../operations/buckets/delete.md).
* [Удалите базу данных](../../ydb/operations/manage-databases.md#delete-db).
* [Удалите функции](../../functions/operations/function/function-delete.md).
* [Удалите API-шлюз](../../api-gateway/operations/api-gw-delete.md).