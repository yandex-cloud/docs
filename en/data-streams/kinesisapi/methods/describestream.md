# DescribeStream

Returns information about the [data stream](../../concepts/glossary.md#stream-concepts).

You can limit the number of shard descriptions per method call using the `Limit` option.

## Request {#request}

The request contains JSON-formatted data.

```json
{
  "ExclusiveStartShardId": "string",
  "Limit": number,
  "StreamName": "string"
}
```

### Request options {#request-options}

Option | Description
----- | -----
`ExclusiveStartShardId` | Shard ID. Stream shard information is returned starting from the shard following the specified one. By default, the output begins with the first shard in the stream.<br/><br/>**Type**: Integer<br/>**Allowed values**: `[a-zA-Z0-9_.-]+`<br/>**Required**: No
`Limit` | The maximum number of shard descriptions returned per method call. If you specify a value greater than `100`, the response will contain `100` shard descriptions.<br/><br/>**Type**: Integer<br/>**Allowed values**: `1`-`10000`.<br/>**Default value**: `100`<br/>**Required**: No
`StreamName` | Data stream name.<br/><br/>**Type**: String<br/>**Size**: `1`-`128` characters.<br/>**The possible values are**: `[a-zA-Z][a-zA-Z0-9-]+*(?<!-)$`<br/>**Required**: Yes

## Response {#response}

Successful requests return HTTP 200 with a JSON-formatted response body.

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

Parameter | Description
----- | -----
`StreamDescription` | Stream status.<br/><br/>**Type**: Object `StreamDescription`

## Errors {#errors}

Error | Description | HTTP code
----- | ----- | -----
`LimitExceededException` | The request limit is exceeded. | 400
`ResourceNotFoundException` | The requested resource was not found. | 400

[Errors](../common-errors.md) common to all methods may occur.
