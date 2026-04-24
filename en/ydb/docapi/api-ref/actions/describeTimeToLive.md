---
sourcePath: overlay/docapi/api-ref/actions/describeTimeToLive.md
---
# DescribeTimeToLive method

Returns the time-to-live (TTL) status for the specified table.

## Request

The request contains data in JSON format.

```json
{
  "TableName": "string"
}
```

### Parameters

Parameter | Description
----- | -----
`TableName` | Name of the table whose TTL status is requested.<br/>It may contain a path in the hierarchical directory structure in `path/to/table` format.<br/><br/>**Type**: String<br/>**Length**: 3 to 255 characters.<br/>**Template**: [a-zA-Z0-9_.-]+<br/>**Required**: Yes

## Response

If successful, HTTP code 200 is returned.
You will get data in JSON format.

```json
{
  "TimeToLiveDescription": {
    "AttributeName": "string",
    "TimeToLiveStatus": "string"
  }
}
```

### Parameters

Parameter | Description
----- | -----
`TimeToLiveSpecification` | TTL status.<br/><br/>**Type**: Object of the `TimeToLiveSpecification` type.

## Errors

Parameter | Description
----- | -----
`InternalServerError` | An internal error occurred on the server side.<br/><br/>**HTTP status code**: 500
`ResourceNotFoundException` | The specified table does not exist or its status is different from `ACTIVE`.<br/><br/>**HTTP status code**: 400<br/>

There may be some [common errors](../../common-errors.md) as well shared by all methods.
