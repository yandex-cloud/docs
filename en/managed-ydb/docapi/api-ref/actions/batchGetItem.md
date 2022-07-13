---
sourcePath: overlay/docapi/api-ref/actions/batchGetItem.md
---
# BatchGetItem method

Returns the attributes of one or more items from one or more tables. The requested items should be specified by primary key.

A single operation can return up to 16 MB of data with as many as 100 items. For example, if you request 100 items of 300 KB each, the method will only return 52 items so as not to exceed the 16 MB limit.
If a partial (incomplete) result is returned, the remaining items will be returned in the `UnprocessedKeys` parameter. You can use them to repeat the query.

If none of the items can be returned because there is not enough throughput, the method returns a `ProvisionedThroughputExceededException`. If at least one item is processed, the method is completed successfully and unprocessed keys are returned in the `UnprocessedKeys` parameter.

By default, the method performs sequential reads from each table. To use strongly consistent reads, set `ConsistentRead=true`.

## Request

The request contains data in JSON format.

```json
{
   "RequestItems": {
      "string" : {
         "AttributesToGet": [ "string" ],
         "ConsistentRead": boolean,
         "ExpressionAttributeNames": {
            "string" : "string"
         },
         "Keys": [
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
         "ProjectionExpression": "string"
      }
   },
   "ReturnConsumedCapacity": "string"
}
```

### Parameters

| Parameter | Description |
| ----- | ----- |
| `RequestItems` | An associative array with table names, where an associative array with items to extract is also specified for each table.<br/>Each item consists of:<ul><li>`ConsistentRead`: If `true`, strictly consistent reads are used. If `false` (by default), sequential reads are used.<br/><li> `ExpressionAttributeNames`: Placeholder that can be used in an expression instead of an attribute name. The placeholder must start with the hash character `#`.<br/>This can be useful in several cases:<ul><li>You need to specify an attribute whose name is in conflict with a reserved word.<li>As a variable if the attribute name is used several times in an expression.<li>To prevent incorrect interpretation of special characters in the attribute name.</ul>For example, the name of the `Percentile` attribute is in conflict with a reserved word and cannot be explicitly used in an expression. To get around this problem, in the `ExpressionAttributeNames` parameter, specify the placeholder: `{"#P":"Percentile"}`. And then, instead of the real attribute name, use `#P`.<li>`Keys`: An array of primary key attribute values to retrieve. For each primary key, specify all the key attributes. For a simple primary key, you only need to specify its value. For a composite primary key, specify values for both the partition key and the sort key.<li>`ProjectionExpression`: Attributes to retrieve. The attributes must be comma-separated.<br/>If the attribute names aren't specified explicitly, all item attributes are returned.</ul><br/>**Type**: String of the `KeysAndAttributes` type.<br/>**Number of entries**: Up to 100 items.<br/>**Key length**: 3-255 characters.<br/>**Pattern**: [a-zA-Z0-9_.-]+<br/>**Required**: Yes |
| `ReturnConsumedCapacity` | Indicates whether to return information about the consumed capacity.<ul><li>`TOTAL` — Return.<li>`NONE` — Do not return.</ul><br/>**Type**: String<br/>**Possible values**: `TOTAL` \| `NONE`<br/>**Required**: No |

## Response

If successful, HTTP code 200 is returned.
The response is returned in JSON format.

```json
{
   "ConsumedCapacity": [
      {
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
   ],
   "Responses": {
      "string" : [
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
      ]
   },
   "UnprocessedKeys": {
      "string" : {
         "AttributesToGet": [ "string" ],
         "ConsistentRead": boolean,
         "ExpressionAttributeNames": {
            "string" : "string"
         },
         "Keys": [
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
         "ProjectionExpression": "string"
      }
   }
}
```

### Parameters

| Parameter | Description |
| ----- | ----- |
| `ConsumedCapacity` | Consumed capacity units.<br/>Returned only if the `ReturnConsumedCapacity` parameter set to `TOTAL` is specified in the request.<br/>Consists of:<ul><li>`TableName`: Table that consumes the allocated bandwidth.<li>`CapacityUnits`: Total number of capacity units consumed.</ul><br/>**Type**: Array of objects of the `ConsumedCapacity` type. |
| `Responses` | An associative array of tables with retrieved items.<br/><br/>**Type**: Associative array of the `AttributeValue` type.<br/>**Key length**: 3 - 255 characters.<br/>**Pattern**: [a-zA-Z0-9_.-]+ |
| `UnprocessedKeys` | An associative array of tables with unprocessed items. The values are in the same form as they were set in `RequestItems`. You can reuse these values in a subsequent request.<br/>Each item consists of:<ul><li>`Keys`: An array of primary key attribute values.<li>`ProjectionExpression`: Retrieved attributes.<li>`ConsistentRead`: If `true`, strictly consistent reads are used. If `false` (by default), sequential reads are used.</ul>a-zA-Z0-9_.-+If there are no unprocessed items left, the response contains an empty `UnprocessedKeys`.<br/><br/>**Type**: Associative array of the `KeysAndAttributes` type.<br/>**Number of entries**: Up to 100 items.<br/>**Key length**: 3 - 255 characters.<br/>**Pattern**:[a-zA-Z0-9_.-]+ |

## Errors

| Parameter | Description |
| ----- | ----- |
| `InternalServerError` | An internal error occurred on the server side.<br/><br/>**HTTP status code**: 500 |
| `ProvisionedThroughputExceededException` | You're sending requests too often. Try to increase the interval between requests.<br/>If their number is not too large, {{ ydb-name }} tries to process them all.<br/><br/>**HTTP status code**: 400 |
| `RequestLimitExceeded` | The bandwidth exceeds the set quota.<br/><br/>**HTTP status code**: 400 |
| `ResourceNotFoundException` | The specified table doesn't exist.<br/><br/>**HTTP status code**: 400 |

There may be [common errors](../../common-errors.md) as well. These are errors that are common to all methods.