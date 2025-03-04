---
title: Exiting the sandbox in {{ cns-full-name }}
description: Follow this guide to exit the sandbox.
---

# Exiting the sandbox

{% include [individual-in-sandbox](../../../_includes/notifications/individual-in-sandbox.md) %}

After practicing on test phone numbers, you can apply to exit the sandbox mode:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you want to create a notification channel in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Select an SMS notification channel you need with an [individual sender](../../concepts/sms.md#individual-sender).
  1. Click **{{ ui-key.yacloud.cns.action_sms-leave-sandbox }}**.

      With that done, a tech support ticket to exit the sandbox will be automatically generated.

      {% include [sms-quota-increase](../../../_includes/notifications/sms-quota-increase.md) %}

{% endlist %}

Once the ticket is approved, you will be able to send SMS messages to any Russian phone numbers in [E.164](https://en.wikipedia.org/wiki/E.164) format, e.g., `+79991112233`.
