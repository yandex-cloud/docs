# DescribeStream

Returns information about a [stream](../../concepts/glossary.md#stream-concepts).

You can limit the number of shard descriptions returned by each method call using the `Limit` parameter.

## Request {#request}

The request contains data in JSON format.

```json
{
  "ExclusiveStartShardId": "string",
  "Limit": number,
  "StreamName": "string"
}
```

### Request parameters {#request-options}

| Parameter | Description |
----- | -----
| `ExclusiveStartShardId` | Shard ID. Information about stream shards is output starting from the shard following the specified one. By default, information is output starting from the first shard in the stream.<br/><br/>**Type**: Integer<br/>**Possible values**: `[a-zA-Z0-9_.-]+`<br/>**Required**: No |
| `Limit` | The maximum number of shard descriptions returned per method call. If you specify a value greater than `100`, the number of descriptions returned won't exceed `100`.<br/><br/>**Type**: Integer<br/>**Possible values**: `1`-`10000`.<br/>**Default value**: `100`<br/>**Required**: No |
| `StreamName` | The name of the stream.<br/><br/>**Type**: String<br/>**Size**: `1`-`128` characters.<br/>**Possible values**: `[a-zA-Z][a-zA-Z0-9-]+*(?<!-)$`<br/>**Required**: Yes |

## Response {#response}

If successful, HTTP code 200 and data in JSON format are returned.

```json
{
  "StreamDescription": {
    "EncryptionType": "string",
    "EnhancedMonitoring": [{
      "ShardLevelMetrics": ["string"]
    }],
    "HasMoreShards": boolean,
    "KeyId": "string",
    "RetentionPeriodHours": number,
    "Shards": [{
      "AdjacentParentShardId": "string",
      "HashKeyRange": {
        "EndingHashKey": "string",
        "StartingHashKey": "string"
      },
      "ParentShardId": "string",
      "SequenceNumberRange": {
        "EndingSequenceNumber": "string",
        "StartingSequenceNumber": "string"
      },
      "ShardId": "string"
    }],
    "StreamCreationTimestamp": number,
    "StreamName": "string",
    "StreamStatus": "string"
  }
}
```

### Response parameters {#response-options}

| Parameter | Description |
----- | -----
| `StreamDescription` | The status of a stream.<br/><br/>**Type**: The `StreamDescription` object |

## Errors {#errors}

| Parameter | Description | HTTP code |
----- | ----- | -----
| `LimitExceededException` | The request limit is exceeded. | 400 |
| `ResourceNotFoundException` | The requested resource was not found. | 400 |

[Errors](../common-errors.md) that are common to all methods may occur.
