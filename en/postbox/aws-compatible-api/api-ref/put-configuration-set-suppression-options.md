# PutConfigurationSetSuppressionOptions method

Updates the [suppression list](../../concepts/suppression-list.md) settings for the [configuration](../../concepts/glossary.md#configuration) in the folder. The folder is selected based on the service account the request originates from.

## Request {#request}

```http
PUT /v2/email/configuration-sets/{ConfigurationSetName}/suppression-options HTTP/2
```

### Path parameters {#path-parameters}

#|
|| **Parameter** | **Description** ||
|| `ConfigurationSetName` | **Type**: String.

Name of the configuration to update. ||
|#

### Request headers {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

### Request body {#request-body}

```json
{
   "SuppressedReasons": ["BOUNCE", "COMPLAINT"]
}
```

#|
|| **Parameter** | **Description** ||
|| `SuppressedReasons` | **Type**: Array.

[Reasons](../../concepts/suppression-list.md#reasons) why the address from the suppression list blocks the send. The possible values of the array's items are `BOUNCE` and `COMPLAINT`.

If there is a `COMPLAINT` value in the array, the addresses are automatically added to the suppression list due to complaints from recipients.

If the array is empty, the suppression list does not block sending of emails, and addresses are not added to it automatically. ||
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
|| `403` | Not enough permissions to execute the request. ||
|| `404 NotFoundException` | The requested resource was not found. ||
|| `429 TooManyRequestsException` | The request [quota](../../concepts/limits.md#postbox-quotas) was exceeded. ||
|#
