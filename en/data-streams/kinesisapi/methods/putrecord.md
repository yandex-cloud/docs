# PutRecord

Sends one [message](../../concepts/glossary.md#message) to a [stream](../../concepts/glossary.md#stream-concepts).

The request specifies the stream name, the [shard key](../../concepts/glossary.md#partition-key), and an object with user data in Base64 encoding.

Returns the ID of the shard where the message was put and the [message sequence number](../../concepts/glossary.md#sequence-number).

Messages are written to the stream shard strictly in the order they are sent.

## Request {#request}

The request contains data in JSON format.

```json
{
  "Data": blob,
  "ExplicitHashKey": "string",
  "PartitionKey": "string",
  "SequenceNumberForOrdering": "string",
  "StreamName": "string"
}
```

### Request parameters {#request-options}

| Parameter | Description |
| ----- | ----- |
| `Data` | User data.<br/><br/>**Type**: Binary, Base64 encoding<br/>**Size**: `0`-`1048576` bytes of Base64 encoded data<br/>**Required**: Yes |
| `ExplicitHashKey` | Shard key hash.<br/>When using the `PartitionKey` hash to specify the shard to put a message into, messages may be distributed across shards suboptimally. Use this parameter to explicitly define the shard to write messages to.<br/><br/>**Type**: String<br/>**Possible values**: `0\|([1-9]\d{0.38})`<br/>**Required**: No |
| `PartitionKey` | Shard key.<br/>Sets the stream shard to write a message to.<br/><br/>**Type**: String<br/>**Size**: `1`-`256` characters.<br/>**Required**: Yes |
| `StreamName` | The name of a stream.<br/><br/>**Type**: String<br/>**Size**: `1`-`128` characters.<br/>**Possible values**: `[a-zA-Z][a-zA-Z0-9-]+*(?<!-)$`<br/>**Required**: Yes |

## Response {#response}

If successful, HTTP code 200 and data in JSON format are returned.

```json
{
  "EncryptionType": "string",
  "SequenceNumber": "string",
  "ShardId": "string"
}
```

### Response parameters {#response-options}

| Parameter | Description |
| ----- | ----- |
| `EncryptionType` | The type of encryption.<br/><br/>**Type**: String<br/>**Possible values**: `NONE`<br/>**Required**: Yes |
| `SequenceNumber` | The sequence number of a message.<br/><br/>**Type**: String<br/>**Possible values**: `0\|([1-9]\d{0,128})`<br/>**Required**: Yes |
| `ShardId` | The ID of the shard that the message was written to.<br/><br/>**Type**: String<br/>**Size**: `1`-`128` characters.<br/>**Possible values**: `[a-zA-Z0-9_.-]+`<br/>**Required**: Yes |

## Errors {#errors}

| Parameter | Description | HTTP code |
| ----- | ----- | ----- |
| `InvalidArgumentException` | The argument is invalid. For more information, see the error message. | 400 |
| `ProvisionedThroughputExceededException` | Insufficient throughput to execute the request. | 400 |
| `ResourceNotFoundException` | The requested resource was not found. | 400 |

[Errors](../common-errors.md) that are common to all methods may occur.
