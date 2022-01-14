# IncreaseStreamRetentionPeriod

Increases the [message retention period](../../concepts/glossary.md#retention-time) in a stream.

Possible values: 4 hours, 12 hours, and 24 hours.

## Request {#request}

The request contains data in JSON format.

```json
{
  "RetentionPeriodHours": number,
  "StreamName": "string"
}
```

### Request parameters {#request-options}

| Parameter | Description |
| ----- | ----- |
| `RetentionPeriodHours` | Message retention period, hours.<br/>Must be greater than the current time.<br/><br/>**Type**: Integer<br/>**Possible values** `12`, `24`.<br/>**Required**: Yes. |
| `StreamName` | The name of a stream.<br/><br/>**Type**: String<br/>**Size**: `1`-`128` characters.<br/>**Possible values**: `[a-zA-Z][a-zA-Z0-9-]+*(?<!-)$`<br/>**Required**: Yes |

## Response {#response}

If successful, an HTTP 200 code and empty body are returned.

## Errors {#errors}

| Parameter | Description | HTTP code |
| ----- | ----- | ----- |
| `InvalidArgumentException` | The argument is invalid. For more information, see the error message. | 400 |
| `LimitExceededException` | The request limit is exceeded. | 400 |
| `ResourceInUseException` | The resource is being used by another operation. | 400 |
| `ResourceNotFoundException` | The requested resource was not found. | 400 |

[Errors](../common-errors.md) that are common to all methods may occur.
