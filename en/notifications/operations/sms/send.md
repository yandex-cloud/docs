---
title: Sending a test SMS notification in {{ cns-full-name }}
description: Follow this guide to send a test SMS notification.
---

# Sending a test SMS notification

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you want to create a notification channel in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Select an SMS notification channel you need.
  1. Navigate to the ![image](../../../_assets/console-icons/handset-arrow-in.svg) **{{ ui-key.yacloud.cns.label_phone-numbers }}** tab.
  1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the test phone number and select ![image](../../../_assets/console-icons/comment.svg) **{{ ui-key.yacloud.cns.action_send-msg }}**.
  1. In the window that opens, enter the message text and click **{{ ui-key.yacloud.cns.action_send-msg }}**.

- AWS SDK for PHP {#php}

  1. If you do not have the AWS SDK for PHP yet, [install and configure it](../../tools/sdk-php.md#aws-sdk).
  1. To send an SMS notification, use this code:

      ```php
      $response = $client->publish(
        [
            'Message' => '<message>',
            'PhoneNumber' => '<phone_number>',
        ]
      );

      print($response->get('MessageId'));
      ```

{% endlist %}