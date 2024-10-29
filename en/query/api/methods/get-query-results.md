# get-query-results

The method returns query results. If a query contains multiple `SELECT` statements, there will be multiple query results. In this case, you need to get the results by their index.

{% include [!](../../_includes/api-common.md) %}

## Request {#request}

`GET` request to `/queries/{query_id}/results/{<query_result_number_starting_from_0>}?project={folder_id}`, where `{folder_id}` is a folder ID and `{query_id}` is the query ID.

Parameters are provided in URLs as query parameters.

| Parameter | Description | Default value | Limitations |
| ----- | ----- | ----- | ----- |
| `offset` | Number of the result array string to get query results from | 0 | Cannot be negative |
| `limit` | Number of result rows | 100 | The value must be from 1 to 1,000. |

## Response {#response}

If successful, an HTTP response with code 200 and query execution results is returned.

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
| `columns` | Array of returned value columns |
| `columns[].name` | Column name |
| `columns[].type` | Column data type |
| `rows` | Array of result rows with the returned value. The number of array elements in each row is the same as the number of columns from the `columns` parameter. |

The rules for converting YQL data types to JSON-compatible data types are described in the [Correspondence of YQL and JSON types](../yql-json-conversion-rules.md) section.

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
