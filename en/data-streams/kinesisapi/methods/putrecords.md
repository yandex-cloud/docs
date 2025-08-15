# PutRecords

Puts multiple [records](../../concepts/glossary.md#message) into a [data stream](../../concepts/glossary.md#stream-concepts) in a single call.

This method delivers higher throughput compared to [PutRecord](putrecord.md). A single request can contain up to 500 records. Each record in the request can be up to 1 MB in size. The total request size cannot exceed 5 MB, including [partition keys](../../concepts/glossary.md#partition-key).

The request must include the stream name and an array of `Records`. Each record must contain a partition key and an object containing Base64-encoded user data. To explicitly specify the hash key determining the target shard for records, use the `ExplicitHashKey` parameter.

Returns an array of elements containing status information for each record. Each entry in the response array corresponds to a record in the request array. The response array maintains the same order as the request array. The response array provides status information for all records, whether processed successfully or not. A single record failure does not prevent processing of subsequent records.

`PutRecords` guarantees that records are written to the stream in the exact order they appear in the request array.

For successfully processed records, the response includes the `ShardId` of the shard where the record was stored and the [`SequenceNumber`](../../concepts/glossary.md#sequence-number) assigned to the record.

For records that failed processing, the response includes an `ErrorCode` and an `ErrorMessage`. Common error types include `ProvisionedThroughputExceededException` and `InternalFailure`. For `ProvisionedThroughputExceededException` errors, the error message includes the account ID, the stream name, and the shard ID of the failed record.

## Request {#request}

The request contains JSON-formatted data.

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

### Request options {#request-options}

Option | Description
----- | -----
`Records` | Record to write<br/><br/>**Type** Array of objects `PutRecordsRequestEntry`<br/>**Number of elements**: `1`-`500`<br/>**Required**: Yes
`StreamName` | Data stream name.<br/><br/>**Type**: String<br/>**Size**: `1`-`128` characters.<br/>**The possible values are**: `[a-zA-Z][a-zA-Z0-9-]+*(?<!-)$`<br/>**Required**: Yes

## Response {#response}

Successful requests return HTTP 200 with a JSON-formatted response body.

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

Parameter | Description
----- | -----
`EncryptionType` | Encryption type.<br/><br/>**Type**: String<br/>**Allowed values**: `NONE`<br/>**Required**: Yes
`FailedRecordCount` | Number of failed records.
`Records` | Record processing results.<br/><br/>**Type** Array of `PutRecordsRequestEntry` objects<br/>**Number of elements**: `1`-`500`<br/>**Required**: Yes

## Errors {#errors}

Error | Description | HTTP code
----- | ----- | -----
`InvalidArgumentException` | The argument is invalid. See the error message for details. | 400
`ResourceNotFoundException` | The requested resource was not found. | 400

[Errors](../common-errors.md) common to all methods may occur.
