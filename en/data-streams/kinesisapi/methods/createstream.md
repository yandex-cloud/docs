# CreateStream

Creates a [stream](../../concepts/glossary.md#stream-concepts).

If successful, the method initiates the creation of a stream, changes its status to `CREATING`, and returns HTTP code 200. Reads and writes are only allowed for a stream in the `ACTIVE` status. To find out the status of a stream, use the [DescribeStream](describestream.md) method.

If you try to create more streams than set in the [quota](../../concepts/limits.md) for your account, the request returns `LimitExceededException`.

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
----- | -----
| `StreamName` | The name of the stream being created.<br/><br/>**Type**: String<br/>**Size**: `1`-`128` characters.<br/>**Possible values**: `[a-zA-Z][a-zA-Z0-9-]+*(?<!-)$`<br/>**Required**: Yes |
| `ShardCount` | Number of [shards](../../concepts/glossary.md#shard) in a stream.<br/><br/>**Type**: Integer<br/>**Minimum value**: `1`.<br/>**Required**: Yes |
| `WriteQuotaKbPerSec` | The limit on writing data to a stream, KB/s.<br/><br/>**Type**: Integer<br/>**Possible values**: `128`, `512`, `1024`.<br/>**Required**: No |
| `RetentionPeriodHours` | The message retention period, hours.<br/><br/>**Type**: Integer<br/>**Possible values** `4`, `12`, `24`.<br/>**Required**: No |

## Response {#response}

If successful, HTTP 200 code and an empty body are returned.

## Errors {#errors}

| Error type | Description | HTTP code |
----- | ----- | -----
| `InvalidArgumentException` | The argument is invalid. For more information, see the error message. | 400 |
| `LimitExceededException` | The request limit is exceeded. | 400 |
| `ResourceInUseException` | The resource is being used by another operation. | 400 |

[Errors](../common-errors.md) that are common to all methods may occur.
