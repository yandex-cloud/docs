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

Possible errors:

#|
|| **Error code** | **Description** ||
|| `400 BadRequestException` | The request contains invalid headers or parameters. ||
|| `404 NotFoundException` | The requested resource was not found. ||
|| `409 AlreadyExistsException` | A configuration with this name already exists. Specify a different name. ||
|| `409 ConcurrentModificationException` | There are conflicting operations. Wait for the previous operation to complete and repeat your request. ||
|| `429 TooManyRequestsException` | The request exceeded the [quota](../../concepts/limits.md#postbox-quotas). ||
|| `429 LimitExceededException` | The request exceeded the [limit](../../concepts/limits.md). ||
|#
