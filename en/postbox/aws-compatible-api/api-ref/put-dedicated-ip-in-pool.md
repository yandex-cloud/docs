# PutDedicatedIpInPool method

Moves a [dedicated IP address](../../concepts/glossary.md#dedicated-ip) into the specified [pool](../../concepts/glossary.md#dedicated-ip-pool). The folder is selected based on the service account the request originates from.

The same IP address can belong only to one pool at any given time. To delete an IP address from a custom pool, move it to `ses-default-dedicated-pool`.

The operation is idempotent: moving an IP address to the exact same pool will succeed.

## Request {#request}

```http
PUT /v2/email/dedicated-ips/{IP}/pool HTTP/2
```

### Path parameters {#path-parameters}

#|
|| **Parameter** | **Description** ||
|| `IP` | **Type**: String.

The dedicated IP address you want to move. ||
|#

### Request headers {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

### Request body {#request-body}

```json
{
  "DestinationPoolName": "<destination_pool_name>"
}
```

#|
|| **Parameter** | **Description** ||
|| `DestinationPoolName` | **Type**: String.

Name of the pool to move the IP address to. ||

|#

## Responses {#responses}

### 200 OK {#200}

{% include [api-response-200](../../../_includes/postbox/api-response-200.md) %}

### Errors {#errors}

{% include [api-errors](../../../_includes/postbox/api-errors.md) %}

The possible errors include:

#|
|| **Error code** | **Description** ||
|| `400 BadRequestException` | The request contains invalid headers or parameters. ||
|| `404 NotFoundException` | IP address was not found or does not belong to your cloud, or the destination pool does not exist. ||
|| `429 TooManyRequestsException` | The request [quota](../../concepts/limits.md#postbox-quotas) was exceeded. ||
|#

The system searches for the IP address first, then the pool. If both the IP address and the pool name are invalid, you will get an IP address error.
