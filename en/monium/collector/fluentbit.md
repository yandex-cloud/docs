# Data transmission via Fluent Bit

Fluent Bit is an agent that collects, processes, and exports logs and metrics. You can use Fluent Bit to send telemetry data to {{ monium-name }} in [OpenTelemetry (OTLP)](https://opentelemetry.io/docs/) format.

Fluent Bit is your optimal choice in the following cases:

* Logs come in many different formats, so you need flexible parsers.
* Your app operates in a {{ k8s }} cluster.
* You need to collect logs centrally from a single host (files, Docker, system logs).
* Logs are already delivered via files or standard app outputs.

Otherwise, we recommend using [OTel Collector](opentelemetry.md).

## Version requirements {#version}

{% include [fluentbit-version](../../_includes/monium/fluentbit-version.md) %}

## Metric transmission limitations {#metrics-limitations}

Fluent Bit cuts the `startTimestampNanos` field off the metrics. Do not use Fluent Bit to transmit metrics if your application is configured for delta temporality (`OTEL_EXPORTER_OTLP_METRICS_TEMPORALITY_PREFERENCE="delta"`) because delta metrics without the period start time are processed incorrectly.

## Configuring telemetry transmission {#configure}

1. [Install](https://docs.fluentbit.io/fluent-bit/v/4.0/installation/getting-started-with-fluent-bit) Fluent Bit next to the telemetry source, e.g., on a server, in a container, or in a {{ k8s }} cluster.

1. Create a configuration file, e.g., `fluent-bit.yaml`.

    Below is an example of the minimum configuration you need to send logs, metrics, and traces to {{ monium-name }}. Configure inputs for your data source.

    {% include [fluentbit-config](../../_includes/monium/fluentbit-config.md) %}

1. Set these environment variables:
   * `MONIUM_PROJECT`: {{ monium-name }} project ID.
   * `MONIUM_API_KEY`: API key with permission to write telemetry data.

1. Run Fluent Bit stating the configuration:

1. Check that logs are fed into [{{ monium-name }}]({{ link-monium }}).

For a simple scenario of using Fluent Bit to send all types of telemetry from a Java application to {{ monium-name }}, see [Example for a Java demo application with Fluent Bit](otel-clinic-fluentbit-example.md).

For detailed configuration examples (Docker, {{ k8s }}, parsers), see [Sending logs via Fluent Bit](../logs/write/fluent-bit.md).
