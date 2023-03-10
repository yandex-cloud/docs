# GetRecords

Gets [messages](../../concepts/glossary.md#message) from a stream [shard](../../concepts/glossary.md#shard).

The `ShardIterator` value defines the position in a shard to start sequential message reads from. If there are no new messages in the shard, `GetRecords` returns an empty list. In this case, invoke `GetRecords` again.

When reading stream messages in a loop, use `GetShardIterator` to get the shard iterator to be used in the first `GetRecords` request. For subsequent reads, you can use the `NextShardIterator` value returned by `GetRecords`. If the shard is closed, `GetRecords` returns `null` in the `NextShardIterator` value.

The size of data returned by `GetRecords` is limited to 2 MB/s and you can call the method no more than 5 times per second. If a `GetRecords` method call returns more data, subsequent calls will fail with `ProvisionedThroughputExceededException` until the throughput returns to 2 MB/s. For example, if a request returns 10 MB/s, subsequent requests made within 5 seconds will fail.

To determine if your application reads all data from a shard fast enough, use the `MillisBehindLatest` metric value in a response.

## Request {#request}

The request contains data in JSON format.

```json
{
  "Limit": number,
  "ShardIterator": "string"
}
```

### Request parameters {#request-options}

| Parameter | Description |
----- | -----
| `Limit` | Maximum number of returned records.<br/><br/>**Type**: Integer.<br/>**Possible values** `1` - `10000`.<br/>**Required**: No. |
| `ShardIterator` | The position in a shard to start sequential message reads from. The iterator value is defined by the message sequence number in a shard.<br/><br/>**Type**: String.<br/>**Size**: `1`-`512` characters.<br/>**Required**: Yes. |

## Response {#response}

If successful, HTTP code 200 and data in JSON format are returned.

```json
{
  "ChildShards": [{
    "HashKeyRange": {
      "EndingHashKey": "string",
      "StartingHashKey": "string"
    },
    "ParentShards": ["string"],
    "ShardId": "string"
  }],
  "MillisBehindLatest": number,
  "NextShardIterator": "string",
  "Records": [{
    "ApproximateArrivalTimestamp": number,
    "Data": blob,
    "EncryptionType": "string",
    "PartitionKey": "string",
    "SequenceNumber": "string"
  }]
}
```

### Response parameters {#response-options}

| Parameter | Description |
----- | -----
| `ChildShards` | List of the current shard's child shards. Returned when the end of the current shard is reached.<br/>**Type**: Array.<br/>**Required**: No. |
| `MillisBehindLatest` | The number of milliseconds that the results returned by `GetRecords` lag behind the latest data in the stream. `0` means that the latest data is returned with no lag.**Type**: Long integer.<br/>**Minimum value**: `0`.<br/>**Required**: No. |
| `NextShardIterator` | Iterator of the position in a shard to start the next sequential read from.<br/>If the shard no longer exists, `null` is returned.**Type**: String.<br/>**Size**: `1`-`512` characters.<br/>**Required**: Yes. |
| `Records` | Messages fetched from a shard.<br/>**Type**: Array.<br/>**Required**: No. |

## Errors {#errors}

| Parameter | Description | HTTP code |
----- | ----- | -----
| `ExpiredIteratorException` | The specified iterator's lifetime expired. | 400 |
| `InvalidArgumentException` | The argument is invalid. For more information, see the error message. | 400 |
| `ProvisionedThroughputExceededException` | Insufficient throughput to execute the request. | 400 |
| `ResourceNotFoundException` | The requested resource was not found. | 400 |

[Errors](../common-errors.md) that are common to all methods may occur.
