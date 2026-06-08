# Getting started with {{ monium-name }}

{{ monium-name }} is a platform for collecting [metrics](./metrics/overview.md), [logs](./logs/quickstart.md), and [traces](./traces/index.md) from {{ yandex-cloud }}, other clouds, or your local infrastructure.

Follow this guide to send telemetry data from your app or demo app via [OTel Collector](https://opentelemetry.io/docs/) and view it in {{ monium-name }}.

To get started with app telemetry:

1. [Get your cloud ready](#before-begin).
1. [Create a service account and API key](#create-ca-key).
1. [Set up your application ](#setup-app).
1. [View the data in {{ monium-name }}](#view-telemetry).

## Get your cloud ready {#before-begin}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [before-you-begin](../_includes/monium/before-you-begin.md) %}

{% endlist %}

## Create a service account and API key {#create-ca-key}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [create-ca-api-key](../_includes/monium/create-ca-api-key.md) %}

{% endlist %}


## Set up your application {#setup-app}

In {{ monium-name }}, telemetry has this hierarchy: project → cluster → service. Data for each service-cluster pair is distributed to individual shards.

The method of configuring your application depends on whether telemetry is already configured or not. If you have already configured telemetry in the application, [specify the connection parameters for {{ monium-name }}](#monium-connect). If telemetry has not yet been configured, or if you do not have an application, [perform a complete setup](#otel-settings).

### Specify the {{ monium-name }} connection settings if telemetry is already configured in your app {#monium-connect}

If you have an application and telemetry delivery is already configured, specify the parameters required to connect to {{ monium-name }}:

* Authentication: [API key](#create-ca-key).
* Endpoint: `{{ api-host-monium }}:443`.
* In the header: `x-monium-project=folder__<folder_ID>` parameter.
* In `OTEL_RESOURCE_ATTRIBUTES`: `cluster` or `deployment.name` and `service` or `service.name`.

{% cut "Attribute priority when writing data" %}

{% include [shard-distribution](../_includes/monium/shard-distribution.md) %}

{% endcut %}

### Set up transfer of telemetry from an app {#otel-settings}

If you have your own application but telemetry delivery has not yet been configured in it, perform the necessary configuration. If you do not have a ready-made application for testing, use the demo app.

{% list tabs group=instructions %}

- Custom app {#own-app}

  1. Set these environment variables:
     
     * `MONIUM_PROJECT`: {{ monium-name }} project name.

       By default, when you create a cloud and folder, two projects are created: `cloud__<cloud_ID>` and `folder__<folder_ID>`. You can also [create other projects](collector/project.md#project-create).
     
       To test {{ monium-name }}, you can specify a project folder, e.g., `folder__{{ folder-id-example }}`.
       
       If entering it manually, make sure that `folder` is followed by two underscores.
     
     
     * `MONIUM_API_KEY`: API key.
  
  1. Set up your application to send OTLP telemetry:
     
     * Install the [auto-instrumentation](https://opentelemetry.io/docs/concepts/instrumentation/#automatic-instrumentation) agent to automatically collect some telemetry data and send it to OTLP.
     * Add the [OpenTelemetry SDK](https://opentelemetry.io/docs/languages/) to your app.

  1. [Install](https://opentelemetry.io/docs/collector/installation/) OTel Collector.

     You can send data to {{ monium-name }} directly from the OpenTelemetry SDK, without using the agent.

  1. In the `otel-collector.yaml` [configuration](https://opentelemetry.io/docs/collector/configuration/) file, configure data transfer to {{ monium-name }}.
  
        Example of a minimal `otel-collector.yaml` configuration:

        ```yaml
        receivers:       
          otlp:          # Target type: OTLP
            protocols:   # Protocols that OTel Collector listens to
              grpc:      # gRPC, default port 4317
              http:      # HTTP, default port 4318

        processors:
          cumulativetodelta:
          batch:

        exporters:       # Connecting to {{ monium-name }}
          otlp/monium:
            compression: zstd
            endpoint: {{ api-host-monium }}:443
            headers:
              Authorization: "Api-Key ${env:MONIUM_API_KEY}"
              x-monium-project: "${env:MONIUM_PROJECT}"

        service:         
          pipelines:
            metrics:                 # Transferring metrics
              receivers: [ otlp ]
              processors: [ batch, cumulativetodelta ]
              exporters: [ otlp/monium ]
            traces:                  # Transferring traces
              receivers: [ otlp ]
              processors: [ batch ]
              exporters: [ otlp/monium ]
            logs:                    # Transferring logs
              receivers: [ otlp ]
              processors: [ batch ]
              exporters: [ otlp/monium ]
        ```

  1. Set the environment variables to distribute data across shards in {{ monium-name }}:
     * `OTEL_SERVICE_NAME`: Name of your application or service.
     * `OTEL_RESOURCE_ATTRIBUTES="cluster=my-cluster"`: Name of the installation the application operates in, e.g., production or test environment. This is an optional setting. The default value is `cluster=default`.
  
  1. Run your app and start sending telemetry.

- Demo app {#demo-app}

  {% include [pet-clinic-intro](../_includes/monium/pet-clinic-intro.md) %}

  {% include [pet-clinic](../_includes/monium/pet-clinic.md) %}

{% endlist %}

After you finish your app setup, [view the telemetry in {{ monium-name }}](#view-telemetry).

## View the data in {{ monium-name }} {#view-telemetry}

{% include [view-telemetry](../_includes/monium/view-telemetry.md) %}

{% include [data-lag](../_includes/monium/data-lag.md) %}

To use the data you collected, you can create [dashboards](operations/dashboard/create.md) and [alerts](operations/alert/create-alert.md).

#### See also {#see-also}

* [Getting started with metrics](metrics/quickstart.md)
* [Getting started with logs](logs/quickstart.md)
* [Getting started with traces](traces/index.md)
* [Creating a dashboard](operations/dashboard/create.md)
* [Creating an alert](operations/alert/create-alert.md)
* [Telemetry delivery methods](collector/index.md)
