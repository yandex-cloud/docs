In this example, you will install [Spring PetClinic](https://github.com/spring-projects/spring-petclinic) and set up sending telemetry data to {{ monium-name }}.

{% list tabs group=instructions %}

- Your infrastructure {#user-infrastructure}

  1. Install [Git](https://git-scm.com/install/) and [Java](https://jdk.java.net/) suitable for your OS. Here is an example:

     ```bash
     sudo apt update
     sudo apt install -y git openjdk-17-jdk
     ```

  1. Download and install [OTel Collector](https://github.com/open-telemetry/opentelemetry-collector-releases/releases) suitable for your OS. Here is an example:

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
        
        exporters:
          otlp_grpc/monium:
            compression: zstd
            endpoint: {{ api-host-monium }}:443
            headers:
              Authorization: "Api-Key ${env:MONIUM_API_KEY}"
              x-monium-project: "${env:MONIUM_PROJECT}"
            sending_queue:
              batch:
        
        service:
          pipelines:
            metrics:
              receivers: [ otlp ]
              exporters: [ otlp_grpc/monium ]
            traces:
              receivers: [ otlp ]
              exporters: [ otlp_grpc/monium ]
            logs:
              receivers: [ otlp ]
              exporters: [ otlp_grpc/monium ]
          telemetry:
            metrics:
              level: normal
              readers:
                - periodic:
                    exporter:
                      otlp:
                        protocol: http/protobuf
                        endpoint: http://localhost:4318
                    interval: 30000
                    timeout: 5000
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
  
  1. Run the application with the Java agent to send telemetry to OTel Collector:

     ```bash
     OTEL_SERVICE_NAME=spring-petclinic \
     OTEL_EXPORTER_OTLP_METRICS_TEMPORALITY_PREFERENCE="delta" \
     java -javaagent:./opentelemetry-javaagent.jar -jar target/*.jar
     ```

  1. Open the Spring PetClinic website at `http://localhost:8080` and simulate user actions.

{% endlist %}