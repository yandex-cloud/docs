---
sourcePath: overlay/docapi/api-ref/actions/transactGetItems.md
---
# TransactGetItems method

Performs a synchronous operation that atomically retrieves multiple items from tables. 
The output is paginated. You can get up to 25 objects, each containing the `Get` structure, per method call. You can retrieve up to 4 MB of data per method call.

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

Parameter | Description
----- | -----
`TransactItems` | Ordered array of objects of the `TransactGetItem` type, each of which contains the `Get` structure.<br/><br/>**Type**: Array of `TransactGetItem` objects<br/>**Array items**: 1 to 25 items.<br/>**Required**: Yes
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

Parameter | Description
----- | -----
`ConsumedCapacity` | Capacity units consumed by a delete operation.<br/>It is returned only if you provide `ReturnConsumedCapacity` set to `TOTAL` in the request.<br/><br/>**Type**: Object of the `ConsumedCapacity` type.
`Responses` | Ordered array of objects of the `ItemResponse` type.<br/>Each object contains an associative array of key/value pairs that are attributes of the requested item.<br/>If it is not possible to get the item, the matching object's value is `Null`. If the item has no attributes, the matching object is empty.<br/><br/>**Type**: Array of `ItemResponse`<br/>**Array size**: 1 to 25 items.

## Errors {#errors}

Parameter | Description
----- | -----
`InternalServerError` | An internal error occurred on the server side.<br/><br/>**HTTP status code**: 500
`ProvisionedThroughputExceededException` | Your request rate is too high. Try to reduce the frequency of requests.<br/>If their number is not too large, {{ ydb-name }} will try to process them all.<br/><br/>**HTTP status code**: 400
`RequestLimitExceeded` | The throughput capacity exceeds the set quota.<br/><br/>**HTTP status code**: 400
`ResourceNotFoundException` | The requested table does not exist.<br/><br/>**HTTP status code**: 400
`TransactionCanceledException` | The entire request was canceled. This may happen in the following cases:<ul><li>There is another ongoing `TransactGetItems` operation that conflicts with a concurrent `PutItem`, `UpdateItem`, `DeleteItem`, or `TransactWriteItems` request.<li>The provisioned capacity is insufficient to complete the transaction.<li>A user error occurred, such as invalid data format.</ul><br/><br/>**HTTP status code**: 400

There may be some [common errors](../../common-errors.md) as well shared by all methods.