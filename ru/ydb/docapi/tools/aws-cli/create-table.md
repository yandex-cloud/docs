# Создание таблицы в AWS CLI

{% list tabs %}

- AWS CLI

    {% note warning %}

    Для работы с AWS CLI из Windows рекомендуется использовать [WSL]({{ ms.docs }}/windows/wsl/).

    {% endnote %}

    Если у вас еще нет AWS CLI, [установите и сконфигурируйте его](../../../../storage/tools/aws-cli.md).
    
    Чтобы создать таблицу с ключом партицирования и ключом сортировки:
    
    1. [Подготовьте](index.md#before-you-begin) Document API эндпоинт и укажите его:

       ```bash
       endpoint=<эндпоинт_вашей_БД>
       ```

    2. Выполните команду:

       ```bash
       aws dynamodb create-table \
         --table-name <название_таблицы> \
         --attribute-definitions \
           AttributeName=<ключ_партицирования>,AttributeType=N \
           AttributeName=<ключ_сортировки>,AttributeType=S \
         --key-schema \
           AttributeName=<ключ_партицирования>,KeyType=HASH \
           AttributeName=<ключ_сортировки>,KeyType=RANGE \
         --endpoint $endpoint
       ```

       Где:
       
       * `--table-name` — название таблицы.
       * `--attribute-definitions` — атрибуты для описания схемы ключей для таблицы и индексов. `AttributeName` — имя атрибута, `AttributeType` — тип данных атрибута: 
         * `N` — тип `Number`. Используется для ключа партицирования.
         * `S` — тип `String`. Используется для ключа сортировки.
         * `B` — тип `Binary`.
       * `--key-schema` — атрибуты для составления первичного ключа для таблицы или индекса. `AttributeName` — имя ключевого атрибута. `KeyType` — роль ключевого атрибута:
         * `HASH` — ключ партицирования. 
         * `RANGE` — ключ сортировки.
       
       Атрибуты в `key-schema` также должны быть определены в массиве `attribute-definitions`.

    ## Пример {#example}
  
    Команда для создания таблицы `series` с ключом партицирования `series_id` и ключом сортировки `title`:
    
    ```bash
    endpoint="https://your-database-endpoint"
    ```

    ```bash
    aws dynamodb create-table \
      --table-name series \
      --attribute-definitions \
        AttributeName=series_id,AttributeType=N \
        AttributeName=title,AttributeType=S \
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
