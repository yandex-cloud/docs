---
sourcePath: overlay/docapi/api-ref/actions/updateItem.md
---
# UpdateItem method

Updates the attributes of an existing item or adds a new item if it does not exist. You can update, delete, or add attribute values. 

You can set an update condition. The method will then be triggered only if the condition is met.

It may return the attribute values as they were before or after the update.

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

Parameter | Description
----- | -----
`Key` | Primary key of the item to update; specify all the key attributes. For a simple primary key, you only need to specify its value. For a composite primary key, specify values for both the partition key and the sort key.<br/><br/>**Type**: Associative array of the `AttributeValue` type.<br/>**Length**: 1 to 65,535 characters.<br/>**Required**: Yes
`TableName` | Name of the table with the item to update.</br>It may contain a path in the hierarchical directory structure in `path/to/table` format.<br/><br/>**Type**: String<br/>**Length**: 3 to 255 characters.<br/>**Template**: [a-zA-Z0-9_.-]+<br/>**Required**: Yes
`ConditionExpression` | Condition for updating the item. The method will be triggered only if the condition is met.<br/>The condition consists of:<ul><li>Functions: `attribute_exists` \| `attribute_not_exists` \| `attribute_type` \| `contains` \| `begins_with` \| `size`. Names are case-sensitive.<li>Comparison operators: `=` \| `<>` \| `<` \| `>` \| `<=` \| `>=` \| `BETWEEN` \| `IN`.<li>Logical operators: `AND` \| `OR` \| `NOT`.</ul><br/>**Type**: String<br/>**Required**: No
`ExpressionAttributeNames` | Placeholder for an attribute name in an expression. The placeholder must start with the hash character, `#`.<br/> You can use it in the following cases:<ul><li>To specify an attribute whose name conflicts with a reserved word.<li>As a variable, if the attribute name is used multiple times in an expression.<li>To prevent incorrect interpretation of special characters in the attribute name.</ul>For example, the `Percentile` attribute name conflicts with the reserved word, so you cannot use it explicitly in an expression. To fix this issue, specify the `{"#P":"Percentile"}` placeholder in the `ExpressionAttributeNames` parameter, and then, further on, use `#P` instead of the real attribute name.<br/><br/>**Type**: String<br/>**Length**: 1 to 65,535 characters.<br/>**Required**: No
`ExpressionAttributeValues` | Placeholder for an attribute name in an expression, same as `ExpressionAttributeNames`. The placeholder must start with a colon, `:`.<br/>For example, you need to check whether the value of the `ProductStatus` attribute was one of the following: `Available` \| `Backordered` \| `Discontinued`. To do this, first declare placeholders: `{ ":avail":{"S":"Available"}, ":back":{"S":"Backordered"}, ":disc":{"S":"Discontinued"} }`. Now you can use them in the expression: `ProductStatus IN (:avail, :back, :disc)`<br/><br/>**Type**: String of the `AttributeValue` type<br/>**Required**: No
`ReturnConsumedCapacity` | Sets whether to return information about the consumed capacity.<ul><li>`TOTAL`: Return.<li>`NONE`: Do not return.</ul><br/>**Type**: String<br/>**Possible values**: `TOTAL` \| `NONE`<br/>**Required**: No
`ReturnValues` | Use it if you need to get the attributes of an item before or after its update.<br/>Possible values:<ul><li>`NONE` (default): Do not return item attributes.<li>`ALL_OLD`: Return all attributes as they were before the item update.<li>`UPDATED_OLD`: Only return the updated attributes as they were before the update.<li>`ALL_NEW`: Return all attributes as they will be after the update.<li>`UPDATED_NEW`: Only return the updated attributes as they will be after the update.</ul>No read capacity units are used in this case.<br/>Return values are strongly consistent.<br/><br/>**Type**: String<br/>**Possible values**:`NONE` \| `ALL_OLD` \| `UPDATED_OLD` \| `ALL_NEW` \| `UPDATED_NEW`<br/>**Required**: No
`UpdateExpression` | Expression to update. It specifies the attributes to update and how to do it.<br/>Possible actions:<ul><li>`SET`: Sets the attribute to the specified value. If no attribute exists, it will be created.<br/>Supported functions:<ul><li>`if_not_exists (path, operand)`: Checks that the specified attribute does not exist. If no attribute is found at the specified `path`, the function will evaluate to the specified operand.<li>`list_append (operand, operand)`: Evaluates to a list with a new item added to it. You can append the new item to the start or the end of the list by reversing the order of the operands.</ul>Function names are case-sensitive.<li>`REMOVE`: Removes attributes.<li>`ADD`: Adds the value to the attribute. <br/>If the attribute exists, the ADD function behavior depends on the data type of the attribute:<ul><li>If it is a **number**, the add operation is performed and the attribute value is added to the specified value. If the attribute or value does not exist before the update, then `0` is used as the initial value for the add operation.<li>If the attribute is a **set**, the specified value is added to the set. Both sets (that in the attribute value and the one specified) must have the same data type.</ul><li>`DELETE`: Deletes the item from the set. You can only use it for sets and top-level attributes. You cannot delete nested attributes.<br/>You can specify multiple items at a time.</ul>A single expression may contain multiple actions, e.g., `SET a=:value1, b=:value2 DELETE :value3, :value4, :value5`<br/><br/>**Type**: String<br/>**Required**: No

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
`Attributes` | Associative array of the `AttributeValue` type containing the item representation before or after its update.<br/>It is returned only if you provide `ReturnValues` set to ≠ `NONE` in the request.<br/><br/>**Type**: Associative array of the `AttributeValue` type.<br/>**Length**: 1 to 65,535 characters.
`ConsumedCapacity` | Capacity units consumed by a delete operation.<br/>It is returned only if you provide `ReturnConsumedCapacity` set to `TOTAL` in the request.<br/><br/>**Type**: Object of the `ConsumedCapacity` type.

## Errors

Parameter | Description
----- | -----
`ConditionalCheckFailedException` | Cannot check the condition specified in the operation.<br/><br/>**HTTP status code**: 400
`InternalServerError` | An internal error occurred on the server side.<br/><br/>**HTTP status code**: 500
`ProvisionedThroughputExceededException` | Your request rate is too high. Try to reduce the frequency of requests.<br/>If their number is not too large, {{ ydb-name }} will try to process them all.<br/><br/>**HTTP status code**: 400
`RequestLimitExceeded` | The throughput capacity exceeds the set quota.<br/><br/>**HTTP status code**: 400
`ResourceNotFoundException` | The specified table does not exist or its state is different from 'ACTIVE'.<br/><br/>**HTTP status code**: 400
`TransactionConflictException` | The operation is rejected because there is an ongoing transaction for the item.<br/><br/>**HTTP status code**: 400

There may be some [common errors](../../common-errors.md) as well shared by all methods.