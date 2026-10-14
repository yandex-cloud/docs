# DeleteDedicatedIpPool method

Deletes a [dedicated IP address pool](../../concepts/glossary.md#dedicated-ip-pool) in a folder. The folder is selected based on the service account the request originates from.

{% include [delete-dedicated-ip-pool-note.md](../../../_includes/postbox/delete-dedicated-ip-pool-note.md) %}

## Request {#request}

```http
DELETE /v2/email/dedicated-ip-pools/{PoolName} HTTP/2
```

### Path parameters {#path-parameters}

#|
|| **Parameter** | **Description** ||
|| `PoolName` | **Type**: String.

Name of the pool to delete. ||
|#

### Request headers {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

## Responses {#responses}

### 200 OK {#200}

{% include [api-response-200](../../../_includes/postbox/api-response-200.md) %}

### Errors {#errors}

{% include [api-errors](../../../_includes/postbox/api-errors.md) %}

The possible errors include:

#|
|| **Error code** | **Description** ||
|| `400 BadRequestException` | The request contains invalid headers or parameters, or the pool is assigned to a configuration. ||
|| `404 NotFoundException` | No pool of that name was found. ||
|| `429 TooManyRequestsException` | The request [quota](../../concepts/limits.md#postbox-quotas) was exceeded. ||
|#
