1. Install [Git](https://git-scm.com/install/) and [Java](https://jdk.java.net/) suitable for your OS. For example:

    ```bash
    sudo apt update
    sudo apt install -y git openjdk-17-jdk
    ```
1. Download and install an [OTel Collector](https://github.com/open-telemetry/opentelemetry-collector-releases/releases) agent suitable for your OS. For example:

    ```bash
    wget https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/v0.144.0/otelcol_0.144.0_linux_amd64.tar.gz
    tar xvf otelcol_0.144.0_linux_amd64.tar.gz
    ```
1. Set environment variables containing data for agent authentication in {{ monium-name }}:

    ```bash
    export MONIUM_PROJECT=folder__<folder_ID>
    export MONIUM_API_KEY=<API_key>
    ```

    Where:

    * `<folder_ID>`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) to house your {{ monium-name }} [project](../../monium/concepts/glossary.md#project).
    * `<api_key>`: Service account [API key](../../iam/concepts/authorization/api-key.md).

        This [service account](../../iam/concepts/users/service-accounts.md) must have the `monium.telemetry.writer` [role](../../monium/security/index.md#monium-telemetry-writer) or more granular roles to writing metrics, logs, or traces. The API key must have the `yc.monium.telemetry.write` [scope](../../iam/concepts/authorization/api-key.md#scoped-api-keys) or narrower scopes for writing metrics, logs, or traces.
1. Create a file named `otel-collector.yaml` and paste the following contents to it:

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
1. Run the [OTel Collector](../../monium/collector/opentelemetry.md) agent:

    ```bash
    ./otelcol --config otel-collector.yaml
    ```

    Once active, the agent will start listening on ports `4317` (gRPC) and `4318` (HTTP).
1. Open a new terminal window, then download and build the `Spring PetClinic` application:

    ```bash
    git clone https://github.com/spring-projects/spring-petclinic
    cd spring-petclinic
    ./mvnw -DskipTests package
    ```

    Result:

    ```text
    ...
    [INFO] ------------------------------------------------------------------------
    [INFO] BUILD SUCCESS
    [INFO] ------------------------------------------------------------------------
    [INFO] Total time:  53.308 s
    [INFO] Finished at: 2026-05-05T18:56:22Z
    [INFO] ------------------------------------------------------------------------
    ```
1. Download the OpenTelemetry Java agent:

    ```bash
    curl -L -o opentelemetry-javaagent.jar \
    https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/latest/download/opentelemetry-javaagent.jar
    ```
1. Run the demo application using the Java agent to send telemetry to OTel Collector:

    ```bash
    cd ~/spring-petclinic
    OTEL_SERVICE_NAME=spring-petclinic \
    OTEL_EXPORTER_OTLP_METRICS_TEMPORALITY_PREFERENCE="delta" \
    java -javaagent:./opentelemetry-javaagent.jar -jar target/*.jar
    ```

    Result:

    ```text
    ...
    2026-05-05T19:00:31.981Z  INFO 3657 --- [           main] 
    o.s.s.petclinic.PetClinicApplication     : Started PetClinicApplication in 9.287 seconds (process running for 12.883)
    ```
1. Open the running `Spring PetClinic` demo app in your browser:

    * If the application is installed on your local computer, its address is `http://localhost:8080`.
    * If you used a VM to install the application, its address is `http://<VM_public_IP_address>:8080`.

1. Interact with the demo application UI as a user: open a menu, click a button, enter new owner details, schedule an appointment, etc.
