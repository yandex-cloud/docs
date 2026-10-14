# ListDedicatedIpPools method

Returns the list of [dedicated IP address pools](../../concepts/glossary.md#dedicated-ip-pool) in the folder. The folder is selected based on the service account the request originates from.

[Reserved pools](../../concepts/dedicated-ip.md#reserved-pools) are not returned in the output.

## Request {#request}

```http
GET /v2/email/dedicated-ip-pools HTTP/2
```

### Query parameters {#query-parameters}

#|
|| **Parameter** | **Description** ||
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
  "DedicatedIpPools": [
    "<pool_1_name>",
    "<pool_2_name>",
    ...
    "<pool_N_name>"
  ],
  "NextToken": "<token>"
}
```

#|
|| **Parameter** | **Description** ||
|| `DedicatedIpPools` | **Type**: Array.

Array of pool names. Each name is provided as a separate string. ||
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
|| `429 TooManyRequestsException` | The request [quota](../../concepts/limits.md#postbox-quotas) was exceeded. ||
|#
