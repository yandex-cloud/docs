### Прерывание трансфера с ошибкой mapper_parsing_exception {#data-types}

Текст ошибки:

```text
mapper_parsing_exception failed to parse field [details.tags] of type [text]
```

Трансфер прерывается из-за несовместимости типов данных на источнике и приемнике.

**Решение:** перенесите данные в новый индекс {{ OS }}, в котором тип поля `details` изменен на `flat_object`.

1. Деактивируйте трансфер.

1. Создайте новый индекс в {{ OS }}:

    ```bash
    curl \
    --user <имя_пользователя_{{ OS }}>:<пароль> \
    --header 'Content-Type: application/json' \
    --request PUT 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:9200/<название_нового_индекса>/_settings' \
    --data '{"index.mapping.total_fields.limit": 2000}'
    ```

1. Измените тип поля `details`:

    ```bash
    curl \
    --user <имя_пользователя_{{ OS }}>:<пароль> \
    --header 'Content-Type: application/json' \
    --request PUT 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:9200/<название_нового_индекса>/_mapping' \
    --data '
        {
            "properties": {
                "details": {
                    "type": "flat_object"
                }
            }
        }'
    ```    

1. Перенесите данные из исходного индекса в новый:

    ```bash
    curl \
    --user <имя_пользователя_{{ OS }}>:<пароль> \
    --header 'Content-Type: application/json' \
    --request POST 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:9200/_reindex' \
    --data '
        {
        "source":{
            "index":"<название_исходного_индекса>"
        },
        "dest":{
            "index":"<название_нового_индекса>"
        }
        }'
    ```

1. Удалите исходный индекс:

    ```bash
    curl \
    --user <имя_пользователя_{{ OS }}>:<пароль> \
    --header 'Content-Type: application/json' \
    --request DELETE 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:9200/<название_исходного_индекса>'
    ```

1. Присвойте новому индексу псевдоним:

    ```bash
    curl \
    --user <имя_пользователя_{{ OS }}>:<пароль> \
    --header 'Content-Type: application/json' \
    --request POST 'https://<адрес_хоста_{{ OS }}_с_ролью_DATA>:9200/_aliases' \
    --data '
        {
        "actions": [
            {
            "add": {
                "index": "<название_нового_псевдонима>",
                "alias": "<название_исходного_псевдонима>"
            }
            }
        ]
        }'
    ```
