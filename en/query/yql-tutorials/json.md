# Working with JSON

The [JSON](https://en.wikipedia.org/wiki/JSON) format is used for storing and processing data.

Basic JSON data operations:

* Check if the `name` object exists.
* Retrieve the `age` object’s value.
* Request object data.

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
    JSON_EXISTS($json, "$.friends[*].name"), -- Check if the `name` object exists
    JSON_VALUE($json, "$.friends[0].age"),   -- Retrieve the `age` object’s value
    JSON_QUERY($json, "$.friends[0]");       -- Request object data
```

Check the example in the right-hand section and click ![run](../../_assets/console-icons/play-fill.svg) **{{ ui-key.yql.yq-query-actions.run-query.button-text }}**.
The query result will appear in the **{{ ui-key.yql.yq-query-results.result.tab-text }}** tab as a table or chart.

## Escaping quotes in JSON {#escaping-json}

Here is an example showing two ways to add a JSON string to a table:

```sql
UPSERT INTO test_json(id, json_string)
VALUES
    (1, Json(@@[{"name":"Peter \"strong cat\" Kourbatov"}]@@)),
    (2, Json('[{"name":"Peter \\\"strong cat\\\" Kourbatov"}]'))
;
```

To insert the first value, we use a `raw string` and escaping via `\"`. To insert the second value, we use escaping via `\\\"`.

We recommend using a `raw string` and escaping via `\"`, as it is more readable.

#### See also {#see-also}

* [SELECT]({{ ydb.docs }}/yql/reference/syntax/select) operator
* [JSON_EXISTS]({{ ydb.docs }}/yql/reference/builtins/json#json_exists) function
* [JSON_VALUE]({{ ydb.docs }}/yql/reference/builtins/json#json_value) function
* [JSON_QUERY]({{ ydb.docs }}/yql/reference/builtins/json#json_query) function
* [Functions for JSON]({{ ydb.docs }}/yql/reference/builtins/json)
