In this example, you will run [Spring PetClinic](https://github.com/spring-projects/spring-petclinic) and set up sending telemetry data to {{ monium-name }}.
You will be able to collect logs, traces, and metrics for JVM (class loading, CPU utilization, garbage collection), database connection pools, and HTTP endpoints without modifying your application code.

{% list tabs group=instructions %}

- Your infrastructure {#user-infrastructure}

  1. Install [Git](https://git-scm.com/install/) and [Java](https://jdk.java.net/) suitable for your OS. Here is an example:

     ```bash
     sudo apt update
     sudo apt install -y git openjdk-25-jdk
     ```

  1. Set the environment variables for the {{ monium-name }} connection:

     ```bash
     export MONIUM_API_KEY=<API_key>
     export MONIUM_PROJECT=<project_ID>
     export MONIUM_CLUSTER=<cluster_name> # optional
     ```

  1. Clone and build Spring PetClinic:

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

  1. Configure telemetry export settings:

     ```bash
     export OTEL_EXPORTER_OTLP_PROTOCOL="grpc"
     export OTEL_EXPORTER_OTLP_ENDPOINT="https://{{ api-host-monium }}:443"
     export OTEL_EXPORTER_OTLP_HEADERS="x-monium-project=${MONIUM_PROJECT},x-monium-cluster=${MONIUM_CLUSTER},authorization=Api-Key ${MONIUM_API_KEY}"
     export OTEL_SERVICE_NAME=spring-petclinic
     ```

  1. Optionally, enable delta temporality for metrics:

     ```bash
     export OTEL_EXPORTER_OTLP_METRICS_TEMPORALITY_PREFERENCE="delta"
     ```

  1. Run the application with the Java agent:

     ```bash
     java -javaagent:./opentelemetry-javaagent.jar -jar target/*.jar
     ```

  1. Open Spring PetClinic at `http://localhost:8080` and simulate user actions. Metrics are created the first time the relevant functions are called.

{% endlist %}