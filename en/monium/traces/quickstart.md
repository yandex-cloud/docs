# Getting started with {{ traces-name }}

{{ traces-name }} is a tool for tracing and analysis of distributed requests. You can use traces to search for causes of low performance and failures, and monitor the execution of specific requests. The system forms a part of {{ monium-name }} and makes use of its shared components, i.e., access management, data model, and unified interface.

## {{ traces-name }} parameters {#main-parameters}

* {% include [otel-only](../../_includes/monium/otel-only.md) %}

* Address for traces: `{{ api-host-monium }}:443`.

* To write logs, you will need a [service account](../../iam/operations/sa/create.md) with the `monium.traces.writer` role and an [API key](../../iam/operations/iam-token/create-for-sa.md).

* Trace viewing interface: [{{ monium-name }} home page]({{ link-monium }}) > **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.traces.title }}**.

## Steps to set up tracing for an application {#configure-traces-export}

In this guide, you will set up the transfer of test traces using the gRPCurl utility. The `test_trace_data.json` file contains the pre-prepared test trace data; and the `send_trace.sh` script substitutes the dynamic data (`trace.id`, span date and time) in the test trace and sends it to {{ monium-name }}.

{% cut "If you are not signed up to {{ yandex-cloud }}" %}

{% include [before-you-begin](../../_includes/monium/before-you-begin.md) %}

{% endcut %}

**In the {{ yandex-cloud }} console**

1. Create a service account with the `monium.traces.writer` role.
1. Create an API key for the service account with `yc.monium.traces.write` for scope and save it. The API key will be used in the next step.

**In your infrastructure or VM**

1. Install [gRPCurl](https://github.com/fullstorydev/grpcurl).

1. Clone the OpenTelemetry repository containing the proto files for GRPC endpoints:

     ```bash
     git clone https://github.com/open-telemetry/opentelemetry-proto.git
     ```

1. Create a file named test_trace_data.json and paste the contents with test trace data into it:

     {% cut "test_trace_data.json" %}

     {% include [test_trace_data](../../_includes/monium/test_trace_data.md) %}

     {% endcut %}

1. Create a file named send_trace.sh and paste the contents of the trace sending script into it:

     {% cut "send_trace.sh" %}

     {% include [send_trace](../../_includes/monium/send_trace.md) %}

     {% endcut %}

1. Create the `MONIUM_PROJECT` and `MONIUM_API_KEY` environment variables and write your parameters into them:

     ```bash
     export MONIUM_PROJECT=<project_name>
     export MONIUM_API_KEY=<API_key>
     ```


     Where:
     
     * `project_name`: `folder__<folder_ID_in_{{ yandex-cloud }}>`, e.g., `folder__b1gv2q1ktr03hylke78j`.
     * `API_key`: API key you created earlier.

1. Add a permission to run the script: 

     ```bash
     chmod +x send_trace.sh
     ```

1. Run the `./send_trace.sh` script.

1. View the traces in {{ monium-name }}.



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

* [{#T}](write/python-ua.md)
* [{#T}](write/python-otel.md)
* [{#T}](operations/traces-explorer.md)
* [{#T}](../logs/quickstart.md)
* [{#T}](../metrics/quickstart.md)