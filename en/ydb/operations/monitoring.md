---
title: Monitoring the database state in {{ ydb-name }}
description: You can track the state of a {{ ydb-name }} database using the monitoring tools in the management console. These tools display diagnostic information as charts. You can also configure Yandex Monitoring alerts for automatic database state monitoring.
---

# Monitoring a database state

You can find the database state details in the management console. You can view them on the **{{ ui-key.yacloud.common.monitoring }}** tab of the database management page or in {{ monitoring-full-name }}.

Diagnostic information about the database state is shown as charts. Charts update every minute.

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}


You can [configure alerts](#monitoring-integration) in {{ monitoring-full-name }} to get notified about database failures. In {{ monitoring-full-name }}, there are two trigger thresholds: `{{ ui-key.yacloud_monitoring.alert.status_warn }}` and `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`. If the specified threshold is exceeded, you will get alerts via the configured [notification channels](../../monitoring/concepts/alerting.md#notification-channel).


## Viewing monitoring charts {#monitoring-database}

To view detailed information about the {{ ydb-name }} database state:

1. In the [management console]({{ link-console-main }}), select the folder the database resides in.
1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
1. Click the database name and open the **{{ ui-key.yacloud.common.monitoring }}** tab.
1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

On the page that opens, you will see the database state charts.

## Integration with {{ monitoring-full-name }} {#monitoring-integration}

To set up alerts for database state indicators:

1. [Create an alert](../../monitoring/operations/alert/create-alert.md).
1. Add a state metric.
1. Set the alert threshold values in the alert settings.

For more information about the {{ ydb-name }} state metrics, see the [metric reference](../../monitoring/metrics-ref/ydb-ref.md).
