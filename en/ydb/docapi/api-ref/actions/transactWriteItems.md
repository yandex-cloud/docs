---
sourcePath: overlay/docapi/api-ref/actions/transactWriteItems.md
---
# TransactWriteItems method

Performs a synchronous write operation that groups up to 25 actions. You can work with items from different tables, but you can only perform one action on a single item per request.

The total size of all items may not exceed 4 MB.

The method is atomic, i.e., either all actions succeed or all of them fail. For rejection reasons, see the [TransactionCanceledException error](#errors) description.

You can perform the following actions:
- `Put`: Write a new item.
- `Update`: Update an existing item.
- `Delete`: Delete an existing item.
- `ConditionCheck`: Condition for checking if an item exists or the state of its attributes.

## Request

The request contains data in JSON format.

```json
{
   "ReturnConsumedCapacity": "string",
   "TransactItems": [
      {
         "ConditionCheck": {
            "ConditionExpression": "string",
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
            "ReturnValuesOnConditionCheckFailure": "string",
            "TableName": "string"
         },
         "Delete": {
            "ConditionExpression": "string",
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
            "ReturnValuesOnConditionCheckFailure": "string",
            "TableName": "string"
         },
         "Put": {
            "ConditionExpression": "string",
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
            },
            "ReturnValuesOnConditionCheckFailure": "string",
            "TableName": "string"
         },
         "Update": {
            "ConditionExpression": "string",
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
            "ReturnValuesOnConditionCheckFailure": "string",
            "TableName": "string",
            "UpdateExpression": "string"
         }
      }
   ]
}
```

### Parameters

Parameter | Description
----- | -----
`TransactItems` | Ordered array of objects of the `TransactWriteItem` type, each of which contains a `Put`, `Update`, `Delete`, or `ConditionCheck` operation. You can work with items from different tables, but you can only use each item in a single request once.<br/><br/>**Type**: Array of `TransactWriteItem` objects<br/>**Array items**: 1 to 25 items.<br/>**Required**: Yes
`ClientRequestToken` | This parameter is not supported. Regardless of token values, all method calls are idempotent. This means that repeated method calls will have the same effect as a single call.<br/>Although the server state will not change, responses may be different. If the `ReturnConsumedCapacity` parameter is set, the first request will return the number of write capacity units. Subsequent requests with the same token will return the number of read capacity units.<br/>The token is valid within 10 minutes of completing the first request. After that, any request with the same token is considered new.<br/>If you send the same token but with different parameters within 10 minutes, the method will return the `IdempotentParameterMismatch` exception.<br/><br/>**Type**: String<br/>**Length**: 1 to 36 characters.<br/>**Required**: No
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
   ]
}
```

### Parameters

Parameter | Description
----- | -----
`ConsumedCapacity` | Capacity units consumed by a delete operation.<br/>It is returned only if you provide `ReturnConsumedCapacity` set to `TOTAL` in the request.<br/><br/>**Type**: Object of the `ConsumedCapacity` type.

## Errors {#errors}

Parameter | Description
----- | -----
`IdempotentParameterMismatchException` | Request rejected as containing an idempotent token with different parameters.<br/><br/>**HTTP status code**: 400
`InternalServerError` | An internal error occurred on the server side.<br/><br/>**HTTP status code**: 500<br/>
`ProvisionedThroughputExceededException` | Your request rate is too high. Try to reduce the frequency of requests.<br/>If their number is not too large, {{ ydb-name }} will try to process them all.<br/><br/>**HTTP status code**: 400
`RequestLimitExceeded` | The throughput capacity exceeds the set quota.<br/><br/>**HTTP status code**: 400
`ResourceNotFoundException` | The requested table does not exist.<br/><br/>**HTTP status code**: 400
`TransactionCanceledException` | The entire request was canceled.<br/>This may happen in the following cases:<ul><li>A condition set in one of the expressions is not met.<li>Multiple actions in a single request target the same item.<li>The provisioned capacity is insufficient to complete the transaction.<li>The size of an individual item is too large (more than 400 KB). A similar error may also occur because of changes made by the transaction.<li>The total size of all items exceeds 4 MB.<li>A user error occurred, such as invalid data format.</ul><br/>**HTTP status code**: 400
`TransactionInProgressException` | There is an ongoing transaction with the specified request token.<br/><br/>**HTTP status code**: 400

There may be some [common errors](../../common-errors.md) as well shared by all methods.
