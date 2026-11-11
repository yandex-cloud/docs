---
title: Sending telemetry data to {{ monium-full-name }} via Fluent Bit
description: Configure Fluent Bit to send logs, metrics, and traces to {{ monium-name }} over OTLP.
---

# Data transmission via Fluent Bit

Fluent Bit is an agent for collecting, processing, and exporting logs, metrics, and traces. You can use Fluent Bit to send telemetry data to {{ monium-name }} over the [OpenTelemetry protocol](https://opentelemetry.io/docs/specs/otlp/) (OTLP).

You can use Fluent Bit in the following cases:

* You need to parse logs in different formats.
* You need to collect logs in a {{ k8s }} cluster.
* You need to collect different logs from a single host: from files, Docker, system logs, or standard app outputs.
* You need a lightweight agent for receiving and sending metrics and traces over OTLP. When sending metrics, keep [limitations](#metrics-limitations) in mind.

Otherwise, we recommend using [OTel Collector](opentelemetry.md).

## Version requirements {#version}

{% include [fluentbit-version](../../_includes/monium/fluentbit-version.md) %}

## Metric transmission limitations {#metrics-limitations}

Fluent Bit does not save the start time of the metric period (`startTimeUnixNano`). Without it the change (delta) of the metric is processed incorrectly. Do not use Fluent Bit to transmit metrics if the `OTEL_EXPORTER_OTLP_METRICS_TEMPORALITY_PREFERENCE="delta"` variable is set in your application.

## Configuring telemetry transmission {#configure}

1. [Install](https://docs.fluentbit.io/manual/installation/downloads) Fluent Bit next to the telemetry source, e.g., on a server, in a container, or in a {{ k8s }} cluster.

1. Create a configuration file, e.g., `fluent-bit.yaml`.

    Below are examples of the minimum configuration you need to send logs, metrics, and traces to {{ monium-name }} over gRPC or HTTP. Configure the input plugin to match your data source.

    [Input](https://docs.fluentbit.io/manual/data-pipeline/inputs/opentelemetry) and [output](https://docs.fluentbit.io/manual/data-pipeline/outputs/opentelemetry) `opentelemetry` plugin are used to send traces. The agent accepts traces over OTLP, buffers them, and sends them to {{ monium-name }} over the same protocol.

    {% include [fluentbit-config](../../_includes/monium/fluentbit-config.md) %}

1. Set these environment variables:

   * `MONIUM_PROJECT`: {{ monium-name }} project, e.g., `folder__<folder_ID>`.
   * `MONIUM_API_KEY`: API key with permission to [write telemetry data](otlp-protocol.md#authorization).

1. Run Fluent Bit stating the configuration:

1. Configure your application to send telemetry data to Fluent Bit over OTLP/HTTP in Protobuf format. For example, for the OpenTelemetry SDK with [environment variable](https://opentelemetry.io/docs/languages/sdk-configuration/otlp-exporter/) support, set the following variables in the application environment:

   ```bash
   export OTEL_EXPORTER_OTLP_ENDPOINT="http://127.0.0.1:4318"
   export OTEL_EXPORTER_OTLP_PROTOCOL="http/protobuf"
   ```

   You can use the `127.0.0.1` address if the application and agent share a common network space, e.g., run on the same server without network isolation or in the same {{ k8s }} pod. In other cases, update the `listen` property of the input plugin and specify an agent address available over network in the application.

1. Run your app with these settings and start sending telemetry.

1. Check that the data is fed into [{{ monium-name }}]({{ link-monium }}).

   For more information on viewing data, see [{#T}](../metrics/metric-explorer.md), [{#T}](../logs/logs-explorer.md), and [{#T}](../traces/operations/traces-explorer.md).

For a simple scenario of using Fluent Bit to send all types of telemetry from a Java application to {{ monium-name }}, see [Example for a Java demo application with Fluent Bit](otel-clinic-fluentbit-example.md).

For detailed configuration examples (Docker, {{ k8s }}, parsers), see [Sending logs via Fluent Bit](../logs/write/fluent-bit.md).
