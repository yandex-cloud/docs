# PutSuppressedDestination method

Adds an address to the [custom suppression list](../../concepts/suppression-list.md#user). The cloud is determined based on the service account the request originates from.

## Request {#request}

```http
PUT /v2/email/suppression/addresses HTTP/2
```

### Request headers {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

### Request body {#request-body}

```json
{
   "EmailAddress": "user@example.com",
   "Reason": "BOUNCE|COMPLAINT"
}
```

#|
|| **Parameter** | **Description** ||
|| `EmailAddress` | **Type**: String.

The recipient's address to add to the suppression list. ||
|| `Reason` | **Type**: String.

This is a required setting. [Reason](../../concepts/suppression-list.md#reasons) to add the address to the suppression list: `BOUNCE` or `COMPLAINT`. ||
|#

If the address is already on the suppression list, a new entry is not created: the reason and time of the change are updated for the current entry, and the creation time is preserved.

## Responses {#responses}

### 200 OK {#200}

{% include [api-response-200](../../../_includes/postbox/api-response-200.md) %}

### Errors {#errors}

{% include [api-errors](../../../_includes/postbox/api-errors.md) %}

The possible errors include:

#|
|| **Error code** | **Description** ||
|| `400 BadRequestException` | The request contains an empty or invalid address, or the reason is not specified or is not equal to `BOUNCE` or `COMPLAINT`. ||
|| `403` | Not enough permissions to execute the request. ||
|| `429 TooManyRequestsException` | The request [quota](../../concepts/limits.md#postbox-quotas) was exceeded. ||
|#
