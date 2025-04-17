---
title: Managing an in-browser push notification channel in {{ cns-full-name }}
description: Follow this guide to update or delete an in-browser push notification channel.
---

# Managing an in-browser push notification channel

## Updating channel parameters {#channel-update}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the notification channel.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the channel and select **{{ ui-key.yacloud.common.edit }}**.
  1. Edit the channel description.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- AWS CLI {#aws-cli}

  1. If you do not have the AWS CLI yet, [install and configure it](../../../storage/tools/aws-cli.md).
  1. Run this command:

      ```bash
      aws sns set-platform-application-attributes \
        --platform-application-arn <notification_channel_ARN> \
        --attributes <parameter1>=<new_value1>
      ```

      Where:

      * `--platform-application-arn`: Notification channel ID (ARN).
      * `--attributes`: Notification channel parameters.

      For more information about the `aws sns set-platform-application-attributes` command, see the [AWS documentation](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/set-platform-application-attributes.html).

- API {#api}

  Use the [setAttributes](../../api-ref/set-platform-application-attributes.md) HTTP API method for the PlatformApplications resource in {{ cns-full-name }}.

{% endlist %}

Updating a notification channel may take some time.

## Deleting a channel {#channel-delete}

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

- API {#api}

  Use the [delete](../../api-ref/delete-platform-application.md) HTTP API method for the PlatformApplications resource in {{ cns-full-name }}.

{% endlist %}
