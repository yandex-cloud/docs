# GetConfigurationSets method

Returns [configuration](../../concepts/glossary.md#configuration) information in the folder. The folder is selected based on the service account the request originates from.

## Request {#request}

```http
GET /v2/email/configuration-sets/{ConfigurationSetName} HTTP/2
```

### Path parameters {#path-parameters}

#|
|| **Parameter** | **Description** ||
|| `ConfigurationSetName` | **Type**: String.

Configuration name. ||
|#

### Request headers {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

## Responses {#responses}

### 200 OK {#200}

```json
{
  "ConfigurationSetName": "<configuration_name>",
  "Tags": [
    {
      "Key": "key_1",
      "Value": "value_1"
    },
    ...
    {
      "Key": "key_N",
      "Value": "value_N"
    }
  ]
}
```

#|
|| **Parameter** | **Description** ||
|| `ConfigurationSetName` | **Type**: String.

Configuration name. ||
|| `Tags` | **Type**: Array.

Label array for configuration. ||
|| `Key` | **Type**: String.

Label key. ||
|| `Value` | **Type**: String.

Label value. ||
|#

The `200 OK` response may contain additional parameters. Its format may vary slightly from the above.

### Errors {#errors}

{% include [api-errors](../../../_includes/postbox/api-errors.md) %}

Possible errors:

#|
|| **Error code** | **Description** ||
|| `400 BadRequestException` | The request contains invalid headers or parameters. ||
|| `404 NotFoundException` | The requested resource was not found. ||
|| `429 TooManyRequestsException` | The request [quota](../../concepts/limits.md#postbox-quotas) was exceeded. ||
|#
