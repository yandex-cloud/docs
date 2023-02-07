# DeleteStream

Deletes a [stream](../../concepts/glossary.md#stream-concepts) and all of its [shards](../../concepts/glossary.md#shard) and data.

If successful, the method initiates the deletion of the stream, changes its status to `DELETING`, and returns HTTP code 200.

You can only delete a stream in the `ACTIVE` status.

The stream will be in the `DELETING` status until {{ yds-short-name }} deletes it. Streams in the `DELETING` status may continue to handle data read and write operations, such as `PutRecord`, `PutRecords`, and `GetRecords`, until their deletion is completed. To find out the status of a stream, use the [DescribeStream](describestream.md) method.

If an application attempts to access a deleted stream, a `ResourceNotFoundException` is returned.

## Request {#request}

The request contains data in JSON format.

```json
{
  "EnforceConsumerDeletion": boolean,
  "StreamName": "string"
}
```

### Request parameters {#request-options}

| Parameter | Description |
----- | -----
| `EnforceConsumerDeletion` | If this parameter is omitted or set to `false` and a stream has registered consumers, the stream is not deleted and a `ResourceInUseException` is returned.<br/><br/>**Type**: Boolean<br/>**Required**: No |
| `StreamName` | The name of the stream.<br/><br/>**Type**: String<br/>**Size**: `1`-`128` characters.<br/>**Possible values**: `[a-zA-Z][a-zA-Z0-9-]+*(?<!-)$`<br/>**Required**: Yes |

## Response {#response}

If successful, an HTTP 200 code and empty body are returned.

## Errors {#errors}

| Parameter | Description | HTTP code |
----- | ----- | -----
| `LimitExceededException` | The request limit is exceeded. | 400 |
| `ResourceInUseException` | The resource is being used by another operation. | 400 |
| `ResourceNotFoundException` | The requested resource was not found. | 400 |

[Errors](../common-errors.md) that are common to all methods may occur.
