---
sourcePath: overlay/docapi/api-ref/actions/query.md
---
# Query method

Finds items based on the specified primary key values.

The `KeyConditionExpression` parameter sets the condition that defines partition key values for the items you select. To narrow the search, you can specify the sort key value and a comparison operator.

To further filter the results, use `FilterExpression`. This condition applies after the initial selection, but before the final results are returned. You cannot specify the attributes of a partition or sort key in this parameter. Instead, specify them in `KeyConditionExpression`.

The operation always returns a set of results. If no suitable items are found, this set will be empty. Empty queries consume minimum read capacity units for this type of reads.

Consumed capacity units are calculated based on the item size rather than the amount of data. Their number does not depend on the number of attributes you request.

Results are always sorted by sort key value. If a sort key has a numeric data type, results are returned in numeric order. Otherwise, they are sorted in UTF-8 byte order. 
The sorting order is set by the `ScanIndexForward` parameter.

Per call, the method reads a maximum of 1 MB of data or the number of items specified under `Limit`. Only then the filters specified in `FilterExpression` apply.

By default, the method performs sequential reads from the table. To use strongly consistent reads, set `ConsistentRead=true`.

## Request

The request contains data in JSON format.

```json
{
   "AttributesToGet": [ "string" ],
   "ConditionalOperator": "string",
   "ConsistentRead": boolean,
   "ExclusiveStartKey": {
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
   "FilterExpression": "string",
   "IndexName": "string",
   "KeyConditionExpression": "string",
   "KeyConditions": {
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
         "ComparisonOperator": "string"
      }
   },
   "Limit": number,
   "ProjectionExpression": "string",
   "QueryFilter": {
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
         "ComparisonOperator": "string"
      }
   },
   "ReturnConsumedCapacity": "string",
   "ScanIndexForward": boolean,
   "Select": "string",
   "TableName": "string"
}
```

### Parameters

Parameter | Description
----- | -----
`TableName` | Name of the table containing the requested items.<br/>It may contain a path in the hierarchical directory structure in `path/to/table` format.<br/><br/>**Type**: String<br/>**Length**: 3 to 255 characters.<br/>**Template**: [a-zA-Z0-9_.-]+<br/>**Required**: Yes
`ConsistentRead` | Consistency of data reads.<br/>`true` enables strongly consistent reads; `false` (by default) enables sequential reads.<br/>It is not supported for global secondary indexes. If you try to scan a secondary index set to `true`, the method will return `ValidationException`.<br/><br/>**Type**: Boolean<br/>**Required**: No
`ExclusiveStartKey` | Primary key of the item for the method to start a search from.<br/>If the method returned `LastEvaluatedKey` in response to the previous request, use this value to continue the search from the last evaluated key.<br/><br/>**Type**: Object of the `AttributeValue` type<br/>**Key length**: Up to 65,535.<br/>**Required**: No
`ExpressionAttributeNames` | Placeholder for an attribute name in an expression. The placeholder must start with the hash character, `#`.<br/> You can use it in the following cases:<ul><li>To specify an attribute whose name conflicts with a reserved word.<li>As a variable, if the attribute name is used multiple times in an expression.<li>To prevent incorrect interpretation of special characters in the attribute name.</ul>For example, the `Percentile` attribute name conflicts with the reserved word, so you cannot use it explicitly in an expression. To fix this issue, specify the `{"#P":"Percentile"}` placeholder in the `ExpressionAttributeNames` parameter, and then, further on, use `#P` instead of the real attribute name.<br/><br/>**Type**: String<br/>**Length**: 1 to 65,535 characters.<br/>**Required**: No
`ExpressionAttributeValues` | Placeholder for an attribute name in an expression, same as `ExpressionAttributeNames`. The placeholder must start with a colon, `:`.<br/>For example, you need to check whether the value of the `ProductStatus` attribute was one of the following: `Available` \| `Backordered` \| `Discontinued`. To do this, first declare placeholders: `{ ":avail":{"S":"Available"}, ":back":{"S":"Backordered"}, ":disc":{"S":"Discontinued"} }`. Now you can use them in the expression: `ProductStatus IN (:avail, :back, :disc)`<br/><br/>**Type**: String of the `AttributeValue` type<br/>**Required**: No
`FilterExpression` | Conditions to apply after the initial data selection.<br/>Items not meeting this condition will not be included in the final response.<br/>**Type**: String<br/>**Required**: No
`IndexName` | Name of the global secondary index to scan. Note that if you use this parameter, you must also specify `TableName`.<br/>**Type**: String<br/>**Length**: 3 to 255 characters.<br/>**Template**: [a-zA-Z0-9_.-]+<br/>**Required**: No
`KeyConditionExpression` | Condition that defines the key values for the items to select.<br/>The condition should perform an equality check for a single partition key value.<br/>Additionally, you can make a comparison for a single sort key value. This allows you to get the item with the specified partition key or sort key value, or multiple items that have the same the partition key value but different sort key values.<br/>Set the equality check in `partitionKeyName = :partitionkeyval` format.<br/>If you need to set a condition for the partition key, combine it with the condition for the sort key, for example: partitionKeyName = :partitionkeyval AND sortKeyName = :sortkeyval.<br/>Possible comparisons for the sort key condition:<ul><li>`sortKeyName = :sortkeyval`: True if the sort key value equals `:sortkeyval`.<li>`sortKeyName < :sortkeyval`: True if the sort key value is less than `:sortkeyval`.<li>`sortKeyName < :sortkeyval`: True if the sort key value is less than or equal to `:sortkeyval`.<li>`sortKeyName > :sortkeyval`: True if the sort key value is greater than `:sortkeyval`.<li>`sortKeyName >= :sortkeyval`: True if the sort key value is greater than or equal to `:sortkeyval`.<li>`sortKeyName BETWEEN :sortkeyval1 AND :sortkeyval2`: True if the sort key value is greater than or equal to `:sortkeyval` and less than or equal to `:sortkeyval2`.<li>`begins_with ( sortKeyName, :sortkeyval )`: True if the sort key value starts with a specific operand. You cannot use the function with a numeric sort key. The function name is case-sensitive.</ul><br/>**Type**: String<br/>**Required**: No
`Limit` | Maximum number of items to evaluate for the selection.<br/>As soon as the method processes the specified number of items, it will stop and return the result up to the last evaluated item. In this case, the `LastEvaluatedKey` parameter will contain the last key that the method evaluated. You can use it to continue scanning from the last evaluated key.<br/><br/>**Type**: Integer<br/>**Range**: Minimum value is 1.<br/>**Required**: No
`ProjectionExpression` | Expression that defines attributes to get. The attributes must be comma-separated.<br/>If you do not explicitly specify the attribute names, all item attributes will be returned.<br/><br/>**Type**: String<br/>**Required**: No
`ReturnConsumedCapacity` | Sets whether to return information about the consumed capacity.<ul><li>`TOTAL`: Return.<li>`NONE`: Do not return.</ul><br/>**Type**: String<br/>**Possible values**: `TOTAL` \| `NONE`<br/>**Required**: No
`ScanIndexForward` | Sets the order of index traversal.<ul><li>`true` (default): In ascending order<li>`false`: In descending order</ul><br/>**Type**: Boolean<br/>**Required**: No
`Select` | Attributes to return.<br/>Possible values:<ul><li>ALL_ATTRIBUTES (default): Returns all attributes of an item from a table or index.<li>COUNT: Returns only the number of matching attributes.</ul><br/>**Type**: String<br/>**Valid values**: `ALL_ATTRIBUTES` \| `COUNT`<br/>**Required**: No

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
   "Count": number,
   "Items": [
      {
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
   ],
   "LastEvaluatedKey": {
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
   "ScannedCount": number
}
```

### Parameters

Parameter | Description
----- | -----
`ConsumedCapacity` | Capacity units consumed by a delete operation.<br/>It is returned only if you provide `ReturnConsumedCapacity` set to `TOTAL` in the request.<br/><br/>**Type**: Object of the `ConsumedCapacity` type.
`Count` | Number of items in a response.<br/>If you used `FilterExpression` in your request, then it is the number of items returned after applying the filter.<br/><br/>**Type**: Integer
`Items` | Array of attributes that match the scan criteria.<br/>Each item in the array consists of the name and value of this attribute.<br/><br/>**Type**: Array of objects of the `AttributeValue` type<br/>**Key length**: 1 to 65,535 characters.
`LastEvaluatedKey` | Primary key of the last evaluated item. Use this value to continue scanning from the last evaluated key. Empty `LastEvaluatedKey` means that the method processed all items and there is nothing more to return.<br/><br/>**Type**: Associative array of the `AttributeValue` type<br/>**Key length**: 1 to 65,535 characters.
`ScannedCount` | Number of items found before using the `FilterExpression` filters.<br/><br/>**Type**: Integer

## Errors

Parameter | Description
----- | -----
`InternalServerError` | An internal error occurred on the server side.<br/><br/>**HTTP status code**: 500<br/>
`ProvisionedThroughputExceededException` | Your request rate is too high. Try to reduce the frequency of requests.<br/>If their number is not too large, {{ ydb-name }} will try to process them all.<br/><br/>**HTTP status code**: 400
`RequestLimitExceeded` | The throughput capacity exceeds the set quota.<br/><br/>**HTTP status code**: 400
`ResourceNotFoundException` | The requested table does not exist.<br/><br/>**HTTP status code**: 400

There may be some [common errors](../../common-errors.md) as well shared by all methods.