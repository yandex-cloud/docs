---
sourcePath: overlay/docapi/api-ref/actions/listTables.md
---
# ListTables method

Returns a list of tables.

The output of tables is paginated, with each page returning a maximum of 100 table names.

## Request

The request contains data in JSON format.

```json
{
   "ExclusiveStartTableName": "string",
   "Limit": number
}
```

### Parameters

| Parameter | Description |
| ----- | ----- |
| `ExclusiveStartTableName` | The name of the table to start a search from.<br/><br/>**Type**: String<br/>**Length**: 3 - 255 characters<br/>**Pattern**: [a-zA-Z0-9_.-]+<br/>**Required**: No |
| `Limit` | Maximum number of tables to return. If the parameter is omitted, up to 100 tables are returned.<br/><br/>**Type**: Integer<br/>**Range**: 1 - 100.<br/>**Required**: No |

## Response
If successful, HTTP code 200 is returned.

The response is returned in JSON format.

```json
{
   "LastEvaluatedTableName": "string",
   "TableNames": [ "string" ]
}
```
### Parameters

| Parameter | Description |
| ----- | ----- |
| `LastEvaluatedTableName` | Name of the last table in the current results page. Use this value as `ExclusiveStartTableName` in a new request to get the next results page.<br/>An empty value means that there are no more tables to output.<br/><br/>**Type**: String<br/>**Length**: 3 - 255 characters<br/>**Pattern**: [a-zA-Z0-9_.-]+ |
| `TableNames` | List of tables, the maximum array size is 100 items.<br/><br/>**Type**: Array of strings<br/>**Length**: 3 - 255 characters<br/>**Pattern**: [a-zA-Z0-9_.-]+ |

## Errors

| Parameter | Description |
| ----- | ----- |
| `InternalServerError` | An internal error occurred on the server side.<br/><br/>**HTTP status code**: 500<br/> |

There may be [common errors](../common-errors) as well. These are errors that are common to all methods.