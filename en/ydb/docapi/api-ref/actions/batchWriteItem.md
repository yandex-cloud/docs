---
sourcePath: overlay/docapi/api-ref/actions/batchWriteItem.md
---
# BatchWriteItem method

Writes items to or deletes them from tables.
With a single call, you can write up to 16 MB of data, including up to 25 put or delete requests. Each item can be up to 400 KB in size.

The `BatchWriteItem` method cannot update items. Use [UpdateItem](./updateItem) instead.

Separate `PutItem` and `DeleteItem` operations within `BatchWriteItem` are atomic. However, the method as a whole is not atomic.

If none of the items is processed because there is not enough throughput, the method will return the `ProvisionedThroughputExceededException` error. If at least one item is processed, the method will complete successfully, while the unprocessed items will be returned under `UnprocessedItems`.

An entire batch write operation may be rejected in the following cases:
- The table you provided in the request does not exist.
- Primary key attributes specified in the request do not match those in the table's primary key schema.
- You try to perform multiple operations with the same item within the same request.
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

Parameter | Description
----- | -----
`RequestItems` | Associative array of tables and table requests to run.<br/> Each item consists of a table name and a list of operations to run (`DeleteRequest` or `PutRequest`).<ul> <li>`DeleteRequest`: Perform a `DeleteItem` operation with the specified item. The item to delete is identified by the `Key` parameter and nested item:<ul><li>`Key`: Associative array of primary key attribute values that uniquely identify the item. Each record consists of an attribute name and attribute value.<br/>For each primary key, specify all the key attributes. For a simple primary key, you only need to specify its value. For a composite primary key, specify values for both the partition key and the sort key.</ul><li>`PutRequest`: Perform a `PutItem` operation with the specified item. The item to put is identified by the `Item` parameter and nested item:<ul><li>`Item`: Associative array of attributes and their values. Each record consists of an attribute name and attribute value. Attribute values must not be null. String and binary type attributes must be greater than zero in length. Set type attributes must not be empty. Requests containing empty values are rejected with `ValidationException`.<br/></ul>**Type**: Associative array of the `WriteRequest` type.<br/>**Number of records**: Up to 25 items.<br/>**Key length**: 3 to 255 characters.<br/>**Template**: [a-zA-Z0-9_.-]+<br/>**Array size**: 1 to 25 items.<br/>**Required**: Yes
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

Parameter | Description
----- | -----
`ConsumedCapacity` | Consumed capacity units.<br/>It is returned only if you provide `ReturnConsumedCapacity` set to `TOTAL` in the request.<br/>It consists of:<ul><li>`TableName`: Table that consumes the provisioned throughput capacity.<li>`CapacityUnits`: Total number of capacity units consumed.</ul><br/>**Type**: Array of `ConsumedCapacity` objects
`UnprocessedItems` | Associative array of tables and unprocessed table requests. The values have the format you set in the `RequestItems` parameter. You can reuse these values in a subsequent request.<br/>If there are no unprocessed items left, the `UnprocessedItems` response parameter will be empty.<br/><br/>**Type**: Associative array of the `WriteRequest` type.<br/>**Number of records**: Up to 25 items.<br/>**Key length**: 3 to 255 characters.<br/>**Template**: [a-zA-Z0-9_.-]+<br/>**Array size**: 1 to 25 items.

## Errors

Parameter | Description
----- | -----
`InternalServerError` | An internal error occurred on the server side.<br/><br/>**HTTP status code**: 500<br/>
`ProvisionedThroughputExceededException` | Your request rate is too high. Try to reduce the frequency of requests.<br/>If their number is not too large, {{ ydb-name }} will try to process them all.<br/><br/>**HTTP status code**: 400
`RequestLimitExceeded` | The throughput capacity exceeds the set quota.<br/><br/>**HTTP status code**: 400
`ResourceNotFoundException` | The requested table does not exist.<br/><br/>**HTTP status code**: 400

There may be some [common errors](../../common-errors.md) as well shared by all methods.