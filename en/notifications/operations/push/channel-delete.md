---
title: Deleting a push notification channel in {{ cns-full-name }}
description: Follow this guide to delete a push notification channel.
---

# Deleting a push notification channel

{% list tabs group=instructions %}

- Management console {#console}

  {% include [channel-delete](../../../_includes/notifications/channel-delete-console.md) %}

- AWS CLI {#aws-cli}

  1. If you do not have the AWS CLI yet, [install and configure it](../../../storage/tools/aws-cli.md).
  1. Run this command:

      ```bash
      aws sns delete-platform-application \
        --platform-application-arn <notification_channel_ARN>
      ```

      Where `--platform-application-arn` is the notification channel ID (ARN).

      For more information about the `aws sns delete-platform-application` command, see the [AWS documentation](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/delete-platform-application.html).

- AWS SDK for Python (boto3) {#python}

  1. If you do not have the AWS SDK for Python (boto3) yet, [install and configure it](../../tools/sdk-python.md#aws-sdk).
  1. To delete a push notification channel, use the following code:

      ```python
      response = client.delete_platform_application(
          PlatformApplicationArn="<notification_channel_ARN>"
      )
      print("Platform application deleted successfully.")
      ```

      Where `PlatformApplicationArn` is the notification channel ID (ARN).

- AWS SDK for PHP {#php}

  1. If you do not have the AWS SDK for PHP yet, [install and configure it](../../tools/sdk-php.md#aws-sdk).
  1. To delete a push notification channel, use the following code:

      ```php
      $response = $client->deletePlatformApplication([
          'PlatformApplicationArn' => '<notification_channel_ARN>',
      ]);

      echo "Platform application deleted successfully.\n";
      ```

      Where `PlatformApplicationArn` is the notification channel ID (ARN).


- API {#api}

  Use the [delete](../../api-ref/delete-platform-application.md) HTTP API method for the PlatformApplications resource in {{ cns-full-name }}.

{% endlist %}
