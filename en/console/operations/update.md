---
title: Updating management console settings
description: Follow this guide to change your management console settings.
---

# Updating management console settings

In the [management console]({{ link-console-main }}), you can update the following settings:

* [Notification settings](#notifications)
* [Language and region](#lang)
* [Appearance](#appearance)

## Specifying notification settings {#notifications}

1. In the management console, select ![icon](../../_assets/console-icons/gear.svg) **Settings** in the left-hand panel.
1. Go to ![icon](../../_assets/console-icons/envelope.svg) **{{ ui-key.yacloud_components.settings.label_title_communications }}**.
1. Link the relevant email address:

   1. In the ![icon](../../_assets/console-icons/at.svg) **{{ ui-key.yacloud_components.settings.field_email }}** field, click ![icon](../../_assets/console-icons/pencil.svg).
   1. In the pop-up window, specify the new email address. A confirmation code will be sent to that address.
   1. Copy the code and paste it in the management console.
   1. Confirm the update of your email address.

1. Link the relevant phone number:

   1. In the ![icon](../../_assets/console-icons/smartphone.svg) **{{ ui-key.yacloud_components.settings.field_phone }}** field, click ![icon](../../_assets/console-icons/pencil.svg).
   1. In the pop-up window, enter the new phone number. A confirmation code will be sent to that number.
   1. Copy the code and paste it in the management console.
   1. Confirm the update of your phone number.

1. Link the relevant Telegram account:

   1. In the ![icon](../../_assets/console-icons/logo-telegram.svg) **{{ ui-key.yacloud_components.settings.label_telegram }}** field, click **{{ ui-key.yacloud_components.settings.button_add-empty-telegram }}**.
   1. In the pop-up window, click **{{ ui-key.yacloud_components.settings.label_telegram-link }}**.

      This will open a chat with the {{ yandex-cloud }} Notify bot in Telegram.

   1. In the chat, click **Start**.

      The bot will send a confirmation code. The code is active for ten minutes.

   1. Enter the code you received in the management console.

1. Under **{{ ui-key.yacloud_components.settings.section_settings }}**, select which notifications to send to which channels.

   Available channels:

   * ![icon](../../_assets/console-icons/at.svg): Email
   * ![icon](../../_assets/console-icons/smartphone.svg): Phone
   * ![icon](../../_assets/console-icons/logo-telegram.svg): Telegram

   The channels are only available if linked to the management console.

   Available notifications:

   * **{{ ui-key.yacloud_components.settings.label_tech-name }}**: About automatic installation of updates and fixes for resources, as well as other maintenance.
   * **{{ ui-key.yacloud_components.settings.label_security-name }}**: About detected vulnerabilities and their remediation.
   * **{{ ui-key.yacloud_components.settings.label_alerting-name }}**: About triggered [alerts](../../monitoring/concepts/alerting.md) if configured in {{ monitoring-full-name }}. For example, you can [create an alert](../../managed-postgresql/operations/storage-space.md#set-alert) to notify you about disk capacity overflow in a {{ mpg-full-name }} cluster.
   * **{{ ui-key.yacloud_components.settings.label_billing-name }}**: About payment, trial period, billing account status, etc.
   * **News and offers**: About new services, discounts, special offers, etc.
   * **{{ ui-key.yacloud_components.settings.label_event-name }}**: About {{ yandex-cloud }} in-person events and webinars.
   * **Offers from other Yandex services**: About non-{{ yandex-cloud }} offers.

## Setting the language and region {#lang}

1. In the management console, select ![icon](../../_assets/console-icons/gear.svg) **Settings** in the left-hand panel.
1. Go to ![icon](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud_components.settings.label_title_region }}**.
1. Select the language for the management console.
1. Select the time zone.

   By default, the time zone is determined automatically. It is used to display operation times in the management console.

1. Select the date and time format to use for operations in the management console.

## Setting the appearance in the management console {#appearance}

1. In the management console, select ![icon](../../_assets/console-icons/gear.svg) **Settings** in the left-hand panel.
1. Go to ![icon](../../_assets/console-icons/palette.svg) **{{ ui-key.yacloud_components.settings.label_title_appearance }}**.
1. Select the interface theme in the management console.

   If you select **{{ ui-key.yacloud_components.settings.value_theme-system }}**, the console theme will match your device's theme.

1. Select the contrast level.
1. Disable **{{ ui-key.yacloud_components.settings.label_promo_banner-name }}** to hide promotions, special offers, and management console usage tips. Enable this option to keep them.
