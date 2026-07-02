[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for YDB](../../index.md) > Document API, совместимый с Amazon DynamoDB > Инструменты > Работа с данными через HTTP-интерфейс

# Работа с данными через HTTP-интерфейс

В этом разделе вы узнаете, как создать таблицу, добавить в нее данные, а затем прочитать их, используя HTTP-интерфейс Document API.

Для выполнения HTTP-запросов в примерах раздела используется утилита [cURL](https://curl.se/).

{% note warning %}

Через Document API возможен доступ только к [документным таблицам](../../concepts/dynamodb-tables.md).

{% endnote %}

## Перед началом работы {#before-you-begin}

1. Если у вас еще нет интерфейса командной строки Yandex Cloud, [установите и инициализируйте его](../../../cli/quickstart.md#install).
1. Подготовьте Document API эндпоинт [созданной БД](../../operations/manage-databases.md).

    {% cut "Как узнать Document API эндпоинт базы данных" %}

    1. Перейдите в [консоль управления](https://console.yandex.cloud).
    1. Выберите нужный каталог и перейдите в сервис **Managed Service for&nbsp;YDB**.
    1. Выберите базу данных, к которой планируете сделать запрос.
    1. В меню слева перейдите в раздел **Обзор**.
    1. Значение эндпоинта указано в строке **Document API эндпоинт**.

        Пример значения эндпоинта `https://docapi.serverless.yandexcloud.net/ru-central1/b1gia87mbaom********/etnudu2n9ri3********`.

    {% endcut %}

    {% note info %}

    Для работы в режиме совместимости с Amazon DynamoDB используйте бессерверную (Serverless) конфигурацию БД.

    {% endnote %}

1. Установите для переменной окружения `ENDPOINT` подготовленное значение:

    ```bash
    export ENDPOINT=<Document_API_эндпоинт>
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
      --header 'X-Amz-Target: DynamoDB_20120810.CreateTable' \
      --header "Authorization: Bearer $(yc iam create-token)" \
      --header "Content-Type: application.json" \
      --data @create.json $ENDPOINT
    ```

    Подробнее о методе `CreateTable` читайте в [справочнике Document API](../api-ref/actions/createTable.md).

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
      --header 'X-Amz-Target: DynamoDB_20120810.PutItem' \
      --header "Authorization: Bearer $(yc iam create-token)" \
      --header "Content-Type: application.json" \
      --data @put.json $ENDPOINT
    ```

    Подробнее о методе `PutItem` читайте в [справочнике Document API](../api-ref/actions/putItem.md).

{% endlist %}

## Чтение записи {#read}

{% list tabs %}

- HTTP-интерфейс

  Чтобы прочитать данные из документной таблицы, выполните команду:

    ```bash
    curl \
      --header 'X-Amz-Target: DynamoDB_20120810.GetItem' \
      --header "Authorization: Bearer $(yc iam create-token)" \
      --header "Content-Type: application.json" \
      --data '{"TableName": "test/pets", "Key": {"species":{"S":"cat"}, "name":{"S":"Tom"}}}' \
      $ENDPOINT
    ```

    Результат:

    ```text
    {"Item":{"name":{"S":"Tom"},"species":{"S":"cat"},"color":{"S":"black"},"price":{"N":"10.5"}}}
    ```

    Подробнее о методе `GetItem` читайте в [справочнике Document API](../api-ref/actions/getItem.md).

{% endlist %}