# get-query

This method returns query details, including its metadata, execution status, and result size.

{% include [!](../../_includes/api-common.md) %}

## Request {#request}

`GET` request to `/queries/{query_id}?project={folder_id}`, where `{folder_id}` is the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) ID and `{query_id}` is the query ID.

## Response {#response}

If successful, the response returns an HTTP 200 status code and query details.

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

Field | Description
--- | ---
`name` | Query name
`type` | Query type: `STREAMING` or `ANALYTICS`
`text` | Query text
`description` | Query description
`meta.started_at` | Query start time
`meta.finished_at` | Query end time
`issues` | When execution errors occur, this field contains an [`Issue`](../index.md#issue) object
`result_sets` | Array of query results
`result_sets[].rows` | Query result row count
`result_sets[].truncated` | The query result row count exceeds the limit and has been truncated

## Example {#example}

Request:

```json
curl \
  --request 'GET' \
  'https://api.yandex-query.cloud.yandex.net/api/fq/v1/queries/cseugn35bc3r********?project=b1gaue5b382m********' \
  --header 'accept: application/json'
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
  "id": "csqugo80f0l3********"
}
```