# PutConfigurationSetDeliveryOptions method

Updates delivery settings for a [configuration](../../concepts/glossary.md#configuration) in a folder. The folder is selected based on the service account the request originates from.

## Request {#request}

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
   "TlsPolicy": "REQUIRE|OPTIONAL",
   "SendingPoolName": "<pool_name>"
}
```

#|
|| **Parameter** | **Description** ||
|| `TlsPolicy` | **Type**: String.

Outgoing connection security policy.

Specifies whether or not to use the TLS protocol for mail covered by the configuration. If `REQUIRE`, emails will be delivered only provided that a TLS connection can be established. If `OPTIONAL`, emails may be delivered as plain text if a TLS connection cannot be established.||
|| `SendingPoolName` | **Type**: String.

Name of the [pool](../../concepts/dedicated-ip.md) of IP addresses that will be used to send emails covered by the configuration.

This is an optional parameter. ||
|#

{% note warning %}

This method completely updates the configuration's delivery settings. If you do not specify `SendingPoolName` during the call, the pool will be unlinked from the configuration, and emails will be sent from the service’s shared IP addresses.

{% endnote %}

{% note info %}

{% include [no-ip-address-in-pool-note.md](../../../_includes/postbox/no-ip-address-in-pool-note.md) %}

{% endnote %}

## Responses {#responses}

### 200 OK {#200}

{% include [api-response-200](../../../_includes/postbox/api-response-200.md) %}

### Errors {#errors}

{% include [api-errors](../../../_includes/postbox/api-errors.md) %}

The possible errors include:

#|
|| **Error code** | **Description** ||
|| `400 BadRequestException` | The request contains invalid headers or parameters, or the pool specified in `SendingPoolName` does not exist. ||
|| `404 NotFoundException` | The requested resource was not found. ||
|| `429 TooManyRequestsException ` | The request [quota](../../concepts/limits.md#postbox-quotas) was exceeded. ||
|#
