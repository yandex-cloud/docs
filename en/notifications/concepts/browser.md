# In-browser push notifications

_In-browser push notifications_ are messages popping up in your browser.

Push notifications may inform you about new content, special offers, and other key updates. Browser notifications work across different platforms: desktops, smartphones, and tablets with any OS. Users do not need to install additional software to receive notifications, a standard browser is enough.

Push notifications are also supported in progressive web apps ([PWA](https://ru.wikipedia.org/wiki/Прогрессивное_веб-приложение)). A PWA is a web application that runs in a browser but also has mobile app features. For example, PWAs can work offline but do not require users to download updates; updates are deployed on the server side.

To send a notification to the browser over a secure channel, the user must subscribe to notifications through the notification server used by their browser. Then you need to create an endpoint for this user in the {{ cns-short-name }} notification channel.

{% include [limits-warning](../../_includes/notifications/limits-warning.md) %}

To set up push notifications:

1. In {{ cns-short-name }}, create the **{{ ui-key.yacloud.cns.type_web }}** channel.
1. From the user browser, call the JavaScript [subscribe](https://developer.mozilla.org/en-US/docs/Web/API/PushManager/subscribe#applications) method using a [Service Worker](https://developer.mozilla.org/ru/docs/Web/API/Service_Worker_API/Using_Service_Workers).

   When the method is called, the browser sends a request to its notification delivery server. For example, Google Chrome sends a request to Firebase Cloud Messaging (FCM), and Safari, to Apple Push Notification service (APNs). The response will return a [PushSubscription](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription) object.

1. Convert the object you got to JSON by calling the [toJSON](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription/toJSON) method.

1. Use this JSON when creating the endpoint. Through this endpoint, you will send notifications to the user.

1. To send a notification, create a message in {{ cns-short-name }} and specify the endpoint ID (ARN) as the recipient.

To send notifications to different users, create a database of endpoints for all users.

This is how push notifications are delivered:

1. Your web app initiates a notification through an in-browser push notification channel.
1. {{ cns-short-name }} receives the send command.
1. {{ cns-short-name }} sends notifications to the servers specified in the endpoints.
1. Notification servers (FCM, APNs) deliver notifications to user browsers.

## Aspects of using in-browser push notifications {#browser-features}

Using in-browser push notifications is similar to using mobile ones, yet there are some differences.

### Creating a push notification channel {#create-channel}

You can create a notification channel using the [create](../api-ref/create-platform-application.md) HTTP API method for the `PlatformApplications` resource in {{ cns-full-name }} or the method’s replacement for the CLI or SDK.

Provide `WEB` for the `Platform` parameter. The `PlatformPrincipal` and `PlatformCredential` attribute values are not used.

Example of creating an in-browser push notification channel for the HTTP API:

```bash
export IAM_TOKEN=<IAM_token>
curl \
  --header "Content-Type: application/x-www-form-urlencoded; charset=utf-8" \
  --header "Authorization: Bearer ${IAM_TOKEN}" \
  --data-urlencode "Action=CreatePlatformApplication" \
  --data-urlencode "ResponseFormat=JSON" \
  --data-urlencode "FolderId=b1g85uk96h3f********" \
  --data-urlencode "Name=test" \
  --data-urlencode "Platform=WEB" \
  "https://{{ cns-host }}/"
```

Where:
* `IAM_TOKEN`: [IAM token](../../iam/concepts/authorization/iam-token.md).
* `Action`: Operation type.
* `ResponseFormat`: Response format, JSON or XML.
* `FolderId`: [Folder ID](../../resource-manager/operations/folder/get-id.md).
* `Name`: Notification channel name, user-defined.

You can also create a notification channel [via the management console](../quickstart-browser.md#create-channel).

### Getting a VAPID key {#get-key}

Calling the subscribe Javascript method from the user’s browser is one of the steps of creating an endpoint. To call the subscribe method, you need a public VAPID key. You can get the VAPID key in the `VAPIDPublicKey` attribute of the [getAttributes](../api-ref/get-platform-application-attributes.md) HTTP API method for the `PlatformApplications` resource in {{ cns-full-name }} or the method’s replacement for the CLI or SDK.

Example of getting the parameters of an in-browser push notification channel for the HTTP API:

```bash
export IAM_TOKEN=<IAM_token>
curl \
  --header "Content-Type: application/x-www-form-urlencoded; charset=utf-8" \
  --header "Authorization: Bearer ${IAM_TOKEN}" \
  --data-urlencode "PlatformApplicationArn=arn:aws:sns::b1g7gh04hiav********:app/WEB/test" \
  --data-urlencode "Action=GetPlatformApplicationAttributes" \
  --data-urlencode "ResponseFormat=JSON" \
  "https://{{ cns-host }}/"
```

Where:
* `IAM_TOKEN`: [IAM token](../../iam/concepts/authorization/iam-token.md).
* `PlatformApplicationArn`: Notification channel ID (ARN).
* `Action`: Operation type.
* `ResponseFormat`: Response format, JSON or XML.

{% cut "Example of a successful response in JSON" %}

  ```json
  {
    "GetPlatformApplicationAttributesResponse": {
      "ResponseMetadata": {
        "RequestId":"1lOn********"
      },
      "GetPlatformApplicationAttributesResult": {
        "Attributes": {
          "CreatedAt": 1744743751,
          "Description": "",
          "LoggingPath": "",
          "Name": "test",
          "Platform": "WEB",
          "VAPIDPublicKey": "BCyZSlvKpYoRx_SaFpHtqyryq9lmutEyJ-hpeh_1jEcwTPvcJRtpv0VGw_zfOSZVjIzLCj5ggWgIyfW********"
        }
      }
    }
  }
  ```
{% endcut %}

You can also get the VAPID key using the management console. To do this:

1. In the [management console]({{ link-console-main }}), select the folder containing the notification channel.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
1. Select the channel of interest.
1. You will see the VAPID key value in the **{{ ui-key.yacloud.cns.field_vapid }}** field under **{{ ui-key.yacloud.common.overview }}**.

### Creating an endpoint {#create-endpoint}

You can create an endpoint using the [create](../api-ref/create-platform-endpoint.md) HTTP API method for the Endpoint resource in {{ cns-full-name }} or the method’s replacement for the CLI or SDK.

To create an endpoint, you need a PushSubscription object in JSON format obtained through the user's browser. You need to provide the PushSubscription object in the `Token` parameter.

{% cut "Example of a PushSubscription object in JSON format" %}

   ```json
   {
    "endpoint": "https://fcm.googleapis.com/fcm/send/abcdef123456",
    "expirationTime": 1704093740000,
    "keys": {
      "p256dh": "BOrLkr7sEt8tERyAv6c8ZG5UC********",
      "auth": "aBcDeFg12345"
    }
   }
   ```
{% endcut %}

Example of creating an endpoint for the HTTP API:

```bash
export IAM_TOKEN=<IAM_token>
curl \
  --header "Content-Type: application/x-www-form-urlencoded; charset=utf-8" \
  --header "Authorization: Bearer ${IAM_TOKEN}" \
  --data-urlencode "PlatformApplicationArn=arn:aws:sns::b1g7gh04hiav********:app/WEB/test" \
  --data-urlencode "Action=CreatePlatformEndpoint" \
  --data-urlencode "Token=<pushSubscription_JSON>" \
  --data-urlencode "CustomUserData=<user_data>" \
  --data-urlencode "ResponseFormat=JSON" \
  "https://{{ cns-host }}/"
```

Where:
* `IAM_TOKEN`: [IAM token](../../iam/concepts/authorization/iam-token.md).
* `PlatformApplicationArn`: Notification channel ID (ARN).
* `Action`: Operation type.
* `Token`: PushSubscription object, in JSON format obtained through the user's browser.
* `CustomUserData`: Other user data that can be stored together with the endpoint.
* `ResponseFormat`: Response format, JSON or XML.

You can create an endpoint [via the management console](../quickstart-browser.md#create-endpoint). When creating an endpoint, you will also need to provide a PushSubscription object in JSON format obtained through the user's browser.

### Sending notifications {#publish}

You can send a notification using the [publish](../api-ref/publish.md) HTTP API method for the Endpoint resource in {{ cns-full-name }} or the method’s replacement for the CLI or SDK.

You can send notifications using one of these methods:

* By sending the notification text in the `Message` parameter without providing text for a specific platform.

    Example of sending a notification in plain text for the HTTP API:
    ```bash
    export IAM_TOKEN=<IAM_token>
    curl \
      --header "Content-Type: application/x-www-form-urlencoded; charset=utf-8" \
      --header "Authorization: Bearer ${IAM_TOKEN}" \
      --data-urlencode "TargetArn=<endpoint_ID>" \
      --data-urlencode "Action=Publish" \
      --data-urlencode "Message=<notification_text>" \
      --data-urlencode "ResponseFormat=json" \
      "https://{{ cns-host }}/"
    ```

    Where:
    * `IAM_TOKEN`: [IAM token](../../iam/concepts/authorization/iam-token.md).
    * `TargetArn`: Endpoint ID (ARN).
    * `Action`: Operation type.
    * `Message`: Message you want to send to the endpoint.
    * `ResponseFormat`: Response format, JSON or XML.

* By providing the default text and text for a specific platform. In which case the notification is likewise provided via the `Message` parameter but in JSON format. You need to additionally specify the `MessageStructure=json` parameter. The `WEB` line will be the key for the platform when sending a notification to the browser.

    Example of sending a notification in JSON format for the HTTP API:
    ```bash
    export IAM_TOKEN=<IAM_token>
    curl \
      --header "Content-Type: application/x-www-form-urlencoded; charset=utf-8" \
      --header "Authorization: Bearer ${IAM_TOKEN}" \
      --data-urlencode "TargetArn=<endpoint_ID>" \
      --data-urlencode "Action=Publish" \
      --data-urlencode "Message={ "default": "<default_text>", "WEB": "<text_for_browser>" }" \
      --data-urlencode "MessageStructure=json" \
      --data-urlencode "ResponseFormat=json" \
      "https://{{ cns-host }}/"
    ```

    Where:
    * `IAM_TOKEN`: [IAM token](../../iam/concepts/authorization/iam-token.md).
    * `TargetArn`: Mobile endpoint ID (ARN).
    * `Action`: Operation type.
    * `Message`: Notification in `json` format.
    * `MessageStructure`: Notification format (`json`).
    * `ResponseFormat`: Response format, JSON or XML.

You can also send a notification without providing text for a specific platform [via the management console](../quickstart-browser.md#publish).

#### See also {#see-also}

* [Service overview](index.md)
* [Getting started with push notifications](../quickstart-push.md)
* [Getting started with the service via the AWS CLI](../tools/aws-cli.md)
* [SMS](sms.md)