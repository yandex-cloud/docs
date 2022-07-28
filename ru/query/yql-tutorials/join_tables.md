# Объединение таблиц

{% include [yql_tutorial_prerequisites.md](_includes/yql_tutorial_prerequisites.md) %}

Запросы можно выполнять не только к данным отдельных источников, но и объединять данные нескольких.

В примере ниже показано, как объединить данные источника `users.json` и `lastnames.csv` на основании одинакового имени:

```sql
$a = -- именованное выражение
SELECT * FROM `tutorial`.`tutorial/users.json`
WITH 
(
    format=json_each_row,
    SCHEMA 
    (
        last_visit_time Int32,
        ip String,
        age Int32,
        last_time_on_site Float,
        user_agent String,
        name String,
        region Int32,
        last_url String 
    )
);


$b = -- именованное выражение
SELECT * FROM `tutorial`.`tutorial/lastnames.csv` 
WITH
(
    format=csv_with_names,
    SCHEMA 
    (
        lastname String,
        name1 String
    )
);

SELECT 
    name, 
    lastname 
FROM 
    $a AS a 
        INNER JOIN -- команда объединения таблиц
            $b AS b 
                ON 
                    a.name=b.name1 --по указанному условию
WHERE age>15;
```

## Смотрите также {#see-also}

* Оператор [SELECT]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select){% endif %}.
* Оператор [JOIN]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/join){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/join){% endif %}.
* [Типы объединений источников данных]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/join#types-of-join-join_type){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/join#tipy-obuedineniya-join_type){% endif %}.
* [Именованные выражения]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/expressions#named-nodes){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/expressions.#named-nodes){% endif %}.
