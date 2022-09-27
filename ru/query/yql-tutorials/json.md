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

* Оператор [SELECT](https://ydb.tech/ru/docs/yql/reference/syntax/select).
* Функция [JSON_EXISTS](https://ydb.tech/ru/docs/yql/reference/builtins/json#json_exists).
* Функция [JSON_VALUE](https://ydb.tech/ru/docs/yql/reference/builtins/json#json_value).
* Функция [JSON_QUERY](https://ydb.tech/ru/docs/yql/reference/builtins/json#json_query).
* [Функции для работы с JSON](https://ydb.tech/ru/docs/yql/reference/builtins/json).
