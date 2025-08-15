# UpdateShardCount

Updates the number of [shards](../../concepts/glossary.md#shard) in the specified [stream](../../concepts/glossary.md#stream-concepts). Only shard count increases are allowed.

On success, this method sets the stream status to `UPDATING` and returns an HTTP 200 response with JSON data. After successful update, the stream transitions to the `ACTIVE` status. The scaling time depends on the stream size and may take several minutes. You can continue reading data from and writing data to the stream while it is in the `UPDATING` status.

## Request {#request}

The request contains JSON-formatted data.

```json
{
  "ScalingType": "string",
  "StreamName": "string",
  "TargetShardCount": number
}
```

### Request options {#request-options}

Option | Description
----- | -----
`ScalingType` | Scaling type. `UNIFORM_SCALING` creates shards of equal size.<br/><br/>**Type**: String<br/>**Allowed values**: `UNIFORM_SCALING`<br/>**Required**: Yes
`StreamName` | Data stream name.<br/><br/>**Type**: String<br/>**Size**: `1`-`128` characters.<br/>**The possible values are**: `[a-zA-Z][a-zA-Z0-9-]+*(?<!-)$`<br/>**Required**: Yes
`TargetShardCount` | Target number of shards.<br/><br/>**Type**: Integer<br/>**Minimum value**: `1`<br/>**Required**: Yes

## Response {#response}

Successful requests return HTTP 200 with a JSON-formatted response body.

```json
{
  "CurrentShardCount": number,
  "StreamName": "string",
  "TargetShardCount": number
}
```

### Response parameters {#response-options}

Option | Description
----- | -----
`CurrentShardCount` | Current number of shards.<br/><br/>**Type**: Integer<br/>**Minimum value**: `1`<br/>**Required**: Yes
`StreamName` | Data stream name.<br/><br/>**Type**: String<br/>**Size**: `1`-`128` characters.<br/>**The possible values are**: `[a-zA-Z][a-zA-Z0-9-]+*(?<!-)$`<br/>**Required**: Yes
`TargetShardCount` | Target number of shards.<br/><br/>**Type**: Integer<br/>**Minimum value**: `1`<br/>**Required**: Yes

## Errors {#errors}

Error | Description | HTTP code
----- | ----- | -----
`InvalidArgumentException` | The argument is invalid. See the error message for details. | 400
`LimitExceededException` | The request limit is exceeded. | 400
`ResourceInUseException` | The resource is currently locked by another operation. | 400
`ResourceNotFoundException` | The requested resource was not found. | 400

[Errors](../common-errors.md) common to all methods may occur.
