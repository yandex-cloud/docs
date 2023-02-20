---
sourcePath: overlay/quickstart/document-api/aws-http.md
---
# Работа с данными через HTTP-интерфейс

В этом разделе вы узнаете, как создать таблицу, добавить в нее данные, а затем прочитать их, используя HTTP-интерфейс Document API.

Для выполнения HTTP-запросов в примерах раздела используется утилита [cURL](https://curl.se/).

{% include [doc-tables-only.md](../../_includes/doc-tables-only.md) %}

## Перед началом работы {#before-you-begin}

1. Если у вас еще нет интерфейса командной строки {{ yandex-cloud }}, [установите и инициализируйте его](../../../cli/quickstart.md#install).
1. Подготовьте Document API эндпоинт [созданной БД](../../operations/manage-databases.md).

    {% cut "Как узнать Document API эндпоинт базы данных" %}

    1. Перейдите в [консоль управления]({{ link-console-main }}).
    1. Выберите нужный каталог и перейдите в сервис **{{ ydb-full-name }}**.
    1. Выберите базу данных, к которой планируете сделать запрос.
    1. В меню слева перейдите в раздел **Обзор**.
    1. Значение эндпоинта указано в строке **Document API эндпоинт**.

        Пример значения эндпоинта `{{ ydb.aws-ep }}`.

    {% endcut %}

    {% note info %}

    Для работы в режиме совместимости с Amazon DynamoDB используйте бессерверную (Serverless) конфигурацию БД.

    {% endnote %}

1. Установите для переменной окружения `ENDPOINT` подготовленное значение:

    ```bash
    export ENDPOINT=<Document API эндпоинт>
    ```

## Создание таблицы {#create-table}

{% list tabs %}

- HTTP-интерфейс

  Задайте конфигурацию таблицы в файле `create.json`:

    ```json
    {
      "TableName": "test/pets",
      "AttributeDefinitions":
      [
        {
          "AttributeName": "species",
          "AttributeType": "S"
        },
        {
          "AttributeName": "name",
          "AttributeType": "S"
        }
      ],
      "KeySchema":
      [
        {
          "AttributeName": "species",
          "KeyType": "HASH"
        },
        {
          "AttributeName": "name",
          "KeyType": "RANGE"
        }
      ]
    }
    ```

  Создайте документную таблицу в базе с помощью команды:

    ```bash
    curl \
      -H 'X-Amz-Target: DynamoDB_20120810.CreateTable' \
      -H "Authorization: Bearer $(yc iam create-token)" \
      -H "Content-Type: application.json" \
      -d @create.json $ENDPOINT
    ```

    Подробнее о методе `CreateTable` читайте в [справочнике Document API](../../docapi/api-ref/actions/createTable.md).

{% endlist %}

## Добавление данных {#add}

{% list tabs %}

- HTTP-интерфейс

  Подготовьте данные для сохранения в документную таблицу, создав файл `put.json`:

    ```json
    {
      "TableName": "test/pets",
      "Item":
      {
        "species": {"S": "cat"},
        "name":    {"S": "Tom"},
        "color":   {"S": "black"},
        "price":   {"N": "10.5"}
      }
    }
    ```

  Добавьте данные в таблицу с помощью команды:

    ```bash
    curl \
      -H 'X-Amz-Target: DynamoDB_20120810.PutItem' \
      -H "Authorization: Bearer $(yc iam create-token)" \
      -H "Content-Type: application.json" \
      -d @put.json $ENDPOINT
    ```

    Подробнее о методе `PutItem` читайте в [справочнике Document API](../../docapi/api-ref/actions/putItem.md).

{% endlist %}

## Чтение записи {#read}

{% list tabs %}

- HTTP-интерфейс

  Чтобы прочитать данные из документной таблицы, выполните команду:

    ```bash
    curl \
      -H 'X-Amz-Target: DynamoDB_20120810.GetItem' \
      -H "Authorization: Bearer $(yc iam create-token)" \
      -H "Content-Type: application.json" \
      -d '{"TableName": "test/pets", "Key": {"species":{"S":"cat"}, "name":{"S":"Tom"}}}' \
      $ENDPOINT
    ```

    Результат:

    ```text
    {"Item":{"name":{"S":"Tom"},"species":{"S":"cat"},"color":{"S":"black"},"price":{"N":"10.5"}}}
    ```

    Подробнее о методе `GetItem` читайте в [справочнике Document API](../../docapi/api-ref/actions/getItem.md).

{% endlist %}
