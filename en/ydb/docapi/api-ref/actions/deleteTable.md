---
sourcePath: overlay/docapi/api-ref/actions/deleteTable.md
---
# DeleteTable method

Deletes a table with all its records. It also deletes table indexes.

You can only delete a table that is `ACTIVE`.

The method is asynchronous.
This means it changes a table status to `DELETING` and immediately returns the result. However, the table is actually being deleted in the background. If its status is already `DELETING`, the method will not return an error.
While the table has the `DELETING` status, {{ ydb-name }} may continue accepting data read and write requests, such as [GetItem](./getItem) and [PutItem](./putItem).

## Request

The request contains data in JSON format.

```json
{
   "TableName": "string"
}
```

### Parameters

Parameter | Description
----- | -----
`TableName` | Name of the table to delete.<br/>It may contain a path in the hierarchical directory structure in `path/to/table` format.<br/><br/>**Type**: String<br/>**Length**: 3 to 255 characters.<br/>**Template**: [a-zA-Z0-9_.-]+<br/>**Required**: Yes

## Response

If successful, HTTP code 200 is returned.
You will get data in JSON format.

```json
{
   "TableDescription": {
      "ArchivalSummary": {
         "ArchivalBackupArn": "string",
         "ArchivalDateTime": number,
         "ArchivalReason": "string"
      },
      "AttributeDefinitions": [
         {
            "AttributeName": "string",
            "AttributeType": "string"
         }
      ],
      "BillingModeSummary": {
         "BillingMode": "string",
         "LastUpdateToPayPerRequestDateTime": number
      },
      "CreationDateTime": number,
      "GlobalSecondaryIndexes": [
         {
            "Backfilling": boolean,
            "IndexArn": "string",
            "IndexName": "string",
            "IndexSizeBytes": number,
            "IndexStatus": "string",
            "ItemCount": number,
            "KeySchema": [
               {
                  "AttributeName": "string",
                  "KeyType": "string"
               }
            ],
            "Projection": {
               "NonKeyAttributes": [ "string" ],
               "ProjectionType": "string"
            },
            "ProvisionedThroughput": {
               "LastDecreaseDateTime": number,
               "LastIncreaseDateTime": number,
               "NumberOfDecreasesToday": number,
               "ReadCapacityUnits": number,
               "WriteCapacityUnits": number
            }
         }
      ],
      "GlobalTableVersion": "string",
      "ItemCount": number,
      "KeySchema": [
         {
            "AttributeName": "string",
            "KeyType": "string"
         }
      ],
      "LatestStreamArn": "string",
      "LatestStreamLabel": "string",
      "LocalSecondaryIndexes": [
         {
            "IndexArn": "string",
            "IndexName": "string",
            "IndexSizeBytes": number,
            "ItemCount": number,
            "KeySchema": [
               {
                  "AttributeName": "string",
                  "KeyType": "string"
               }
            ],
            "Projection": {
               "NonKeyAttributes": [ "string" ],
               "ProjectionType": "string"
            }
         }
      ],
      "ProvisionedThroughput": {
         "LastDecreaseDateTime": number,
         "LastIncreaseDateTime": number,
         "NumberOfDecreasesToday": number,
         "ReadCapacityUnits": number,
         "WriteCapacityUnits": number
      },
      "Replicas": [
         {
            "GlobalSecondaryIndexes": [
               {
                  "IndexName": "string",
                  "ProvisionedThroughputOverride": {
                     "ReadCapacityUnits": number
                  }
               }
            ],
            "KMSMainKeyId": "string",
            "ProvisionedThroughputOverride": {
               "ReadCapacityUnits": number
            },
            "RegionName": "string",
            "ReplicaStatus": "string",
            "ReplicaStatusDescription": "string",
            "ReplicaStatusPercentProgress": "string"
         }
      ],
      "RestoreSummary": {
         "RestoreDateTime": number,
         "RestoreInProgress": boolean,
         "SourceBackupArn": "string",
         "SourceTableArn": "string"
      },
      "SSEDescription": {
         "InaccessibleEncryptionDateTime": number,
         "KMSMainKeyArn": "string",
         "SSEType": "string",
         "Status": "string"
      },
      "StreamSpecification": {
         "StreamEnabled": boolean,
         "StreamViewType": "string"
      },
      "TableArn": "string",
      "TableId": "string",
      "TableName": "string",
      "TableSizeBytes": number,
      "TableStatus": "string"
   }
}
```

### Parameters

Parameter | Description
----- | -----
`TableDescription` | Properties of the deleted table.<br/><br/>**Type**: JSON object

## Errors

Parameter | Description
----- | -----
`InternalServerError` | An internal error occurred on the server side.<br/><br/>**HTTP status code**: 500<br/>
`LimitExceededException` | Table operations limit exceeded.<br/>You can concurrently perform up to 50 operations on tables, including `CreateTable`, `UpdateTable`, `DeleteTable`, `UpdateTimeToLive`, `RestoreTableFromBackup`, and `RestoreTableToPointInTime`.<br/><br/>**HTTP status code**: 400
`ResourceInUseException` | The table is in use and you cannot delete it now.<br/>This error occurs if a table is being created or its structure is being updated, i.e., the table status is `CREATING` or `UPDATING`, respectively.<br/><br/>**HTTP status code**: 400<br/>
`ResourceNotFoundException` | The requested table does not exist.<br/><br/>**HTTP status code**: 400<br/>

There may be some [common errors](../../common-errors.md) as well shared by all methods.