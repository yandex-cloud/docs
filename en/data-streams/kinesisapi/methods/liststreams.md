# ListStreams

Returns a list of [streams](../../concepts/glossary.md#stream-concepts).

The `HasMoreStreams` response parameter indicates there are more streams to retrieve. To fetch remaining streams, use the last returned stream name as the `ExclusiveStartStreamName` parameter in your subsequent request.

## Request {#request}

The request contains JSON-formatted data.

```json
{
  "ExclusiveStartStreamName": "string",
  "Limit": number
}
```

### Request options {#request-options}

Option | Description
----- | -----
`ExclusiveStartStreamName` | The name of the stream where output should begin<br/><br/>**Type**: String<br/>**Size**: `1`-`128` characters.<br/>**The possible values are**: `[a-zA-Z0-9_.-]+`<br/>**Required**: No
`Limit` | The maximum number of streams in the list. If you specify a value greater than `100`, the response will contain `100` streams.<br/><br/>**Type**: Integer<br/>**Allowed values**: `1`-`10000`.<br/>**Default value**: `100`<br/>**Required**: No

## Response {#response}

Successful requests return HTTP 200 with a JSON-formatted response body.

```json
{
  "HasMoreStreams": boolean,
  "StreamNames": ["string"]
}
```

### Response parameters {#response-options}

Parameter | Description
----- | -----
`HasMoreStreams` | If `true`, the list contains more streams to retrieve.<br/><br/>**Type**: Boolean
`StreamNames` | Data stream name.<br/><br/>**Type**: String<br/>**Size**: `1`-`128` characters.<br/>**The possible values are**: `[a-zA-Z][a-zA-Z0-9-]+*(?<!-)$`

## Errors {#errors}

Error | Description
----- | -----
`LimitExceededException` | The request limit is exceeded. | 400

[Errors](../common-errors.md) common to all methods may occur.
