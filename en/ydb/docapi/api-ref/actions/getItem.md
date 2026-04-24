---
sourcePath: overlay/docapi/api-ref/actions/getItem.md
---
# GetItem method

Returns a set of attributes for the item with the specified primary key.
If the item is not found, nothing is returned.

By default, the method returns eventually consistent data from the table. To get strongly consistent data, set `ConsistentRead=true`.

## Request

The request contains data in JSON format.

```json
{
   "AttributesToGet": [ "string" ],
   "ConsistentRead": boolean,
   "ExpressionAttributeNames": {
      "string" : "string"
   },
   "Key": {
      "string" : {
         "B": blob,
         "BOOL": boolean,
         "BS": [ blob ],
         "L": [
            "AttributeValue"
         ],
         "M": {
            "string" : "AttributeValue"
         },
         "N": "string",
         "NS": [ "string" ],
         "NULL": boolean,
         "S": "string",
         "SS": [ "string" ]
      }
   },
   "ProjectionExpression": "string",
   "ReturnConsumedCapacity": "string",
   "TableName": "string"
}
```

### Parameters

Parameter | Description
----- | -----
`Key` | Associative array of attributes of the key/value type that serve as a primary key of the item to get.<br/>For a primary key, specify all its key attributes. For a simple key, you only need to specify its value. For a composite primary key, specify values for both the partition key and the sort key.<br/><br/>**Type**: Object of the `AttributeValue` type.<br/>**Length**: 1 to 65,535 characters.<br/>**Required**: Yes
`TableName` | Name of the table with the item to get.<br/>It may contain a path in the hierarchical directory structure in `path/to/table` format.<br/><br/>**Type**: String<br/>**Length**: 3 to 255 characters.<br/>**Template**: [a-zA-Z0-9_.-]+<br/>**Required**: Yes
`ConsistentRead` | Consistency of data reads.<br/>`true` enables strongly consistent reads; `false` (by default) enables sequential reads.<br/><br/>**Type**: Boolean<br/>**Required**: No
`ExpressionAttributeNames` | Placeholder for an attribute name in an expression. The placeholder must start with the hash character, `#`.<br/> You can use it in the following cases:<ul><li>To specify an attribute whose name conflicts with a reserved word.<li>As a variable, if the attribute name is used multiple times in an expression.<li>To prevent incorrect interpretation of special characters in the attribute name.</ul>For example, the `Percentile` attribute name conflicts with the reserved word, so you cannot use it explicitly in an expression. To fix this issue, specify the `{"#P":"Percentile"}` placeholder in the `ExpressionAttributeNames` parameter, and then, further on, use `#P` instead of the real attribute name.<br/><br/>**Type**: String<br/>**Length**: 1 to 65,535 characters.<br/>**Required**: No
`ProjectionExpression` | Expression that defines attributes to get. The attributes must be comma-separated.<br/>If you do not explicitly specify the attribute names, all item attributes will be returned.<br/><br/>**Type**: String<br/>**Required**: No
`ReturnConsumedCapacity` | Sets whether to return information about the consumed capacity.<ul><li>`TOTAL`: Return.<li>`NONE`: Do not return.</ul><br/>**Type**: String<br/>**Possible values**: `TOTAL` \| `NONE`<br/>**Required**: No
## Response

If successful, HTTP code 200 is returned.
You will get data in JSON format.

```json
{
   "ConsumedCapacity": {
      "CapacityUnits": number,
      "GlobalSecondaryIndexes": {
         "string" : {
            "CapacityUnits": number,
            "ReadCapacityUnits": number,
            "WriteCapacityUnits": number
         }
      },
      "LocalSecondaryIndexes": {
         "string" : {
            "CapacityUnits": number,
            "ReadCapacityUnits": number,
            "WriteCapacityUnits": number
         }
      },
      "ReadCapacityUnits": number,
      "Table": {
         "CapacityUnits": number,
         "ReadCapacityUnits": number,
         "WriteCapacityUnits": number
      },
      "TableName": "string",
      "WriteCapacityUnits": number
   },
   "Item": {
      "string" : {
         "B": blob,
         "BOOL": boolean,
         "BS": [ blob ],
         "L": [
            "AttributeValue"
         ],
         "M": {
            "string" : "AttributeValue"
         },
         "N": "string",
         "NS": [ "string" ],
         "NULL": boolean,
         "S": "string",
         "SS": [ "string" ]
      }
   }
}
```

### Parameters

Parameter | Description
----- | -----
`ConsumedCapacity` | Capacity units consumed by a delete operation.<br/>It is returned only if you provide `ReturnConsumedCapacity` set to `TOTAL` in the request.<br/><br/>**Type**: Object of the `ConsumedCapacity` type.
`Item` | Attributes of the requested item.<br/><br/>**Type**: Associative array of the `AttributeValue` type.<br/>**Length**: 1 to 65,535 characters.

## Errors

Parameter | Description
----- | -----
`InternalServerError` | An internal error occurred on the server side.<br/><br/>**HTTP status code**: 500
`ProvisionedThroughputExceededException` | Your request rate is too high. Try to reduce the frequency of requests.<br/>If their number is not too large, {{ ydb-name }} will try to process them all.<br/><br/>**HTTP status code**: 400
`RequestLimitExceeded` | The throughput capacity exceeds the set quota.<br/><br/>**HTTP status code**: 400
`ResourceNotFoundException` | The requested table does not exist.<br/><br/>**HTTP status code**: 400

There may be some [common errors](../../common-errors.md) as well shared by all methods.