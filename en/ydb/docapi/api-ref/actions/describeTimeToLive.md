---
sourcePath: overlay/docapi/api-ref/actions/describeTimeToLive.md
---
# DescribeTimeToLive method

Returns information about the TTL status in the specified table.

## Request

The request contains data in JSON format.

```json
{
  "TableName": "string"
}
```

### Parameters

| Parameter | Description |
| ----- | ----- |
| `TableName` | Name of the table that the TTL state is requested for.<br/>May contain a path in the directory hierarchy like path/to/table.<br/><br/>**Type**: String<br/>**Length**: 3 - 255 characters.<br/>**Pattern**: [a-zA-Z0-9_.-]+<br/>**Required**: Yes |

## Response

If successful, HTTP code 200 is returned.
The response is returned in JSON format.

```json
{
  "TimeToLiveDescription": {
    "AttributeName": "string",
    "TimeToLiveStatus": "string"
  }
}
```

### Parameters

| Parameter | Description |
| ----- | ----- |
| `TimeToLiveSpecification` | TTL status.<br/><br/>**Type**: Object of the `TimeToLiveSpecification` type. |

## Errors

| Parameter | Description |
| ----- | ----- |
| `InternalServerError` | An internal error occurred on the server side.<br/><br/>**HTTP status code**: 500 |
| `ResourceNotFoundException` | The specified table doesn't exist or its state is different from `ACTIVE`.<br/><br/>**HTTP status code**: 400<br/> |

There may be [common errors](../../common-errors.md) as well. These are errors that are common to all methods.
