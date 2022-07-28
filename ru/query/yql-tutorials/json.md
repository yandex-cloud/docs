# JSON

Формат данных [JSON](https://ru.wikipedia.org/wiki/JSON) часто используется при хранении и обработке данных.

В примере ниже показано, как выполнять базовые операции с данными в этом формате:

```sql
$json = CAST(@@{
    "friends": [
        {
            "name": "James Holden",
            "age": 35
        },
        {
            "name": "Naomi Nagata",
            "age": 30
        }
    ]
}@@ AS Json);

SELECT
    JSON_EXISTS($json, "$.friends[*].name"), -- проверка существования объекта name,
    JSON_VALUE($json, "$.friends[0].age"), -- получение значения объекта age
    JSON_QUERY($json, "$.friends[0]"); -- запрос на получение данных из объекта
```

## Смотрите также {#see-also}

* Оператор [SELECT]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select){% endif %}.
* Функция [JSON_EXISTS]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/builtins/json#json_exists){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/builtins/json#json_exists){% endif %}.
* Функция [JSON_VALUE]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/builtins/json#json_value){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/builtins/json#json_value){% endif %}.
* Функция [JSON_QUERY]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/builtins/json#json_query){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/builtins/json#json_query){% endif %}.
* [Функции для работы с JSON]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/builtins/json){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/builtins/json){% endif %}.
