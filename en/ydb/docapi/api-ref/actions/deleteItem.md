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

| Parameter | Description |
| ----- | ----- |
| `Key` | An associative array of attribute names for `AttributeValue` objects, representing the primary key of the item to delete.<br/>For a simple primary key, you only need to specify its value.<br/>For a composite primary key, specify the value of a partition key and a sort key.<br/><br/>**Type**: String<br/>**Length**: 1 - 65535 characters.<br/>**Required**: Yes |
| `TableName` | Name of the table to delete the item from.</br>May contain a path in the directory hierarchy like path/to/table<br/><br/>**Type**: String<br/>**Length**: 3 - 255 characters<br/>**Pattern**: [a-zA-Z0-9_.-]+<br/>**Required**: Yes |
| `ConditionExpression` | Condition for deleting the item. The item is only deleted if the condition is met.<br/>The condition consists of:<ul><li>Functions: `attribute_exists | attribute_not_exists | attribute_type | contains | begins_with | size`. Names of the following are case-sensitive.<br/><li>Comparison operator: `= | <> | < | > | <= | >= | BETWEEN | IN`<br/><li>Logical operator: `AND | OR | NOT`</ul><br/>**Type**: String<br/>**Required**: No |
| `ExpressionAttributeNames` | Placeholder that can be used in an expression instead of an attribute name. The placeholder must start with the hash character `#`.<br/> Possible use cases:<ul><li>If you need to specify an attribute whose name conflicts with the word reserved.<li>As a variable if the attribute name is used in an expression multiple times.<li>To prevent the misinterpretation of special characters in the attribute name.</ul>For example, the attribute name `Percentile` conflicts with the reserved word and you can't use it in the expression explicitly. To get around this problem, in the `ExpressionAttributeNames` parameter, specify the placeholder: `{"#P":"Percentile"}`. Then, instead of the real attribute name, use `#P`.<br/><br/>**Type**: String<br/>**Length**: 1 - 65535 characters.<br/>**Required**: No |
| `ExpressionAttributeValues` | Placeholder that can be used in an expression instead of an attribute value, similar to `ExpressionAttributeNames`. The placeholder must start with a colon `:`.<br/>For example, you need to check whether the value of the `ProductStatus` attribute was one of the following: `Available | Backordered | Discontinued`. To do this, first declare placeholders: `{ ":avail":{"S":"Available"}, ":back":{"S":"Backordered"}, ":disc":{"S":"Discontinued"} }`. After that, you can use them in the expression: `ProductStatus IN (:avail, :back, :disc)`<br/><br/>**Type**: String of the `AttributeValue` type<br/>**Required**: No |
| `ReturnConsumedCapacity` | Indicates whether to return information about consumed capacity.<ul><li>`TOTAL`: Return.<li>`NONE`: Do not return.</ul><br/>**Type**: String<br/>**Possible values**: `TOTAL | NONE`<br/>**Required**: No |
| `ReturnValues` | Used if you want to get the attributes of the item to delete.<br/>Possible values:<ul><li>`ALL_OLD`: Return the contents of the deleted item<li>`NONE` (default): Do not return the contents of the deleted item</ul><br/>**Type**: String<br/>**Required**: No |

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
| `Attributes` | An associative array of the `AttributeValue` type containing the item's representation before it was deleted.<br/>Returned only if the request passed the `ReturnValues` parameter set to `ALL_OLD`.<br/><br/>**Type**: Associative array of the `AttributeValue` type<br/>**Length**: 1 - 65535 characters. |
| `ConsumedCapacity` | Units of capacity consumed by a delete operation.<br/>Returned only if the request passed the `ReturnConsumedCapacity` parameter set to `TOTAL`.<br/><br/>**Type**: Object type `ConsumedCapacity type` |

## Errors

| Parameter | Description |
| ----- | ----- | ----- |
| `ConditionalCheckFailedException` | Failed to evaluate the condition specified in the operation.<br/><br/>**HTTP status code**: 400 |
| `InternalServerError` | An internal error occurred on the server side.<br/><br/>**HTTP status code**: 500 |
| `ItemCollectionSizeLimitExceededException` | Item collection size limit exceeded. This exception is only returned for tables with one or more local secondary indexes.<br/><br/>**HTTP status code**: 400 |
| `ProvisionedThroughputExceededException` | You're sending requests too often. Try to increase the interval between requests.<br/>If their number is not too large, {{ ydb-name }} tries to process them all.<br/><br/>**HTTP status code**: 400 |
| `RequestLimitExceeded` | The bandwidth exceeds the set quota.<br/><br/>**HTTP status code**: 400 |
| `ResourceNotFoundException` | The specified table doesn't exist.<br/><br/>**HTTP status code**: 400 |
| `TransactionConflictException` | The operation is rejected as a different transaction is in progress for the item.<br/><br/>**HTTP status code**: 400 |

There may be [common errors](../common-errors) as well. These are errors that are common to all methods.

