# PutRecord

Puts one [record](../../concepts/glossary.md#message) into a [data stream](../../concepts/glossary.md#stream-concepts).

The request must include the stream name, the [partition key](../../concepts/glossary.md#partition-key) and an object containing the user data in Base64 encoding.

Returns the ID of the shard where the record was stored and the [record’s sequence number](../../concepts/glossary.md#sequence-number).

The system writes messages to the stream shard strictly in the order they are sent.

## Request {#request}

The request contains JSON-formatted data.

```json
{
  "Data": blob,
  "ExplicitHashKey": "string",
  "PartitionKey": "string",
  "SequenceNumberForOrdering": "string",
  "StreamName": "string"
}
```

### Request options {#request-options}

Option | Description
----- | -----
`Data` | User data.<br/><br/>**Type**: Binary, Base64-encoded<br/>**Size**: `0`-`1048576` bytes of Base64-encoded data<br/>**Required**: Yes
`ExplicitHashKey` | Partition key hash.<br/>Using the `PartitionKey` hash to assign records to shards may result in uneven record distribution across shards. Use this option to explicitly specify the target shard for message storage.<br/><br/>**Type**: String<br/>**Allowed values**: `0\|([1-9]\d{0.38})`<br/>**Required**: No
`PartitionKey` | Partition key.<br/>Determines the target stream shard for record storage<br/><br/>**Type**: String<br/>**Size**: `1`-`256` characters.<br/>**Required**: Yes
`StreamName` | Data stream name.<br/><br/>**Type**: String<br/>**Size**: `1`-`128` characters.<br/>**The possible values are**: `[a-zA-Z][a-zA-Z0-9-]+*(?<!-)$`<br/>**Required**: Yes

## Response {#response}

Successful requests return HTTP 200 with a JSON-formatted response body.

```json
{
  "EncryptionType": "string",
  "SequenceNumber": "string",
  "ShardId": "string"
}
```

### Response parameters {#response-options}

Parameter | Description
----- | -----
`EncryptionType` | Encryption type.<br/><br/>**Type**: String<br/>**Allowed values**: `NONE`<br/>**Required**: Yes
`SequenceNumber` | Record sequence number.<br/><br/>**Type**: String<br/>**Allowed values**: `0\|([1-9]\d{0.128})`<br/>**Required**: Yes
`ShardId` | The ID of the target shard for the record storage.<br/><br/>**Type**: String<br/>**Size**: `1`-`128` characters.<br/>**The possible values are**: `[a-zA-Z0-9_.-]+`<br/>**Required**: Yes

## Errors {#errors}

Error | Description | HTTP code
----- | ----- | -----
`InvalidArgumentException` | The argument is invalid. See the error message for details. | 400
`ProvisionedThroughputExceededException` | Insufficient throughput to process the request. | 400
`ResourceNotFoundException` | The requested resource was not found. | 400

[Errors](../common-errors.md) common to all methods may occur.
