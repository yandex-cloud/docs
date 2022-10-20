В этом сценарии вы создадите [функцию](../functions/concepts/function.md) с приложением на [Python](https://python.org/), которое выполняет простой запрос к базе данных {{ ydb-short-name }}.

Функция с привязанным [сервисным аккаунтом](../iam/concepts/users/service-accounts.md) авторизуется в {{ ydb-short-name }} через сервис метаданных.

Приложение создает драйвер подключения к базе {{ ydb-short-name }}, сессию, транзакцию и выполняет запрос, используя библиотеку `ydb`. Эта библиотека устанавливается как [зависимость](../functions/lang/python/dependencies.md) при создании версии функции. Параметры подключения к базе данных передаются в приложение через переменные окружения.

Чтобы создать функцию и подключиться к базе данных:

1. [Подготовьте облако к работе](#before-begin).
1. [Создайте сервисный аккаунт](#create-sa).
1. [Создайте базу данных {{ ydb-short-name }}](#create-database).
1. [Создайте функцию](#create-function).
1. [Протестируйте функцию](#test-function).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](_tutorials_includes/before-you-begin.md) %}

{% if product == "yandex-cloud" %}

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для этого сценария входит:

* плата за использование функции (см. [тарифы {{ sf-full-name }}](../functions/pricing.md));
* плата за выполнение запросов к базе данных (см. [тарифы {{ ydb-full-name }}]{% if audience == "external" %}(../ydb/pricing/serverless.md){% else %}(https://cloud.yandex.ru/docs/ydb/pricing/serverless){% endif %}).

{% endif %}

## Создайте сервисный аккаунт {#create-sa}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать сервисный аккаунт.
  1. Выберите вкладку **Сервисные аккаунты**.
  1. Нажмите кнопку **Создать сервисный аккаунт**.
  1. Введите имя сервисного аккаунта, например `sa-function`. Требования к имени:

      {% include [name-format](../_includes/name-format.md) %}

  1. Нажмите **Добавить роль** и выберите `editor`.
  1. Нажмите кнопку **Создать**.

{% endlist %}

## Создайте базу данных {{ ydb-short-name }} {#create-database}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать базу данных.
  1. В списке сервисов выберите **{{ ydb-name }}**.
  1. Нажмите кнопку **Создать базу данных**.
  1. Введите имя базы. Требования к имени:

      {% include [name-format](../_includes/name-format.md) %}

  1. В блоке **Тип базы данных** выберите опцию **Serverless**.
  1. Нажмите кнопку **Создать базу данных**.

      Дождитесь запуска базы данных. В процессе создания база будет иметь статус `Provisioning`. Когда база станет готова к использованию, статус сменится на `Running`.
  1. Нажмите на имя созданной БД.
  1. В блоке **YDB эндпоинт** найдите поля **Эндпоинт** и **База данных** и сохраните их значения. Они понадобятся на следующем шаге.

{% endlist %}

## Создайте функцию {#create-function}

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите создать функцию.
  1. В списке сервисов выберите **{{ sf-name }}**.
  1. Нажмите кнопку **Создать функцию**.
  1. Введите имя и описание функции. Требования к имени:

      {% include [name-format](../_includes/name-format.md) %}

  1. Нажмите кнопку **Создать**.
  1. В блоке **Редактор** выберите среду выполнения **Python** и нажмите **Продолжить**.
  1. В блоке **Код функции** очистите содержимое файла `index.py` и вставьте в него следующий код:

      ```python
      import os
      import ydb

      # create driver in global space.
      driver = ydb.Driver(endpoint=os.getenv('YDB_ENDPOINT'), database=os.getenv('YDB_DATABASE'))
      # Wait for the driver to become active for requests.
      driver.wait(fail_fast=True, timeout=5)
      # Create the session pool instance to manage YDB sessions.
      pool = ydb.SessionPool(driver)

      def execute_query(session):
          # create the transaction and execute query.
          return session.transaction().execute(
              'select 1 as cnt;',
              commit_tx=True,
              settings=ydb.BaseRequestSettings().with_timeout(3).with_operation_timeout(2)
          )

      def handler(event, context):
          # Execute query with the retry_operation helper.
          result = pool.retry_operation_sync(execute_query)
          return {
              'statusCode': 200,
              'body': str(result[0].rows[0].cnt == 1),
          }
      ```

  1. В блоке **Код функции** создайте файл `requirements.txt` и вставьте в него следующий текст:

      ```txt
      ydb
      ```

  1. В качестве точки входа укажите `index.handler`.
  1. Выберите сервисный аккаунт, например `sa-function`.
  1. Настройте переменные окружения:
      * `YDB_ENDPOINT` — введите строку вида `<протокол>://<эндпоинт базы данных>`.

          Например, если протокол `grpcs`, а эндпоинт `ydb.serverless.yandexcloud.net:2135`, введите `grpcs://ydb.serverless.yandexcloud.net:2135`.
      * `YDB_DATABASE` — введите сохраненное ранее значение поля **База данных**, например `/{{ region-id }}/b1gia87mbaomkfvsleds/etn02j1mlm4vgjhij03e`.
  1. В верхнем правом углу блока **Редактор** нажмите кнопку **Создать версию**.

{% endlist %}

## Протестируйте функцию {#test-function}

{% list tabs %}

- Консоль управления

  1. Перейдите на вкладку **Тестирование**.
  1. Нажмите кнопку **Запустить тест** и посмотрите результат тестирования.

      При успешных подключении к БД и выполнении запроса состояние функции изменится на `Выполнена`, а ответ функции будет содержать следующий текст:

      ```json
      {
          "statusCode": 200,
          "body": "True"
      }
      ```

{% endlist %}

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [удалите базу данных](../ydb/operations/manage-database.md#delete-db);
1. [удалите функцию](../functions/operations/function/function-delete.md).