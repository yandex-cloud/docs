---
title: "Создание таблицы в AWS CLI"
description: "Следуя данной инструкции, вы сможете создать таблицу в AWS CLI."
---

# Создание таблицы в AWS CLI

{% list tabs %}

- AWS CLI

    {% note warning %}

    Для работы с AWS CLI из Windows рекомендуется использовать [WSL]({{ ms.docs }}/windows/wsl/).

    {% endnote %}

    Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../../../ydb/docapi/tools/aws-setup.md).
    
    Чтобы создать таблицу сериалов с ключом партицирования по номеру сериала и ключом сортировки по названию сериала:
    
    1. [Подготовьте](index.md#before-you-begin) Document API эндпоинт и укажите его:

       ```bash
       endpoint=<эндпоинт_вашей_БД>
       ```

    1. Выполните команду:

       ```bash
       aws dynamodb create-table \
         --table-name <имя_таблицы> \
         --attribute-definitions \
           AttributeName=<номер_сериала>,AttributeType=N \
           AttributeName=<название_сериала>,AttributeType=S \
           AttributeName=<описание_сериала>,AttributeType=S \
           AttributeName=<дата_выхода_сериала>,AttributeType=S \
         --key-schema \
           AttributeName=<номер_сериала>,KeyType=HASH \
           AttributeName=<название_сериала>,KeyType=RANGE \
         --endpoint $endpoint
       ```

       Где:
       
       * `--table-name` — имя [таблицы](../../../../ydb/concepts/dynamodb-tables.md).
       * `--attribute-definitions` — описание атрибутов элементов. `AttributeName` — имя атрибута, `AttributeType` — тип атрибута: 
         * `N` — тип `Number`.
         * `S` — тип `String`.
         * `B` — тип `Binary`.
       * `--key-schema` — схема ключей для таблицы. `AttributeName` — имя ключевого атрибута. `KeyType` — тип ключа:
         * `HASH` — ключ партицирования.
         * `RANGE` — ключ сортировки.
       
       Атрибуты в `key-schema` также должны быть определены в массиве `attribute-definitions`.

    ## Пример {#example}
  
    Чтобы создать таблицу с именем `series`, ключом партицирования `series_id` и ключом сортировки `title`:
    
    ```bash
    endpoint="your-database-endpoint"
    ```

    ```bash
    aws dynamodb create-table \
      --table-name series \
      --attribute-definitions \
        AttributeName=series_id,AttributeType=N \
        AttributeName=title,AttributeType=S \
        AttributeName=series_info,AttributeType=S \
        AttributeName=release_date,AttributeType=S \
      --key-schema \
        AttributeName=series_id,KeyType=HASH \
        AttributeName=title,KeyType=RANGE \
      --endpoint $endpoint
    ```

    Результат:

    ```text
    {
        "TableDescription": {
            "AttributeDefinitions": [
                {
                    "AttributeName": "series_id",
                    "AttributeType": "N"
                },
                {
                    "AttributeName": "title",
                    "AttributeType": "S"
                },
                {
                    "AttributeName": "series_info",
                    "AttributeType": "S"
                },
                {
                    "AttributeName": "release_date",
                    "AttributeType": "S"
                }
            ],
            "TableName": "series",
            "KeySchema": [
                {
                    "AttributeName": "series_id",
                    "KeyType": "HASH"
                },
                {
                    "AttributeName": "title",
                    "KeyType": "RANGE"
                }
            ],
            "TableStatus": "ACTIVE",
            "CreationDateTime": "2020-12-27T13:21:10+00:00",
            "TableSizeBytes": 0,
            "ItemCount": 0
        }
    }
    ```

{% endlist %}
