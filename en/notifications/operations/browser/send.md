---
title: Sending a push notification in {{ cns-full-name }}
description: Follow this guide to send a push notification.
---

# Sending a push notification

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder containing your endpoint.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Select an in-browser push notification channel.
  1. Navigate to the ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.cns.label_endpoints }}** tab.
  1. Select the endpoint you need.
  1. Enter the notification text and click **{{ ui-key.yacloud.cns.action_send-msg }}**.

  Each sent notification is assigned a unique ID. To save it, click **{{ ui-key.yacloud.cns.action_copy-msg-id }}**.

- AWS CLI {#aws-cli}

  1. If you do not have the AWS CLI yet, [install and configure it](../../../storage/tools/aws-cli.md).

  1. Run this command:

      ```bash
      aws sns publish \
        --target-arn "<endpoint_ARN>" \
        --message-structure json \
        --message '{"default": "<notification_text>", "WEB": "<notification_text>"}'
      ```

  Where:

  * `--target-arn`: Endpoint ID (ARN).
  * `--message-structure`: Message format.
  * `--message`: Message.

- AWS SDK for Python {#python}

  1. If you do not have the AWS SDK for Python (boto3) yet, [install and configure it](../../tools/sdk-python.md#aws-sdk).
  1. To send a notification, use this code:

      ```python
      try:
        response = client.publish(
            TargetArn="<endpoint_ARN>",
            Message=json.dumps({
                "default": "<notification_text>",
                "WEB": "<notification_text>",
            }),
            MessageStructure="json",
        )
        print(f'Message ID: {response["MessageId"]}')

      except botocore.exceptions.ClientError as error:
        print(f"Error: {error}")
      ```

- AWS SDK for PHP {#php}

  1. If you do not have the AWS SDK for PHP yet, [install and configure it](../../tools/sdk-php.md#aws-sdk).
  1. To send a notification, use this code:

      ```php
      $response = $client->publish(
        [
            'TargetArn' => '<endpoint_ARN>',
            'Message' => json_encode([
                'default' => '<notification_text>',
                'WEB' => '<notification_text>',
            ]),
            'MessageStructure' => 'json',
        ]
      );
      print('Message ID: ' . $response->get('MessageId'));
      ```

- AWS SDK for JavaScript {#javascript}

   1. If you do not have the AWS SDK for JavaScript yet, [install and configure it](../../tools/sdk-javascript.md).
   1. To send a notification to a browser, use this code:
   
       ```javascript
       try {
        const response = await client.send(
            new AWS.PublishCommand({
                Message: JSON.stringify({
                    "default": "<notification_text>",
                    "WEB": "<notification_text>",
                }),
                MessageStructure: "json",
                TargetArn: "<endpoint_ARN>",
            }),
        );
        console.log("Message ID:", response["MessageId"]);
      } catch (e) {
        console.log("Error:", e)
      }
      ```

- API {#api}

  Use the HTTP API [publish](../../api-ref/publish.md) method for the {{ cns-full-name }} Publish resource.

{% endlist %}
