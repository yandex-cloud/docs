---
sourcePath: overlay/docapi/api-ref/actions/batchWriteItem.md
---
# BatchWriteItem method

Writes items to or deletes them from tables.
A single call can write up to 16 MB of data, including up to 25 put or delete requests. Each item can be up to 400 KB in size.

`BatchWriteItem` can't update items. To do this, use the [UpdateItem](./updateItem) method.

The individual `PutItem` and `DeleteItem` operations used in `BatchWriteItem` are atomic. However, the method as a whole is not.

If none of the items can be processed because there is not enough throughput, the method returns a `ProvisionedThroughputExceededException`. If at least one item is processed, the action is successful and the unprocessed items are returned in the `UnprocessedItems` parameter.

The entire batch write operation can be rejected:
- A table specified in the request doesn't exist.
- Primary key attributes specified in the request don't match those in the table's primary key schema.
- You try to perform multiple operations on the same item in the same request.
- Your request contains at least two items with identical hash and range keys.
- There are more than 25 requests in the batch.
- Any individual batch item exceeds 400 KB.
- The total request size exceeds 16 MB.

## Request

The request contains data in JSON format.

```json
{
   "RequestItems": {
      "string" : [
         {
            "DeleteRequest": {
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
               }
            },
            "PutRequest": {
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
         }
      ]
   },
   "ReturnConsumedCapacity": "string"
}
```

### Parameters

| Parameter | Description |
| ----- | ----- |
| `RequestItems` | An associative array of tables and related requests to perform.<br/> Each item consists of a table name and a list of operations to perform (`DeleteRequest` or `PutRequest`).<ul> <li>`DeleteRequest`: Perform a `DeleteItem` operation on the specified item. The item to delete is identified by the `Key` parameter and nested element:<ul><li>`Key`: An associative array of primary key attributes that uniquely identify the item. Each entry consists of an attribute name and attribute value.<br/>For each primary key, specify all the key attributes. For a simple primary key, you only need to specify its value. For a composite primary key, specify values for both the partition key and the sort key.</ul><li>`PutRequest`: Perform a `PutItem` operation on the specified item. The item to be put is identified by the `Item` parameter and nested element:<ul><li>`Item`: An associative array of attributes and their values. Each entry consists of an attribute name and attribute value. Attribute values must not be null. String and binary type attributes must have lengths greater than zero. Set type attributes must not be empty. Requests containing empty values are rejected with a `ValidationException` exception.<br/></ul>**Type**: Associative array of the `WriteRequest` type.<br/>**Number of entries**: Up to 25 items.<br/>**Key length**: 3-255 characters.<br/>**Pattern**: [a-zA-Z0-9_.-]+<br/>**Array size**: 1-25 items.<br/>**Required**: Yes |
| `ReturnConsumedCapacity` | Indicates whether to return information about the consumed capacity.<ul><li>`TOTAL`: Return.<li>`NONE`: Do not return.</ul><br/>**Type**: String<br/>**Possible values**: `TOTAL` \| `NONE`<br/>**Required**: No |

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
   "UnprocessedItems": {
      "string" : [
         {
            "DeleteRequest": {
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
               }
            },
            "PutRequest": {
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
         }
      ]
   }
}
```

### Parameters

| Parameter | Description |
| ----- | ----- |
| `ConsumedCapacity` | Consumed capacity units.<br/>Returned only if the `ReturnConsumedCapacity` parameter set to `TOTAL` is specified in the request.<br/>Consists of:<ul><li>`TableName`: Table that consumes the allocated bandwidth.<li>`CapacityUnits`: Total number of capacity units consumed.</ul><br/>**Type**: Array of objects of the `ConsumedCapacity` type. |
| `UnprocessedItems` | An associative array of tables and related requests that were not processed. The values are in the same form as they were set in `RequestItems`. You can reuse these values in a subsequent request.<br/>If there are no unprocessed items left, the response contains an empty `UnprocessedItems`.<br/><br/>**Type**: Associative array of the `WriteRequest` type.<br/>**Number of entries**: Up to 25 items.<br/>**Key length**: 3-255 characters.<br/>**Pattern**: [a-zA-Z0-9_.-]+<br/>**Array size**: 1-25 items. |

## Errors

| Parameter | Description |
| ----- | ----- |
| `InternalServerError` | An internal error occurred on the server side.<br/><br/>**HTTP status code**: 500<br/> |
| `ProvisionedThroughputExceededException` | You're sending requests too often. Try to increase the interval between requests.<br/>If their number is not too large, {{ ydb-name }} tries to process them all.<br/><br/>**HTTP status code**: 400 |
| `RequestLimitExceeded` | The bandwidth exceeds the set quota.<br/><br/>**HTTP status code**: 400 |
| `ResourceNotFoundException` | The specified table doesn't exist.<br/><br/>**HTTP status code**: 400 |

There may be [common errors](../../common-errors) as well. These are errors that are common to all methods.
