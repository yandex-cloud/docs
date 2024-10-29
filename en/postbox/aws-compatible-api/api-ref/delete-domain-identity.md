# DeleteDomainIdentity method

This method deletes an [address](../../concepts/glossary.md#adress) in a folder. The folder is selected based on the service account the request originates from.

## Request {#request}

```http
DELETE /v2/email/identities/{DomainIdentity} HTTP/2
```

### Path parameters {#path-parameters}

#|
|| **Parameter** | **Description** ||
|| `DomainIdentity` | **Type**: String.

Address to delete. The minimum length is one character. ||
|#

### Request headers {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

## Responses {#responses}

### 200 OK {#200}

{% include [api-response-200](../../../_includes/postbox/api-response-200.md) %}

### Errors {#errors}

{% include [api-errors](../../../_includes/postbox/api-errors.md) %}

Possible errors:

#|
|| **Error code** | **Description** ||
|| `400 BadRequestException` | The request contains invalid headers or parameters. ||
|| `404 NotFoundException` | The requested resource was not found. ||
|| `409 ConcurrentModificationException` | The resource is already in use. Wait for the operation to complete and repeat your request. ||
|| `429 TooManyRequestsException` | The request [quota](../../concepts/limits.md#postbox-quotas) was exceeded. ||
|| `429 LimitExceededException` | The request [limit](../../concepts/limits.md) was exceeded. ||
|#