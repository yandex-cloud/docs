# get-query-results

This method returns query results. A query containing multiple `SELECT` statements returns multiple query results. If this is the case, you can access results by their index.

{% include [!](../../_includes/api-common.md) %}

## Request {#request}

`GET` request to `/queries/{query_id}/results/{<query_result_number_starting_from_0>}?project={folder_id}`, where `{folder_id}` is the folder ID and `{query_id}` is the query ID.

SQL query arguments are provided in the URL as query string variables.

| Argument | Description | Default value | Limitations |
| ----- | ----- | ----- | ----- |
| `offset` | The number of rows to skip before starting to return rows from the query result set | 0 | Cannot be negative |
| `limit` | Number of result rows | 100 | This value must be between 1 and 1,000 |

## Response {#response}

If successful, the response returns an HTTP 200 status code and query results.

```json
{
  "columns": [
    {
      "name": "column0",
      "type": "Int32"
    },
    {
      "name": "column1",
      "type": "Int32"
    }    
  ],
  "rows": [
    [
      "1",
      "2"
    ],
    [
      "3",
      "4"
    ]    
  ]
}
```

| Field | Description |
| ----- | ----- |
| `columns` | Result column array |
| `columns[].name` | Column name |
| `columns[].type` | Column data type |
| `rows` | Result row array Each row array’s element count matches the number of columns in the `columns` field |

Conversion rules from YQL data types to JSON-compatible data types are described in the [YQL to JSON type mapping](../yql-json-conversion-rules.md) section.

## Example {#example}

Request:

```json
curl \
  --request 'GET' \
  'https://api.yandex-query.cloud.yandex.net/api/fq/v1/queries/cseugn35bc3r********/results/0?project=b1gaue5b382m********&offset=0&limit=100' \
  --header 'accept: application/json'
```

Response:

```json
{
  "columns": [
    {
      "name": "column0",
      "type": "Int32"
    },
    {
      "name": "column1",
      "type": "Int32"
    }    
  ],
  "rows": [
    [
      "1",
      "2"
    ],
    [
      "3",
      "4"
    ]
  ]
}
```
