# Getting started with {{ cloud-logging-name }}

{{ cloud-logging-name }} is a distributed and highly available system for storing, searching, visualizing, and analyzing logs. The system forms a part of {{ monium-name }} and makes use of its shared components, i.e., access management, data model, and unified interface.

{{ cloud-logging-name }} features:

* {% include [otel-only](../../_includes/monium/otel-only.md) %}

* You can write logs via the [API](../api-ref/authentication.md) in gRPC and HTTP formats.

* Address for writing logs: `{{ api-host-monium }}:443`.

* To write logs, you will need a [service account](../../iam/operations/sa/create.md) with the `monium.logs.writer` role and an [API key](../../iam/operations/iam-token/create-for-sa.md).

* Log viewing interface: [{{ monium-name }} home page]({{ link-monium }}) > **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.logs.title }}**.

## Setting up logging {#configure-traces-export}

Follow these steps to set up log transfer from your application to {{ cloud-logging-name }} through {{ unified-agent-short-name }}. The application will send logs in OTLP format to the local {{ unified-agent-short-name }} input, and the agent will collect the logs and deliver them to {{ monium-name }}. The application can be located either in your local infrastructure or in {{ yandex-cloud }}.

You also can set up log transfer through [Fluent Bit](write/fluent-bit.md) or directly from the app. By using the agent, you separate the generation of logs and their delivery to the storage system. This approach removes the need for the application to write data to the storage system and prevents data loss in case of failures.

{% cut "If you are not signed up to {{ yandex-cloud }}" %}

{% include [before-you-begin](../../_includes/monium/before-you-begin.md) %}

{% endcut %}

1. [Create](../../iam/operations/sa/create.md) a service account with the `monium.logs.writer` role.
1. Create an [API key](../../iam/operations/authentication/manage-api-keys.md#create-api-key) for the service account.

1. Set up log transfer from your application in OTLP format:
     1. Install an [SDK](https://opentelemetry.io/docs/languages/) for relevant programming language.
     1. Set up log transfer to the address the agent will be listening to, e.g, `localhost:8889`.

1. Install [{{ unified-agent-short-name }}](../concepts/data-collection/unified-agent/installation.md).

1. Configure {{ unified-agent-short-name }} to listen to the app's logs and send them to {{ monium-name }}.

     Example configuration:

     ```yaml
     storages:
        - name: logs_storage
        plugin: fs
        config:
            directory: /my/logs_storage
            max_partition_size: 1gb

    routes:
    - input:
        plugin: otel_logs
        config:
            port: 8889

        channel:
        pipe:
            - storage_ref:
                name: logs_storage
        output:
            plugin: otel_logs
            config:
            project: folder__<folder_ID>
            cluster: doc

            format: proto
            url: "{{ api-host-monium }}:443"

            tvm:
                client_id: 2025442
                destination_id: 2045111
                secret:
                file: /my/secret/token
     ```

     In this configuration, {{ unified-agent-short-name }} will accept application logs in OpenTelemetry format at `localhost:8889` and send them to the collector that writes logs from the `2025442` TVM application to the `folder__<folder_ID>` project.

     {{ unified-agent-short-name }} uses the [otel_logs input](../concepts/data-collection/unified-agent/inputs.md#otel_logs_input) to accept logs and the [otel_logs output](../concepts/data-collection/unified-agent/outputs.md#otel_logs_output) to transfer them.

1. Run your app and start sending logs.

## Viewing logs {#view-logs}

1. On the [{{ monium-name }} home page]({{ link-monium }}), select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.logs.title }}** on the left.
1. At the top, set the search interval using the timeline, a preset interval, or by entering the time value directly.
1. In the search bar, enter a query to search for application logs:
   1. Select the `folder__<folder_ID>` project. By default, the current folder's project is selected.
   1. Enter your query to search for application logs.
   1. Click **Execute query**.
1. To view logs for a specific entry, expand it.


#### See also {#see-also}

* [{#T}](../traces/quickstart.md)
* [{#T}](../metrics/quickstart.md)