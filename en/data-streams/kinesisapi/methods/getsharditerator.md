# GetShardIterator

Returns a [shard](../../concepts/glossary.md#shard) iterator for the stream.

An iterator expires 5 minutes after being retrieved.

An iterator specifies the starting position in the shard from which the [GetRecords](getrecords.md) method begins sequential [record](../../concepts/glossary.md#message) retrieval. The position is specified using the [sequence number](../../concepts/glossary.md#sequence-number) of a message in the shard.

The request must specify the iterator type.

For example, to retrieve an iterator that begins reading from a specific sequence number, specify the `AT_SEQUENCE_NUMBER` iterator type and provide the sequence number in the `StartingSequenceNumber` parameter. Alternatively, use the `AFTER_SEQUENCE_NUMBER` iterator type to get an iterator that starts reading from the record immediately after the one specified in the `StartingSequenceNumber` parameter. Use sequence numbers returned by the [PutRecord](putrecord.md), [PutRecords](putrecords.md), [GetRecords](getrecords.md), and [DescribeStream](deletestream.md) methods.

To retrieve an iterator that begins reading from a specific timestamp, use the `AT_TIMESTAMP` iterator type and specify the starting time in the `Timestamp` parameter.

Use `TRIM_HORIZON` iterators to read from the oldest record in the shard, or `LATEST` iterators to start with the newest available record.

When reading records from a stream in a loop, first call `GetShardIterator` to get the shard iterator for your initial `GetRecords` request. For subsequent reads, you can use the `NextShardIterator` value returned in the `GetRecords` response.

Frequent calls to `GetShardIterator` may result in a `ProvisionedThroughputExceededException`.

If a shard has been closed (for example, due to [resharding](updateshardcount.md)), the method returns an iterator for this shard’s last record.

Each open shard has a limit of 5 `GetShardIterator` requests per second.

## Request {#request}

The request contains JSON-formatted data.

```json
{
  "ShardId": "string",
  "ShardIteratorType": "string",
  "StartingSequenceNumber": "string",
  "StreamName": "string",
  "Timestamp": number
}
```

### Request options {#request-options}

Option | Description
----- | -----
`ShardId` | ID of the target shard for the new iterator.<br/><br/>**Type**: String<br/>**Size**: `1`-`128` characters.<br/>**The possible values are**: `[a-zA-Z0-9_.-]+`.<br/>**Required**: Yes.
`ShardIteratorType` | Shard iterator type.<br/><br/>**Type**: ShardIteratorType.<br/>**Allowed values**:<ul><li>`AT_SEQUENCE_NUMBER`: points to the record matching the sequence number specified in `StartingSequenceNumber`.</li><li>`AFTER_SEQUENCE_NUMBER`: points to the record following the one matching `StartingSequenceNumber`.</li><li>`AT_TIMESTAMP`: points to the record at the specified timestamp.</li><li>`TRIM_HORIZON`: points to the oldest record in the shard.</li><li>`LATEST`: points to the latest record in the shard.</li></ul>**Required**: Yes.
`StartingSequenceNumber` | Record sequence number.<br/>Used in conjunction with `AT_SEQUENCE_NUMBER` and `AFTER_SEQUENCE_NUMBER` iterator types.<br/><br/>**Type**: String<br/>**Size**: `1`-`256` characters.<br/>**Required**: No.
`StreamName` | Data stream name.<br/><br/>**Type**: String<br/>**Size**: `1`-`128` characters.<br/>**Allowed values**: lowercase letters, numbers, and hyphens (the first character must be a letter and the last character cannot be a hyphen).<br/>**Required**: No.
`Timestamp` | The timestamp specifying where sequential record retrieval begins.<br/>Used in conjunction with the `AT_TIMESTAMP` iterator type.<br/><br/>**Type**: Integer

## Response {#response}

Successful requests return HTTP 200 with a JSON-formatted response body.

```json
{
  "Iterator": "string"
}
```

### Response parameters {#response-options}

Parameter | Description
----- | -----
`Iterator` | The starting position within the shard for sequential message retrieval. The iterator’s position corresponds to the sequence number of a record in the shard.<br/><br/>**Type**: String<br/>**Size**: `1`-`512` characters.<br/>**Required**: Yes

## Errors {#errors}

Error | Description | HTTP code
----- | ----- | -----
`InvalidArgumentException` | The argument is invalid. See the error message for details. | 400
`ProvisionedThroughputExceededException` | Insufficient throughput to process the request. | 400
`ResourceNotFoundException` | The requested resource was not found. | 400

[Errors](../common-errors.md) common to all methods may occur.
