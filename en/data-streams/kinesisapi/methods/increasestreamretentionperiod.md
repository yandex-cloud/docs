# IncreaseStreamRetentionPeriod

Increases the [record retention period](../../concepts/glossary.md#retention-time) in a stream.

Available retention period options: 4 hours, 12 hours, 24 hours.

## Request {#request}

The request contains JSON-formatted data.

```json
{
  "RetentionPeriodHours": number,
  "StreamName": "string"
}
```

### Request options {#request-options}

Option | Description
----- | -----
`RetentionPeriodHours` | Record retention period, hours.<br/>Must be larger than the current value.<br/><br/>**Type**: Integer<br/>**Allowed values**: `12`, `24`.<br/>**Required**: Yes
`StreamName` | Data stream name.<br/><br/>**Type**: String<br/>**Size**: `1`-`128` characters.<br/>**The possible values are**: `[a-zA-Z][a-zA-Z0-9-]+*(?<!-)$`<br/>**Required**: Yes

## Response {#response}

Successful responses include an HTTP 200 code and an empty response body.

## Errors {#errors}

Error | Description | HTTP code
----- | ----- | -----
`InvalidArgumentException` | The argument is invalid. See the error message for details. | 400
`LimitExceededException` | The request limit is exceeded. | 400
`ResourceInUseException` | The resource is currently locked by another operation. | 400
`ResourceNotFoundException` | The requested resource was not found. | 400

[Errors](../common-errors.md) common to all methods may occur.
