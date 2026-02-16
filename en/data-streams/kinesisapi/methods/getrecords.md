# GetRecords

Retrieves [records](../../concepts/glossary.md#message) from a data stream [shard](../../concepts/glossary.md#shard).

The `ShardIterator` value specifies the starting point in the shard for sequential record processing. If the shard contains no new records, `GetRecords` returns an empty list. In this case, repeat the `GetRecords` request.

When reading records from a stream in a loop, first call `GetShardIterator` to get the shard iterator for your initial `GetRecords` request. For subsequent reads, you can use the `NextShardIterator` value returned in the `GetRecords` response. If the shard has been closed, `GetRecords` returns `null` for the `NextShardIterator` value.

The data returned by `GetRecords` is limited to 2 MB/s, with a maximum call frequency of 5 requests per second. If a `GetRecords` call exceeds the 2 MB/s limit, subsequent calls will throw a `ProvisionedThroughputExceededException` until the throughput drops below the threshold. For example, a 10 MB/s response would block further requests for 5 seconds.

To determine if your application keeps up with all incoming shard data, check the `MillisBehindLatest` value in the response.

## Request {#request}

The request contains JSON-formatted data.

```json
{
  "Limit": number,
  "ShardIterator": "string"
}
```

### Request options {#request-options}

Option | Description
----- | -----
`Limit` | Maximum number of records returned.<br/><br/>**Type**: Integer<br/>**Allowed values**: `1` - `10000`.<br/>**Required**: No.
`ShardIterator` | The starting position within the shard for sequential message processing. The iterator’s position corresponds to the sequence number of a record in the shard.<br/><br/>**Type**: String<br/>**Size**: `1`-`512` characters.<br/>**Required**: Yes.

## Response {#response}

Successful requests return HTTP 200 with a JSON-formatted response body.

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

Parameter | Description
----- | -----
`ChildShards` | List of child shards of the current shard. This parameter is returned when reaching the end of the current shard.<br/>**Type**: Array<br/>**Required**: No.
`MillisBehindLatest` | The latency in milliseconds between the latest data written to the stream and the `GetRecords` response. If the value is `0`, it means the system returns the latest stream data with no lag.**Type**: Long integer<br/>**Minimum value**: `0`.<br/>**Required**: No.
`NextShardIterator` | A shard iterator specifying the starting point for subsequent sequential reads.<br/>If the shard no longer exists, this parameter is set to `null`.**Type**: String<br/>**Size**: `1`-`512` characters.<br/>**Required**: Yes.
`Records` | Records retrieved from the shard.<br/>**Type**: Array<br/>**Required**: No.

## Errors {#errors}

Error | Description | HTTP code
----- | ----- | -----
`ExpiredIteratorException` | The specified iterator has expired. | 400
`InvalidArgumentException` | The argument is invalid. See the error message for details. | 400
`ProvisionedThroughputExceededException` | Insufficient throughput to process the request. | 400
`ResourceNotFoundException` | The requested resource was not found. | 400

[Errors](../common-errors.md) common to all methods may occur.
