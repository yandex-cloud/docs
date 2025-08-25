# PutConfigurationSetDeliveryOptions method

Updates delivery settings for a [configuration](../../concepts/glossary.md#configuration) in a folder. The folder is selected based on the service account the request originates from.

## Query {#request}

```http
PUT /v2/email/configuration-sets/{ConfigurationSetName}/delivery-options HTTP/2
```

### Path parameters {#path-parameters}

#|
|| **Parameter** | **Description** ||
|| `ConfigurationSetName` | **Type**: String.

Name of the configuration to update.
|#

### Request headers {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

### Request body {#request-body}

```json
{
   "TlsPolicy": "REQUIRE|OPTIONAL"
}
```

#|
|| **Parameter** | **Description** ||
|| `TlsPolicy` | **Type**: String.

Outgoing connection security policy.

It specifies whether or not to use the TLS protocol for the messages with this configuration. If the value is `REQUIRE`, messages will be delivered only when it is possible to establish a TLS connection. If `OPTIONAL`, messages may be delivered as plain text if a TLS connection is not established.||

|#

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
|| `429 TooManyRequestsException ` | The request [quota](../../concepts/limits.md#postbox-quotas) was exceeded. ||
|#
