# Collecting telemetry

## Data transfer parameters {#connection-parameters}

To transmit telemetry to {{ monium-name }}:

1. Set up telemetry collection from your application in [OpenTelemetry](https://opentelemetry.io/) format.

     You can send telemetry directly from the application or via an [agent](#collectors).
     
1. [Create a service account](../../iam/operations/sa/create.md).
1. [Create an API key](../../iam/operations/authentication/manage-api-keys.md) for the service account with the required scopes:
   * `yc.monitoring.manage`: Writing data.
   * `yc.monium.telemetry.write`: Writing all telemetry types.
   * `yc.monium.metrics.write`: Writing metrics.
   * `yc.monium.logs.write`: Writing logs.
   * `yc.monium.traces.write`: Writing traces.

1. Specify data transfer settings:

    * Endpoint: `{{ api-host-monium }}:443`.
    * Protocol: `gRPC` or `HTTP`.

1. In {{ monium-name }}, telemetry follows this hierarchy: project → cluster → service. Data is stored in shards in _service-cluster_ pairs.

     To distribute data, specify:

      * Project: Provided as the `x-monium-project` header parameter. This may be a `folder__<folder_ID>` or a `cloud__<cloud_ID>`.
      * Cluster: Provided in `OTEL_RESOURCE_ATTRIBUTES` with the `cluster` or `deployment.name` key name. This is optional. If a cluster is not specified, data will go to the `default` cluster.
      * Service: Provided in `OTEL_RESOURCE_ATTRIBUTES` with the `service` or `service.name` key name.

    {% include [shard-distribution](../../_includes/monium/shard-distribution.md) %}

## Data transfer agents {#collectors}

With {{ monium-name }}, you can manage telemetry from {{ yandex-cloud }} resources, other clouds, or applications in your infrastructure.

Transfer of {{ yandex-cloud }} data is set up when you create or update a resource.

To set up data transfer from applications, do one or both of the following:
* Connect the OpenTelemetry SDK and set up OTLP export.
* Use automation tools, i.e., agents or libraries that automatically collect telemetry from popular frameworks and libraries without modifying the code.

You can transfer data to {{ monium-name }} directly from the OpenTelemetry SDK or use an OTLP-compatible agent.


The agent is installed next to the application on a server, VM, or in a container and set up to receive telemetry and send it to {{ monium-name }}. If the application is configured to send data in a format other than OTLP, you will need an intermediate agent for OTLP conversion.

Learn more about setting up agents:

* [{{ unified-agent-short-name }}](../concepts/data-collection/unified-agent/index.md): Agent by Yandex.
* [OTel Collector](../collector/opentelemetry.md): OpenTelemetry ecosystem agent.
* [Fluent Bit](../logs/write/fluent-bit.md): Agent to use for logs.