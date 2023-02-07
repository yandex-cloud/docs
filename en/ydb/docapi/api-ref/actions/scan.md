---
sourcePath: overlay/docapi/api-ref/actions/scan.md
---
# Scan method

Returns items and attributes from the specified table.

By default, all items are returned, but no more than 1 MB at a time or up to 100 entries. If there is more data in the table, the `LastEvaluatedKey` parameter returns the last primary key evaluated by the scan operation. You can use it to continue scanning.

Filters specified in the `FilterExpression` parameter only apply after the main selection.

By default, the method returns potentially consistent data from the table. To get strongly consistent data, set `ConsistentRead=true`.

## Request

The request contains data in JSON format.

```json
{
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
   "Limit": number,
   "ProjectionExpression": "string",
   "ReturnConsumedCapacity": "string",
   "ScanFilter": {
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
   "Select": "string",
   "TableName": "string"
}
```

### Parameters

| Parameter | Description |
| ----- | ----- |
| `TableName` | Name of the table with data.<br/>May contain a path in the directory hierarchy like path/to/table.<br/><br/>**Type**: String<br/>**Length**: 3 - 255 characters<br/>**Pattern**: [a-zA-Z0-9_.-]+<br/>**Required**: Yes |
| `ConsistentRead` | Defines the read consistency model.<br/>If `true`, strongly consistent reads are used. If `false` (default), sequential reads are used.<br/>This parameter isn't supported for global secondary indexes. If you try to scan a secondary index set to `true`, the method returns the `ValidationException`.<br/><br/>**Type**: Boolean<br/>**Required**: No |
| `ExclusiveStartKey` | Primary key of the item that the method starts searching from.<br/>If the method returned `LastEvaluatedKey` in response to the previous request, use this value to continue the search from the place where the method stopped last time.<br/><br/>**Type**: Object of the `AttributeValue` type<br/>**Key length**: Up to 65535 characters.<br/>**Required**: No |
| `ExpressionAttributeNames` | Placeholder that can be used in an expression instead of an attribute name. The placeholder must start with the hash character `#`.<br/> Possible use cases:<ul><li>If you need to specify an attribute whose name conflicts with the word reserved.<li>As a variable if the attribute name is used several times in an expression.<li>To prevent incorrect interpretation of special characters in the attribute name.</ul>For example, the name of the `Percentile` attribute is in conflict with a reserved word and cannot be explicitly used in an expression. To get around this problem, in the `ExpressionAttributeNames` parameter, specify the placeholder: `{"#P":"Percentile"}`. Then, instead of the real attribute name, use `#P`.<br/><br/>**Type**: String<br/>**Length**: 1 - 65535 characters.<br/>**Required**: No |
| `ExpressionAttributeValues` | Placeholder that can be used in an expression instead of an attribute value, similar to `ExpressionAttributeNames`. The placeholder must start with a colon `:`.<br/>For example, you need to check whether the value of the `ProductStatus` attribute was one of the following: `Available` \| `Backordered` \| `Discontinued`. To do this, first declare placeholders: `{ ":avail":{"S":"Available"}, ":back":{"S":"Backordered"}, ":disc":{"S":"Discontinued"} }`. After that, you can use them in the expression: `ProductStatus IN (:avail, :back, :disc)`<br/><br/>**Type**: String of the `AttributeValue` type<br/>**Required**: No |
| `FilterExpression` | Conditions to apply after the initial data selection.<br/>Items that don't meet this condition won't be included in the final response.<br/>**Type**: String<br/>**Required**: No |
| `IndexName` | The name of the global secondary index to scan. Note that if you use this parameter, you must also specify `TableName`.<br/>**Type**: String<br/>**Length**: 3 - 255 characters<br/>**Template**: [a-zA-Z0-9_.-]+<br/>**Required**: No |
| `Limit` | The maximum number of items to be evaluated for the selection.<br/> As soon as the method processes the specified number of items, it stops and returns the result to where it stopped. In this case, the `LastEvaluatedKey` parameter contains the last key that the method evaluated. You can use it to continue scanning from where the method stopped.<br/><br/>**Type**: Integer<br/>**Range**: 1 is the minimum value.<br/>**Required**: No |
| `ProjectionExpression` | Expression that defines attributes to retrieve. The attributes must be comma-separated.<br/>If the attribute names aren't specified explicitly, all item attributes are returned.<br/><br/>**Type**: String<br/>**Required**: No |
| `ReturnConsumedCapacity` | Indicates whether to return information about the consumed capacity.<ul><li>`TOTAL`: Return.<li>`NONE`: Do not return.</ul><br/>**Type**: String<br/>**Possible values**: `TOTAL` \| `NONE`<br/>**Required**: No |
| `Select` | Attributes to return.<br/>Possible values:<ul><li>`ALL_ATTRIBUTES` (default): Returns all attributes of an item from a table or index.<li>`COUNT`: returns only the number of matching attributes.</ul><br/>**Type**: String<br/>**Acceptable values**: `ALL_ATTRIBUTES` \| `COUNT`<br/>**Required**: No |

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

| Parameter | Description |
| ----- | ----- |
| `ConsumedCapacity` | Capacity units consumed by a delete operation.<br/>Returned only if the `ReturnConsumedCapacity` parameter set to `TOTAL` is specified in the request.<br/><br/>**Type**: Object of the `ConsumedCapacity` type. |
| `Count` | Count of items in a response.<br/>If you used `FilterExpression`, then it's equal to the number of items returned after applying the filter.<br/><br/>**Type**: Integer |
| `Items` | Array of attributes that match the scan criteria.<br/>Each item in the array consists of the name and value of this attribute.<br/><br/>**Type**: Array of objects of the `AttributeValue` type<br/>**Key length**: 1 - 65535 characters. |
| `LastEvaluatedKey` | Primary key of the item where the scan stopped. Use this value to continue from where you stopped. If the `LastEvaluatedKey` is empty, it means that the method processed all items and there is nothing more to return.<br/><br/>**Type**: Associative array of the `AttributeValue` type<br/>**Key length**: 1 - 65535 characters. |
| `ScannedCount` | Count of items found before using the `FilterExpression` filters.<br/><br/>**Type**: Integer |

## Errors

| Parameter | Description |
| ----- | ----- |
| `InternalServerError` | An internal error occurred on the server side.<br/><br/>**HTTP status code**: 500<br/> |
| `ProvisionedThroughputExceededException` | You're sending requests too often. Try to increase the interval between requests.<br/>If their number is not too large, {{ ydb-name }} tries to process them all.<br/><br/>**HTTP status code**: 400 |
| `RequestLimitExceeded` | The bandwidth exceeds the set quota.<br/><br/>**HTTP status code**: 400 |
| `ResourceNotFoundException` | The specified table doesn't exist.<br/><br/>**HTTP status code**: 400 |

There may be [common errors](../common-errors) as well. These are errors that are common to all methods.