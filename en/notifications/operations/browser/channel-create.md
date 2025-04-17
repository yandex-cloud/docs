---
title: Creating an in-browser push notification channel in {{ cns-full-name }}
description: Follow this guide to create an in-browser push notification channel.
---

# Create an in-browser push notification channel

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you want to create a notification channel in.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Click **{{ ui-key.yacloud.cns.action_create-channel }}**.
  1. Select the **{{ ui-key.yacloud.cns.type_web }}** tab.
  1. Optionally, under **{{ ui-key.yacloud.cns.section_logging }}**, enable **{{ ui-key.yacloud.cns.field_logging }}**.
     1. In the **{{ ui-key.yacloud.cns.field_logging-folder }}** list, select the folder the [log group](../../../logging/concepts/log-group.md) will reside in.
     1. In the **{{ ui-key.yacloud.cns.field_log-group }}** field, select an existing log group or create a new one.
  1. Enter a name for your notification channel. The channel name must be unique within {{ cns-name }}.
  1. Optionally, click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.cns.button_add-description }}** and enter a description for your notification channel.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- AWS CLI {#aws-cli}

  1. If you do not have the AWS CLI yet, [install and configure it](../../../storage/tools/aws-cli.md).
  1. Run this command:

     ```bash
     aws sns create-platform-application \
     --name <channel_name> \
     --platform "WEB" \
     --attributes "{}"
     ```

     Where `--name` is a user-defined name for the notification channel.

     For more information about the `aws sns create-platform-application` command, see the [AWS documentation](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/create-platform-application.html).

- AWS SDK for Python {#python}

  1. If you do not have the AWS SDK for Python (boto3) yet, [install and configure it](../../tools/sdk-python.md#aws-sdk).
  1. To create a push notification channel, use the following code:

     ```python
     try:
      response = client.create_platform_application(
        Name="<channel_name>",
        Platform="WEB",
        Attributes={},
      )
      print(f'PlatformApplication ARN: {response["PlatformApplicationArn"]}')

     except botocore.exceptions.ClientError as error:
      print(f"Error: {error}")
     ```

- AWS SDK for PHP {#php}

  1. If you do not have the AWS SDK for PHP yet, [install and configure it](../../tools/sdk-php.md#aws-sdk).
  1. To create a push notification channel, use the following code:

      ```php
      $response = $client->createPlatformApplication(
        [
          'Name' => '<channel_name>',
          'Platform' => 'WEB',
          'Attributes' => [],
        ]
      );
      print('PlatformApplication ARN: ' . $response->get('PlatformApplicationArn'));
      ```

- AWS SDK for JavaScript {#javascript}

   1. If you do not have the AWS SDK for JavaScript yet, [install and configure it](../../tools/sdk-javascript.md).
   1. To create a push notification channel, use the following code:

      ```javascript
      try {
        const response = await client.send(
          new AWS.CreatePlatformApplicationCommand({
            Name: "<channel_name>",
            Platform: "WEB",
          }),
        );
        console.log("PlatformApplication ARN:", response["PlatformApplicationArn"]);
      } catch (e) {
        console.log("Error:", e)
      }
      ```

- API {#api}

  Use the [create](../../api-ref/create-platform-application.md) HTTP API method for the _PlatformApplications_ resource in {{ cns-full-name }}.

{% endlist %}

Creating a notification channel may take some time. After you create your channel, [create an endpoint](endpoint-create.md).