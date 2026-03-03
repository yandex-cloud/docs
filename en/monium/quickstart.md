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
    
     {% cut "otel-collector.yaml section description" %}
     
     * `receivers`: Sets `otlp` (OpenTelemetry Protocol) as receiver type, and `grpc` and `http` as receiving protocols. You can specify ports if using non-default ones.
   
     * `processors`: Enables `cumulativetodeltaprocessor` to provide monotonically increasing sums as a `RATE` type metric.
   
     * `exporters`: {{ monium-name }} settings:
       * `endpoint`: Data endpoint, `{{ api-host-monium }}:443`.
       * `Authorization`: API key from the `MONIUM_API_KEY` variable.
       * `x-monium-project`: Project name from the `MONIUM_PROJECT` variable.
       * `compression`: `zstd` data compression type to reduce CPU consumption compared to the default `gzip` method. This is an optional setting.
   
     * `service` > `pipelines`: Properties of the channels for receiving and sending each data type to {{ monium-name }}: `metrics`, `logs`, and `traces`. You can specify only the data types you need.
    
     {% endcut %}

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

{% list tabs group=instructions %}

- Management console {#console}

  1. On the [{{ monium-name }}]({{ link-monium }}) home page, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.shards.title }}** on the left.
  1. In the list, select the shard with your service name.

     The shard name follows the `<project_name>_<cluster_name>_<service_name>` format, e.g., `folder__{{ folder-id-example }}_default_spring-petclinic`.
  
  1. To view a specific data type, on the left, select:

     * **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }}**.
 
       In the query string, select `project`, `cluster`, and `service` in succession and click **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**.
       Learn more about [using metrics](operations/metric/metric-explorer.md).

     * **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.logs.title }}**.
     
       In the query string, select `project`, `cluster`, and `service` in succession and click **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**.
       Learn more about [using logs](logs/).
     
     * **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.traces.title }}**.

       In the query string, select `project` and `service` in succession and click **Execute**.
       Learn more about [using traces](traces/operations/traces-explorer.md).

{% endlist %}

To use telemetry data, create a [dashboard](operations/dashboard/create.md) and [alerts](operations/alert/create-alert.md).

## Example of demo app setup {#example-app}

In this example, you will install [Spring PetClinic](https://github.com/spring-projects/spring-petclinic) and set up telemetry to {{ monium-name }}.

{% list tabs group=instructions %}

- Your infrastructure {#user-infrastructure}

  1. Install [Git](https://git-scm.com/install/) and [Java](https://jdk.java.net/) suitable for your OS. Here is an example:

     ```bash
     sudo apt update
     sudo apt install -y git openjdk-17-jdk
     ```

  1. Download and install OTel Collector for your OS. 
  
     {% include [otel-version](../_includes/monium/otel-version.md) %}

     ```bash
     wget https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/v144.0/otelcol-linux_amd64.tar.gz
     tar xvf otelcol-linux_amd64.tar.gz
     ```

  1. Set these environment variables:

     ```bash
     export MONIUM_PROJECT=folder__<folder_ID>
     export MONIUM_API_KEY=<API_key>
     ```

  1. Create a file named `stream_put_record.py` and paste the following code to it:

        ```yaml
        receivers:
          otlp:          
            protocols:   
              grpc:      
              http:      

        processors:
          cumulativetodelta:
          batch:

        exporters:       
          otlp/monium:
            compression: zstd
            endpoint: {{ api-host-monium }}:443
            headers:
              Authorization: "Api-Key ${env:MONIUM_API_KEY}"
              x-monium-project: "${env:MONIUM_PROJECT}"

        service:         
          pipelines:
            metrics:                 
              receivers: [ otlp ]
              processors: [ batch, cumulativetodelta ]
              exporters: [ otlp/monium ]
            traces:                 
              receivers: [ otlp ]
              processors: [ batch ]
              exporters: [ otlp/monium ]
            logs:                   
              receivers: [ otlp ]
              processors: [ batch ]
              exporters: [ otlp/monium ]
        ```
  
  1. Run OTel Collector:

     ```bash
     ./otelcol-linux_amd64 --config otel-collector.yaml
     ```
     
     It will start listening on ports `4317` (gRPC) and `4318` (HTTP).

  1. Download and build Spring PetClinic:

     ```bash
     git clone https://github.com/spring-projects/spring-petclinic
     cd spring-petclinic
     ./mvnw -DskipTests package
     ```
  
  1. Download the OpenTelemetry Java agent:

     ```bash
     curl -L -o opentelemetry-javaagent.jar \
     https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/latest/download/opentelemetry-javaagent.jar
     ```
  
  1. Set this environment variable:

     ```bash
     export OTEL_SERVICE_NAME=spring-petclinic
     ```
  
  1. Run the application with the Java agent to send telemetry to OTel Collector:

     ```bash
     java -javaagent:./opentelemetry-javaagent.jar -jar target/*.jar
     ```

  1. Open the Spring PetClinic website at `http://localhost:8080` and simulate user actions.
  
  1. [Look up the telemetry data in {{ monium-name }}](#view-telemetry).

{% endlist %}

#### What's next

* [Creating a dashboard](metrics/quickstart.md)
* [Creating an alert](operations/alert/create-alert.md)
* [Configuring data collection via an agent](collector/)
* [Configuring logs](logs/quickstart.md)
* [Configuring traces](traces/)