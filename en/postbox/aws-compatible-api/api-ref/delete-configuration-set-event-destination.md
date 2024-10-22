# DeleteConfigurationSetEventDestination method

Deletes a [subscription](../../concepts/glossary.md#subscription) for a [configuration](../../concepts/glossary.md#configuration) in a folder. The folder is selected based on the service account the request originates from.

## Request {#request}

```http
DELETE /v2/email/configuration-sets/{ConfigurationSetName}/event-destinations/{EventDestinationName} HTTP/2
```

### Path parameters {#path-parameters}

#|
|| **Parameter** | **Description** ||
|| `ConfigurationSetName` | **Type**: String.

Configuration name. ||
|| `EventDestinationName` | **Type**: String.

Name of the subscription to delete. ||
|#

### Request headers {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

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