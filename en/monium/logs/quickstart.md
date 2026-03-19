# Getting started with {{ cloud-logging-name }}

{{ cloud-logging-name }} is a distributed and highly available system for storing, searching, visualizing, and analyzing logs. The system forms part of the {{ monium-name }} platform and uses its basic components, such as access management, data model, and unified interface.

## Log delivery {#data-send}

In {{ monium-name }}, log delivery is configured similarly to other types of telemetry. If you are new to {{ yandex-cloud }} or have no application from which to test sending logs, start with the general [{#T}](../quickstart.md) section: it describes the basics of how to set up your environment and send data with the help of Otel Collector.

You also can set up log transfer through [Fluent Bit](write/fluent-bit.md) or directly from the app.

If you already have a {{ yandex-cloud }} account, an application of your own, and prior experience with telemetry, configure log delivery as detailed below.

### {{ cloud-logging-name }} parameters {#main-parameters}

* {% include [otel-only](../../_includes/monium/otel-only.md) %}

* Address for writing logs: `{{ api-host-monium }}:443`.

* To write logs, you will need a [service account](../../iam/operations/sa/create.md) with the `monium.logs.writer` role and an [API key](../../iam/operations/iam-token/create-for-sa.md) with the `yc.monium.logs.write` scope.


## Viewing logs {#view-logs}

1. On the [{{ monium-name }} home page]({{ link-monium }}), select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.logs.title }}** on the left.
1. At the top, set the search interval using the timeline, a preset interval, or by entering the time value directly.
1. In the search bar, enter a query to search for application logs:
   1. Select the `folder__<folder_ID>` project. By default, the current folder's project is selected.
   1. Enter your query to search for application logs.
   1. Click **Execute query**.
1. To view logs for a specific entry, expand it.

## Service dashboard for logs {#logs-service-dashboard}

The system automatically collects [incoming log metrics](logs-metrics.md): data amount, delivery delays, number of errors by severity level.

Incoming log charts are available on the service dashboard.

#### See also {#see-also}

* [{#T}](../traces/quickstart.md)
* [{#T}](../metrics/quickstart.md)