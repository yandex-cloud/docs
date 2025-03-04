---
title: Adding a test phone number in {{ cns-full-name }}
description: Follow this guide to add a test phone number.
---

# Adding a test phone number

{% include [sandbox-test-numbers](../../../_includes/notifications/sandbox-test-numbers.md) %}

To add a test phone number:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you want to create a notification channel in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Select an SMS notification channel you need.
  1. Navigate to the ![image](../../../_assets/console-icons/handset-arrow-in.svg) **{{ ui-key.yacloud.cns.label_phone-numbers }}** tab.
  1. Click **Add test phone number**.
  1. In the window that opens, enter a phone number and click **Get code**. An SMS with a confirmation code will be sent to the specified phone number.

      Russian phone numbers in [E.164](https://en.wikipedia.org/wiki/E.164) format are supported, e.g., `+79991112233`.

  1. Enter the code from the SMS and click **{{ ui-key.yacloud.common.confirm }}**.

{% endlist %}
