# Joining tables

{% include [yql_tutorial_prerequisites.md](_includes/yql_tutorial_prerequisites.md) %}

You can both make queries to data from separate sources and join data from multiple sources.

The example below shows how to join data from the `users.json` and `lastnames.csv` sources based on the same name:

```sql
$a = -- A named expression
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


$b = -- A named expression
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
        INNER JOIN -- The command to join tables
            $b AS b
                ON
                    a.name=b.name1 --by the specified condition
WHERE age>15;
```

## See also {#see-also}

* [SELECT]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/select){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/select){% endif %}.
* [JOIN]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/join){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/join){% endif %}.
* [Types of data source join]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/join#types-of-join-join_type){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/join#tipy-obuedineniya-join_type){% endif %}.
* [Named expressions]{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/expressions#named-nodes){% endif %}{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/expressions.#named-nodes){% endif %}.