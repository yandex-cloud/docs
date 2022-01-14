# UpdateStream

Updates the parameters of a [stream](../../concepts/glossary.md#stream-concepts).

## Request {#request}

The request contains data in JSON format.

```json
{
  "StreamName": "string",
  "ShardCount": number,
  "WriteQuotaKbPerSec": number,
  "RetentionPeriodHours": number
}
```

### Request parameters {#request-options}

| Parameter | Description |
| ----- | ----- |
| `StreamName` | The name of the stream being created.<br/><br/>**Type**: String<br/>**Size**: `1`-`128` characters.<br/>**Possible values**: `[a-zA-Z][a-zA-Z0-9-]+*(?<!-)$`<br/>**Required**: Yes |
| `ShardCount` | The number of [shards](../../concepts/glossary.md#shard) in a stream.<br/>The shard count may only increase.<br/><br/>**Type**: Integer<br/>**Minimum value**: `1`.<br/>**Required**: No |
| `WriteQuotaKbPerSec` | The limit on the stream data write speed, KB/s.<br/><br/>**Type**: Integer<br/>**Possible values**: `128`, `512`, `1024`.<br/>**Required**: No |
| `RetentionPeriodHours` | Message retention period.<br/><br/>**Type**: Integer<br/>**Possible values** `4`, `12`, `24`.<br/>**Required**: No |

## Response {#response}

If successful, HTTP code 200 and data in JSON format are returned.

```json
{
  "StreamName": "string",
  "ShardCount": number,
  "WriteQuotaKbPerSec": number,
  "RetentionPeriodHours": number
}
```

### Response parameters {#response-options}

| Parameter | Description |
| ----- | ----- |
| `StreamName` | The name of the stream being created.<br/><br/>**Type**: String<br/>**Size**: `1`-`128` characters.<br/>**Possible values**: `[a-zA-Z][a-zA-Z0-9-]+*(?<!-)$`<br/>**Required**: Yes |
| `ShardCount` | The number of [shards](../../concepts/glossary.md#shard) in a stream.<br/><br/>**Type**: Integer<br/>**Minimum value**: `1`.<br/>**Required**: No |
| `WriteQuotaKbPerSec` | The limit on writing data to a stream.<br/><br/>**Type**: Integer<br/>**Possible values**: `128`, `512`, `1024`.<br/>**Required**: No |
| `RetentionPeriodHours` | Message retention period.<br/><br/>**Type**: Integer<br/>**Possible values** `4`, `12`, `24`.<br/>**Required**: No |

## Errors {#errors}

| Parameter | Description | HTTP code |
| ----- | ----- | ----- |
| `InvalidArgumentException` | The argument is invalid. For more information, see the error message. | 400 |
| `ResourceInUseException` | The resource is being used by another operation. | 400 |

[Errors](../common-errors.md) that are common to all methods may occur.
