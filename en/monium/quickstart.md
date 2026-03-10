# Getting started with {{ monium-name }}

{{ monium-name }} is a platform made to collect telemetry data (metrics, logs, and traces) from {{ yandex-cloud }}, other clouds, or your local infrastructure.

Follow this guide to send telemetry data from your app or demo app via [OTel Collector](https://opentelemetry.io/docs/) and view it in {{ monium-name }}.

To get started:

1. [Get your cloud ready](#before-begin).
1. [Create a service account and API key](#create-ca-key).
1. Set up telemetry data transfer from [your app](#otel-settings) or [demo app](#example-app).

    If OTLP telemetry is already configured, specify [{{ monium-name }} connection settings](#monium-connect).

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


## Set up telemetry data transfer from your app {#otel-settings}

If you do not have a ready-to-use application, [configure a demo app](#example-app).

In {{ monium-name }}, telemetry follows this hierarchy: project → cluster → service. The data is distributed among shards for each service-cluster pair.

{% list tabs group=instructions %}

- Your infrastructure {#user-infrastructure}

  1. Set these environment variables:
     
     * `MONIUM_PROJECT`: {{ monium-name }} project name in `folder__<folder_ID>` format, e.g., `folder__{{ folder-id-example }}`.
     * `MONIUM_API_KEY`: API key.
  
  1. Set up telemetry from your application in OTLP format:
     
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

{% endlist %}

## {{ monium-name }} connection settings and data distribution {#monium-connect}

If your application is already configured to send telemetry data, specify these settings:

* Authentication: [API key](#create-ca-key).
* Endpoint: `{{ api-host-monium }}:443`.
* In the header: `x-monium-project=folder__<folder_ID>` parameter.
* In `OTEL_RESOURCE_ATTRIBUTES`: `cluster` or `deployment.name` and `service` or `service.name`.

{% include [shard-distribution](../_includes/monium/shard-distribution.md) %}

## View the data in {{ monium-name }} {#view-telemetry}

{% include [view-telemetry](../_includes/monium/view-telemetry.md) %}

To use telemetry data, create a [dashboard](operations/dashboard/create.md) and [alerts](operations/alert/create-alert.md).

## Example of demo app setup {#example-app}

{% include [pet-clinic](../_includes/monium/pet-clinic.md) %}
  
[Look up the telemetry data in {{ monium-name }}](#view-telemetry).

{% endlist %}

#### What's next

* [Creating a dashboard](metrics/quickstart.md)
* [Creating an alert](operations/alert/create-alert.md)
* [Configuring data collection via an agent](collector/)
* [Configuring logs](logs/quickstart.md)
* [Configuring traces](traces/)