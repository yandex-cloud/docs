# get-query

The method returns information about a query, including query metada, its execution status, and an array of results.

{% include [!](../../_includes/api-common.md) %}

## Request {#request}

`GET` request to `/queries/{query_id}?project_id={folder_id}`, where `{folder_id}` is the folder ID and `{query_id}` is the query ID.

## Response {#response}

If successful, an HTTP response with code 200 and query information is returned.

```json
{
  "name": "<query_name>",
  "type": "<query_type>",
  "text": "<query_text>",
  "description": "<description>",
  "meta": {
    "started_at": "2022-09-03T14:53:00.067Z",
    "finished_at": "2022-09-03T14:53:00.067Z"
  },
  "issues": {
    "details": [
      {
        "position": {
          "row": 0,
          "column": 0,
          "file": "string"
        },
        "message": "string",
        "end_position": {
          "row": 10,
          "column": 10,
          "file": "string"
        },
        "issue_code": 0,
        "severity": "FATAL",
        "issues": [
        ],
        "status": 0
      }
    ],
    "message": "string",
    "status": 0
  },
  "result_sets": [
    {
      "rows": 0,
      "truncated": true
    }
  ],
  "status": "RUNNING",
  "id": "string"
}
```

| Field | Description |
| ----- | ----- |
| `name` | Query name |
| `type` | Query type: `STREAMING` or `ANALYTICS`. |
| `text` | Query text |
| `description` | Query description |
| `meta.started_at` | Query execution start time |
| `meta.finished_at` | Query execution end time |
| `issues` | If the query fails, you'll see an object named [`Issue`](../index.md#issue) |
| `result_sets` | An array of query execution results |
| `result_sets[].rows` | The number of rows with query execution results |
| `result_sets[].truncated` | The number of rows with query execution results exceeded the limit and was truncated. |

## Example {#example}

Query:

```json
curl -X 'GET' \
  'https://api.yandex-query.cloud.yandex.net/api/fq/v1/queries/cseugn35bc3r5lrmbnt7?project=b1gaue5b382mmmlolb1k' \
  -H 'accept: application/json'
```

Response:

```json
{
  "name": "",
  "type": "ANALYTICS",
  "text": "select 1",
  "description": "",
  "meta": {
    "started_at": "2022-09-03T15:02:36.827Z",
    "finished_at": "2022-09-03T15:02:36.827Z"
  },
  "issues": [],
  "result_sets": [
    {
      "rows": 110,
      "truncated": false
    }
  ],
  "status": "FINISHED",
  "id": "csqugo80f0l35isue09b"
}
```
