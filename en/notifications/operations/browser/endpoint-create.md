---
title: Creating an endpoint for in-browser notifications
description: Follow this guide to create an endpoint for in-browser push notifications.
---

# Creating an endpoint

For each channel, you need to create a set of [endpoints](../../concepts/browser.md) through which to send notifications to specific users' browsers.

To create an endpoint:

1. From the user's browser, use [Service Worker](https://developer.mozilla.org/ru/docs/Web/API/Service_Worker_API/Using_Service_Workers) to call the JavaScript [subscribe](https://developer.mozilla.org/en-US/docs/Web/API/PushManager/subscribe#applications) method.

    The [PushSubscription](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription) object will be returned in response.

1. Convert the object you got into JSON by calling the [toJSON](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription/toJSON) method.

JSON response format:

```json
{
  "endpoint": <string>,
  "expirationTime": <DOMHighResTimeStamp,null>,
  "keys": {
    "p256dh": <string>,
    "auth": <string>
  }
}
```
Where:
* `endpoint`: URL the push notification will be sent to. Typically this is the address of a push notification server, e.g., Firebase Cloud Messaging (FCM).
* `expirationTime`: Notification lifetime in milliseconds. The `null` value represents unlimited lifetime.
* `keys`: Notification protection data:
    * `p256dh`: User's public key used to encrypt notification data.
    * `auth`: Authentication key to confirm the identity of the sender.

{% cut "Example response in JSON" %}

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
   
Once you have the data you need to send to notifications to a user, create an endpoint:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder containing the notification channel.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Select the **{{ ui-key.yacloud.cns.type_web }}** tab.
  1. Select a notification channel.
  1. Select the ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.cns.label_endpoints }}** tab.
  1. Click **{{ ui-key.yacloud.cns.action_create-endpoint }}**.
  1. Enter the **{{ ui-key.yacloud.cns.field_web-push-endpoint_params }}** received when subscribing the user.
  1. Optionally, enter **{{ ui-key.yacloud.cns.field_endpoint-user-data }}**, a [UTF-8](https://en.wikipedia.org/wiki/UTF-8) encoded text up to 2,048 characters long.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- AWS CLI {#aws-cli}

  1. If you do not have the AWS CLI yet, [install and configure it](../../../storage/tools/aws-cli.md).
  1. Run this command:

     ```bash
     aws sns create-platform-endpoint \
     --platform-application-arn <channel_ARN> \
     --token <pushSubscription_JSON>
     ```

     Where:

     * `--platform-application-arn`: Notification channel ID (ARN).
     * `--token`: [PushSubscription](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription) object, in [JSON](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription/toJSON) format received in the user's browser.

     For more information about the `aws sns create-platform-endpoint` command, see the [AWS documentation](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/create-platform-endpoint.html).

- AWS SDK for Python {#python}

  1. If you do not have the AWS SDK for Python (boto3) yet, [install and configure it](../../tools/sdk-python.md#aws-sdk).
  1. To create an endpoint, use the following code:

     ```python
     try:
      response = client.create_platform_endpoint(
        PlatformApplicationArn="<channel_ARN>",
        Token="<pushSubscription_JSON>",
      )
      print(f'Endpoint ARN: {response["EndpointArn"]}')

     except botocore.exceptions.ClientError as error:
      print(f"Error: {error}")
     ```

- AWS SDK for PHP {#php}

  1. If you do not have the AWS SDK for PHP yet, [install and configure it](../../tools/sdk-php.md#aws-sdk).
  1. To create an endpoint, use the following code:

      ```php
      $response = $client->createPlatformApplication(
        [
          'PlatformApplicationArn' => '<channel_ARN>',
          'Token' => '<pushSubscription_JSON>',
        ]
      );
      print('Endpoint ARN: ' . $response->get('EndpointArn'));
      ```

- AWS SDK for JavaScript {#javascript}

   1. If you do not have the AWS SDK for JavaScript yet, [install and configure it](../../tools/sdk-javascript.md).
   1. To create an endpoint, use the following code:

      ```javascript
      try {
        const response = await client.send(
          new AWS.CreatePlatformEndpointCommand({
            PlatformApplicationArn: "<channel_ARN>",
            Token: "<pushSubscription_JSON>",
          }),
        );
        console.log("Endpoint ARN:", response["EndpointArn"]);
      } catch (e) {
        console.log("Error:", e)
      }
      ```

- API {#api}

  Use the [create](../../api-ref/create-platform-endpoint.md) HTTP API method for the Endpoint resource in {{ cns-full-name }}.

{% endlist %}

Creating an endpoint may take some time.