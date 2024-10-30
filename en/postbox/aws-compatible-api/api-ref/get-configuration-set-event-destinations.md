# GetConfigurationSetEventDestinations method

Returns information about [subscriptions](../../concepts/glossary.md#subscription) for a [configuration](../../concepts/glossary.md#configuration) in a folder. The folder is selected based on the service account the request originates from.

## Request {#request}

```http
GET /v2/email/configuration-sets/{ConfigurationSetName}/event-destinations HTTP/2
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
  "EventDestinations": [
    {
      "Name": "<subscription_name>",
      "Enabled": <subscription_state>,
      "KinesisFirehoseDestination": {
        "DeliveryStreamArn": "<data_stream>"
      }
    }
  ]
}
```

#|
|| **Parameter** | **Description** ||
|| `EventDestinations` | **Type**: Array.

Array of subscriptions. ||
|| `Name` | **Type**: String.

Subscription name. ||
|| `Enabled` | **Type**: Boolean.

Subscription state: `true` for enabled, `false` for disabled. If the subscription is enabled, email delivery notifications are sent to the specified stream. ||
|| `KinesisFirehoseDestination` | **Type**: Object.

Object that specifies the destination for notifications. ||
|| `DeliveryStreamArn` | **Type**: String.

{{ yds-full-name }} data stream notifications will go to.

Format: `arn:yc:yds:<region>::<endpoint>:<stream name>`.

{% cut "Example" %}

`arn:yc:yds:ru-central1::https://yds.serverless.yandexcloud.net/ru-central1/b1gkgm9daf9605nj****/etn5nuveugdr18ak****:postbox`

{% endcut %} ||
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
