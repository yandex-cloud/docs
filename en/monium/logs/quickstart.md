# Getting started with application logs

{{ monium-logs-name }} is a distributed and highly available system for storing, searching, visualizing, and analyzing logs. The system forms part of the {{ monium-name }} platform and uses its basic components, such as access management, data model, and unified interface.

This section provides general information about transferring logs from your app to {{ monium-name }} and viewing them.

For {{ yandex-cloud }} resources, see [{#T}](quickstart-resources.md).

## Log delivery {#data-send}

If you are new to {{ yandex-cloud }} or have no application to test sending logs from, visit [{#T}](../quickstart.md). The section describes the basic environment setup and sending telemetry data with the help of Otel Collector.

In {{ monium-name }}, log delivery is configured similarly to other types of telemetry. Data is received in OpenTelemetry format; therefore, you can send logs either using an agent or collector that supports it or send directly from the application.

If your cloud and application are already configured and you have prior experience with telemetry, configure log delivery as detailed below.

### {{ cloud-logging-name }} parameters {#main-parameters}

* {% include [otel-only](../../_includes/monium/otel-only.md) %}

* Address for writing logs: `{{ api-host-monium }}:443`.

* Authentication:
  * [Service account](../../iam/operations/sa/create.md) with the `monium.logs.writer` role or common `monium.telemetry.writer` role.
  * [API key](../../iam/operations/iam-token/create-for-sa.md) with the `yc.monium.logs.write` or `yc.monium.telemetry.write` scope.

* In header: `x-monium-project=<project_ID>` parameter.

    This may be a cloud (`cloud__<cloud_ID>`) project, folder (`folder__<folder_ID>`) project, or another [project](../../monium/collector/project.md#project-create).

* In `OTEL_RESOURCE_ATTRIBUTES`: `cluster` or `deployment.name` and `service` or `service.name`.

    If no cluster is specified, the default option is `cluster = default`.


## Viewing logs {#view-logs}

{% list tabs group=instructions %}

- {{ monium-name }} UI {#console}

  1. On the [{{ monium-name }}]({{ link-monium }}) home page, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.logs.title }}** on the left.
  1. At the top, set the data search period on the timeline.
  1. In the search bar, enter a query to search for application logs:
     
     {% include [application-labels](../../_includes/monium/application-labels.md) %}

  1. Click **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**.
  1. To view logs for a specific entry, expand it.

{% endlist %}

For more on logs, see [{#T}](logs-explorer.md).

## Service dashboard for logs {#logs-service-dashboard}

{% include [service-logs](../../_includes/monium/service-logs.md) %}

#### See also {#see-also}

* [{#T}](../traces/index.md)
* [{#T}](../metrics/quickstart.md)