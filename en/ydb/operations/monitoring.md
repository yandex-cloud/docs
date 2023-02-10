---
title: "Monitoring the database status in Managed Service for YDB"
description: "You can track the status of the Managed Service for YDB database with monitoring tools in the management console. These tools display diagnostic information in the form of charts. You can also configure Yandex Monitoring alerts to monitor the DB status automatically."
---

# Monitoring DB status

DB status details are available in the management console. You can view them on the **Monitoring** tab of the DB management page or in {{ monitoring-full-name }}.

Diagnostic information about the DB status is presented as charts. The chart update period is 1 minute.

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% if audience != "internal" %}

You can [configure alerts](#monitoring-integration) in {{ monitoring-full-name }} to receive notifications about DB failures. In {{ monitoring-full-name }}, there are two alert thresholds: `Warning` and `Alarm`. If the specified threshold is exceeded, you'll receive alerts via the configured [notification channels](../../monitoring/concepts/alerting.md#notification-channel).

{% endif %}

## Viewing monitoring charts {#monitoring-database}

To view detailed information about the {{ ydb-name }} database status:

1. Go to the folder page and select **{{ ydb-name }}**.
1. Click the name of the desired database and open the **Monitoring** tab.
1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

On the page that opens, you'll see the DB status charts.

## Integration with {{ monitoring-full-name }} {#monitoring-integration}

To set up alerts for DB status indicators:

1. [Create an alert](../../monitoring/operations/alert/create-alert.md).
1. Add a status metric.
1. Set the alert threshold values in the alert settings.

For more information about the {{ ydb-name }} status metrics, see the [metric reference](../../monitoring/metrics-ref/index.md#ydb).
