# create-query

This method creates a data query and runs it. Once started, the query status changes to `RUNNING`. You can only [get](get-query-results.md) results after the query completes successfully. To check the query status, use the [get-query-status](get-query-status.md) method.

{% include [!](../../_includes/api-common.md) %}

## Request {#request}

`POST` request to `/queries?project={folder_id}`, where `{folder_id}` is the folder ID.

The request body contains JSON-formatted data:

```json
{
  "name": "human readable default name",
  "type": "ANALYTICS",
  "text": "string",
  "description": ""
}
```

| Field | Description | Valid values | Note | Limitations |
| ----- | ----- | ----- | ----- | ----- |
| `name` | Query name | | If this value is not specified, the query is assigned the default name | The field length must not exceed 1,024 bytes |
| `type` | Query type | `STREAMING` for streaming queries, `ANALYTICS` for analytical queries | Default value: `ANALYTICS` | |
| `text` | Query text | String | Required | The field length must be between 1 and 102,400 bytes |
| `description` | Query description | | The default value is an empty string | The field length must not exceed 10,240 bytes |

## Response {#response}

If successful, the response returns an HTTP 200 status code and the query ID.

```json
{
  "id": "string"
}
```

| Field | Description | Note |
| ----- | ----- | ----- |
| `id` | New query ID | Required |

## Example {#example}

Request:

```json
curl \
  --request 'POST' \
  'https://api.yandex-query.cloud.yandex.net/api/fq/v1/queries?project=b1gaue5b382m********' \
  --header 'accept: application/json' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "Test query",
    "type": "ANALYTICS",
    "text": "select 1",
    "description": ""
  }'
```

Response:

```json
{
  "id": "csqugo80f0l3********"
}
```
