# Collecting telemetry

{{ monium-name }} automatically receives telemetry data from {{ yandex-cloud }} resources. You can also send telemetry data in [OpenTelemetry](https://opentelemetry.io/) format to {{ monium-name }} from any sources: other clouds, your own infrastructure, or applications.

This section describes how to configure the transfer of metrics, logs, and traces to {{ monium-name }}. You can send data directly from an application using the OpenTelemetry SDK or use a collector agent for centralized telemetry collection and routing.

## Connection setup {#connection-parameters}

To transmit telemetry to {{ monium-name }}:

1. Set up telemetry collection from your application in [OpenTelemetry](https://opentelemetry.io/) format.

   You can send telemetry directly from the application or via an [agent](#collectors).
     
1. [Create a service account](../../iam/operations/sa/create.md).
1. [Create an API key](../../iam/operations/authentication/manage-api-keys.md) for the service account. Select a scope depending on the type of transferred data:

   * `yc.monium.telemetry.write`: Writing all telemetry types.
   * `yc.monium.metrics.write`: Writing metrics.
   * `yc.monium.logs.write`: Writing logs.
   * `yc.monium.traces.write`: Writing traces.

1. Configure the connection as follows:

    * Endpoint: `{{ api-host-monium }}:443`.
    * Protocol: `gRPC` or `HTTP`.

1. Configure data distribution across shards.

   In {{ monium-name }}, telemetry has this hierarchy: project → cluster → service. Data is stored in shards in _service-cluster_ pairs.

   Specify the following parameters:

   * **Project**: Provided as the `x-monium-project` header. 
   
      By default, when you create a cloud and folder, two projects are created: `cloud__<cloud_ID>` and `folder__<folder_ID>`. You can also create your own projects to collect telemetry.
   
   * **Cluster**: Provided in `OTEL_RESOURCE_ATTRIBUTES` with the `cluster` or `deployment.name` key. This is an optional property. The default value is `default`.
   * **Service**: Provided in `OTEL_RESOURCE_ATTRIBUTES` with the `service` or `service.name` key.

   {% include [shard-distribution](../../_includes/monium/shard-distribution.md) %}

## Agents {#collectors}

{{ monium-name }} accepts telemetry from {{ yandex-cloud }} resources, other clouds, and applications in your infrastructure.

Transfer for {{ yandex-cloud }} resources is set up when you create or update a resource.

Two types of telemetry collection are available for applications:

* **OpenTelemetry SDK**: Connect the SDK to your application and set up OTLP export.
* **Automatic instrumentation**: Use agents or libraries that automatically collect telemetry from popular frameworks without modifying the code.

You can transfer data directly from the SDK or use an OTLP-compatible agent.

The agent is installed next to the application on a server, VM, or in a container. It receives telemetry and sends it to {{ monium-name }}. If the application sends data in a format other than OTLP, you will need an agent for conversion.

Learn more about the setup:

* [{{ unified-agent-short-name }}](../concepts/data-collection/unified-agent/index.md): Agent by Yandex.
* [OTel Collector](../collector/opentelemetry.md): OpenTelemetry ecosystem agent.
* [Fluent Bit](fluentbit.md): A lightweight agent for log processing and forwarding other types of telemetry.