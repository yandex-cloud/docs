[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Functions](../index.md) > [Практические руководства](index.md) > Бэкенд на Serverless > Развертывание веб-приложения с использованием Java Servlet API

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

В стоимость ресурсов, необходимых для поддержки веб-приложения, входят:

* Плата за количество запросов к API-шлюзу и исходящий трафик ([тарифы Yandex API Gateway](../../api-gateway/pricing.md)).
* Плата за операции с YDB и хранение данных ([тарифы Yandex Managed Service for YDB](../../ydb/pricing/serverless.md)).
* Плата за количество вызовов функции, вычислительные ресурсы, выделенные для выполнения функции, и исходящий трафик ([тарифы Cloud Functions](../pricing.md)).

## Подготовьте окружение {#prepare}

1. [Создайте](../../iam/operations/sa/create.md#create-sa) сервисный аккаунт и [назначьте](../../iam/operations/roles/grant.md#cloud-or-folder) ему следующие [роли](*roles) на ваш каталог:

    * [`functions.functionInvoker`](../security/index.md#functions-functionInvoker);
    * [`storage.viewer`](../../storage/security/index.md#storage-viewer);
    * [`ydb.editor`](../../ydb/security/index.md#ydb-editor).
1. Склонируйте [репозиторий](https://github.com/yandex-cloud-examples/yc-serverless-servlet) c проектом:

    ```bash
    git clone https://github.com/yandex-cloud-examples/yc-serverless-servlet
    ```
1. Добавьте содержимое склонированного локального репозитория `yc-serverless-servlet` в ZIP-архив `servlet.zip`. Архив потребуется позднее при создании функций Yandex Cloud Functions.


## Создайте бакет Yandex Object Storage {#create-bucket}

Создайте [бакет](*bucket) и загрузите в него файл `index.html`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором хотите создать бакет.
  1. Перейдите в сервис **Object Storage**.
  1. Нажмите кнопку **Создать бакет** и в открывшемся окне:

      1. Задайте имя бакета в соответствии с [правилами именования](*bucket_name).
      1. При необходимости ограничьте максимальный размер бакета.
      1. В полях **Чтение объектов**, **Чтение списка объектов** и **Чтение настроек** выберите `С авторизацией`.
      1. Выберите [класс хранилища](*storage_class) по умолчанию.
      1. Нажмите кнопку **Создать бакет**.
  1. Выберите созданный бакет.
  1. В правом верхнем углу страницы нажмите кнопку ![arrow-up-from-line](../../_assets/console-icons/arrow-up-from-line.svg) **Загрузить** и в папке с проектом выберите файл `src/main/resources/index.html`.
  1. Выберите класс хранилища для файла и нажмите кнопку **Загрузить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Чтобы создать бакет, выполните команду, указав уникальное [имя бакета](*bucket_name):

      ```bash
      yc storage bucket create \
        --name <имя_бакета> \
        --default-storage-class standard
      ```

      Результат:

      ```text
      name: sample-bucket
      folder_id: b1g5bhjofg7o********
      anonymous_access_flags: {}
      default_storage_class: STANDARD
      versioning: VERSIONING_DISABLED
      created_at: "2026-06-01T04:44:30.688587Z"
      resource_id: e3eqmpmknkus********
      ```

      Подробнее о команде `yc storage bucket create` читайте в [справочнике CLI](../../cli/cli-ref/storage/cli-ref/bucket/create.md).

  1. Чтобы загрузить в бакет файл `index.html`, выполните команду:

      ```bash
      yc storage s3api put-object \
        --bucket <имя_бакета> \
        --key index.html \
        --body "<локальный_путь_к_файлу>" \
        --content-type "text/html"
      ```

      Где:

      * `--bucket` — имя бакета, созданного ранее.
      * `--body` — локальный путь к файлу `index.html`, скачанному ранее из репозитория. Например: `/Users/myuser/repositories/yc-serverless-servlet/src/main/resources/index.html`.

      Результат:

      ```text
      etag: '"f38989ca9039c275f5f56840********"'
      request_id: 72d413fc********
      ```

      Подробнее о команде `yc storage s3api put-object` читайте в [справочнике CLI](../../cli/cli-ref/storage/cli-ref/s3api/put-object.md).

{% endlist %}

## Создайте базу данных Yandex Managed Service for YDB {#create-db}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Создайте базу данных в [режиме Serverless](*ydb_modes):

      1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создали бакет.
      1. Перейдите в сервис **Managed Service for&nbsp;YDB**.
      1. Нажмите кнопку **Создать базу данных**.
      1. Задайте **[Имя](*name)** базы.
      1. В блоке **Тип базы данных** выберите `Serverless`.
      1. Нажмите кнопку **Создать базу данных**.
      1. Дождитесь запуска базы данных. В процессе создания база будет иметь статус `Provisioning`, а когда станет готова к использованию, статус изменится на `Running`.
      1. Выберите созданную БД.
      1. В блоке **Соединение** найдите поле **Эндпоинт** и сохраните его значение. Оно понадобится позднее при создании функций.
  1. Создайте таблицу с именем `Tasks`:

      1. Чтобы открыть корневую директорию базы, в меню слева выберите ![folder](../../_assets/console-icons/folder.svg) **Навигация**.
      1. Чтобы создать запрос к БД, в правом верхнем углу нажмите кнопку **Новый SQL-запрос**. На открывшейся странице **Запрос**:

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
          1. Нажмите кнопку ![triangle-right-fill](../../_assets/console-icons/triangle-right-fill.svg) **Выполнить**.

- CLI {#cli}

  1. Создайте базу данных в [режиме Serverless](../../ydb/concepts/serverless-and-dedicated.md#serverless), указав в команде ее [имя](*name):

      ```bash
      yc ydb database create <имя_БД> \
        --serverless
      ```

      Результат:

      ```text
      done (22s)
      id: etnm3b9gco6k********
      folder_id: b1g5bhjofg7o********
      created_at: "2026-06-01T04:54:48Z"
      name: sample-database
      status: PROVISIONING
      endpoint: grpcs://ydb.serverless.yandexcloud.net:2135/?database=/ru-central1/b1gj9ja2h4ct********/etnm3b9gco6k********
      serverless_database:
        storage_size_limit: "53687091200"
      location_id: ru-central1
      backup_config:
        backup_settings:
          - name: daily
            backup_schedule:
              daily_backup_schedule:
                execute_time:
                  hours: 17
            backup_time_to_live: 604800s
            type: SYSTEM
      document_api_endpoint: https://docapi.serverless.yandexcloud.net/ru-central1/b1gj9ja2h4ct********/etnm3b9gco6k********
      monitoring_config: {}
      ```

      Сохраните значение поля `endpoint`. Оно понадобится позднее.

      Подробнее о команде `yc ydb database create` читайте в [справочнике CLI](../../cli/cli-ref/ydb/cli-ref/database/create.md).
  1. [Установите](https://ydb.tech/docs/ru/reference/ydb-cli/install) утилиту `YDB CLI`, позволяющую работать с базами данных YDB.
  1. Сохраните [IAM-токен](../../iam/concepts/authorization/iam-token.md), необходимый для аутентификации запросов через `YDB CLI`, в переменную окружения `IAM_TOKEN`:

        ```bash
        export IAM_TOKEN=$(yc iam create-token)
        ```
  1. Создайте таблицу с именем `Tasks`:

      ```bash
      ydb \
        --endpoint grpcs://ydb.serverless.yandexcloud.net:2135 \
        --database "/ru-central1/b1gj9ja2h4ct********/etnjkrvloo7k********" \
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

      Где:

      * `--endpoint` — первая часть значения поля `endpoint`, сохраненного при создании базы данных (часть до вхождения `/?database=`). Например, `grpcs://ydb.serverless.yandexcloud.net:2135`.
      * `--database` — вторая часть значения поля `endpoint` (часть после вхождения `/?database=`). Например: `/ru-central1/b1gj9ja2h4ct********/etnjkrvloo7k********`.

{% endlist %}

## Создайте функции Cloud Functions {#create-functions}

Создайте [функцию](*functions) для каждого сервлета:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором вы создали бакет и базу данных.
  1. Перейдите в сервис **Cloud Functions**.
  1. Нажмите кнопку **Создать функцию**.
  1. Задайте **Имя** `add-task` и (опционально) **Описание** функции.
  1. Нажмите кнопку **Создать**.
  1. В блоке **Редактор** выберите среду выполнения `Java 21`, отключите опцию **Добавить файлы с примерами кода** и нажмите кнопку **Продолжить**.
  1. Подготовьте код функции. Для этого в поле **Источник кода** выберите `ZIP-архив`.
  1. В поле **Файл** нажмите кнопку **Прикрепить файл** и выберите созданный ранее архив `servlet.zip`.
  1. В поле **Точка входа** введите `yandex.cloud.examples.serverless.todo.AddTaskServlet`.
  1. В поле **Таймаут** установите значение `10`.
  1. В поле **Сервисный аккаунт** выберите аккаунт, созданный при [подготовке окружения](#prepare).
  1. Добавьте переменные окружения:
     * `ENDPOINT` — введите первую часть значения поля **Эндпоинт**, сохраненного при [создании базы данных YDB](#create-db) (часть между вхождениями `grpcs://` и `/?database=`). Например, `ydb.serverless.yandexcloud.net:2135`.
     * `DATABASE` — введите вторую часть значения поля **Эндпоинт** (часть после вхождения `/?database=`). Например, `/ru-central1/r1gra875baom********/g5n22e7ejfr1********`.
  1. Нажмите кнопку **Сохранить изменения** и дождитесь завершения сборки версии функции.
  1. На открывшейся странице **Обзор** включите опцию **Публичная функция**.
  1. Повторите действия 3–14, чтобы создать функцию с именем `list-tasks` и точкой входа `yandex.cloud.examples.serverless.todo.ListTasksServlet`.
  1. Повторите действия 3–14, чтобы создать функцию с именем `delete-task` и точкой входа `yandex.cloud.examples.serverless.todo.DeleteTaskServlet`.

- CLI {#cli}

  1. Создайте функцию с именем `add-task`:

      ```bash
      yc serverless function create \
        --name add-task
      ```

      Результат:

      ```text
      id: d4e3reah34e0********
      folder_id: b1g5bhjofg7o********
      created_at: "2026-06-01T05:07:13.071Z"
      name: add-task
      http_invoke_url: https://functions.yandexcloud.net/d4e3reah34e0********
      status: ACTIVE
      ```

      Сохраните идентификатор созданной функции (значение поля `id`). Он понадобится позднее при создании API-шлюза.

      Подробнее о команде `yc serverless function create` читайте в [справочнике CLI](../../cli/cli-ref/serverless/cli-ref/function/create.md).
  1. Создайте версию функции `add-task`:

      ```bash
      yc serverless function version create \
        --function-name add-task \
        --runtime java21 \
        --service-account-id <идентификатор_сервисного_аккаунта> \
        --entrypoint "yandex.cloud.examples.serverless.todo.AddTaskServlet" \
        --memory 128m \
        --execution-timeout 10s \
        --source-path "./servlet.zip" \
        --environment ENDPOINT="<YDB_эндпоинт>",DATABASE="<имя_БД>"
      ```

      Где:

      * `--function-name` — имя функции, версию которой вы хотите создать.
      * `--runtime` — среда выполнения.
      * `--service-account-id` — [идентификатор](../../iam/operations/sa/get-id.md) сервисного аккаунта, созданного при [подготовке окружения](#prepare).
      * `--entrypoint` — точка входа, указывается в формате `<имя_файла_с_функцией>.<имя_обработчика>`.
      * `--memory` — объем RAM, доступный функции.
      * `--execution-timeout` — максимальное время выполнения функции до таймаута.
      * `--source-path` — локальный путь к созданному ранее ZIP-архиву `servlet.zip` с кодом функции и необходимыми зависимостями.
      * `--environment` — переменные окружения в формате `key=value`:

          * `ENDPOINT` — первая часть значения поля `endpoint`, сохраненного при создании базы данных (часть между вхождениями `grpcs://` и `/?database=`). Например, `ydb.serverless.yandexcloud.net:2135`.
          * `DATABASE` — вторая часть значения поля `endpoint` (часть после вхождения `/?database=`). Например: `/ru-central1/b1gj9ja2h4ct********/etnjkrvloo7k********`.

      Результат:

      ```text
      done (52s)
      id: d4eve0ahaf3e********
      function_id: d4e3reah34e0********
      created_at: "2026-06-01T05:18:34.900Z"
      ...
      log_options:
        folder_id: b1g5bhjofg7o********
      ```

      Подробнее о команде `yc serverless function version create` читайте в [справочнике CLI](../../cli/cli-ref/serverless/cli-ref/function/version/create.md).
  1. Сделайте функцию публичной:

      ```bash
      yc serverless function allow-unauthenticated-invoke add-task
      ```

      Подробнее о команде `yc serverless function allow-unauthenticated-invoke` читайте в [справочнике CLI](../../cli/cli-ref/serverless/cli-ref/function/allow-unauthenticated-invoke.md).
  1. Повторите действия 1–3, чтобы создать функцию с именем `list-tasks` и точкой входа `yandex.cloud.examples.serverless.todo.ListTasksServlet`.
  1. Повторите действия 1–3, чтобы создать функцию с именем `delete-task` и точкой входа `yandex.cloud.examples.serverless.todo.DeleteTaskServlet`.

{% endlist %}

## Создайте API-шлюз {#create-api-gw}

Для обеспечения взаимодействия между сервисами создайте [API-шлюз](*api_gw):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы создали бакет, базу данных и функции.
  1. Перейдите в сервис **API Gateway**.
  1. Нажмите кнопку **Создать API-шлюз**.
  1. Задайте **[Имя](*name)** и (опционально) **Описание** шлюза.
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
              bucket: <имя_бакета>
              object: index.html
              presigned_redirect: false
              service_account_id: <идентификатор_сервисного_аккаунта>
            operationId: static
        /add:
            post:
              x-yc-apigateway-integration:
                type: cloud-functions
                function_id: <идентификатор_функции_add-task>
              operationId: addTask
        /list:
          get:
            x-yc-apigateway-integration:
              type: cloud-functions
              function_id: <идентификатор_функции_list-tasks>
            operationId: listTasks
        /delete:
          delete:
            x-yc-apigateway-integration:
              type: cloud-functions
              function_id: <идентификатор_функции_delete-task>
            operationId: deleteTask
      ```

        Где:

        * `bucket` — имя бакета, в который вы загрузили файл `index.html`.
        * `service_account_id` — [идентификатор](../../iam/operations/sa/get-id.md) сервисного аккаунта, созданного при [подготовке окружения](#prepare).
        * Блок `/add`, параметр `function_id` — [идентификатор](../operations/function/function-info.md) функции `add-task`.
        * Блок `/list`, параметр `function_id` — идентификатор функции `list-tasks`.
        * Блок `/delete`, параметр `function_id` — идентификатор функции `delete-task`.

  1. Нажмите кнопку **Создать**.
  1. В открывшемся списке API-шлюзов нажмите на созданный шлюз и сохраните URL-адрес созданного API-шлюза (значение поля **Служебный домен**).

- CLI {#cli}

  1. Создайте файл `todo.yaml` и сохраните в него следующую спецификацию:

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
              bucket: <имя_бакета>
              object: index.html
              presigned_redirect: false
              service_account_id: <идентификатор_сервисного_аккаунта>
            operationId: static
        /add:
            post:
              x-yc-apigateway-integration:
                type: cloud-functions
                function_id: <идентификатор_функции_add-task>
              operationId: addTask
        /list:
          get:
            x-yc-apigateway-integration:
              type: cloud-functions
              function_id: <идентификатор_функции_list-tasks>
            operationId: listTasks
        /delete:
          delete:
            x-yc-apigateway-integration:
              type: cloud-functions
              function_id: <идентификатор_функции_delete-task>
            operationId: deleteTask
      ```

      Где:

      * `bucket` — имя бакета, в который вы загрузили файл `index.html`.
      * `service_account_id` — [идентификатор](../../iam/operations/sa/get-id.md) сервисного аккаунта, созданного при [подготовке окружения](#prepare).
      * Блок `/add`, параметр `function_id` — идентификатор функции `add-task`, сохраненный ранее.
      * Блок `/list`, параметр `function_id` — идентификатор функции `list-tasks`, сохраненный ранее.
      * Блок `/delete`, параметр `function_id` — идентификатор функции `delete-task`, сохраненный ранее.
  1. Создайте API-шлюз, указав в команде локальный путь к созданному ранее файлу `todo.yaml`:

      ```bash
      yc serverless api-gateway create \
        --name todo-list \
        --spec "./todo.yaml" \
        --description "simple todo list"
      ```

      Результат:

      ```text
      done (2s)
      id: d5d9ut8546r7********
      folder_id: b1g5bhjofg7o********
      created_at: "2026-06-01T05:49:08.648Z"
      name: todo-list
      description: simple todo list
      status: ACTIVE
      domain: d5d9ut8546r7********.wnq2w1o5.apigw.yandexcloud.net
      connectivity: {}
      log_options:
        folder_id: b1g5bhjofg7o********
      execution_timeout: 300s
      ```

      Сохраните доменное имя (значение поля `domain`) созданного API-шлюза. Шлюз будет доступен по URL-адресу `https://<доменное_имя>`.

      Подробнее о команде `yc serverless api-gateway create` читайте в [справочнике CLI](../../cli/cli-ref/serverless/cli-ref/api-gateway/create.md).

{% endlist %}

## Проверьте работу приложения {#test}

Чтобы открыть приложение, в браузере перейдите по URL-адресу созданного API-шлюза. Если все было настроено правильно, в открывшемся приложении вы сможете создавать, просматривать и удалять задачи.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

* [Удалите API-шлюз](../../api-gateway/operations/api-gw-delete.md).
* [Удалите функции](../operations/function/function-delete.md).
* [Удалите базу данных](../../ydb/operations/manage-databases.md#delete-db).
* [Удалите](../../storage/operations/objects/delete.md) файл `index.html`, затем [удалите](../../storage/operations/buckets/delete.md) бакет.

[*name]: Требования к имени:
         
         * длина — от 3 до 63 символов;
         * может содержать строчные буквы латинского алфавита, цифры и дефисы;
         * первый символ — буква, последний — не дефис.

[*bucket_name]: Имя бакета должно быть уникальным в пределах сервиса Yandex Object Storage. Подробнее читайте в разделе [Именование бакетов](../../storage/concepts/bucket.md#naming).

[*storage_class]: В зависимости от требований пользователя к длительности хранения объектов и частоте операций с ними Yandex Object Storage предоставляет хранилища разных классов. Подробнее читайте в разделе [Класс хранилища](../../storage/concepts/storage-class.md).

[*ydb_modes]: Базы данных YDB типа `Serverless` не требуют от пользователя какого-либо конфигурирования, администрирования, отслеживания загрузки или управления ресурсами. Подробнее читайте в разделе [Режимы работы Serverless и Dedicated](../../ydb/concepts/serverless-and-dedicated.md).

[*functions]: Функции Yandex Cloud Functions позволяют размещать в Yandex Cloud код, который можно запускать по запросу или триггеру. Подробнее читайте в разделе [Функция](../concepts/function.md).

[*bucket]: Бакет — это часть хранилища Yandex Object Storage, выделенная для данных пользователя. Подробнее читайте в разделе [Бакет в Object Storage](../../storage/concepts/bucket.md).

[*api_gw]: API-шлюз — это интерфейс взаимодействия с сервисами в интернете или внутри Yandex Cloud, который задается декларативно при помощи спецификации. Подробнее читайте в разделе [Взаимосвязь ресурсов в API Gateway](../../api-gateway/concepts/index.md).

[*roles]: Роль — это набор разрешений, который определяет допустимые операции с ресурсами в Yandex Cloud. Подробнее читайте в разделе [Роли](../../iam/concepts/access-control/roles.md).