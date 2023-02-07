---
sourcePath: overlay/docapi/api-ref/actions/transactGetItems.md
---
# TransactGetItems method

A synchronous operation that atomically retrieves multiple items from tables.
The output is paginated. Up to 25 objects can be returned at a time, each of which contains a `Get` structure. You can retrieve up to 4 MB of data per transaction.

The method can be completely rejected with the reason described in the [TransactionCanceledException error message](#errors).

## Request

The request contains data in JSON format.

```json
{
   "ReturnConsumedCapacity": "string",
   "TransactItems": [
      {
         "Get": {
            "ExpressionAttributeNames": {
               "string" : "string"
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
            "ProjectionExpression": "string",
            "TableName": "string"
         }
      }
   ]
}
```

### Parameters

| Parameter | Description |
| ----- | ----- |
| `TransactItems` | An ordered array of objects of the `TransactGetItem` type, each of which contains a `Get` structure.<br/><br/>**Type**: Array of `TransactGetItem` objects<br/>**Array items**: 1-25.<br/>**Required**: Yes |
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
   "Responses": [
      {
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
   ]
}
```

### Parameters

| Parameter | Description |
| ----- | ----- |
| `ConsumedCapacity` | Capacity units consumed by a delete operation.<br/>Returned only if the `ReturnConsumedCapacity` parameter set to `TOTAL` is specified in the request.<br/><br/>**Type**: Object of the `ConsumedCapacity` type. |
| `Responses` | An ordered array of objects of the `ItemResponse` type.<br/>Each object contains an associative array of key/value pairs that are attributes of the requested item.<br/>If it isn't possible to get the item, the corresponding object's value is `Null`. If the item has no attributes, the corresponding object is empty.<br/><br/>**Type**: Array of `ItemResponse` objects<br/>**Array size**: 1-25 items. |

## Errors {#errors}

| Parameter | Description |
| ----- | ----- |
| `InternalServerError` | An internal error occurred on the server side.<br/><br/>**HTTP status code**: 500 |
| `ProvisionedThroughputExceededException` | You're sending requests too often. Try to increase the interval between requests.<br/>If their number is not too large, {{ ydb-name }} tries to process them all.<br/><br/>**HTTP status code**: 400 |
| `RequestLimitExceeded` | The bandwidth exceeds the set quota.<br/><br/>**HTTP status code**: 400 |
| `ResourceNotFoundException` | The specified table doesn't exist.<br/><br/>**HTTP status code**: 400 |
| `TransactionCanceledException` | The entire request was canceled. This may happen in the following cases:<ul><li>Another `TransactGetItems` operation is in progress and is in conflict with a concurrent `PutItem`, `UpdateItem`, `DeleteItem`, or `TransactWriteItems` request.<li>The allocated capacity is insufficient to complete the transaction.<li>A user error occurred, such as incorrect data format.</ul><br/><br/>**HTTP status code**: 400 |

There may be [common errors](../../common-errors.md) as well. These are errors that are common to all methods.