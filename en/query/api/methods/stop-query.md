# stop-query

This method terminates a query.

{% include [!](../../_includes/api-common.md) %}

## Request {#request}

`POST` request to `/queries/{query_id}/stop?project={folder_id}`, where `{folder_id}` is the folder ID and `{query_id}` is the query ID.

## Response {#response}

If successful, the response returns an HTTP 204 status code and an empty body.

## Example {#example}

Request:

```json
curl \
  --request 'POST' \
  'https://api.yandex-query.cloud.yandex.net/api/fq/v1/queries/cseugn35bc3r********/stop?project=b1gaue5b382m********' \
  --header 'accept: */*' \
  --data ''
```

Response: HTTP 204.
