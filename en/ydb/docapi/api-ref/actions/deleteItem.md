---
sourcePath: overlay/docapi/api-ref/actions/deleteItem.md
---
# DeleteItem method

Deletes a table item by the specified primary key.

You can set a condition. An item will then be deleted only if the condition is met.

The method may return the attribute values as they were before the item was deleted.

## Request

The request contains data in JSON format.

```json
{
   "ConditionalOperator": "string",
   "ConditionExpression": "string",
   "Expected": {
      "string" : {
         "AttributeValueList": [
            {
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
         ],
         "ComparisonOperator": "string",
         "Exists": boolean,
         "Value": {
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
   },
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
   "ReturnConsumedCapacity": "string"
   "ReturnValues": "string",
   "TableName": "string"
}
```

### Parameters

Parameter | Description
----- | -----
`Key` | Associative array of attribute names for `AttributeValue` objects that serves as a primary key of the item to delete.<br/>For a simple primary key, you only need to specify its value.<br/>For a composite primary key, specify the value of a partition key and a sort key.<br/><br/>**Type**: String<br/>**Length**: 1 to 65,535 characters.<br/>**Required**: Yes
`TableName` | Name of the table containing the item to delete.</br>It may contain a path in the hierarchical directory structure in `path/to/table` format.<br/><br/>**Type**: String<br/>**Length**: 3 to 255 characters.<br/>**Template**: [a-zA-Z0-9_.-]+<br/>**Required**: Yes
`ConditionExpression` | Condition for deleting the item. The record will be deleted only if the condition is met.<br/>The condition consists of:<ul><li>Functions: `attribute_exists` \| `attribute_not_exists` \| `attribute_type` \| `contains` \| `begins_with` \| `size`. Names are case-sensitive.<br/><li>Comparison operators: `=` \| `<>` \| `<` \| `>` \| `<=` \| `>=` \| `BETWEEN` \| `IN`<br/><li>Logical operators: `AND` \| `OR` \| `NOT`</ul><br/>**Type**: String<br/>**Required**: No
`ExpressionAttributeNames` | Placeholder for an attribute name in an expression. The placeholder must start with the hash character, `#`.<br/> You can use it in the following cases:<ul><li>To specify an attribute whose name conflicts with a reserved word.<li>As a variable, if the attribute name is used multiple times in an expression.<li>To prevent incorrect interpretation of special characters in the attribute name.</ul>For example, the `Percentile` attribute name conflicts with the reserved word, so you cannot use it explicitly in an expression. To fix this issue, specify the `{"#P":"Percentile"}` placeholder in the `ExpressionAttributeNames` parameter, and then, further on, use `#P` instead of the real attribute name.<br/><br/>**Type**: String<br/>**Length**: 1 to 65,535 characters.<br/>**Required**: No
`ExpressionAttributeValues` | Placeholder for an attribute name in an expression, same as `ExpressionAttributeNames`. The placeholder must start with a colon, `:`.<br/>For example, you need to check whether the value of the `ProductStatus` attribute was one of the following: `Available` \| `Backordered` \| `Discontinued`. To do this, first declare placeholders: `{ ":avail":{"S":"Available"}, ":back":{"S":"Backordered"}, ":disc":{"S":"Discontinued"} }`. Now you can use them in the expression: `ProductStatus IN (:avail, :back, :disc)`<br/><br/>**Type**: String of the `AttributeValue` type<br/>**Required**: No
`ReturnConsumedCapacity` | Sets whether to return information about the consumed capacity.<ul><li>`TOTAL`: Return.<li>`NONE`: Do not return.</ul><br/>**Type**: String<br/>**Possible values**: `TOTAL` \| `NONE`<br/>**Required**: No
`ReturnValues` | Use it if you need to get attributes of an item to delete.<br/>Possible values:<ul><li>`ALL_OLD`: Return the contents of the deleted item.<li>`NONE` (default): Do not return the contents of the deleted item.</ul><br/>**Type**: String<br/>**Required**: No

## Response

If successful, HTTP code 200 is returned.
You will get data in JSON format.

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

Parameter | Description
----- | -----
`Attributes` | Associative array of the `AttributeValue` type containing the item representation before it was deleted.<br/>It is returned only if you provide `ReturnValues` set to `ALL_OLD` in the request.<br/><br/>**Type**: Associative array of the `AttributeValue` type.<br/>**Length**: 1 to 65,535 characters.
`ConsumedCapacity` | Capacity units consumed by a delete operation.<br/>It is returned only if you provide `ReturnConsumedCapacity` set to `TOTAL` in the request.<br/><br/>**Type**: Object of the `ConsumedCapacity` type.

## Errors

Parameter | Description
----- | ----- 
`ConditionalCheckFailedException` | Failed to evaluate the condition specified in the operation.<br/><br/>**HTTP status code**: 400
`InternalServerError` | An internal error occurred on the server side.<br/><br/>**HTTP status code**: 500
`ItemCollectionSizeLimitExceededException` | Item collection size limit exceeded. This exception is only returned for tables with one or more local secondary indexes.<br/><br/>**HTTP status code**: 400
`ProvisionedThroughputExceededException` | Your request rate is too high. Try to reduce the frequency of requests.<br/>If their number is not too large, {{ ydb-name }} will try to process them all.<br/><br/>**HTTP status code**: 400
`RequestLimitExceeded` | The throughput capacity exceeds the set quota.<br/><br/>**HTTP status code**: 400
`ResourceNotFoundException` | The requested table does not exist.<br/><br/>**HTTP status code**: 400
`TransactionConflictException` | The operation is rejected because there is an ongoing transaction for the item.<br/><br/>**HTTP status code**: 400

There may be some [common errors](../../common-errors.md) as well shared by all methods.