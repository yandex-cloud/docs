# CreateStream

Creates a [data stream](../../concepts/glossary.md#stream-concepts).

On success, this method initiates stream creation, sets the stream status to `CREATING`, and returns an HTTP 200 response. Read and write operations are only permitted for streams with the `ACTIVE` status. To check the stream status, use the [DescribeStream](describestream.md) method.

If you attempt to create more streams than your account [quota](../../concepts/limits.md) allows, the request will return `LimitExceededException`.

## Request {#request}

The request contains JSON-formatted data.

```json
{
  "StreamName": "string",
  "ShardCount": number,
  "WriteQuotaKbPerSec": number,
  "RetentionPeriodHours": number
}
```

### Request options {#request-options}

Option | Description
----- | -----
`StreamName` | Data stream name.<br/><br/>**Type**: String<br/>**Size**: `1`-`128` characters.<br/>**The possible values are**: `[a-zA-Z][a-zA-Z0-9-]+*(?<!-)$`<br/>**Required**: Yes
`ShardCount` | Number of stream [shards](../../concepts/glossary.md#shard).<br/><br/>**Type**: Integer<br/>**Minimum value**: `1`.<br/>**Required**: Yes
`WriteQuotaKbPerSec` | Stream write throughput limit, KB/s.<br/><br/>**Type**: Integer<br/>**Allowed values**: `128`, `512`, `1024`.<br/>**Required**: No
`RetentionPeriodHours` | Record retention period, hours.<br/><br/>**Type**: Integer<br/>**Allowed values**: `4`, `12`, `24`.<br/>**Required**: No

## Response {#response}

Successful responses include an HTTP 200 code and an empty response body.

## Errors {#errors}

Error type | Description | HTTP code
----- | ----- | -----
`InvalidArgumentException` | The argument is invalid. See the error message for details. | 400
`LimitExceededException` | The request limit is exceeded. | 400
`ResourceInUseException` | The resource is currently locked by another operation. | 400

[Errors](../common-errors.md) common to all methods may occur.
