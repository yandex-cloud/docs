# Getting started with {{ traces-name }}

{{ traces-name }} is a tool for tracing and analysis of distributed requests. You can use traces to search for causes of low performance and failures, and monitor the execution of specific requests. The system forms a part of {{ monium-name }} and makes use of its shared components, i.e., access management, data model, and unified interface.

## Trace delivery {#data-send}

Trace delivery is configured the same way as delivery of other telemetry data. See [Data delivery](../collector/index.md) for information about configuration rules, authentication, agent configuration, and implementation examples.

### {{ traces-name }} parameters {#main-parameters}

* {% include [otel-only](../../_includes/monium/otel-only.md) %}

* Address for traces: `{{ api-host-monium }}:443`.

* To write logs, you will need a [service account](../../iam/operations/sa/create.md) with the `monium.traces.writer` role and an [API key](../../iam/operations/iam-token/create-for-sa.md).

* Trace viewing interface: [{{ monium-name }}]({{ link-monium }}) home page > **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.traces.title }}**.

## Viewing traces {#view-traces}

1. On the [{{ monium-name }} home page]({{ link-monium }}), select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.traces.title }}** on the left.
1. At the top, set the search interval using the timeline, a preset interval, or by entering the time value directly.
1. Select **{{ ui-key.yacloud_monitoring.traces.traces-search.mode.traces }}** or **{{ ui-key.yacloud_monitoring.traces.traces-search.mode.spans }}**.
1. Enter a date search [query](../concepts/querying.md).
    
     By default, the search will take place in the current project: `folder__<folder_ID>`, you can choose another one.

1. Click **Execute**.

1. To open a separate trace, specify its ID in the **{{ ui-key.yacloud_monitoring.traces.trace-id-input.placeholder }}** field at the top right.

For more on trace viewing and searching, see [{#T}](operations/traces-explorer.md).

#### See also {#see-also}

* [{#T}](operations/traces-explorer.md)
* [{#T}](../logs/quickstart.md)
* [{#T}](../metrics/quickstart.md)