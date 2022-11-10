# Working with JSON {#JSON}

The [JSON](https://ru.wikipedia.org/wiki/JSON) data format is used for storing and processing data.

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

Take a look at the block on the right and click ![run](../../_assets/query/run.svg) **Run**.
Query execution results are available in the **Result** tab as a table or schema.

## See also {#see-also}

* [SELECT](https://ydb.tech/en/docs/yql/reference/syntax/select).
* [JSON_EXISTS](https://ydb.tech/en/docs/yql/reference/builtins/json#json_exists).
* [JSON_VALUE](https://ydb.tech/en/docs/yql/reference/builtins/json#json_value).
* [JSON_QUERY](https://ydb.tech/en/docs/yql/reference/builtins/json#json_query).
* [Functions for JSON](https://ydb.tech/en/docs/yql/reference/builtins/json).
