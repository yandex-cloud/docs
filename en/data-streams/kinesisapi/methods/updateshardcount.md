# UpdateShardCount

Updates the number of [shards](../../concepts/glossary.md#shard) in the specified [stream](../../concepts/glossary.md#stream-concepts). Only an increase in the shard count is allowed.

If successful, the method changes the stream status to `UPDATING` and returns HTTP code 200 and data in JSON format. Once updated, the stream status changes to `ACTIVE`. The scaling time depends on the stream size and may take several minutes. While the stream is in the `UPDATING` status, data reads and writes do not stop.

## Request {#request}

The request contains data in JSON format.

```json
{
  "ScalingType": "string",
  "StreamName": "string",
  "TargetShardCount": number
}
```

### Request parameters {#request-options}

| Parameter | Description |
----- | -----
| `ScalingType` | The type of scaling. `UNIFORM_SCALING` creates shards of the same size.<br/><br/>**Type**: String<br/>**Possible values**: `UNIFORM_SCALING`<br/>**Required**: Yes |
| `StreamName` | The name of the stream.<br/><br/>**Type**: String<br/>**Size**: `1`-`128` characters.<br/>**Possible values**: `[a-zA-Z][a-zA-Z0-9-]+*(?<!-)$`<br/>**Required**: Yes |
| `TargetShardCount` | The target number of shards.<br/><br/>**Type**: Integer<br/>**Minimum value**: `1`<br/>**Required**: Yes |

## Response {#response}

If successful, HTTP code 200 and data in JSON format are returned.

```json
{
  "CurrentShardCount": number,
  "StreamName": "string",
  "TargetShardCount": number
}
```

### Response parameters {#response-options}

| Parameter | Description |
----- | -----
| `CurrentShardCount` | The current number of shards.<br/><br/>**Type**: Integer<br/>**Minimum value**: `1`<br/>**Required**: Yes |
| `StreamName` | The name of the stream.<br/><br/>**Type**: String<br/>**Size**: `1`-`128` characters.<br/>**Possible values**: `[a-zA-Z][a-zA-Z0-9-]+*(?<!-)$`<br/>**Required**: Yes |
| `TargetShardCount` | The target number of shards.<br/><br/>**Type**: Integer<br/>**Minimum value**: `1`<br/>**Required**: Yes |

## Errors {#errors}

| Parameter | Description | HTTP code |
----- | ----- | -----
| `InvalidArgumentException` | The argument is invalid. For more information, see the error message. | 400 |
| `LimitExceededException` | The request limit is exceeded. | 400 |
| `ResourceInUseException` | The resource is being used by another operation. | 400 |
| `ResourceNotFoundException` | The requested resource was not found. | 400 |

[Errors](../common-errors.md) that are common to all methods may occur.
