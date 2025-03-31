# Alert settings in {{ monitoring-full-name }}

In this tutorial, you will learn how to track the status of [trails](../../audit-trails/concepts/trail.md) using [alerts](../../monitoring/concepts/alerting.md#alert).

To start tracking the status of trails:

1. [Get your cloud ready](#before-you-begin).
1. [Create a notification channel](#create-channel).
1. [Set up alerts](#setup-alerts).

If you no longer need the alerts, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Create a notification channel {#create-channel}

To get notifications about a triggered alert:

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a notification channel.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
1. In the left-hand panel, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.channels.title }}**.
1. In the top-right corner, click **{{ ui-key.yacloud_monitoring.channel.button_new-channel }}**.
1. Specify the channel parameters:
    * In the **{{ ui-key.yacloud_monitoring.channel.field_name }}** field, specify `alerts-channel`.
    * In the **{{ ui-key.yacloud_monitoring.channel.field_method }}** field, specify the notification method.
    * In the **{{ ui-key.yacloud_monitoring.channel.field_recipients }}** field, list notification recipients.
1. Click **{{ ui-key.yacloud_monitoring.channel.button_create }}**. 

The channel will appear in the list.

## Set up alerts {#setup-alerts}

You can set up one or more alerts.

For more information about how to [create alerts](../../monitoring/operations/alert/create-alert.md) and about [alert parameters](../../monitoring/concepts/alerting.md#alert-parameters), see the {{ monitoring-full-name }} documentation.

### Deactivating a trail {#deactivating-trail}

The alert will send a notification that the trail is being deactivated.

1. In the [management console]({{ link-console-main }}), select the folder where you want to create an alert.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
1. In the left-hand panel, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}**.
1. In the top-right corner, click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
1. In the **{{ ui-key.yacloud_monitoring.alert.title_name }}** field, specify `deactivating-trail-alert`. 
1. Under **{{ ui-key.yacloud_monitoring.alert.section_metrics }}**, click ![image](../../_assets/console-icons/plus.svg) to the right of the folder name and specify:
    1. `service = Audit Trails`. 
    1. `name = trail.status`.
    1. `status != ACTIVE`.
    1. `trail = <trail_name>`.
1. Under **{{ ui-key.yacloud_monitoring.alert.section_alert-conditions }}**, specify:
    1. **{{ ui-key.yacloud_monitoring.alert.label_trigger-condition }}**: `{{ ui-key.yacloud_monitoring.alert.title_comparison-ne }}`
    1. **{{ ui-key.yacloud_monitoring.alert.label_alarm }}**: `0`
1. Under **{{ ui-key.yacloud_monitoring.alert.section_notifications }}**, click **{{ ui-key.yacloud_monitoring.alert.button_add-channel }}** and select the [previously created](#create-channel) notification channel.
1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**. 

The alert is created.

### Stopping delivery of audit logs to destination object {#stopping-logs}

The alert will send notification that the trail has stopped uploading audit logs to its destination object, for example, due to a lack of free space in the bucket.

The **{{ ui-key.yacloud_monitoring.alert.label_evaluation-window }}** parameter depends on the specific trail. The type and number of resources within the audit trail logging section will define the frequency for uploading audit logs to the destination object. 

1. In the [management console]({{ link-console-main }}), select the folder where you want to create an alert.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
1. In the left-hand panel, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}**.
1. In the top-right corner, click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
1. In the **{{ ui-key.yacloud_monitoring.alert.title_name }}** field, specify `stopping-logs-alert`. 
1. Under **{{ ui-key.yacloud_monitoring.alert.section_metrics }}**, click ![image](../../_assets/console-icons/plus.svg) to the right of the folder name and specify:
    1. `service = Audit Trails`. 
    1. `name = trail.delivered_events_count`.
    1. `trail = <trail_name>`.
1. Under **{{ ui-key.yacloud_monitoring.alert.section_alert-conditions }}**, specify:
    1. **{{ ui-key.yacloud_monitoring.alert.label_trigger-condition }}**: `{{ ui-key.yacloud_monitoring.alert.title_comparison-eq }}`
    1. **{{ ui-key.yacloud_monitoring.alert.label_alarm }}**: `0`
    1. **{{ ui-key.yacloud_monitoring.alert.label_evaluation-window }}**: `<trail_value>`
1. Under **{{ ui-key.yacloud_monitoring.alert.section_notifications }}**, click **{{ ui-key.yacloud_monitoring.alert.button_add-channel }}** and select the [previously created](#create-channel) notification channel.
1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**. 

The alert is created.

### Modifying the number of trails {#number-trails}

The alert will send a notification that the number of trails in a cloud has changed.

1. In the [management console]({{ link-console-main }}), select the folder where you want to create an alert.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
1. In the left-hand panel, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}**.
1. In the top-right corner, click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
1. In the **{{ ui-key.yacloud_monitoring.alert.title_name }}** field, specify `number-trails-alert`. 
1. Under **{{ ui-key.yacloud_monitoring.alert.section_metrics }}**, click ![image](../../_assets/console-icons/plus.svg) to the right of the folder name and specify:
    1. `service = Audit Trails`. 
    1. `name = quota.trails_count.usage`.
1. Under **{{ ui-key.yacloud_monitoring.alert.section_alert-conditions }}**, specify:
    1. **{{ ui-key.yacloud_monitoring.alert.label_trigger-condition }}**: `{{ ui-key.yacloud_monitoring.alert.title_comparison-ne }}`
    1. **{{ ui-key.yacloud_monitoring.alert.label_alarm }}**: `<number_of_trails>`.
1. Under **{{ ui-key.yacloud_monitoring.alert.section_notifications }}**, click **{{ ui-key.yacloud_monitoring.alert.button_add-channel }}** and select the [previously created](#create-channel) notification channel.
1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**. 

The alert is created.

### Nearing cloud trail quota {#trail-quota}

The alert will send a notification that the number of trails used per cloud consumed over 80% of the quota.
   
1. In the [management console]({{ link-console-main }}), select the folder where you want to create an alert.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
1. In the left-hand panel, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}**.
1. In the top-right corner, click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
1. In the **{{ ui-key.yacloud_monitoring.alert.title_name }}** field, specify `trail-quota-alert`. 
1. Under **{{ ui-key.yacloud_monitoring.alert.section_metrics }}**, click ![image](../../_assets/console-icons/plus.svg) to the right of the folder name and specify:
    1. `service = Audit Trails`. 
    1. `name = quota.trails_count.usage`.
1. Under **{{ ui-key.yacloud_monitoring.alert.section_alert-conditions }}**, specify:
    1. **{{ ui-key.yacloud_monitoring.alert.label_trigger-condition }}**: `{{ ui-key.yacloud_monitoring.alert.title_comparison-gt }}`
    1. **{{ ui-key.yacloud_monitoring.alert.label_alarm }}**: `<number_equal_to_80%_of_quota>`
1. Under **{{ ui-key.yacloud_monitoring.alert.section_notifications }}**, click **{{ ui-key.yacloud_monitoring.alert.button_add-channel }}** and select the [previously created](#create-channel) notification channel.
1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**. 

The alert is created.

### Unauthorized access attempts {#unauthorized-access}

The alert will send a notification that an unauthorized request has been sent to one of the trail resources.

1. In the [management console]({{ link-console-main }}), select the folder where you want to create an alert.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
1. In the left-hand panel, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}**.
1. In the top-right corner, click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
1. In the **{{ ui-key.yacloud_monitoring.alert.title_name }}** field, specify `unauthorized-access-alert`. 
1. Under **{{ ui-key.yacloud_monitoring.alert.section_metrics }}**, click ![image](../../_assets/console-icons/plus.svg) to the right of the folder name and specify:
    1. `service = Audit Trails`. 
    1. `name = trail.unauthorized_events_count`.
1. Under **{{ ui-key.yacloud_monitoring.alert.section_alert-conditions }}**, specify:
    1. **{{ ui-key.yacloud_monitoring.alert.label_trigger-condition }}**: `{{ ui-key.yacloud_monitoring.alert.title_comparison-gt }}`
    1. **{{ ui-key.yacloud_monitoring.alert.label_alarm }}**: `0`
1. Under **{{ ui-key.yacloud_monitoring.alert.section_notifications }}**, click **{{ ui-key.yacloud_monitoring.alert.button_add-channel }}** and select the [previously created](#create-channel) notification channel.
1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**. 

The alert is created.

## How to delete the resources you created {#clear-out}

To stop tracking the status of trails, [delete](../../monitoring/operations/alert/delete-alert.md) the respective alert.
