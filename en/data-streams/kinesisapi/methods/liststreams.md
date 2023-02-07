# ListStreams

Outputs a list of [streams](../../concepts/glossary.md#stream-concepts).

The `HasMoreStreams` response parameter indicates that there are more streams to output. To request them, specify the name of the stream returned last as the `ExclusiveStartStreamName` value in the next request.

## Request {#request}

The request contains data in JSON format.

```json
{
  "ExclusiveStartStreamName": "string",
  "Limit": number
}
```

### Request parameters {#request-options}

| Parameter | Description |
----- | -----
| `ExclusiveStartStreamName` | The name of the stream to start the output from.<br/><br/>**Type**: String<br/>**Size**: `1`-`128` characters.<br/>**Possible values**: `[a-zA-Z0-9_.-]+`<br/>**Required**: No |
| `Limit` | The maximum number of streams in the list. If you specify a value greater than `100`, no more than `100` streams will be output.<br/><br/>**Type**: Integer<br/>**Possible values**: `1`-`10000`.<br/>**Default value**: `100`<br/>**Required**: No |

## Response {#response}

If successful, HTTP code 200 and data in JSON format are returned.

```json
{
  "HasMoreStreams": boolean,
  "StreamNames": ["string"]
}
```

### Response parameters {#response-options}

| Parameter | Description |
----- | -----
| `HasMoreStreams` | If `true`, the list contains more streams to output.<br/><br/>**Type**: Boolean |
| `StreamNames` | The name of a stream.<br/><br/>**Type**: String<br/>**Size**: `1`-`128` characters.<br/>**Possible values**: `[a-zA-Z][a-zA-Z0-9-]+*(?<!-)$` |

## Errors {#errors}

| Parameter | Description |
----- | -----
| `LimitExceededException` | The request limit is exceeded. | 400 |

[Errors](../common-errors.md) that are common to all methods may occur.
