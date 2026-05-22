---
sourcePath: overlay/docapi/api-ref/actions/updateTable.md
---
# UpdateTable method

Updates global secondary indexes and change data capture settings for a specified table.

You can only perform one of the following operations per request:
- Add a global secondary index to the table.
- Delete a global secondary index from the table.
- Enable/disable change data capture.

## Request

The request contains data in JSON format.

```json
{
   "AttributeDefinitions": [
      {
         "AttributeName": "string",
         "AttributeType": "string"
      }
   ],
   "BillingMode": "string",
   "GlobalSecondaryIndexUpdates": [
      {
         "Create": {
            "IndexName": "string",
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
         },
         "Delete": {
            "IndexName": "string"
         }
      }
   ],
   "StreamSpecification": {
      "StreamEnabled": boolean,
      "StreamViewType": "string"
   },
   "TableName": "string"
}
```

### Parameters


Parameter | Description
----- | -----
`TableName` | Name of the table to update.<br/>It may contain a path in the hierarchical directory structure in `path/to/table` format.<br/><br/>**Type**: String<br/>**Length**: 3 to 255 characters.<br/>**Template**: [a-zA-Z0-9_.-]+<br/>**Required**: Yes
`AttributeDefinitions` | Array of attributes describing the key schema for the table and indexes.<br/><br/>**Type**: Array of `AttributeDefinition` objects.<br/>**Required**: No
`GlobalSecondaryIndexUpdates` | Array of operations describing actions on global secondary indexes: <ul><li>`Create` adds a global secondary index to the table.<br>**Type**: Array of `GlobalSecondaryIndexUpdate` objects.<br>**Required**: No </li> <li>`Delete` deletes a global secondary index from the table.</li></ul>You can only add or delete one index per request.<br>When creating an index, specify the following parameters:<ul><li>`IndexName`: It must be unique and at least three characters long. This is a required parameter.</li><li>`KeySchema`: Attributes that make up the index primary key.</li><li>`Projection`: Specifies attributes copied from the table into the index. Currently, the only supported `ProjectionType` is `ALL`.</li><li>`NonKeyAttributes`: List of one or multiple non-key attribute names that are projected to the secondary index.</li><br/>**Required**: No</ul><br>When deleting a table, you can specify just `IndexName`.
`StreamSpecification` | Description of the change data feed settings for a table:<br/><ul><li>`StreamEnabled` defines whether change data capture for the table is enabled.</li><li>`StreamViewType` defines the CDC type:<ul><li>`KEYS_ONLY`: Only the primary key components and the change flag are written.</li><li>`NEW_IMAGE`: Any column values resulting from changes are written.</li><li>`OLD_IMAGE`: Any column values before changes are written.</li><li>`NEW_AND_OLD_IMAGES`: Combination of the *NEW_IMAGE* and *OLD_IMAGE* modes. Writes the values of all columns before and after the update.</li></ul></li><br/>**Type**: Object of the `StreamSpecification` type.<br/>**Required**: No

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
      "Replicas": [
         {             
            "KMSMainKeyId": "string",
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
`TableDescription` | Properties of the created table.<br/><br/>**Type**: `TableDescription` type object.

## Errors

Parameter | Description
----- | -----
`InternalServerError` | An internal error occurred on the server side.<br/><br/>**HTTP status code**: 500
`LimitExceededException` | Table operations limit exceeded.<br/>You can concurrently perform up to 50 operations on tables, including `CreateTable`, `UpdateTable`, `DeleteTable`, `UpdateTimeToLive`, `RestoreTableFromBackup`, and `RestoreTableToPointInTime`.<br/><br/>**HTTP status code**: 400
`ResourceInUseException` | Attempting to create a table with the existing name.<br/><br/>**HTTP status code**: 400<br/>
`ResourceNotFoundException` | The specified table does not exist or is still being created using the [createTable](./createTable.md) method.<br/><br/>**HTTP status code**: 400<br/>
`ValidationException` | Attempt to enable change data capture if it is already enabled. Attempt to disable change data capture if it is disabled. Attempt to add an index with a name already taken.

There may be some [common errors](../../common-errors.md) as well shared by all methods.