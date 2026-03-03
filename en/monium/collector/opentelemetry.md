# Data transmission via OpenTelemetry Collector

OpenTelemetry Collector (OTel Collector) is an agent that collects, processes, and exports telemetry data based on the [OpenTelemetry](https://opentelemetry.io/docs/) standard. You can use the OTel Collector to transfer data from your app to {{ monium-name }}.

## Setting up transfer of metrics from an app {#configure-metrics-transfer}

1. Add the {{ monium-name }} project name to the `MONIUM_PROJECT` environment variable.

    The project name format is `folder__{folder_id}`, where `folder_id` is the ID of the {{ yandex-cloud }} [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing your app.
    
    The folder must have the `monitoring.editor` [role](../../resource-manager/operations/folder/set-access-bindings.md) or higher assigned to it.

1. In this folder, create a [service account](../../iam/operations/sa/create.md) and [API key](../../iam/operations/iam-token/create-for-sa.md) with the `yc.monitoring.manage` and `yc.logging.write` scopes.

1. Add the API key to the `MONIUM_API_KEY` environment variable.

1. Add the [OpenTelemetry SDK](https://opentelemetry.io/docs/languages/) to your app.

1. [Install](https://opentelemetry.io/docs/collector/installation/) OTel Collector.

1. In the `otel-collector.yaml` [configuration](https://opentelemetry.io/docs/collector/configuration/) file, configure data transfer to {{ monium-name }}:
   
   * In the `x-monium-project` header, specify the project name: the `MONIUM_PROJECT` or `folder__{folder_id}` variable.

   * Add to the configuration the `cumulativetodeltaprocessor` processor to provide monotonically increasing sums as a `RATE` type metric.

   * Optionally, enable `zstd` compression to reduce CPU consumption compared to the default `gzip` method.

        Example of a minimal `otel-collector.yaml` configuration:

        ```yaml
        receivers:       # Configuration of input data (metrics, logs, traces)
            otlp:        # Target type: OTLP (OpenTelemetry Protocol)
            protocols:   # List of protocols the Collector will await data on:
            grpc:        # gRPC, default port 4317
            http:        # HTTP, default port 4318
        
        processors:
            cumulativetodelta:

        exporters:       # Receiving system parameters: {{ monium-name }}
            otlp/monium:
            compression: zstd
            endpoint: {{ api-host-monium }}:443
            headers:
                Authorization: Api-Key ${env:MONIUM_API_KEY}
                x-monium-project: ${env:MONIUM_PROJECT}

        service:         # Routing of data processing in Collector
            pipelines:
            metrics:     # Transfer of metrics, you can also add traces and logs
                receivers: [ otlp ]
                processors: [ batch, cumulativetodelta ]
                exporters: [ otlp/monium ]
        ```

1. Add the name of your app or service to the `OTEL_SERVICE_NAME` environment variable.

1. Run the app.

1. View the submitted metrics.

   1. Open the [shard](../concepts/glossary.md#shard) list:

      ```
      {{ link-monium }}/projects/<project_name>/shards/
      ```
    
      Where `<project_name>` is the `${MONIUM_PROJECT}` variable or the `folder__{folder_id}` record.
    
   1. Select the shard of your application or service.

## Distribution of metrics across shards {#shard-distribution}

{% include [shard-distribution](../../_includes/monium/shard-distribution.md) %}

## Example of adding telemetry {#spring-example}

In this example, you will add telemetry tools to the [Spring Pet Clinic](https://github.com/spring-projects/spring-petclinic) test app developed on the basis of the [Spring Framework](https://spring.io/).

1. Install and set up [OTel Collector](#configure-metrics-transfer).

1. Download the repository and build the app:

    ```sh
    git clone https://github.com/spring-projects/spring-petclinic
    cd spring-petclinic
    ./mvnw clean package
    ```

1. Download the Java agent for telemetry collection:

    ```sh
    curl -L 'https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/latest/download/opentelemetry-javaagent.jar' > opentelemetry-javaagent.jar
    ```

1. Configure the `service.name` resource attribute via the `OTEL_SERVICE_NAME` environment variable. 

1. Run the application with the Java agent sending data to the locally installed otel-collector:

    ```sh
    OTEL_SERVICE_NAME=pet-clinic java -javaagent:opentelemetry-javaagent.jar -jar target/spring-petclinic-*-SNAPSHOT.jar
    ```

1. View the submitted metrics in the shard at the following link:

    ```
    {{ link-monium }}/projects/<project_name>/shards/<project_name>_default_pet-clinic
    ```

    Where `<project_name>` is the `${MONIUM_PROJECT}` variable or the `folder__{folder_id}` record.

    OTel Collector transmits data within one minute.
