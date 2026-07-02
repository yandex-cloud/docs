# get-query-status

This method returns the query status. You can use it to track query progress and [retrieve the results](get-query-results.md) once it is completed.

{% include [!](../../_includes/api-common.md) %}

## Request {#request}

`GET` request to `/queries/{query_id}/status?project={folder_id}`, where `{folder_id}` is the folder ID and `{query_id}` is the query ID.

## Response {#response}

If successful, the response returns an HTTP 200 status code and the query status, i.e., `RUNNING`, `COMPLETED`, or `FAILED`.

```json
{
  "status": "RUNNING"
}
```

## Example {#example}

Query:

```json
curl \
  --request 'GET' \
  --header 'accept: application/json' \
  'https://api.yandex-query.cloud.yandex.net/api/fq/v1/queries/cseugn35bc3r********/status?project=b1gaue5b382m********'
```

Response:

```json
{
  "status": "RUNNING"
}
```
