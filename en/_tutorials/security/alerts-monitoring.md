# Configuring dashboards and alerts in {{ monitoring-full-name }}

In this tutorial, you will learn how to track [trail](../../audit-trails/concepts/trail.md) status using [dashboards](../../monitoring/concepts/visualization/dashboard.md) and [{{ monitoring-full-name }}](../../monitoring/) [alerts](../../monitoring/concepts/alerting.md#alert).

This guide assumes that you already have deployed your infrastructure: 

* Created {{ yandex-cloud }} resources to collect security events for.
* Created a [trail](../../audit-trails/concepts/trail.md) in {{ at-name }} to collect events.
* Configured the [target](../../audit-trails/concepts/trail.md#target) to store and manage events: a [bucket](../../storage/concepts/bucket.md), [datastream](../../data-streams/concepts/glossary.md#stream-concepts), or [log group](../../logging/concepts/log-group.md).

To start tracking the status of trails:

* [Set up alerts](#setup-alerts).
* [Set up the dashboard](#setup-dashboard).

If you no longer need the resources, [delete them](#clear-out).

## Set up alerts {#setup-alerts}

### Create a notification channel {#create-channel}

To get notifications about a triggered alert:

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a notification channel.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
1. In the left-hand panel, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.channels.title }}**.
1. In the top-right corner, click **{{ ui-key.yacloud_monitoring.channel.button_new-channel }}**.
1. Specify the channel settings:
    * In the **{{ ui-key.yacloud_monitoring.channel.field_name }}** field, specify `alerts-channel`.
    * In the **{{ ui-key.yacloud_monitoring.channel.field_method }}** field, specify the notification method.
    * In the **{{ ui-key.yacloud_monitoring.channel.field_recipients }}** field, list notification recipients.
1. Click **{{ ui-key.yacloud_monitoring.channel.button_create }}**. 

The channel will appear in the list.

### Add alerts {#add-alerts}

You can set up one or more alerts.

For more information about how to [create alerts](../../monitoring/operations/alert/create-alert.md) and about [alert parameters](../../monitoring/concepts/alerting.md#alert-parameters), see the {{ monitoring-full-name }} documentation.

#### Deactivating a trail {#deactivating-trail}

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
    1. **{{ ui-key.yacloud_monitoring.alert.label_trigger-condition }}**: `{{ ui-key.yacloud_monitoring.alert.title_comparison-ne }}`.
    1. **{{ ui-key.yacloud_monitoring.alert.label_alarm }}**: `0`.
1. Under **{{ ui-key.yacloud_monitoring.alert.section_notifications }}**, click **{{ ui-key.yacloud_monitoring.alert.button_add-channel }}** and select the [previously created](#create-channel) notification channel.
1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**. 

The alert is created.

#### Stopping delivery of audit logs to destination object {#stopping-logs}

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
    1. **{{ ui-key.yacloud_monitoring.alert.label_trigger-condition }}**: `{{ ui-key.yacloud_monitoring.alert.title_comparison-eq }}`.
    1. **{{ ui-key.yacloud_monitoring.alert.label_alarm }}**: `0`.
    1. **{{ ui-key.yacloud_monitoring.alert.label_evaluation-window }}**: `<trail_value>`.
1. Under **{{ ui-key.yacloud_monitoring.alert.section_notifications }}**, click **{{ ui-key.yacloud_monitoring.alert.button_add-channel }}** and select the [previously created](#create-channel) notification channel.
1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**. 

The alert is created.

#### Modifying the number of trails {#number-trails}

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
    1. **{{ ui-key.yacloud_monitoring.alert.label_trigger-condition }}**: `{{ ui-key.yacloud_monitoring.alert.title_comparison-ne }}`.
    1. **{{ ui-key.yacloud_monitoring.alert.label_alarm }}**: `<number_of_trails>`.
1. Under **{{ ui-key.yacloud_monitoring.alert.section_notifications }}**, click **{{ ui-key.yacloud_monitoring.alert.button_add-channel }}** and select the [previously created](#create-channel) notification channel.
1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

#### Nearing cloud trail quota {#trail-quota}

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
    1. **{{ ui-key.yacloud_monitoring.alert.label_trigger-condition }}**: `{{ ui-key.yacloud_monitoring.alert.title_comparison-gt }}`.
    1. **{{ ui-key.yacloud_monitoring.alert.label_alarm }}**: `<number_equal_to_80%_of_quota>`.
1. Under **{{ ui-key.yacloud_monitoring.alert.section_notifications }}**, click **{{ ui-key.yacloud_monitoring.alert.button_add-channel }}** and select the [previously created](#create-channel) notification channel.
1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

#### Unauthorized access attempts {#unauthorized-access}

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
    1. **{{ ui-key.yacloud_monitoring.alert.label_trigger-condition }}**: `{{ ui-key.yacloud_monitoring.alert.title_comparison-gt }}`.
    1. **{{ ui-key.yacloud_monitoring.alert.label_alarm }}**: `0`.
1. Under **{{ ui-key.yacloud_monitoring.alert.section_notifications }}**, click **{{ ui-key.yacloud_monitoring.alert.button_add-channel }}** and select the [previously created](#create-channel) notification channel.
1. Click **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

## Set up a dashboard {#setup-dashboard}

### Create a dashboard {#create-dashboard}

{% list tabs group=instructions %}

- {{ monitoring-short-name }} UI {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the trails are in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. Navigate to the **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}** tab.
  1. Click **{{ ui-key.yacloud_monitoring.actions.common.create }}**.
  1. Click **{{ ui-key.yacloud_monitoring.actions.common.save }}** at the top right.
  1. In the window that opens, enter a name for the dashboard, e.g., `missing-events`, and click **{{ ui-key.yacloud_monitoring.actions.common.save }}**.

{% endlist %}

### Create a chart for missed event monitoring {#create-missing-events-chart}

You can monitor missed events using [{{ at-name }} metrics](../../audit-trails/concepts/user-metrics.md):

* `trail.processed_events_count`: Rate at which the events are accepted for processing.
* `trail.delivered_events_count`: Event delivery rate to the destination object.

Copy a ready-to-use chart for missed event monitoring to your dashboard:

1. Open the trail dashboard in {{ monitoring-name }}:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
      1. In the left-hand panel, select ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.audit-trails.label_trails }}**.
      1. Select the trail you need.
      1. Go to the ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}** panel for the selected trail.
      1. Click **{{ ui-key.yacloud.monitoring.button_open-in-monitoring }}** at the top right.

          This will take you to the {{ monitoring-short-name }} interface.

    {% endlist %}

1. Copy the chart:

    {% list tabs group=instructions %}

    - {{ monitoring-short-name }} UI {#console}

      1. Find the **Processed versus delivered events** chart.
      1. To the right of the chart name, click ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) → **{{ ui-key.yacloud_monitoring.dashboard.widget.copy }}**.
      1. Specify a name, e.g., `Processed versus delivered events — <trail_name>`.
      1. Select a cloud and folder, then specify the dashboard [you created earlier](#create-dashboard).
      1. Click **{{ ui-key.yacloud_monitoring.component.add-to-dashboard-form.action.copy-and-go }}**.

          This will open your dashboard with a new chart.

    {% endlist %}

If you need to, follow the same steps to add charts from other trails to your dashboard.

### Review the chart for missed event monitoring {#investigate-missing-events-chart}

Note that there may be a lag between **Delivered events** and **Processed events**. Normally, you may encounter short-term lags that are compensated soon. If you have observed a persistent delivery lag of one hour or longer, check the trail status and [diagnostics logs](../../audit-trails/concepts/diagnostics.md).

#### Get the trail status {#get-trail-status}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.audit-trails.label_trails }}**.
  1. Select the trail. The **{{ ui-key.yacloud.audit-trails.label_trail }}** page will display detailed information about the trail.

{% endlist %}

The `Active` status during a persistent lag between **Delivered events** and **Processed events** means that the trail operates normally, but there are some other reasons why data is delivered to the destination object with delays. In this case, check the destination object status and logs:

* [{#T}](../../storage/operations/buckets/get-info.md)
* [Getting information about a log group](../../logging/operations/index.md#log-group-info)
* [{#T}](../../data-streams/operations/index.md)

The `Error` status indicates a trail performance error. In which case, review the trail diagnostics log.

#### Review the trail diagnostics log {#get-trail-status}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.audit-trails.label_trails }}**.
  1. Select the trail.
  1. Navigate to the ![image](../../_assets/console-icons/receipt.svg) **{{ ui-key.yacloud.audit-trails.logs }}** panel and review the log.
  1. Read [this](../../audit-trails/operations/error.md) troubleshooting guide.

{% endlist %}

### Create a chart for the destination object {#create-destination-chart}

Apart from the chart for missed event monitoring, you can add a chart for the destination object:

* **{{ objstorage-name }}**

    Events can be missed if there is not enough space for storing logs, e.g, if a trail sends logs to a bucket of limited size. To monitor the available bucket space, create a chart for the `space_usage` [metric](../../monitoring/metrics-ref/storage-ref.md) and add the `max-size` metric as a threshold.

    The `max-size` metric will not be available if the maximum bucket size is not specified. If so, you need to track the storage space per cloud [quota](../../storage/concepts/limits.md#storage-quotas) usage on your own.

* **{{ cloud-logging-name }}**

    [Add](../../logging/tutorials/log-group-record-monitoring.md) a chart for the `group.service.ingested_records_per_second` [metric](../../monitoring/metrics-ref/logging-ref.md) to the dashboard to display the actual rate of log ingestion into the log group. Comparing this value with the `Maximum write speed` [quota](../../logging/concepts/limits.md#logging-quotas) helps determine whether the log stream is hitting its limit. The additional `group.service.ingest_requests_per_second` chart filtered by `ERROR` status enables detecting write errors promptly.


* **{{ yds-name }}**: See the [{{ ydb-full-name }}](../../ydb/) tutorials:
  * [{#T}](../../ydb/metrics.md)
  * [{#T}](../../ydb/concepts/limits.md)



## How to delete the resources you created {#clear-out}

* [Delete the alerts](../../monitoring/operations/alert/delete-alert.md)
* [Delete the dashboard](../../monitoring/operations/dashboard/delete-dashboard.md)