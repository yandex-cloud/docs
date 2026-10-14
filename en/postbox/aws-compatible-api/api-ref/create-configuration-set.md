# CreateConfigurationSet method

Creates a [configuration](../../concepts/glossary.md#configuration) in a folder. The folder is selected based on the service account the request originates from.

## Request {#request}

```http
POST /v2/email/configuration-sets HTTP/2
```

### Request headers {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

### Request body {#request-body}

```json
{
  "ConfigurationSetName": "<configuration_name>",
  "SuppressionOptions": {
    "SuppressedReasons": ["BOUNCE", "COMPLAINT"]
  },
  "DeliveryOptions": {
    "TlsPolicy": "REQUIRE|OPTIONAL",
    "SendingPoolName": "<pool_name>"
  },
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
|| `ConfigurationSetName` | **Type**: String.

Configuration name.  ||

|| `SuppressionOptions` | **Type**: Object.

[Suppression list](../../concepts/suppression-list.md) settings for your configuration. Contains the `SuppressedReasons` array. ||
|| `SuppressedReasons` | **Type**: Array.

[Reasons](../../concepts/suppression-list.md#reasons) why the address from the suppression list blocks the send. Possible array item values: `BOUNCE` and `COMPLAINT`.

If there is a `COMPLAINT` value in the array, the addresses are automatically added to the suppression list due to complaints from recipients. ||
|| `DeliveryOptions` | **Type**: Object.

Delivery settings for emails sent using the configuration.

This is an optional parameter. You can modify the delivery settings for an existing configuration using the [PutConfigurationSetDeliveryOptions](put-configuration-set-delivery-options.md) method. ||

|| `TlsPolicy` | **Type**: String.

Outgoing connection security policy.

Specifies whether or not to use the TLS protocol for mail covered by the configuration. If `REQUIRE`, emails will be delivered only provided that a TLS connection can be established. If `OPTIONAL`, emails may be delivered as plain text if a TLS connection cannot be established. ||
|| `SendingPoolName` | **Type**: String.

Name of the [pool](../../concepts/dedicated-ip.md) of IP addresses that will be used to send emails covered by the configuration.

This is an optional parameter. ||
|| `Tags` | **Type**: Array.

Array of labels for the configuration.

The maximum number of labels is 50. ||
|| `Key` | **Type**: String.

Label key.

The keyword may be from 1 to 63 characters long. ||
|| `Value` | **Type**: String.

Label value.

The label value may be from 0 (no value) to 256 characters long. ||
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
|| `404 NotFoundException` | The requested resource was not found. ||
|| `409 AlreadyExistsException` | A configuration of this name already exists. Choose a different one. ||
|| `409 ConcurrentModificationException` | There are conflicting operations. Wait for the previous operation to complete and repeat your request. ||
|| `429 TooManyRequestsException` | The request [quota](../../concepts/limits.md#postbox-quotas) was exceeded. ||
|| `429 LimitExceededException` | The request [limit](../../concepts/limits.md) was exceeded. ||
|#
