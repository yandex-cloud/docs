# UpdateConfigurationSetEventDestination method

Updates [subscription](../../concepts/glossary.md#subscription) for a [configuration](../../concepts/glossary.md#configuration) within a folder. The folder is selected based on the service account the request originates from.

## Request {#request}

```http
PUT /v2/email/configuration-sets/{ConfigurationSetName}/event-destinations/{EventDestinationName} HTTP/2
```

### Path parameters {#path-parameters}

#|
|| **Parameter** | **Description** ||
|| `ConfigurationSetName` | **Type**: String.

Configuration name. ||
|| `EventDestinationName` | **Type**: String.

Name of the subscription to update.
|#

### Request headers {#request-headers}

{% include [api-request-headers](../../../_includes/postbox/api-request-headers.md) %}

### Request body {#request-body}

```json
{
  "EventDestination": {
    "Enabled": <subscription_state>,
    "KinesisFirehoseDestination": {
      "IamRoleArn": "<compatibility_parameter>",
      "DeliveryStreamArn": "<data_stream>"
    }
  }
}
```

#|
|| **Parameter** | **Description** ||
|| `EventDestination` | **Type**: Object.

Object containing the subscription parameters. ||
|| `Enabled` | **Type**: Boolean.

Subscription state: `true` for enabled, `false` for disabled. If the subscription is enabled, email delivery notifications will go to the specified stream. ||
|| `KinesisFirehoseDestination` | **Type**: Object.

Object defining the destination for notifications. ||
|| `IamRoleArn` | **Type**: String.

Used only for compatibility with AWS. ||
|| `DeliveryStreamArn` | **Type**: String.

{{ yds-full-name }} data stream notifications are sent to.

Format: `arn:yc:yds:<region>::<endpoint>:<stream name>`. You can copy the endpoint from the stream's **{{ ui-key.yacloud.ydb.overview.label_kinesis-endpoint }}** field in {{ yds-name }}.

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
|| `429 TooManyRequestsException ` | The request [quota](../../concepts/limits.md#postbox-quotas) was exceeded. ||
|#