# DeleteSuppressedDestination method

Deletes an address from the [custom suppression list](../../concepts/suppression-list.md#user). The cloud is determined based on the service account the request originates from.

## Request {#request}

```http
DELETE /v2/email/suppression/addresses/{EmailAddress} HTTP/2
```

### Path parameters {#path-parameters}

#|
|| **Parameter** | **Description** ||
|| `EmailAddress` | **Type**: String.

Recipient's address you need to delete from the suppression list. Use percent encoding, e.g., `user%40example.com`. ||
|#

### Request headers {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

## Responses {#responses}

### 200 OK {#200}

{% include [api-response-200](../../../_includes/postbox/api-response-200.md) %}

If the specified address is not on the suppression list, the request completes successfully too.

### Errors {#errors}

{% include [api-errors](../../../_includes/postbox/api-errors.md) %}

The possible errors include:

#|
|| **Error code** | **Description** ||
|| `400 BadRequestException` | The request gives an empty or invalid address. ||
|| `403` | Not enough permissions to execute the request. ||
|| `429 TooManyRequestsException` | The request [quota](../../concepts/limits.md#postbox-quotas) was exceeded. ||
|#
