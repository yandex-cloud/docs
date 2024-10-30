# create-query

The method creates a data query and runs it. After that, the query status changes to `RUNNING`. You can only [get](get-query-results.md) results once the query completes successfully. To find out the query status, use the [get-query-status](get-query-status.md) method.

{% include [!](../../_includes/api-common.md) %}

## Request {#request}

`POST` request to `/queries?project={folder_id}`, where `{folder_id}` is a folder ID.

The request body contains data in JSON format:

```json
{
  "name": "human readable default name",
  "type": "ANALYTICS",
  "text": "string",
  "description": ""
}
```

| Field | Description | Acceptable values | Comment | Limitations |
| ----- | ----- | ----- | ----- | ----- |
| `name` | Query name | | If the parameter is not specified, it is assigned the default name. | The length must not exceed 1024 bytes. |
| `type` | Query type | `STREAMING` for streaming queries, `ANALYTICS` for analytical ones | Default value: `ANALYTICS` | |
| `text` | Query text | String | Required | The length must be from 1 to 102400 bytes. |
| `description` | Query description | | The default value is an empty string. | The length must not exceed 10240 bytes. |

## Response {#response}

If successful, the HTTP code 200 and query ID are returned.

```json
{
  "id": "string"
}
```

| Field | Description | Comment |
| ----- | ----- | ----- |
| `id` | ID of the created query | Required |

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
