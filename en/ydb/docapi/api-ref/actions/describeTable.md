---
sourcePath: overlay/docapi/api-ref/actions/describeTable.md
---
# DescribeTable method

Returns information about a table, including its current status, creation time, primary key schema, and indexes.

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
`TableName` | Name of the table to get information about.<br/>It may contain a path in the hierarchical directory structure in `path/to/table` format.<br/><br/>**Type**: String<br/>**Length**: 3 to 255 characters.<br/>**Template**: [a-zA-Z0-9_.-]+<br/>**Required**: Yes

## Response

If successful, HTTP code 200 is returned.
You will get data in JSON format.

```json
{
   "Table": {
      "AttributeDefinitions": [
         {
            "AttributeName": "string",
            "AttributeType": "string"
         }
      ],
      "CreationDateTime": number,
      "ItemCount": number,
      "KeySchema": [
         {
            "AttributeName": "string",
            "KeyType": "string"
         }
      ],
      "StreamSpecification": {
          "StreamEnabled": boolean,
          "StreamViewType": "string"
      },
      "TableName": "string",
      "TableSizeBytes": number,
      "TableStatus": "string"
   }
}
```

### Parameters

Parameter | Description
----- | -----
`Table` | Table properties.<br/><br/>**Type**: Object of the `TableDescription` type.

## Errors

Parameter | Description
----- | -----
`InternalServerError` | An internal error occurred on the server side.<br/><br/>**HTTP status code**: 500<br/>
`ResourceNotFoundException` | The specified table does not exist or is still being created using the [createTable](./createTable.md) method.<br/><br/>**HTTP status code**: 400<br/>

There may be some [common errors](../../common-errors.md) as well shared by all methods.