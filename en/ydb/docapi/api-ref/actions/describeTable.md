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

| Parameter | Description |
| ----- | ----- |
| `TableName` | Name of the table to delete.<br/>May contain a path in the directory hierarchy like path/to/table.<br/><br/>**Type**: String<br/>**Length**: 3 - 255 characters<br/>**Pattern**: [a-zA-Z0-9_.-]+<br/>**Required**: Yes |

## Response

If successful, HTTP code 200 is returned.
The response is returned in JSON format.

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
      "TableName": "string",
      "TableSizeBytes": number,
      "TableStatus": "string"
   }
}
```

### Parameters

| Parameter | Description |
| ----- | ----- |
| `Table` | Table properties.<br/><br/>**Type**: Object of the `TableDescription` type. |

## Errors

| Parameter | Description |
| ----- | ----- |
| `InternalServerError` | An internal error occurred on the server side.<br/><br/>**HTTP status code**: 500<br/> |
| `ResourceNotFoundException` | The specified table either doesn't exist or is still being created by the method [createTable](./createTable)<br/><br/>**HTTP status code**: 400<br/> |

There may be [common errors](../common-errors) as well. These are errors that are common to all methods.

