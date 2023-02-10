---
sourcePath: overlay/docapi/api-ref/actions/getItem.md
---
# GetItem method

Returns a set of attributes for the item with the specified primary key.

If the desired item is not found, nothing is returned.

By default, the method returns potentially consistent data from the table. To get strongly consistent data, set `ConsistentRead=true`.

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

| Parameter | Description |
| ----- | ----- |
| `Key` | An associative array of attributes of the key/value type that represent the primary key of the extracted item.<br/>For a primary key, specify all its key attributes. For a simple key, you only need to specify its value. For a composite primary key, specify the partition key and sort key values.<br/><br/>**Type**: `AttributeValue` object<br/>**Length**: 1 - 65535 characters<br/>**Required**: Yes |
| `TableName` | Name of the table with the item to extract.<br/>May contain a path in the directory hierarchy like path/to/table.<br/><br/>**Type**: String<br/>**Length**: 3 - 255 characters.<br/>**Pattern**: [a-zA-Z0-9_.-]+<br/>**Required**: Yes |
| `ConsistentRead` | Defines the read consistency model.<br/>If `true`, strongly consistent reads are used. If `false` (default), sequential reads are used.<br/><br/>**Type**: Boolean<br/>**Required**: No |
| `ExpressionAttributeNames` | Placeholder that can be used in an expression instead of an attribute name. The placeholder must start with the hash character `#`.<br/> Possible use cases:<ul><li>If you need to specify an attribute whose name conflicts with the word reserved.<li>As a variable if the attribute name is used several times in an expression.<li>To prevent incorrect interpretation of special characters in the attribute name.</ul>For example, the name of the `Percentile` attribute is in conflict with a reserved word and cannot be explicitly used in an expression. To get around this problem, in the `ExpressionAttributeNames` parameter, specify the placeholder: `{"#P":"Percentile"}`. Then, instead of the real attribute name, use `#P`.<br/><br/>**Type**: String<br/>**Length**: 1 - 65535 characters.<br/>**Required**: No |
| `ProjectionExpression` | Expression that defines attributes to retrieve. The attributes must be comma-separated.<br/>If the attribute names aren't specified explicitly, all item attributes are returned.<br/><br/>**Type**: String<br/>**Required**: No |
| `ReturnConsumedCapacity` | Indicates whether to return information about the consumed capacity.<ul><li>`TOTAL`: Return.<li>`NONE`: Do not return.</ul><br/>**Type**: String<br/>**Possible values**: `TOTAL` \| `NONE`<br/>**Required**: No |
## Response

If successful, HTTP code 200 is returned.
The response is returned in JSON format.

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

| Parameter | Description |
| ----- | ----- |
| `ConsumedCapacity` | Capacity units consumed by a delete operation.<br/>Returned only if the `ReturnConsumedCapacity` parameter set to `TOTAL` is specified in the request.<br/><br/>**Type**: Object of the `ConsumedCapacity` type. |
| `Item` | A set of attributes of the requested item.<br/><br/>**Type**: Associative array of the `AttributeValue` type.<br/>**Length**: 1 - 65535 characters |

## Errors

| Parameter | Description |
| ----- | ----- |
| `InternalServerError` | An internal error occurred on the server side.<br/><br/>**HTTP status code**: 500 |
| `ProvisionedThroughputExceededException` | You're sending requests too often. Try to increase the interval between requests.<br/>If their number is not too large, {{ ydb-name }} tries to process them all.<br/><br/>**HTTP status code**: 400 |
| `RequestLimitExceeded` | The bandwidth exceeds the set quota.<br/><br/>**HTTP status code**: 400 |
| `ResourceNotFoundException` | The specified table doesn't exist.<br/><br/>**HTTP status code**: 400 |

There may be [common errors](../common-errors) as well. These are errors that are common to all methods.