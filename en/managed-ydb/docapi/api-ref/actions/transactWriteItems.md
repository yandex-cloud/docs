---
sourcePath: overlay/docapi/api-ref/actions/transactWriteItems.md
---
# TransactWriteItems method

A synchronous write operation that groups up to 25 actions. You can work with items from different tables, but you can only perform one action on a single item per query.

The total size of all items may not exceed 4 MB.

The method is atomic, meaning that either all actions are performed or none. For reasons for rejection, see the [TransactionCanceledException](#errors) error description.

Allowed actions:
- `Put`: Write a new item.
- `Update`: Update an existing item.
- `Delete`: Delete an existing item.
- `ConditionCheck`: Condition for checking if an item exists or what state its attributes are in.

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

| Parameter | Description |
| ----- | ----- |
| `TransactItems` | An ordered array of `TransactWriteItem` objects, each of which contains a `Put`, `Update`, `Delete`, or `ConditionCheck` operation. You can work with items from different tables, but each item in a single query can only be used once.<br/><br/>**Type**: Array of `TransactWriteItem` objects<br/>**Array items**: 1-25.<br/>**Required**: Yes |
| `ClientRequestToken` | Not supported. Regardless of token values, all method calls are idempotent. This means that repeated method calls will have the same effect as a single call.<br/>Although the server state won't change, responses may be different. If the `ReturnConsumedCapacity` parameter is set, the first request returns the number of write capacity units. Subsequent requests with the same token return the number of read capacity units.<br/>The token is valid within 10 minutes of completing the first request. After that, any request with the same token is counted as new.<br/>If you send the same token but with different parameters for 10 minutes, the method returns the `IdempotentParameterMismatch` exception.<br/><br/>**Type**: String<br/>**Length**: 1-36 characters.<br/>**Required**: No |
| `ReturnConsumedCapacity` | Indicates whether to return information about the consumed capacity.<ul><li>`TOTAL`: Return.<li>`NONE`: Do not return.</ul><br/>**Type**: String<br/>**Possible values**: `TOTAL` \| `NONE`<br/>**Required**: No |

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
   ]
}
```

### Parameters

| Parameter | Description |
| ----- | ----- |
| `ConsumedCapacity` | Capacity units consumed by a delete operation.<br/>Returned only if the `ReturnConsumedCapacity` parameter set to `TOTAL` is specified in the request.<br/><br/>**Type**: Object of the `ConsumedCapacity` type. |

## Errors {#errors}

| Parameter | Description |
| ----- | ----- |
| `IdempotentParameterMismatchException` | Request rejected as containing an idempotent token with other parameters.<br/><br/>**HTTP status code**: 400 |
| `InternalServerError` | An internal error occurred on the server side.<br/><br/>**HTTP status code**: 500<br/> |
| `ProvisionedThroughputExceededException` | You're sending requests too often. Try to increase the interval between requests.<br/>If their number is not too large, {{ ydb-name }} tries to process them all.<br/><br/>**HTTP status code**: 400 |
| `RequestLimitExceeded` | The bandwidth exceeds the set quota.<br/><br/>**HTTP status code**: 400 |
| `ResourceNotFoundException` | The specified table doesn't exist.<br/><br/>**HTTP status code**: 400 |
| `TransactionCanceledException` | The entire request was canceled.<br/>This may happen in the following cases:<ul><li>A condition set in one of the expressions isn't met.<li>An attempt to perform multiple actions on a single item in a single request.<li>The allocated capacity is insufficient to complete the transaction.<li>The size of an individual item is too large (more than 400 KB). A similar error may also occur due to changes made by the transaction.<li>The total size of all items exceeds 4 MB.<li>A user error occurred, such as incorrect data format.</ul><br/>**HTTP status code**: 400 |
| `TransactionInProgressException` | The transaction with the specified request token is already in progress.<br/><br/>**HTTP status code**: 400 |

There may be [common errors](../common-errors) as well. These are errors that are common to all methods.