---
sourcePath: overlay/docapi/api-ref/actions/putItem.md
---
# PutItem method

Replaces an item in a table or creates a new one. If the item with the specified primary key already exists, the method replaces it with a new item. If there is no item, the method creates it.

You can set a condition. The method is then triggered only if the condition is met.

It may return the attribute values that were valid before the update.

## Request

The request contains data in JSON format.

```json
{
   "ConditionalOperator": "string",
   "ConditionExpression": "string",
   "ExpressionAttributeNames": {
      "string" : "string"
   },
   "ExpressionAttributeValues": {
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
   },
   "ReturnConsumedCapacity": "string",
   "ReturnValues": "string",
   "TableName": "string"
}
```

### Parameters

| Parameter | Description |
| ----- | ----- |
| `Item` | An associative array of attributes of the key/value type.<br/>Only primary key attributes are required, but you can specify other attributes, too.<br/>For a primary key, specify all its key attributes. For a simple key, you only need to specify its value. For a composite primary key, specify the value of the partition key and the sort key.<br/>Values for string and binary attributes can be empty.<br/><br/>**Type**: Object of the `AttributeValue` type<br/>**Length**: 1 - 65535 characters<br/>**Required**: Yes |
| `TableName` | Name of the table storing the item.</br>May contain a path in the directory hierarchy like path/to/table.<br/><br/>**Type**: String<br/>**Length**: 3 - 255 characters<br/>**Pattern**: [a-zA-Z0-9_.-]+<br/>**Requested**: Yes |
| `ConditionExpression` | Condition for replacing the item. The method will trigger only if the condition is met.<br/>The condition consists of:<ul><li>A function: `attribute_exists` \| `attribute_not_exists` \| `attribute_type` \| `contains` \| `begins_with` \| `size`. Names are case-sensitive.<li>A comparison operator: `=` \| `<>` \| `<` \| `>` \| `<=` \| `>=` \| `BETWEEN` \| `IN`.<li>A logical operator: `AND` \| `OR` \| `NOT`.</ul><br/>**Type**: String<br/>**Required**: No |
| `ExpressionAttributeNames` | Placeholder that can be used in an expression instead of an attribute name. The placeholder must start with the hash character `#`.<br/> Possible use cases:<ul><li>If you need to specify an attribute whose name conflicts with the word reserved.<li>As a variable if the attribute name is used several times in an expression.<li>To prevent incorrect interpretation of special characters in the attribute name.</ul>For example, the name of the `Percentile` attribute is in conflict with a reserved word and cannot be explicitly used in an expression. To get around this problem, in the `ExpressionAttributeNames` parameter, specify the placeholder: `{"#P":"Percentile"}`. Then, instead of the real attribute name, use `#P`.<br/><br/>**Type**: String<br/>**Length**: 1 - 65535 characters.<br/>**Required**: No |
| `ExpressionAttributeValues` | Placeholder that can be used in an expression instead of an attribute value, similar to `ExpressionAttributeNames`. The placeholder must start with a colon `:`.<br/>For example, you need to check whether the value of the `ProductStatus` attribute was one of the following: `Available` \| `Backordered` \| `Discontinued`. To do this, first declare placeholders: `{ ":avail":{"S":"Available"}, ":back":{"S":"Backordered"}, ":disc":{"S":"Discontinued"} }`. After that, you can use them in the expression: `ProductStatus IN (:avail, :back, :disc)`<br/><br/>**Type**: String of the `AttributeValue` type<br/>**Required**: No |
| `ReturnConsumedCapacity` | Indicates whether to return information about the consumed capacity.<ul><li>`TOTAL`: Return.<li>`NONE`: Do not return.</ul><br/>**Type**: String<br/>**Possible values**: `TOTAL` \| `NONE`<br/>**Required**: No |
| `ReturnValues` | Use it if you need to get the attributes of an item before its update.<br/>Possible values:<ul><li>`NONE` (default): Do not return item attributes<li>`ALL_OLD`: Return all attributes as they were before the item update</ul><br/>**Type**: String<br/>**Possible values**: `NONE` \| `ALL_OLD`<br/>**Required**: No |

## Response

If successful, HTTP code 200 is returned.
The response is returned in JSON format.

```json
{
   "Attributes": {
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
   }
}
```

### Parameters

| Parameter | Description |
| ----- | ----- |
| `Attributes` | An associative array of the `AttributeValue` type containing attribute values before their update.<br/>Returned only if the request passed the `ReturnValues` parameter set to `ALL_OLD`.<br/><br/>**Type**: Associative array of the `AttributeValue` type<br/>**Length**: 1 - 65535 characters. |
| `ConsumedCapacity` | Capacity units consumed by a delete operation.<br/>Returned only if the `ReturnConsumedCapacity` parameter set to `TOTAL` is specified in the request.<br/><br/>**Type**: Object of the `ConsumedCapacity` type. |

## Errors

| Parameter | Description |
| ----- | ----- |
| `ConditionalCheckFailedException` | Failed to evaluate the condition specified in the operation.<br/><br/>**HTTP status code**: 400 |
| `InternalServerError` | An internal error occurred on the server side.<br/><br/>**HTTP status code**: 500 |
| `ItemCollectionSizeLimitExceededException` | Item collection size limit exceeded. This exception is only returned for tables with one or more local secondary indexes.<br/><br/>**HTTP status code**: 400 |
| `ProvisionedThroughputExceededException` | You're sending requests too often. Try to increase the interval between requests.<br/>If their number is not too large, {{ ydb-name }} tries to process them all.<br/><br/>**HTTP status code**: 400 |
| `RequestLimitExceeded` | The bandwidth exceeds the set quota.<br/><br/>**HTTP status code**: 400 |
| `ResourceNotFoundException` | The specified table doesn't exist.<br/><br/>**HTTP status code**: 400 |
| `TransactionConflictException` | The operation is rejected as a different transaction is in progress for the item.<br/><br/>**HTTP status code**: 400 |

There may be [common errors](../common-errors) as well. These are errors that are common to all methods.