---
sourcePath: overlay/docapi/api-ref/actions/updateItem.md
---
# UpdateItem method

Updates the attributes of an existing item or adds a new item if it doesn't exist. You can update, delete, or add attribute values.

You can set an update condition. The method is then triggered only if the condition is met.

It may return the attribute values that were valid before or after the update.

## Request

The request contains data in JSON format.

```json
{
   "AttributeUpdates": {
      "string" : {
         "Action": "string",
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
   "ReturnConsumedCapacity": "string",
   "ReturnValues": "string",
   "TableName": "string",
   "UpdateExpression": "string"
}
```

### Parameters

| Parameter | Description |
| ----- | ----- |
| `Key` | Primary key of the item to update, specify all the key attributes. For a simple primary key, you only need to specify its value. For a composite primary key, specify the value of the partition key and sort key.<br/><br/>**Type**: Associative array of the `AttributeValue` type.<br/>**Length**: 1: 65535 characters.<br/>**Required**: Yes |
| `TableName` | Name of the table storing the item to update.</br>May contain a path in the directory hierarchy like path/to/table.<br/><br/>**Type**: String<br/>**Length**: 3: 255 characters<br/>**Pattern**: [a-zA-Z0-9_.-]+<br/>**Required**: Yes |
| `ConditionExpression` | Condition for updating the item. The method will trigger only if the condition is met.<br/>The condition consists of:<ul><li>A function: `attribute_exists` \| `attribute_not_exists` \| `attribute_type` \| `contains` \| `begins_with` \| `size`. Names are case-sensitive.<li>A comparison operator: `=` \| `<>` \| `<` \| `>` \| `<=` \| `>=` \| `BETWEEN` \| `IN`.<li>A logical operator: `AND` \| `OR` \| `NOT`.</ul><br/>**Type**: String<br/>**Required**: No |
| `ExpressionAttributeNames` | Placeholder that can be used in an expression instead of an attribute name. The placeholder must start with the hash character `#`.<br/> Possible use cases:<ul><li>If you need to specify an attribute whose name conflicts with the word reserved.<li>As a variable if the attribute name is used several times in an expression.<li>To prevent incorrect interpretation of special characters in the attribute name.</ul>For example, the name of the `Percentile` attribute is in conflict with a reserved word and cannot be explicitly used in an expression. To get around this problem, in the `ExpressionAttributeNames` parameter, specify the placeholder: `{"#P":"Percentile"}`. Then, instead of the real attribute name, use `#P`.<br/><br/>**Type**: String<br/>**Length**: 1: 65535 characters.<br/>**Required**: No |
| `ExpressionAttributeValues` | Placeholder that can be used in an expression instead of an attribute value, similar to `ExpressionAttributeNames`. The placeholder must start with a colon `:`.<br/>For example, you need to check whether the value of the `ProductStatus` attribute was one of the following: `Available` \| `Backordered` \| `Discontinued`. To do this, first declare placeholders: `{ ":avail":{"S":"Available"}, ":back":{"S":"Backordered"}, ":disc":{"S":"Discontinued"} }`. After that, you can use them in the expression: `ProductStatus IN (:avail, :back, :disc)`<br/><br/>**Type**: String of the `AttributeValue` type<br/>**Required**: No |
| `ReturnConsumedCapacity` | Indicates whether to return information about the consumed capacity.<ul><li>`TOTAL` — Return.<li>`NONE` — Do not return.</ul><br/>**Type**: String<br/>**Possible values**: `TOTAL` \| `NONE`<br/>**Required**: No |
| `ReturnValues` | Use it if you need to get the attributes of an item before and after its update.<br/>Possible values:<ul><li>`NONE` (default): Do not return item attributes<li>`ALL_OLD`: Return all attributes as they were before the item update<li>`UPDATED_OLD`: Only return the updated attributes as they were before the update.<li>`ALL_NEW`: Return all attributes as they will be after the update.<li>`UPDATED_NEW`: Only return the updated attributes as they will be after the update.</ul>No read capacity units are used in this case.<br/>Returned values are strongly consistent.<br/><br/>**Type**: String<br/>**Possible values**: `NONE` \| `ALL_OLD` \| `UPDATED_OLD` \| `ALL_NEW` \| `UPDATED_NEW`<br/>**Required**: No |
| `UpdateExpression` | Expression to update. Specifies how and which attributes to update.<br/>Possible actions:<ul><li>`SET`: Sets the attribute to the specified value. If no attribute exists, it will be created.<br/>Supported functions:<ul><li>`if_not_exists (path, operand)`: Checks that the specified attribute doesn't exist. If no attribute is found at the specified `path`, the function calculates the specified operand.<li>`list_append (operand, operand)` — evaluates to a list with a new element added to it. You can append the new element to the start or the end of the list by reversing the order of the operands.</ul>Function names are case-sensitive.<li>`REMOVE`: Removes attributes.<li>`ADD`: Adds a value to an attribute. <br/>F the attribute exists, the ADD function behavior depends on the attribute's data type:<ul><li>If it's **numeric**, the addition operation is performed and the attribute value is added to the specified value. If the attribute or value didn't exist, then `0` is taken as the basis and used by the addition operation.<li>If the attribute is a **set**, the specified value is added to the set. Both sets (that in the attribute value and the one specified) must have the same data type.</ul><li>`DELETE` Deletes an item from the set. Applicable to sets and top-level attributes only. You can't delete nested attributes.<br/>You can specify multiple items at a time.</ul>A single expression may contain multiple actions, for example, `SET a=:value1, b=:value2 DELETE :value3, :value4, :value5`<br/><br/>**Type**: String<br/>**Required**: No |

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
| `Attributes` | Associative array of the `AttributeValue` type containing an item's representation before or after it's updated.<br/>Returned only if the request passed the `ReturnValues` parameter that wasn't set to `NONE`.<br/><br/>**Type**: Associative array of the `AttributeValue` type<br/>**Length**: 1: 65535 characters. |
| `ConsumedCapacity` | Capacity units consumed by a delete operation.<br/>Returned only if the `ReturnConsumedCapacity` parameter set to `TOTAL` is specified in the request.<br/><br/>**Type**: Object of the `ConsumedCapacity` type. |

## Errors

| Parameter | Description |
| ----- | ----- |
| `ConditionalCheckFailedException` | Can't check the condition specified in the operation.<br/><br/> **HTTP status code**: 400 |
| `InternalServerError` | An internal error occurred on the server side.<br/><br/>**HTTP status code**: 500 |
| `ProvisionedThroughputExceededException` | You're sending requests too often. Try to increase the interval between requests.<br/>If their number is not too large, {{ ydb-name }} tries to process them all.<br/><br/>**HTTP status code**: 400 |
| `RequestLimitExceeded` | The bandwidth exceeds the set quota.<br/><br/>**HTTP status code**: 400 |
| `ResourceNotFoundException` | The specified table doesn't exist or its state is different from 'ACTIVE'.<br/><br/>**HTTP status code**: 400 |
| `TransactionConflictException` | The operation is rejected as a different transaction is in progress for the item.<br/><br/>**HTTP status code**: 400 |

There may be [common errors](../common-errors) as well. These are errors that are common to all methods.