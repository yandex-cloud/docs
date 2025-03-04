---
title: Updating a push notification channel in {{ cns-full-name }}
description: Follow this guide to update a push notification channel.
---

# Updating a push notification channel

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder containing the notification channel.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the push notification channel and select **{{ ui-key.yacloud.common.edit }}**.
  1. On the **{{ ui-key.yacloud.cns.type_mobile }}** tab, edit the authentication parameters for your platform:

      {% include [push-channel-platforms-params.md](../../../_includes/notifications/push-channel-platforms-params.md) %}

  1. Click ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.cns.button_add-description }}** and enter a description for your notification channel.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- AWS CLI {#aws-cli}

  1. If you do not have the AWS CLI yet, [install and configure it](../../../storage/tools/aws-cli.md).
  1. Run this command:

      ```bash
      aws sns set-platform-application-attributes \
        --platform-application-arn <notification_channel_ARN> \
        --attributes <параметр1>=<new_value1>, ... <parameterN>=<new_valueN>
      ```

      Where:

      * `--platform-application-arn`: Notification channel ID (ARN).
      * `--attributes`: Comma-separated notification channel parameters you want to update, in `<parameter1>=<new_value1>` format.

      For more information about the `aws sns set-platform-application-attributes` command, see the [AWS documentation](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/set-platform-application-attributes.html).

- AWS SDK for Python (boto3) {#python}

  1. If you do not have AWS SDK for Python (boto3) yet, [install and configure it](../../tools/sdk-python.md#aws-sdk).
  1. To update a push notification channel, use the following code:

      ```python
      response = client.set_platform_application_attributes(
          PlatformApplicationArn="<notification_channel_ARN>",
          Attributes={
              "<параметр1>": "<new_value1>",
              ...
              "<parameterN>": "<new_valueN>"
          }
      )
      print("Attributes updated successfully.")
      ```

      Where:

      * `PlatformApplicationArn`: Notification channel ID (ARN)
      * `Attributes`: Comma-separated parameters you want to update, in `"<parameterN>": "<new_valueN>"` format.

- AWS SDK for PHP {#php}

  1. If you do not have the AWS SDK for PHP yet, [install and configure it](../../tools/sdk-php.md#aws-sdk).
  1. To update a push notification channel, use the following code:

      ```php
      $response = $client->setPlatformApplicationAttributes([
          'PlatformApplicationArn' => '<notification_channel_ARN>',
          'Attributes' => [
              '<parameter1>' => '<new_value1>',
              ...
              '<parameterN>' => '<new_valueN>'
          ],
      ]);

      echo "Platform application attributes updated successfully.\n";
      ```

      Where:

      * `PlatformApplicationArn`: Notification channel ID (ARN)
      * `Attributes`: Comma-separated parameters you want to update, in `'<parameter>' => '<new_value>'` format.


- API {#api}

  Use the [setAttributes](../../api-ref/set-platform-application-attributes.md) HTTP API method for the PlatformApplications resource in {{ cns-full-name }}.

{% endlist %}

Updating a notification channel may take some time.
