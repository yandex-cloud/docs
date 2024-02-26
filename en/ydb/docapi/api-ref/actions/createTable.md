---
sourcePath: overlay/docapi/api-ref/actions/createTable.md
---
# CreateTable method

Creates a new table.

The method is asynchronous.
This means it changes a table's state to `CREATING` and immediately returns the result. However, the table is actually being created in the background, and you can only use it after it goes `ACTIVE`.

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
   "GlobalSecondaryIndexes": [
      {
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
      }
   ],
   "KeySchema": [
      {
         "AttributeName": "string",
         "KeyType": "string"
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

| Parameter | Description |
| ----- | ----- |
| `AttributeDefinitions` | An array of attributes that describe the key schema for a table and indexes.<br/><br/>**Type**: Array of `AttributeDefinition` type objects<br/>**Required**: Yes |
| `GlobalSecondaryIndexes` | An array of attributes describing one or more global secondary indexes to be created in the table. Each item consists of:<ul><li>`IndexName` is the index name. The name must be unique and at least three characters long. This is a required parameter.</li><li>`KeySchema` are the attributes that constitute the primary key of the index.</li><li>`Projection` specifies attributes that are copied from the table to the index. Currently the only supported `ProjectionType` is `ALL`.</li><li>`NonKeyAttributes` is a list of one or more non-key attribute names that are projected to the secondary index.</li></ul><br/>**Required**: No |
| `KeySchema` | Attributes that make up the primary key. These attributes should also be specified in `AttributeDefinitions`.<br/>Each item consists of:<ul><li>`AttributeName`: Attribute name.<li>`KeyType`: Role that the key attribute will assume:<ul><li>`HASH`: Partition key<li>`RANGE`: Sort key</ul></ul>For a simple primary key (partition key), specify only one attribute with the `HASH` role.<br/>For a composite primary key (partition key + sort key), specify two attributes: the first one with the HASH role and the second with the `RANGE` role<br/><br/>**Type**: Array of `KeySchemaElement` type objects<br/>**Length**: 1-2 items<br/>**Required**: Yes |
| `StreamSpecification` | Description of the update stream settings for a table:<br/><ul><li>`StreamEnabled` defines whether update streaming for the table is active or not.</li><li>`StreamViewType` defines the streaming type:<ul><li>`KEYS_ONLY`: Only the primary key components and the change flag are written.</li><li>`NEW_IMAGE`: Any column values resulting from updates are written.</li><li>`OLD_IMAGE`: Any column values before updates are written.</li><li>`NEW_AND_OLD_IMAGES`: Combination of the *NEW_IMAGE* and *OLD_IMAGE* modes. Writes the values of all columns before and after the update.</li></ul></li><br/>**Type**: A `StreamSpecification` type object<br/>**Required**: No |
| `TableName` | Table name.<br/>May contain a path through the folder hierarchy in path/to/table format.<br/><br/>**Type**: String<br/>**Length**: 3 - 255 characters<br/>**Pattern**: [a-zA-Z0-9_.-]+<br/>**Required**: Yes |

## Response

If successful, HTTP code 200 is returned.
The response is returned in JSON format.

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

| Parameter | Description |
| ----- | ----- |
| `TableDescription` | Properties of the created table.<br/><br/>**Type**: a `TableDescription` object |

## Errors

| Parameter | Description |
| ----- | ----- |
| `InternalServerError` | An internal error occurred on the server side.<br/><br/>**HTTP status code**: 500 |
| `LimitExceededException` | Table operations limit exceeded.<br/>You can simultaneously perform up to 50 operations on tables, such as `CreateTable`, `UpdateTable`, `DeleteTable`, `UpdateTimeToLive`, `RestoreTableFromBackup`, and `RestoreTableToPointInTime`.<br/><br/>**HTTP status code**: 400 |
| `ResourceInUseException` | An attempt to create a table with a name that already exists.<br/><br/>**HTTP status code**: 400<br/> |

There may be [common errors](../common-errors) as well. These are errors that are common to all methods.