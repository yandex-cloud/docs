---
title: Managing a {{ sd-full-name }} subscription
description: In this section, you will learn how to subscribe to alerts and comments on them in {{ sd-full-name }}.
---

# Managing a subscription

You can subscribe to [alerts](../../concepts/alerts.md) and comments to them.

## Creating a subscription {#create-subscription}

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}**.
  1. In the top-right corner, click **Create subscription**. This will open the subscription creation page.
  1. In the **Name** field, enter a name for the subscription.
  1. Enable **Activate subscription** to receive notifications. You can also do it later. If you do not activate the subscription, it will be saved, but you will not be receiving any notifications for it.
  1. Select at least one event type: 
      * `Alert`: Alerts matching the subscription filters. 
      * `Alert comment`: Comments to such alerts.
  1. In the **Sink** field, select the [alert sink](../../concepts/workspace.md#alert-sinks). You can select several sinks at the same time.  
  1. Optionally, under **Alert filters**, configure the alerts you want covered by the subscription. If you add no filters, notifications will be sent for all alerts.
  1. Optionally, under **Recipients**, click **Add recipient** to add users to receive notifications. Notifications will be delivered via the channels specified in users’ personal settings. For more on configuring channels, see [{#T}](../../../support/notify.md#notification-settings).
  1. Click **Create**.

{% endlist %}

## Viewing subscriptions {#show-subscriptions}

To view your subscriptions:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}
  
  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![subcription](../../../_assets/console-icons/envelope-open.svg) **Subscriptions**.
  
  The page will display all subscriptions for which you receive notifications: those created by you or those you were added to.

{% endlist %}  


## Editing a subscription {#edit-subscription}

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}
  
  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![subcription](../../../_assets/console-icons/envelope-open.svg) **Subscriptions**.
  1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the subscription and select:
     
     {% list tabs %}
     
     - Subscription created by you 

        * ![image](../../../_assets/console-icons/pencil.svg) **Edit** to edit the subscription.
        * ![image](../../../_assets/console-icons/arrows-rotate-right.svg) **Activate** to activate an inactive subscription or ![image](../../../_assets/console-icons/pause.svg) **Deactivate** to pause notifications.

     - Subscription created by another author

        * ![image](../../../_assets/console-icons/gear.svg) **Set up channels** to configure notification channels.
        * ![image](../../../_assets/console-icons/person-xmark.svg) **Unsubscribe** to unsubscribe from the mailing list. The subscription will disappear from the page. To subscribe to it again, contact its owner. 
     
     {% endlist %}

{% endlist %}

## Deleting a subscription or unsubscribing {#delete-subscription}

You can delete a subscription created by you or unsubscribe if you were added to it.

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}
  
  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![subcription](../../../_assets/console-icons/envelope-open.svg) **Subscriptions**.
  1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the subscription and select:
    
     * ![image](../../../_assets/console-icons/trash-bin.svg) **Delete** to delete a subscription created by you. 
     * ![image](../../../_assets/console-icons/person-xmark.svg) **Unsubscribe** to unsubscribe from a mailing list you were added to. The subscription will disappear from the page. To subscribe to it again, contact its owner. 
     
{% endlist %}
