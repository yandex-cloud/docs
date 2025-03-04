---
title: How to create an escalation policy
description: In this article, you will learn how to create and configure an escalation policy to notify users of critical events in a timely manner.
---

# Creating an escalation policy

{% include [escalations-preview](../../../_includes/monitoring/escalations-preview.md) %}



{% include [escalations-definition](../../../_includes/monitoring/escalation-definition.md) %}

## Getting started {#before-you-begin}

Make sure you have added [recipients](../../concepts/alerting/notification-channel.md#channel-parameters) and they have the proper roles.

## Creating a policy {#create-escalation}

1. On the {{ monitoring-name }} page, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.escalations.title }}** on the left panel.
1. Click **{{ ui-key.yacloud.common.create }}**.
1. Specify **Name** and **Description** (optional).

1. Select an escalation schedule:
 
   * **24/7**: Send notifications every day at any time.

   * **Working hours**: Send notifications on working days from 10:00 to 21:00 Moscow time (time zone UTC+3). Weekends and public holidays are as per the RF business calendar.

   * **Custom settings**: Send notifications based on a custom schedule:

      * **Country**: Follow the business calendar of the the selected country.

        {% note info %}

        To consider different sets of weekends and holidays in distributed teams, create multiple escalations for different countries.

        {% endnote %}

      * **Time zone**: May not match the country you selected.
      * **No notification on weekends and holidays**: Weekends and holidays as per the business calendar of the selected country.
      * **Sending hours**: Start and end time of the notification interval in the selected time zone. To send notifications 24/7, click ![image](../../../_assets/console-icons/xmark.svg) next to this setting.
      * **Sending days**: Days of week for your escalation to send notifications. To send notifications every day, check all days or clear the setting.

        {% note info %}

        The **No notification on weekends and holidays** setting has a higher priority than the **Sending days** setting. Therefore, no notifications will be sent on weekends and holidays regardless of the sending days you selected.

        {% endnote %}

1. Configure escalation steps: Channel sequence and parameters for sending notifications:

    * **Initial delay**: First iteration delay when starting an escalation, 2 minutes by default. To start escalation without delay, remove the value from this field.
    * Specify the parameters of the first escalation step: 
      * **Method**: [Notification method](../../concepts/alerting/notification-channel.md#channel-parameters):
       
          {% include [escalation-channels](../../../_includes/monitoring/escalation-channels.md) %}

      * **Delay after step**: Delay before moving to the next step if the notification is successfully delivered but escalation is not stopped. You can set the delay in seconds or minutes. For example, `30s`, `10m`, or `3m30s`.
      
        Default delay is `30m`. To send the next step notification without delay, remove the value from the field.

        {% note warning %}

        For phone calls, regardless of the escalation step and initial delay settings, a minimum delay period of 1 minute will be applied.

        {% endnote %}

        {% note info %}

        If a step is unsuccessful, there will be no delay before the next step. For the last iteration step, there will be a delay before moving on to the next iteration whether the step was successful or not.

        {% endnote %}

      * **Ignore if repeated**: Send the notification at this escalation step only once and ignore this step in subsequent repetitions. For example, if you want to send only one email to report an issue.
      * **Recipient**: List of notification recipients.
        
        Specify a {{ yandex-cloud }} account as the recipient. It may be the owner's account or an [additional account](../../../iam/concepts/users/accounts.md), e.g., a federated account or Yandex ID.
    * To add another notification, click **Add step** and specify the notification parameters.
        
      The number of escalation steps is unlimited.

1. Drag and drop steps to create the required escalation sequence.
1. Click **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

Your new escalation policy will appear on the right side of the page.

## Adding a policy to an alert {#add-to-alert}

1. On the [{{ monitoring-name }}]({{ link-monitoring }}) page, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}** on the left panel.
1. Open for editing or [create an alert](create-alert.md).
1. Add a [notification method](../../operations/alert/create-alert.md) and select an escalation policy from the list.

The escalation will start as soon as the alert gets the **Alarm** status. All recipients will see a pop-up window in the {{ monitoring-short-name }} interface and will start receiving notifications according to the configured policy. If the alert gets any other status, the escalation will stop.

## Viewing notifications {#view-notifications}

To track the sending of escalation notifications: 
* Add a widget to the [dashboard](../dashboard/add-widget.md#escalation).
* Go to **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.notification-feed.title }}**.

## Updating an escalation policy {#escalation-update}

1. On the {{ monitoring-name }} page, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.escalations.title }}** on the left panel.
1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the escalation policy and select **{{ ui-key.yacloud.common.edit }}**.
1. Specify new policy settings.
1. Click **{{ ui-key.yacloud_monitoring.actions.common.save }}**.

If you are editing an ongoing escalation, the your changes will take effect starting from the next iteration.