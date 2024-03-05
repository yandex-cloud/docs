# Working with JSON

The [JSON](https://en.wikipedia.org/wiki/JSON) data format is used for storing and processing data.

Below are basic operations with data in this format:

* Check the existence of the `name` object.
* Retrieve the value of the `age` object.
* Query object data.

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
    JSON_EXISTS($json, "$.friends[*].name"), -- Checking if the name object exists,
    JSON_VALUE($json, "$.friends[0].age"), -- Getting the age object value
    JSON_QUERY($json, "$.friends[0]"); -- Querying the object data.
```

Take a look at the example on the right and click ![run](../../_assets/console-icons/play-fill.svg) **{{ ui-key.yql.yq-query-actions.run-query.button-text }}**.
Query results are available in the **{{ ui-key.yql.yq-query-results.result.tab-text }}** tab as a table or schema.

## Escaping quotes in JSON {#escaping-json}

Let's look at the two ways to add a JSON string to a table:

```sql
UPSERT INTO test_json(id, json_string)
VALUES
    (1, Json(@@[{"name":"Peter \"strong cat\" Kourbatov"}]@@)),
    (2, Json('[{"name":"Peter \\\"strong cat\\\" Kourbatov"}]'))
;
```

To insert the first string value, a `raw string` and the escape method with `\"` are used. To insert the second string, escaping with `\\\"` is used.

We recommend using a `raw string` and `\"` as the escape method, since it is more visual.

## See also {#see-also}

* [SELECT](https://ydb.tech/en/docs/yql/reference/syntax/select).
* [JSON_EXISTS](https://ydb.tech/en/docs/yql/reference/builtins/json#json_exists).
* [JSON_VALUE](https://ydb.tech/en/docs/yql/reference/builtins/json#json_value).
* [JSON_QUERY](https://ydb.tech/en/docs/yql/reference/builtins/json#json_query).
* [Functions for JSON](https://ydb.tech/en/docs/yql/reference/builtins/json).
