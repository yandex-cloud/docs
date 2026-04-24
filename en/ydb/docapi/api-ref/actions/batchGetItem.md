---
sourcePath: overlay/docapi/api-ref/actions/batchGetItem.md
---
# BatchGetItem method

Returns the attributes of one or multiple items from one or multiple tables. Specify the items by primary key in your request.

You may get up to 16 MB of data with as many as 100 items in a single response. For example, if you request 100 items of 300 KB each, you will only get 52 items to stay within the 16 MB limit.
If you get a partial (incomplete) result, the remaining items will be returned under `UnprocessedKeys`. You can use them to repeat the request.
If you do not get any items because there is not enough throughput, the method will return the `ProvisionedThroughputExceededException` error. If at least one item is processed, the method will complete successfully, while unprocessed keys will be returned under `UnprocessedKeys`.

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

Parameter | Description
----- | -----
`RequestItems` | Associative array of table names, where an associative array of items to retrieve is also specified for each table.<br/>Each item consists of:<ul><li>`ConsistentRead`: `true` enables strongly consistent reads; `false` (by default) enables sequential reads.<br/><li> `ExpressionAttributeNames`: Placeholder for an attribute name in an expression. The placeholder must start with the hash character, `#`.<br/>You can use it in the following cases:<ul><li>To specify an attribute whose name conflicts with a reserved word.<li>As a variable, if the attribute name is used multiple times in an expression.<li>To prevent incorrect interpretation of special characters in the attribute name.</ul>For example, the `Percentile` attribute name conflicts with the reserved word, so you cannot use it explicitly in an expression. To fix this issue, specify the `{"#P":"Percentile"}` placeholder in the `ExpressionAttributeNames` parameter, and then, further on, use `#P` instead of the real attribute name.<li>`Keys`: Array of primary key attribute values to retrieve. For each primary key, specify all the key attributes. For a simple primary key, you only need to specify its value. For a composite primary key, specify values for both the partition key and the sort key.<li>`ProjectionExpression`: Attributes to retrieve. List the attributes separated with commas.<br/>If you do not explicitly specify the attribute names, all item attributes will be returned.</ul><br/>**Type**: String of the `KeysAndAttributes` type<br/>**Number of records** type: Up to 100 items.<br/>**Key length**: 3 to 255 characters.<br/>**Template**: [a-zA-Z0-9_.-]+<br/>**Required**: Yes
`ReturnConsumedCapacity` | Sets whether to return information about the consumed capacity.<ul><li>`TOTAL`: Return.<li>`NONE`: Do not return.</ul><br/>**Type**: String<br/>**Possible values**: `TOTAL` \| `NONE`<br/>**Required**: No

## Response

If successful, HTTP code 200 is returned.
You will get data in JSON format.

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

Parameter | Description
----- | -----
`ConsumedCapacity` | Consumed capacity units.<br/>It is returned only if you provide `ReturnConsumedCapacity` set to `TOTAL` in the request.<br/>It consists of:<ul><li>`TableName`: Table that consumes the provisioned throughput capacity.<li>`CapacityUnits`: Total number of capacity units consumed.</ul><br/>**Type**: Array of `ConsumedCapacity` objects
`Responses` | Associative array of tables with retrieved items.<br/><br/>**Type**: Associative array of the `AttributeValue` type.<br/>**Key length**: 3 to 255 characters.<br/>**Template**: [a-zA-Z0-9_.-]+
`UnprocessedKeys` | Associative array of tables with unprocessed items. The values have the format you set in the `RequestItems` parameter. You can reuse these values in a subsequent request.<br/>Each item consists of:<ul><li>`Keys`: Array of primary key attribute values.<li>`ProjectionExpression`: Attributes you retrieved.<li>`ConsistentRead`: `true` enables strongly consistent reads; `false` (by default) enables sequential reads.</ul>If there are no unprocessed items left, the `UnprocessedKeys` response parameter will be empty.<br/><br/>**Type**: Associative array of the `KeysAndAttributes` type.<br/>**Number of records**: Up to 100 items.<br/>**Key length**: 3 to 255 characters.<br/>**Template**: [a-zA-Z0-9_.-]+

## Errors

Parameter | Description
----- | -----
`InternalServerError` | An internal error occurred on the server side.<br/><br/>**HTTP status code**: 500
`ProvisionedThroughputExceededException` | Your request rate is too high. Try to reduce the frequency of requests.<br/>If their number is not too large, {{ ydb-name }} will try to process them all.<br/><br/>**HTTP status code**: 400
`RequestLimitExceeded` | The throughput capacity exceeds the set quota.<br/><br/>**HTTP status code**: 400
`ResourceNotFoundException` | The requested table does not exist.<br/><br/>**HTTP status code**: 400

There may be some [common errors](../../common-errors.md) as well shared by all methods.