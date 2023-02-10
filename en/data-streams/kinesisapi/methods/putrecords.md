# PutRecords

Writes multiple [messages](../../concepts/glossary.md#message) to a [stream](../../concepts/glossary.md#stream-concepts) per call.

The method provides greater performance as compared to [PutRecord](putrecord.md). Up to 500 messages can be sent in a single request. Each message in the request can be up to 1 MB in size. The entire request can't exceed 5 MB, including [shard keys](../../concepts/glossary.md#partition-key).

The request specifies the stream name and the `Records` array of messages. For each element of the array, a shard key and an object with Base64-encoded user data are specified. To explicitly set the hash key of the shard to write messages to, use the `ExplicitHashKey` parameter.

Returns an array of elements with data about written messages. Each element of the array returned corresponds to an element of the array sent. The elements in both arrays are ordered the same way. The returned array includes data from both successfully and unsuccessfully processed messages. Failure to write any message does not stop the processing of subsequent messages.

`PutRecords` ensures that messages will be written in the same order as in the sent array.

Data about a successfully processed message contains the `ShardId` indicating the shard that the message was written to and the [message number](../../concepts/glossary.md#sequence-number) (`SequenceNumber`).

Data about a message that the service failed to process contains the `ErrorCode` and `ErrorMessage`. Possible error types: `ProvisionedThroughputExceededException` or `InternalFailure`. If the type is `ProvisionedThroughputExceededException`, the error message contains the account ID, the stream name, and the shard ID of the message that couldn't be processed.

## Request {#request}

The request contains data in JSON format.

```json
{
  "Records": [{
    "Data": blob,
    "ExplicitHashKey": "string",
    "PartitionKey": "string"
  }],
  "StreamName": "string"
}
```

### Request parameters {#request-options}

| Parameter | Description |
| ----- | ----- |
| `Records` | Messages to write.<br/><br/>**Type** Array of objects `PutRecordsRequestEntry`<br/>**Number of elements**: `1`-`500`<br/>**Required**: Yes |
| `StreamName` | The name of a stream.<br/><br/>**Type**: String<br/>**Size**: `1`-`128` characters.<br/>**Possible values**: `[a-zA-Z][a-zA-Z0-9-]+*(?<!-)$`<br/>**Required**: Yes |

## Response {#response}

If successful, HTTP code 200 and data in JSON format are returned.

```json
{
  "EncryptionType": "string",
  "FailedRecordCount": number,
  "Records": [{
    "ErrorCode": "string",
    "ErrorMessage": "string",
    "SequenceNumber": "string",
    "ShardId": "string"
  }]
}
```

### Response parameters {#response-options}

| Parameter | Description |
| ----- | ----- |
| `EncryptionType` | The type of encryption.<br/><br/>**Type**: String<br/>**Possible values**: `NONE`<br/>**Required**: Yes |
| `FailedRecordCount` | The number of unprocessed messages. |
| `Records` | The results of message processing.<br/><br/>**Type** Array of objects `PutRecordsRequestEntry`<br/>**Number of elements**: `1`-`500`<br/>**Required**: Yes |

## Errors {#errors}

| Parameter | Description | HTTP code |
| ----- | ----- | ----- |
| `InvalidArgumentException` | The argument is invalid. For more information, see the error message. | 400 |
| `ResourceNotFoundException` | The requested resource was not found. | 400 |

[Errors](../common-errors.md) that are common to all methods may occur.
