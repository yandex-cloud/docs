# stop-query

The method stops a query.

{% include [!](../../_includes/api-common.md) %}

## Request {#request}

`POST` request to `/queries/{query_id}/stop?project={folder_id}`, where `{folder_id}` is the folder ID and `{query_id}` is the query ID.

## Response {#response}

If successful, an empty HTTP response with code 204 is returned.

## Example {#example}

Query:

```json
curl -X 'POST' \
  'https://api.yandex-query.cloud.yandex.net/api/fq/v1/queries/cseugn35bc3r5lrmbnt7/stop?project=b1gaue5b382mmmlolb1k' \
  -H 'accept: */*' \
  -d ''
```

Response: HTTP 204.
