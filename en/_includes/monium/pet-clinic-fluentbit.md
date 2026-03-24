In this example, you will install [Spring PetClinic](https://github.com/spring-projects/spring-petclinic) and set up sending telemetry data to {{ monium-name }} via Fluent Bit.

{% list tabs group=instructions %}

- Your infrastructure {#user-infrastructure}

  1. Install [Git](https://git-scm.com/install/) and [Java](https://jdk.java.net/) suitable for your OS. Here is an example:

     ```bash
     sudo apt update
     sudo apt install -y git openjdk-17-jdk
     ```

  1. Install [Fluent Bit](https://docs.fluentbit.io/fluent-bit/v/4.0/installation/getting-started-with-fluent-bit) 4.0 or higher.

  1. Set these environment variables:

     ```bash
     export MONIUM_PROJECT=<project_ID>
     export MONIUM_API_KEY=<API_key>
     ```

  1. Create a configuration file, e.g., `fluent-bit.yaml`. Use the [Fluent Bit settings](../../monium/collector/fluentbit.md#configure) section configuration. Example for gRPC:

     ```yaml
     pipeline:
       inputs:
         - name: opentelemetry
           listen: 127.0.0.1
           port: 4318

       outputs:
         - name: opentelemetry
           match: "*"
           host: {{ api-host-monium }}
           port: 443
           tls: on
           compress: zstd
           grpc: on
           header:
             - Authorization Api-Key ${MONIUM_API_KEY}
             - x-monium-project ${MONIUM_PROJECT}
     ```

  1. Run Fluent Bit:

     ```bash
     fluent-bit -c fluent-bit.yaml
     ```

     Fluent Bit will start receiving telemetry over OTLP at `127.0.0.1:4318` (HTTP).

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

  1. Run the application with the Java agent. The telemetry will go to Fluent Bit port 4318. Do not specify `OTEL_EXPORTER_OTLP_METRICS_TEMPORALITY_PREFERENCE="delta"`: when transferred via Fluent Bit, delta metrics cannot be processed correctly.

     ```bash
     OTEL_SERVICE_NAME=spring-petclinic \
     OTEL_EXPORTER_OTLP_METRICS_TEMPORALITY_PREFERENCE="cumulative" \
     java -javaagent:./opentelemetry-javaagent.jar -jar target/*.jar
     ```

  1. Open Spring PetClinic at `http://localhost:8080` and simulate user actions.

{% endlist %}
