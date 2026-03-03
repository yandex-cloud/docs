# Data collection agents

A telemetry collection agent allows you to separate the generation of traces on the application side and their subsequent delivery to the storage system. This approach gives you a more reliable and manageable observability infrastructure, removes the load of sending data from the application, and prevents data loss if the application fails or if storage is temporarily unavailable.

## Data flow overview {#data-transfer-scheme}

1. Generating traces in an application.

     An application generates traces using the [OpenTelemetry SDK](https://opentelemetry.io/docs/languages/) for the selected programming language. Currently, {{ monium-name }} only supports the OpenTelemetry format for incoming data.

1. Sending traces to a local agent.

     An application sends traces to a locally deployed agent on a specific port, e.g., `localhost:8889`.

1. Data collection and delivery by the agent.

     An agent listens on the specified port, receives incoming traces, temporarily stores them, and sends them to {{ monium-name }} for storage, visualization, and analysis.

You will need to manually configure the trace generation settings, collection port, delivery address, and {{ monium-name }} authorization in the agent configuration.

## Telemetry agents {#telemetry-agents}

* [{{ unified-agent-short-name }}](../../concepts/data-collection/unified-agent/): Yandex agent that supports traces, logs, and metrics.
* [OpenTelemetry Collector](https://opentelemetry.io/docs/collector/quick-start/): OpenTelemetry community agent.