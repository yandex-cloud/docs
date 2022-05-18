# Объединение таблиц

Запросы можно выполнять не только к данным отдельных источников, но и объединять данные нескольких.

В примере ниже показано, как объединить данные источника `users.json` и `lastnames.csv` на основании одинакового имени:

```sql
$a = -- Именованное выражение.
SELECT * FROM `tutorial`.object("tutorial/users.json", json_each_row)
WITH SCHEMA (
    Int32 AS last_visit_time,
    String AS ip,
    Int32 AS age,
    Float AS last_time_on_site,
    String AS user_agent,
    String AS name,
    Int32 AS region,
    String AS last_url);


$b = -- Именованное выражение.
SELECT * FROM `tutorial`.object("tutorial/lastnames.csv", csv_with_names)
WITH SCHEMA (
    String AS lastname,
    String AS name1);

SELECT 
    name, 
    lastname 
FROM 
    $a AS a 
        INNER JOIN                  -- Команда объединения таблиц
            $b AS b 
                ON 
                    a.name=b.name1  --по указанному условию.
WHERE age>15;
```

## Смотрите также {#see-also}

* Оператор [SELECT]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select){% endif %}.
* Оператор [JOIN]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/join){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/join){% endif %}.
* [Типы объединений источников данных]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/join#types-of-join-join_type){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/join#tipy-obuedineniya-join_type){% endif %}.
* [Именованные выражения]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/expressions#named-nodes){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/expressions.#named-nodes){% endif %}.
