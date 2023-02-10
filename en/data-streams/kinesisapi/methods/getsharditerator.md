# GetShardIterator

Returns an iterator of a stream [shard](../../concepts/glossary.md#shard).

The iterator's lifetime expires 5 minutes after it is received.

The iterator sets the position in the shard to start reading the sequence of [messages](../../concepts/glossary.md#message) from using the [GetRecords](getrecords.md) method. The position is set using the [sequence number](../../concepts/glossary.md#sequence-number) of the message in the shard.

The request must specify the type of iterator.

For example, to get an iterator to read a sequence starting from a message with a certain sequence number, specify the `AT_SEQUENCE_NUMBER` iterator type and the message number in the `StartingSequenceNumber` parameter. The `AFTER_SEQUENCE_NUMBER` iterator type returns a value for reading the sequence starting from the message following the one specified in the `StartingSequenceNumber` parameter. The sequence numbers used are those returned when calling the [PutRecord](putrecord.md), [PutRecords](putrecords.md), [GetRecords](getrecords.md), and [DescribeStream](deletestream.md) methods.

To get an iterator for reading a sequence starting at a certain point in time, specify the `AT_TIMESTAMP` iterator type and the time in the `Timestamp` parameter.

The `TRIM_HORIZON` iterator type allows reading a sequence starting from the oldest record and the `LATEST` type from the most recent record in the shard.

When reading stream messages in a loop with `GetRecords`, use `GetShardIterator` to get the shard iterator to be used in the first `GetRecords` request. For subsequent reads, you can use the `NextShardIterator` value returned by `GetRecords`.

If you call the `GetShardIterator` method too often, a `ProvisionedThroughputExceededException` may be thrown.

If a shard no longer exists (for example, as a result of updating the [number of shards](updateshardcount.md)), the method returns an iterator for the last message in the shard.

There is a limit of five transactions per second per open shard when using `GetShardIterator`.

## Request {#request}

The request contains data in JSON format.

```json
{
  "ShardId": "string",
  "ShardIteratorType": "string",
  "StartingSequenceNumber": "string",
  "StreamName": "string",
  "Timestamp": number
}
```

### Request parameters {#request-options}

| Parameter | Description |
| ----- | ----- |
| `ShardId` | The ID of the shard that the iterator is requested for.<br/><br/>**Type**: String.<br/>**Size**: `1`-`128` characters.<br/>**Possible values**: `[a-zA-Z0-9_.-]+`.<br/>**Required**: Yes. |
| `ShardIteratorType` | The type of shard iterator.<br/><br/>**Type**: ShardIteratorType.<br/>**Possible values**:<ul><li>`AT_SEQUENCE_NUMBER`: Indicates the message with the number specified in `StartingSequenceNumber`.</li><li>`AFTER_SEQUENCE_NUMBER`: Indicates the message following the one specified in `StartingSequenceNumber`.</li><li>`AT_TIMESTAMP`: Indicates the message that the time is set for.</li><li>`TRIM_HORIZON`: Indicates the oldest message in the shard.</li><li>`LATEST`: Indicates the most recent message in the shard.</li></ul>**Required**: Yes. |
| `StartingSequenceNumber` | The sequence number of a message.<br/>Used with the `AT_SEQUENCE_NUMBER` or `AFTER_SEQUENCE_NUMBER` iterator type.<br/><br/>**Type**: String.<br/>**Size**: `1`-`256` characters.<br/>**Required**: No. |
| `StreamName` | The name of a stream.<br/><br/>**Type**: String.<br/>**Size**: `1`-`128` characters.<br/>**Possible values**: Lowercase Latin letters, numbers, and hyphens (the first character must be a letter and the last character can't be a hyphen).<br/>**Required**: No. |
| `Timestamp` | The timestamp of writing the message to start sequential reads from.<br/>Used with the `AT_TIMESTAMP` iterator type.<br/><br/>**Type**: Integer. |

## Response {#response}

If successful, HTTP code 200 and data in JSON format are returned.

```json
{
  "Iterator": "string"
}
```

### Response parameters {#response-options}

| Parameter | Description |
| ----- | ----- |
| `Iterator` | The position in a shard to start sequential message reads from. The iterator value is defined by the message sequence number in the shard.<br/><br/>**Type**: String<br/>**Size**: `1`-`512` characters.<br/>**Required**: Yes |

## Errors {#errors}

| Parameter | Description | HTTP code |
| ----- | ----- | ----- |
| `InvalidArgumentException` | The argument is invalid. For more information, see the error message. | 400 |
| `ProvisionedThroughputExceededException` | Insufficient throughput to execute the request. | 400 |
| `ResourceNotFoundException` | The requested resource was not found. | 400 |

[Errors](../common-errors.md) that are common to all methods may occur.
