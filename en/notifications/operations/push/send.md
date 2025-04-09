---
title: Sending a push notification in {{ cns-full-name }}
description: Follow this guide to send a push notification.
---

# Sending a push notification

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder containing your endpoint.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Select a push notification channel.
  1. Navigate to the ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.cns.label_endpoints }}** tab.
  1. Select the endpoint you need.
  1. Select a notification format under **{{ ui-key.yacloud.cns.section_message-sending }}**: `Text` or `JSON`.
  1. Enter notification text or a JSON object with notification data.
  1. Click **{{ ui-key.yacloud.cns.action_send-msg }}**.

  Each sent notification is assigned a unique ID. To save it, click **{{ ui-key.yacloud.cns.action_copy-msg-id }}**.

  You can send a new notification immediately or resend the previous one.

- AWS CLI {#aws-cli}

  If you do not have the AWS CLI yet, [install and configure it](../../../storage/tools/aws-cli.md).

  **Explicit notifications (Bright Push)**

  To send an explicit notification, run this command:

  * Apple iOS (APNs)

      ```bash
      aws sns publish \
        --target-arn "<endpoint_ARN>" \
        --message-structure json \
        --message '{"default": "<notification_text>", "APNS": "{ \"aps\": { \"alert\": \"<notification_text>\"} }" }'
      ```

  * Google Android (FCM)

      ```bash
      aws sns publish \
        --target-arn "<endpoint_ARN>" \
        --message-structure json \
        --message '{"default": "<notification_text>", "GCM": "{ \"notification\": { \"body\": \"<notification_text>\"} }" }'
      ```

  Where:

  * `--target-arn`: Mobile endpoint ID (ARN)
  * `--message-structure`: Message format
  * `--message`: Message

  **Silent notifications (Silent Push)**

  To send a silent notification, run this command:

  ```bash
  aws sns publish \
    --target-arn <endpoint_ARN> \
    --message-structure json \
    --message '{"data": { "key": "value" } }'
  ```

  Where:

  * `--target-arn`: Mobile endpoint ID (ARN)
  * `--message-structure`: Message format
  * `--message`: Message

- AWS SDK for Python (boto3) {#python}

  If you do not have the AWS SDK for Python (boto3) yet, [install and configure it](../../tools/sdk-python.md#aws-sdk).

  **Explicit notifications (Bright Push)**

  To send an explicit notification, use this code:

  * Apple iOS (APNs)

      ```json
      response = client.publish(
          TargetArn="<endpoint_ID>",
          Message=json.dumps({
              "default": "<notification_text>",
              "APNS": json.dumps({
                  "aps": {
                      "alert": "<notification_text>"
                  }
              })
          }),
          MessageStructure="json"
      )
      print ("Message id:", response["MessageId"])
      ```

  * Google Android (FCM)

      ```python
      response = client.publish(
          TargetArn="<endpoint_ID>",
          Message=json.dumps({
              "default": "<notification_text>",
              "GCM": json.dumps({
                  "notification": {
                      "body": "<notification_text>"
                  }
              })
          }),
          MessageStructure="json"
      )
      print ("Message id:", response["MessageId"])
      ```

  * RuStore Android

      ```python
      response = client.publish(
          TargetArn="<endpoint_ID>",
          Message=json.dumps({
              "default": "<default_notification_text>",
              "RUSTORE": json.dumps({
                  "notification": {
                      "title": "<notification_title>",
                      "body": "<notification_text>",
                  }
              })
          }),
          MessageStructure="json"
      )
      message_id = response["MessageId"]
      print(f"Message id is: {message_id}")
      ```

  Where:

  * `TargetArn`: Mobile endpoint ID (ARN).
  * `MessageStructure`: Message format.
  * `Message`: Message.

  **Silent notifications (Silent Push)**

  To send a silent notification, use this code:

  ```python
  response = client.publish(
      TargetArn="<endpoint ARN>",
      Message='{"data": { "key": "value" } }')
  print ("Message id:", response["MessageId"])
  ```

  Where:

  * `TargetArn`: Mobile endpoint ID (ARN)
  * `Message`: Message

- AWS SDK for PHP {#php}

  If you do not have the AWS SDK for PHP yet, [install and configure it](../../tools/sdk-php.md#aws-sdk).

  **Explicit notifications (Bright Push)**

  To send an explicit notification, use this code:

  * Apple iOS (APNs)

      ```php
      $response = $client->publish(
        [
            'TargetArn' => '<endpoint_ID>',
            'Message' => json_encode([
                'default' => '<notification_text>',
                'APNS' => json_encode([
                    'aps' => [
                        'alert' => '<notification_text>',
                    ],
                ])
            ]),
            'MessageStructure' => 'json',
        ]
      );

      print($response->get('MessageId'));
      ```

  * Google Android (FCM)

      ```php
      $response = $client->publish(
        [
            'TargetArn' => '<endpoint_ID>',
            'Message' => json_encode([
                'default' => '<notification_text>',
                'GCM' => json_encode([
                    'notification' => [
                        'title' => '<notification_title>',
                        'body' => '<notification_text>',
                    ],
                ])
            ]),
            'MessageStructure' => 'json',
        ]
      );

      print($response->get('MessageId'));
      ```

  Where:

  * `TargetArn`: Mobile endpoint ID (ARN).
  * `MessageStructure`: Message format.
  * `Message`: Message.

  **Silent notifications (Silent Push)**

  To send a silent notification, use this code:

  * Google Android (FCM)

      ```php
      $response = $client->publish(
        [
            'TargetArn' => '<endpoint_ID>',
            'Message' => json_encode([
                'default' => '<notification_text>',
                'GCM' => json_encode([
                    'data' => ['<key>' => '<value>'],
                ])
            ]),
            'MessageStructure' => 'json',
        ]
      );

      print($response->get('MessageId'));
      ```

      Where:

      * `TargetArn`: Mobile endpoint ID (ARN).
      * `MessageStructure`: Message format.
      * `Message`: Message.


- API {#api}

  Use the HTTP API [publish](../../api-ref/publish.md) method for the {{ cns-full-name }} Publish resource.

{% endlist %}
