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

1. On the {{ monitoring-name }} page, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.escalations.title }}** on the left-hand panel.
1. Click **{{ ui-key.yacloud.common.create }}**.
1. Optionally, specify **Name** and **Description**.

1. Select an escalation schedule:
 
   * **24/7**: Notify every day at any time.

   * **Working hours**: Notify on work days from 10:00 to 21:00 Moscow time (time zone UTC+3). Weekends and public holidays are as per the Russian business calendar.

   * **Custom settings**: Notify based on a custom schedule:

      * **Country**: Follow the business calendar of the the selected country.

        {% note info %}

        To consider varying holiday and non-working day schedules across distributed teams, create multiple escalations for different countries.

        {% endnote %}

      * **Time zone**: May not match the selected country.
      * **No notification on weekends and holidays**: Weekends and holidays as per the business calendar of the selected country.
      * **Send hours**: Start and end time of the notification interval in the selected time zone. To send notifications 24/7, click ![image](../../../_assets/console-icons/xmark.svg) next to this setting.
      * **Send days**: Days of week for your escalation to send notifications. To send them every day, check all days or clear the setting.

        {% note info %}

        The **No notification on weekends and holidays** setting has a higher priority than the **Send days** setting. Therefore, no notifications will be sent on weekends and holidays no matter what send days you select.

        {% endnote %}

1. Configure escalation steps, i.e., channel sequence and notification parameters:

    * **Initial delay**: First iteration delay when an escalation starts, 2 minutes by default. To start without delay, clear this field.
    * Specify the parameters of the first escalation step: 
      * **Method**: [Notification method](../../concepts/alerting/notification-channel.md#channel-parameters):
       
          {% include [escalation-channels](../../../_includes/monitoring/escalation-channels.md) %}

      * **Delay after step**: Delay before moving on to the next step if the notification is successfully delivered but escalation is not stopped. You can set the delay in seconds or minutes, e.g., `30s`, `10m`, or `3m30s`.
      
        The default delay is `30m`. To send the next step notification without delay, clear this field.

        {% note warning %}

        Phone calls will always have a minimum 1-minute delay, no matter what escalation step or initial delay you configure.

        {% endnote %}

        {% note info %}

        If a step fails, there will be no delay before the next step. For the last iteration step, there will be a delay before moving on to the next iteration whether the step was successful or not.

        {% endnote %}

      * **Ignore if repeated**: Send the notification only once at this escalation step and ignore it in subsequent iterations. For example, if you want to send a single email to report an issue.
      * **Recipient**: List of notification recipients.
        
        Specify a {{ yandex-cloud }} account as the recipient. It may be the owner's account or an [additional account](../../../iam/concepts/users/accounts.md), e.g., a federated account or Yandex ID.
    * To add another notification, click **Add step** and specify the notification parameters.
        
      The number of escalation steps is unlimited.

1. Drag and drop steps to create the escalation sequence you need.
1. Click **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

You will see the escalation policy that you have just created on the right of the page.

## Adding a policy to an alert {#add-to-alert}

1. On the [{{ monitoring-name }}]({{ link-monitoring }}) page, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}** on the left-hand panel.
1. Open an alert for editing or [create a new one](create-alert.md).
1. Add a [notification method](../../operations/alert/create-alert.md) and select an escalation policy from the list.

The escalation will start as soon as the alert gets the **Alarm** status. All recipients will see a pop-up window in the {{ monitoring-short-name }} interface and will start receiving notifications according to the configured policy. If the alert gets any other status, the escalation will stop.

## Viewing notifications {#view-notifications}

To keep track of sent escalation notifications: 
* Add a widget to your [dashboard](../dashboard/add-widget.md#escalation).
* Navigate to **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.notification-feed.title }}**.

## Updating an escalation policy {#escalation-update}

1. On the {{ monitoring-name }} page, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.escalations.title }}** on the left-hand panel.
1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the escalation policy and select **{{ ui-key.yacloud.common.edit }}**.
1. Specify new policy settings.
1. Click **{{ ui-key.yacloud_monitoring.actions.common.save }}**.

If you are editing a running escalation, the changes you make will take effect starting from the next iteration.