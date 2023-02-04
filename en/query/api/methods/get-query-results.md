# get-query-results

The method returns query execution results. If the query contains multiple `SELECT` statements, multiple query execution results are generated. In this case, get the results by their index.

{% include [!](../../_includes/api-common.md) %}

## Request {#request}

`GET` request to `/queries/{query_id}/results/{<query_execution_result_number_starting_with_0>}?project={folder_id}`, where `{folder_id}` is the folder ID and `{query_id}` is the query ID.

Parameters are passed in URLs as query parameters.

| Parameter | Description | Default value |
| ----- | ----- | ----- |
| `offset` | Number of the result array string to get query results from. | 0 |
| `limit` | Number of result rows  | 100 |

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
| `columns` | An array of returned value columns |
| `columns[].name` | Column name. |
| `columns[].type` | Column data type. |
| `rows` | An array of result rows with the returned value. The number of array elements of each row is the same as the number of columns from the `columns` parameter. |

The rules for converting YQL data types to JSON-compatible data types are described in the [Correspondence of YQL and JSON types](../yql-json-conversion-rules.md) section.

## Example {#example}

Query:

```json
curl -X 'GET' \
  'https://api.yandex-query.cloud.yandex.net/api/fq/v1/queries/cseugn35bc3r5lrmbnt7/results/0?project=b1gaue5b382mmmlolb1k&offset=0&limit=100' \
  -H 'accept: application/json'
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
