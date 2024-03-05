# create-query

The method creates a data query and runs it. After that, the query status changes to `RUNNING`. You can only [get](get-query-results.md) results once the query completes successfully. To find out the query status, use the [get-query-status](get-query-status.md) method.

{% include [!](../../_includes/api-common.md) %}

## Query {#request}

`POST` query to `/queries?project={folder_id}`, where `{folder_id}` is the folder ID.

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
| `type` | Query type | `STREAMING` or `ANALYTICS` | The default value is `ANALYTICS`. | |
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
| `Id` | ID of the created query | Required |

## Example {#example}

Query:

```json
curl -X 'POST' \
  'https://api.yandex-query.cloud.yandex.net/api/fq/v1/queries?project=b1gaue5b382mmmlolb1k' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
    "name": "Test query",
    "type": "ANALYTICS",
    "text": "select 1",
    "description": ""
  }'
```

Response:

```json
{
  "id": "csqugo80f0l35isue09b"
}
```
