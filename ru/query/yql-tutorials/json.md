# Работа с JSON {#JSON}

Формат данных [JSON](https://ru.wikipedia.org/wiki/JSON) используется для хранения и обработки данных.

Базовые операции с данными в этом формате:

* Проверить существование объекта `name`.
* Получить значение объекта `age`.
* Запросить данные из объекта.

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
    JSON_EXISTS($json, "$.friends[*].name"), -- Проверка существования объекта name,
    JSON_VALUE($json, "$.friends[0].age"),   -- получение значения объекта age,
    JSON_QUERY($json, "$.friends[0]");       -- запрос на получение данных из объекта.
```

Рассмотрите пример в блоке справа и нажмите кнопку ![run](../../_assets/query/run.svg) **Выполнить**.
Результат выполнения запроса отобразится на вкладке **Результат** в виде таблицы или схемы.

## Смотрите также {#see-also}

* Оператор [SELECT]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select){% endif %}.
* Функция [JSON_EXISTS]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/builtins/json#json_exists){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/builtins/json#json_exists){% endif %}.
* Функция [JSON_VALUE]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/builtins/json#json_value){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/builtins/json#json_value){% endif %}.
* Функция [JSON_QUERY]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/builtins/json#json_query){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/builtins/json#json_query){% endif %}.
* [Функции для работы с JSON]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/builtins/json){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/builtins/json){% endif %}.
