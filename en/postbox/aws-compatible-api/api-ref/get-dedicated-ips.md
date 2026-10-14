# GetDedicatedIps method

Returns a list of [dedicated IP addresses](../../concepts/glossary.md#dedicated-ip) in a folder or [pool](../../concepts/glossary.md#dedicated-ip-pool). The folder is selected based on the service account the request originates from.

## Request {#request}

```http
GET /v2/email/dedicated-ips HTTP/2
```

### Query parameters {#query-parameters}

#|
|| **Parameter** | **Description** ||
|| `PoolName` | **Type**: String.

Pool name. If the parameter is specified, only IP address from this pool will be returned in the response.

This is an optional parameter. ||
|| `PageSize` | **Type**: Integer.

Maximum number of results you can get on one page in response to your request. If the number of results exceeds the `PageSize` value, the response returns the `NextToken` token to request the next results page.

This is an optional parameter. ||
|| `NextToken` | **Type**: String.

Token to get the next results page in response to a request. To do this, provide the `NextToken` value you get in response to your previous request.

This is an optional parameter. ||
|#


### Request headers {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

## Responses {#responses}

### 200 OK {#200}

```json
{
  "DedicatedIps": [
    {
      "Ip": "<IP_address>",
      "WarmupStatus": "DONE",
      "WarmupPercentage": 100,
      "PoolName": "<pool_name>"
    }
  ],
  "NextToken": "<token>"
}
```

#|
|| **Parameter** | **Description** ||
|| `DedicatedIps` | **Type**: Array.

Array of dedicated IP addresses. ||
|| `Ip` | **Type**: String.

Dedicated IP address. ||
|| `WarmupStatus` | **Type**: String.

IP [warm-up](../../concepts/dedicated-ip.md#warmup) status. It always returns `DONE`. ||
|| `WarmupPercentage` | **Type**: Integer.

IP warm-up completion percentage. It always returns `100`. ||
|| `PoolName` | **Type**: String.

Name of the pool the IP address belongs to. IP addresses not distributed among custom pools are in the default pool named `ses-default-dedicated-pool`. ||

|| `NextToken` | **Type**: String.

Token to get the next results page in response to a request. If the number of results exceeds the `PageSize` value, the response returns the `NextToken` token to request the next results page. Each page gets its own token for pagination. ||
|#

The `200 OK` response may contain additional parameters. Its format may vary slightly from the above.

### Errors {#errors}

{% include [api-errors](../../../_includes/postbox/api-errors.md) %}

The possible errors include:

#|
|| **Error code** | **Description** ||
|| `400 BadRequestException` | The request contains invalid headers or parameters, or an incorrect token is provided in the `NextToken` parameter. ||
|| `404 NotFoundException` | No pool of that name was found. ||
|| `429 TooManyRequestsException` | The request [quota](../../concepts/limits.md#postbox-quotas) was exceeded. ||
|#
