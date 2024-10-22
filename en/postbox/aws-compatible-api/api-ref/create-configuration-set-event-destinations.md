# CreateConfigurationSetEventDestinations method

Creates a [subscription](../../concepts/glossary.md#subscription) for a [configuration](../../concepts/glossary.md#configuration) in a folder. The folder is selected based on the service account the request originates from.

## Request {#request}

```http
POST /v2/email/configuration-sets/{ConfigurationSetName}/event-destinations HTTP/2
```

### Path parameters {#path-parameters}

#|
|| **Parameter** | **Description** ||
|| `ConfigurationSetName` | **Type**: String.

Configuration name. ||
|#

### Request headers {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

### Request body {#request-body}

```json
{
  "EventDestinationName": "<subscription_name>",
  "EventDestination": {
    "Enabled": <subscription_state>,
    "KinesisFirehoseDestination": {
      "IamRoleArn": "<role>",
      "DeliveryStreamArn": "<data_stream>"
    }
  }
}
```

#|
|| **Parameter** | **Description** ||
|| `EventDestinationName` | **Type**: String.

Subscription name. ||
|| `EventDestinations` | **Type**: Object.

Object with subscription parameters. ||
|| `Enabled` | **Type**: Boolean.

Subscription state: `true` for enabled, `false` for disabled. If the subscription is enabled, email delivery notifications are sent to the specified stream. ||
|| `KinesisFirehoseDestination` | **Type**: Object.

Object which sets the destination for notifications. ||
|| `IamRoleArn` | **Type**: String.

This parameter is not used. It is provided for compatibility with AWS. ||
|| `DeliveryStreamArn` | **Type**: String.

Data stream in {{ yds-full-name }} notifications are sent to.

Format: `arn:yc:yds:<region>::<endpoint>:<stream name>`. You can copy the endpoint from the **{{ ui-key.yacloud.ydb.overview.label_kinesis-endpoint }}** field of the appropriate stream in {{ yds-name }}.

{% cut "Example" %}

`arn:yc:yds:ru-central1::https://yds.serverless.yandexcloud.net/ru-central1/b1gkgm9daf9605nj****/etn5nuveugdr18ak****:postbox`

{% endcut %} ||
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
|| `409 AlreadyExistsException` | A subscription with this name already exists. Specify a different name. ||
|| `409 ConcurrentModificationException` | There are conflicting operations. Wait for the previous operation to complete and repeat your request. ||
|| `429 TooManyRequestsException` | The request exceeded the [quota](../../concepts/limits.md#postbox-quotas). ||
|| `429 LimitExceededException` | The request exceeded the [limit](../../concepts/limits.md). ||
|#
