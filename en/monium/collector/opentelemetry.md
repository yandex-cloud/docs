# Data transmission via OpenTelemetry Collector

OpenTelemetry Collector (OTel Collector) is an agent that collects, processes, and exports telemetry data based on the [OpenTelemetry](https://opentelemetry.io/docs/) standard. You can use the OTel Collector to transfer data from your app to {{ monium-name }}.

This application can be located in the {{ yandex-cloud }} infrastructure, another cloud, or your local infrastructure.

## Setting up transfer of telemetry from an app {#configure-metrics-transfer}

1. [Install](https://opentelemetry.io/docs/collector/installation/) OTel Collector next to your app.

1. Add the [OpenTelemetry SDK](https://opentelemetry.io/docs/languages/) to your app.

1. Create a `otel-collector.yaml` configuration file.

    The `otel-collector.yaml` configuration below enables delivery of all telemetry types; remove those you do not need.

    {% include [otel-collector-config](../../_includes/monium/otel-collector-config.md) %}

1. Check your `otel-collector.yaml` configuration:

    ```bash
    otelcol validate --config=otel-collector.yaml
    ```

1. Set these environment variables:
     
     * `MONIUM_PROJECT`: {{ monium-name }} project name. Your project name can be in `folder__<folder_ID>` format, e.g., `folder__{{ folder-id-example }}`.
     * `MONIUM_API_KEY`: API key.
     * `OTEL_SERVICE_NAME`: Name of your application or service for data distribution across shards.

1. Run your application and start delivery of telemetry.

1. View telemetry data in [{{ monium-name }}]({{ link-monium }}).