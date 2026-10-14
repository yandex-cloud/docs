# CreateDedicatedIpPool method

Creates a [pool of dedicated IP addresses](../../concepts/glossary.md#dedicated-ip-pool) in a folder. The folder is selected based on the service account the request originates from.

## Request {#request}

```http
POST /v2/email/dedicated-ip-pools HTTP/2
```

### Request headers {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

### Request body {#request-body}

```json
{
  "PoolName": "<pool_name>",
  "ScalingMode": "STANDARD",
  "Tags": [
    {
      "Key": "<label_key>",
      "Value": "<label_value>"
    }
  ]
}
```

#|
|| **Parameter** | **Description** ||
|| `PoolName` | **Type**: String.

Pool name. It must be unique within the cloud.

The allowed characters are lowercase Latin letters, digits, underscores (`_`), and hyphens (`-`). The name must be 1 to 64 characters long.

You cannot use names [reserved](../../concepts/dedicated-ip.md#reserved-pools) by the service. ||
|| `ScalingMode` | **Type**: String.

Pool scaling mode. The possible value is `STANDARD`.

This is an optional parameter. ||
|| `Tags` | **Type**: Array.

Pool label array.

This is an optional parameter. ||
|| `Key` | **Type**: String.

Label key. ||
|| `Value` | **Type**: String.

Label value. ||
|#

## Responses {#responses}

### 200 OK {#200}

{% include [api-response-200](../../../_includes/postbox/api-response-200.md) %}

### Errors {#errors}

{% include [api-errors](../../../_includes/postbox/api-errors.md) %}

The possible errors include:

#|
|| **Error code** | **Description** ||
|| `400 BadRequestException` | The request contains invalid headers or parameters. You also get this error if the pool name does not meet the requirements, a reserved pool name is specified, or `ScalingMode` is not equal to `STANDARD`. ||
|| `409 AlreadyExistsException` | A pool with this name already exists. Choose a different one. ||
|| `429 TooManyRequestsException` | The request [quota](../../concepts/limits.md#postbox-quotas) was exceeded. ||
|#
