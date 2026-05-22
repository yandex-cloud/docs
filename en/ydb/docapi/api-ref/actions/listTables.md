---
sourcePath: overlay/docapi/api-ref/actions/listTables.md
---
# ListTables method

Returns a list of tables.
The output is paginated. You can get up to 100 table names per method call.

## Request

The request contains data in JSON format.

```json
{
   "ExclusiveStartTableName": "string",
   "Limit": number
}
```

### Parameters

Parameter | Description
----- | -----
`ExclusiveStartTableName` | Name of the table to start a search from.<br/><br/>**Type**: String<br/>**Length**: 3 to 255 characters.<br/>**Template**: [a-zA-Z0-9_.-]+<br/>**Required**: No
`Limit` | Maximum number of tables to return. If you omit this parameter, you can get up to 100 tables.<br/><br/>**Type**: Integer<br/>**Range**: 1 to 100<br/>**Required**: No

## Response
If successful, HTTP code 200 is returned.

You will get data in JSON format.

```json
{
   "LastEvaluatedTableName": "string",
   "TableNames": [ "string" ]
}
```
### Parameters

Parameter | Description
----- | -----
`LastEvaluatedTableName` | Name of the last table on the current results page. Use this value as `ExclusiveStartTableName` in a new request to get the next results page.<br/>An empty value means there are no more tables to output.<br/><br/>**Type**: String<br/>**Length**: 3 to 255 characters.<br/>**Template**: [a-zA-Z0-9_.-]+
`TableNames` | List of tables; the maximum array size is 100 records.<br/><br/>**Type**: Array of strings<br/>**Length**: 3 to 255 characters.<br/>**Template**: [a-zA-Z0-9_.-]+

## Errors

Parameter | Description
----- | -----
`InternalServerError` | An internal error occurred on the server side.<br/><br/>**HTTP status code**: 500<br/>

There may be some [common errors](../../common-errors.md) as well shared by all methods.