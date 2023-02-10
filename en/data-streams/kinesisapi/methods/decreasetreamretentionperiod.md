# DecreaseStreamRetentionPeriod

Decreases the [message retention period](../../concepts/glossary.md#retention-time) in a stream.

Possible values: 4 hours, 12 hours, and 24 hours.

This operation may result in data loss. For example, if the retention period is reduced from 24 to 12 hours, data that has been in the stream for more than 12 hours becomes unavailable.

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
| `RetentionPeriodHours` | Message retention period, hours.<br/>Must be less than the current time.<br/><br/>**Type**: Integer<br/>**Possible values** `4`, `12`.<br/>**Required**: Yes. |
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
