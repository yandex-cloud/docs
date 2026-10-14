# GetDedicatedIp method

Returns information about a [dedicated IP address](../../concepts/glossary.md#dedicated-ip) in a folder. The folder is selected based on the service account the request originates from.

## Request {#request}

```http
GET /v2/email/dedicated-ips/{IP} HTTP/2
```

### Path parameters {#path-parameters}

#|
|| **Parameter** | **Description** ||
|| `IP` | **Type**: String.

Dedicated IP address. ||
|#

### Request headers {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

## Responses {#responses}

### 200 OK {#200}

```json
{
  "DedicatedIp": {
    "Ip": "<IP_address>",
    "WarmupStatus": "DONE",
    "WarmupPercentage": 100,
    "PoolName": "<pool_name>"
  }
}
```

#|
|| **Parameter** | **Description** ||
|| `Ip` | **Type**: String.

Dedicated IP address. ||
|| `WarmupStatus` | **Type**: String.

IP [warm-up](../../concepts/dedicated-ip.md#warmup) status. It always returns `DONE`. ||
|| `WarmupPercentage` | **Type**: Integer.

IP warm-up completion percentage. It always returns `100`. ||
|| `PoolName` | **Type**: String.

Name of the [pool](../../concepts/glossary.md#dedicated-ip-pool) the IP address belongs to. ||

|#

The `200 OK` response may contain additional parameters. Its format may vary slightly from the above.

### Errors {#errors}

{% include [api-errors](../../../_includes/postbox/api-errors.md) %}

The possible errors include:

#|
|| **Error code** | **Description** ||
|| `400 BadRequestException` | The request contains invalid headers or parameters, or the `IP` parameter value is not a valid IP address. ||
|| `404 NotFoundException` | The IP address was not found or does not belong to your cloud. ||
|| `429 TooManyRequestsException` | The request [quota](../../concepts/limits.md#postbox-quotas) was exceeded. ||
|#
