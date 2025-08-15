# DeleteStream

Deletes a [stream](../../concepts/glossary.md#stream-concepts), including all its [shards](../../concepts/glossary.md#shard) and data.

On success, this method starts the stream deletion process, changes the stream status to `DELETING`, and returns an HTTP 200 response.

You can only delete a stream if its status is `ACTIVE`.

The stream will remain in the `DELETING` status until {{ yds-short-name }} completes the deletion. While in the `DELETING` status, the data stream may continue to process read and write operations, such as `PutRecord`, `PutRecords` and `GetRecords`, until deletion completes. To check the stream status, use the [DescribeStream](describestream.md) method.

If an application attempts to access a deleted stream, the API returns `ResourceNotFoundException`.

## Request {#request}

The request contains JSON-formatted data.

```json
{
  "EnforceConsumerDeletion": boolean,
  "StreamName": "string"
}
```

### Request options {#request-options}

Option | Description
----- | -----
`EnforceConsumerDeletion` | If this option is omitted or set to `false` while the stream has active consumers, the deletion fails with `ResourceInUseException` error.<br/><br/>**Type**: Boolean<br/>**Required**: No
`StreamName` | Data stream name.<br/><br/>**Type**: String<br/>**Size**: `1`-`128` characters.<br/>**The possible values are**: `[a-zA-Z][a-zA-Z0-9-]+*(?<!-)$`<br/>**Required**: Yes

## Response {#response}

Successful responses include an HTTP 200 code and an empty response body.

## Errors {#errors}

Error | Description | HTTP code
----- | ----- | -----
`LimitExceededException` | The request limit is exceeded. | 400
`ResourceInUseException` | The resource is currently locked by another operation. | 400
`ResourceNotFoundException` | The requested resource was not found. | 400

[Errors](../common-errors.md) common to all methods may occur.
