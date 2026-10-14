# GetDedicatedIpPool method

Returns information about a [dedicated IP address pool](../../concepts/glossary.md#dedicated-ip-pool) in a folder. The folder is selected based on the service account the request originates from.

## Request {#request}

```http
GET /v2/email/dedicated-ip-pools/{PoolName} HTTP/2
```

### Path parameters {#path-parameters}

#|
|| **Parameter** | **Description** ||
|| `PoolName` | **Type**: String.

Pool name.

You cannot use this method to get information about a [reserved pool](../../concepts/dedicated-ip.md#reserved-pools). ||
|#

### Request headers {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

## Responses {#responses}

### 200 OK {#200}

```json
{
  "DedicatedIpPool": {
    "PoolName": "<pool_name>",
    "ScalingMode": "STANDARD"
  }
}
```

#|
|| **Parameter** | **Description** ||
|| `PoolName` | **Type**: String.

Pool name. ||
|| `ScalingMode` | **Type**: String.

Pool scaling mode. It always returns `STANDARD`. ||
|#

The `200 OK` response may contain additional parameters. Its format may vary slightly from the above.

### Errors {#errors}

{% include [api-errors](../../../_includes/postbox/api-errors.md) %}

The possible errors include:

#|
|| **Error code** | **Description** ||
|| `400 BadRequestException` | The request contains invalid headers or parameters, or info about a [reserved pools](../../concepts/dedicated-ip.md#reserved-pools) is requested. ||
|| `404 NotFoundException` | No pool of that name was found. ||
|| `429 TooManyRequestsException` | The request [quota](../../concepts/limits.md#postbox-quotas) was exceeded. ||
|#
