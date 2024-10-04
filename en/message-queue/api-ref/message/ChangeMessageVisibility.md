# ChangeMessageVisibility

Method for setting the visibility timeout for a message that is being processed. The total timeout of a message cannot exceed 12 hours.

Example: there is a message with a visibility timeout of 5 minutes. After 3 minutes, `ChangeMessageVisibility` is called with a timeout of 10 minutes. You can extend the visibility timeout by gradually increasing the value of `MessageVisibility` until the allowed maximum is reached. If the total timeout exceeds 12 hours, the request is rejected.

If you attempt to set the visibility timeout to a value greater than the maximum time left, Message Queue returns an error.

The timeout value set for a message using `ChangeMessageVisibility` is not saved in memory forever. If you don't delete a message after it is received, the visibility timeout for the message reverts to the original timeout value the next time the message is received.

For more information about message visibility, see [Messages](../../concepts/message.md) and [Visibility timeout](../../concepts/visibility-timeout.md).

## Request {#request}

### Request parameters {#request-parameters}

Parameter | Type | Required parameter | Description
----- | ----- | ----- | -----
`QueueUrl` | **string** | Yes | URL of the queue where the message is placed.
`ReceiptHandle` | **string** | Yes | `ReceiptHandle` parameter from the `ReceiveMessage` request.
`VisibilityTimeout` | **integer** | Yes | New value of a [visibility timeout](../../concepts/visibility-timeout.md) for the queue, specified in seconds. Valid values: from 0 to 43200 seconds. The default value is: 30.

## Response {#response}

### Successful response fields {#response-parameters}

The response does not contain any fields.

### ChangeMessageVisibility errors {#errors}

For a list of errors common for all methods, see [{#T}](../common-errors.md).

HTTP code | Error ID | Description
----- | ----- | -----
400 | `MessageNotInflight` | The message is not being processed.
400 | `ReceiptHandleIsInvalid` | The specified `ReceiptHandle` is invalid.

## Sample request {#request-example}

```text
Action=ChangeMessageVisibility
&Version=2012-11-05
&QueueUrl=https://message-queue.{{ api-host }}/b1g8ad42m6he********/dj6000000000********/sample-queue
&ReceiptHandle=EAIgloPDh4gtKAI
&VisibilityTimeout=35
```

For more information about forming requests, see [General API request format](../index.md#api-request).

## Response example {#response-example}

```xml
<ChangeMessageVisibilityResponse>
    <ResponseMetadata>
        <RequestId>4ead5a64-f3b95d31-f3705dcf-150cb879-666abba2bcc160987e4d9e46********</RequestId>
    </ResponseMetadata>
</ChangeMessageVisibilityResponse>
```
