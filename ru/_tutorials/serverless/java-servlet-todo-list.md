В этом сценарии вы узнаете, как с помощью serverless-технологий и Java Servlet API создать небольшое веб-приложение для управления списком задач.

## Подготовьте окружение {#prepare}

1. [Скачайте](https://storage.yandexcloud.net/doc-files/servlet.zip) архив с файлами проекта.

1. [Создайте](../../iam/operations/sa/create.md#create-sa) сервисный аккаунт и [назначьте](../../iam/operations/roles/grant#access-to-sa) ему роли `viewer` и `editor` на ваш каталог.

1. Создайте [бакет](../../storage/concepts/bucket.md) и загрузите в него файл `index.html`:

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать бакет.
    1. Выберите сервис **{{ objstorage-name }}**.
    1. Нажмите кнопку **Создать бакет**.
    1. На странице создания бакета:
        1. Введите имя бакета в соответствии с [правилами именования](../../storage/concepts/bucket.md#naming).
        1. При необходимости ограничьте максимальный размер бакета.
        1. Выберите тип [доступа](../../storage/concepts/bucket.md#bucket-access).
        1. Выберите [класс хранилища](../../storage/concepts/storage-class.md) по умолчанию.
        1. Нажмите кнопку **Создать бакет** для завершения операции.
    1. Нажмите кнопку **Загрузить**.
    1. В появившемся окне выберите в папке с проектом файл `index.html` (находится по пути `src/main/resources/`) и нажмите кнопку **Открыть**.
    1. Выберите [класс хранилища](../../storage/concepts/storage-class.md) для файла и нажмите кнопку **Загрузить**.

## Создайте базу данных {#create-db}

1. Создайте базу данных в [режиме Serverless](../../ydb/concepts/serverless-and-dedicated#serverless):

    1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать базу данных.
    1. Выберите сервис **{{ ydb-name }}**.
    1. Нажмите кнопку **Создать базу данных**.
    1. Введите **Имя** базы.
    1. В блоке **Тип базы данных** выберите **Serverless**.
    1. Нажмите кнопку **Создать базу данных**.
    1. Дождитесь запуска базы данных. В процессе создания база будет иметь статус `Provisioning`, а когда станет готова к использованию, статус изменится на `Running`.

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

## Создайте функции {#create-functions}

Создайте [функцию](../../functions/concepts/function.md) для каждого сервлета:

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать функцию.
  1. Выберите сервис **{{ sf-name }}**
  1. Нажмите кнопку **Создать функцию**.
  1. Введите имя `add-task` и описание функции.
  1. Нажмите кнопку **Создать**.
  1. Перейдите в раздел **Редактор** и создайте версию функции с параметрами:
      * Среда выполнения: `java11`.
      * Таймаут, с: 5.
      * Память: 128 МБ.
      * Сервисный аккаунт: укажите аккаунт, созданный на [этом](#prepare) шаге.
  1. Добавьте переменные окружения:
      * `DATABASE` — значение поля **База данных** из раздела **YDB эндпоинт**;
      * `ENDPOINT` — значение поля **Эндпоинт** из раздела **YDB эндпоинт**.
  1. В поле **Точка входа** введите `yandex.cloud.examples.serverless.todo.AddTaskServlet`.
  1. Подготовьте код функции. Для этого в поле **Способ** выберите **ZIP-архив** и укажите путь к файлу `servlet.zip`.
  1. Нажмите **Создать версию**.
  1. Повторите шаги 3-10 и создайте функцию с именем `list-tasks` и точкой входа `yandex.cloud.examples.serverless.todo.ListTasksServlet`.
  1. Повторите шаги 3-10 и создайте функцию с именем `delete-task` и точкой входа `yandex.cloud.examples.serverless.todo.DeleteTaskServlet`.

- CLI

  1. Создайте функцию с именем `add-task`:

      ```bash
      yc serverless function create --name=add-task
      ```

      Результат:

      ```bash
      id: d4ejb1799eko6re4omb1
      folder_id: aoek49ghmknnpj1ll45e
      created_at: "2021-03-08T14:07:32.134Z"
      name: add-task
      log_group_id: eolm8aoq9vcppsieej6h
      http_invoke_url: https://functions.yandexcloud.net/d4ejb1799eko6re4omb1
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

      Параметры:

      * `function-name` — имя функции, версию которой вы хотите создать;
      * `runtime` — среда выполнения;
      * `entrypoint` — точка входа, указывается в формате \<имя файла с функцией>.\<имя обработчика>;
      * `memory` — объем RAM;
      * `execution-timeout` — максимальное время выполнения функции до таймаута;
      * `source-path` — ZIP-архив c кодом функции и необходимыми зависимостями;
      * `environment` — переменные окружения в формате key=value.

      Результат:

      ```bash
      done (1s)
      id: d4evvn8obisajd51plaq
      function_id: d4ejb1799eko6re4omb1
      created_at: "2021-03-08T15:07:32.134Z"
      runtime: java11
      entrypoint: yandex.cloud.examples.serverless.todo.AddTaskServlet
      resources:
      memory: "134217728"
      execution_timeout: 5s
      image_size: "4096"
      status: ACTIVE
      tags:
      - $latest
      log_group_id: ckg3qh8h363p40gmr9gn
      ```
  
  1. Повторите шаги 1-2 и создайте функцию с именем `list-tasks` и точкой входа `yandex.cloud.examples.serverless.todo.ListTasksServlet`.
  1. Повторите шаги 1-2 и создайте функцию с именем `delete-task` и точкой входа `yandex.cloud.examples.serverless.todo.DeleteTaskServlet`.

- API

  Воспользуйтесь API методами [create](../../functions/functions/api-ref/Function/create) и [createVersion](../../functions/functions/api-ref/Function/createVersion).

- Yandex Cloud Toolkit

  Создать функцию и ее версию можно с помощью [плагина Yandex Cloud Toolkit](https://github.com/yandex-cloud/ide-plugin-jetbrains) для семейства IDE на [платформе IntelliJ](https://www.jetbrains.com/ru-ru/opensource/idea/) от [JetBrains](https://www.jetbrains.com/).

{% endlist %}

## Создайте API-шлюз {#create-api-gw}

1. Для обеспечения взаимодействия между сервисами создайте API-шлюз:

    {% list tabs %}

    - Консоль управления

      1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать API-шлюз.
      1. Выберите сервис **{{ api-gw-name }}**.
      1. Нажмите кнопку **Создать API-шлюз**.
      1. Введите имя шлюза и описание.
      1. В блок **Спецификация** добавьте спецификацию:

          ```
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

          Параметры:

          * `<бакет>` — имя бакета, в котором лежит файл `index.html`;
          * `<сервисный аккаунт>` — идентификатор сервисного аккаунта, созданного на [этом](#prepare) шаге;
          * `<идентификатор add-task>` — идентификатор функции `add-task`;
          * `<идентификатор list-tasks>` — идентификатор функции `list-tasks`;
          * `<идентификатор delete-task>` — идентификатор функции `delete-task`.

      1. Нажмите кнопку **Создать**.

    - CLI

      1. Сохраните следующую спецификацию в файл `todo.yaml`:
            
          ```
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

          Параметры:

          * `<бакет>` — имя бакета, в котором лежит файл `index.html`;
          * `<сервисный аккаунт>` — идентификатор сервисного аккаунта, созданного на [этом](#prepare) шаге;
          * `<идентификатор add-task>` — идентификатор функции `add-task`;
          * `<идентификатор list-tasks>` — идентификатор функции `list-tasks`;
          * `<идентификатор delete-task>` — идентификатор функции `delete-task`.

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
          id: d5delqeel34qjjfcdj81
          folder_id: b1g86q4m5vej8lkljme5
          created_at: "2021-03-08T14:07:32.134Z"
          name: todo-list
          description: simple todo list
          status: ACTIVE
          domain: d5delqeel34qjjfcdj81.apigw.yandexcloud.net
          log_group_id: ckg2hdmevnvcngprqvqb
          ```

    - Yandex Cloud Toolkit

      Создать API-шлюз можно с помощью [плагина Yandex Cloud Toolkit](https://github.com/yandex-cloud/ide-plugin-jetbrains) для семейства IDE на [платформе IntelliJ](https://www.jetbrains.com/ru-ru/opensource/idea/) от [JetBrains](https://www.jetbrains.com/).

    {% endlist %}

1. Чтобы открыть приложение, перейдите по ссылке, указанной в поле **Служебный домен** созданного API-шлюза.
