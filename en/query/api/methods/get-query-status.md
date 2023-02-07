# get-query-status

The method returns the query execution status. Use the method to track the query progress to wait until it's executed and [get query results](get-query-results.md).

{% include [!](../../_includes/api-common.md) %}

## Request {#request}

`GET` request to `/queries/{query_id}/status?project={folder_id}`, where `{folder_id}` is the folder ID and `{query_id}` is the query ID.

## Response {#response}

If successful, an HTTP response with code 200 and the query execution status (`RUNNING`, `COMPLETED`, or `FAILED`) is returned.

```json
{
  "status": "RUNNING"
}
```

## Example {#example}

Query:

```json
curl -X 'GET' \
  'https://api.yandex-query.cloud.yandex.net/api/fq/v1/queries/cseugn35bc3r5lrmbnt7/status?project=b1gaue5b382mmmlolb1k' \
  -H 'accept: application/json'
}
```

Response:

```json
{
  "status": "RUNNING"
}
```
