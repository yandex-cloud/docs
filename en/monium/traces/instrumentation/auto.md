# Auto-instrumentation

With automatic instrumentation, OpenTelemetry libraries and agents intercept calls to standard frameworks and protocols and automatically generate spans. You get a trace without writing additional code: you just need to connect the agent or library and specify the export parameters.

## How it works {#how-it-works}

Automatic instrumentation is embedded between your application and the libraries in use. Depending on the language, this works in different ways:

* **Java**: The Java agent modifies bytecode as classes are loaded.
* **Python, Node.js**: These tools replace calls to standard modules with wrappers that create spans.

In all cases, every intercepted call automatically creates a span with attributes under the [OpenTelemetry semantic conventions](https://opentelemetry.io/docs/specs/semconv/): HTTP method, URL, response status, database table name, and so on.

## What is covered automatically {#coverage}

Automatic instrumentation creates spans for typical operations:

* HTTP servers and clients: Flask, Django, Express, Spring, `requests`, `net/http`, etc.
* Database clients: PostgreSQL, MySQL, Redis, and MongoDB.
* Message queues: Kafka and RabbitMQ.

For a complete list of supported libraries for each language, see the [OpenTelemetry instrumentation registry](https://opentelemetry.io/ecosystem/registry/?language=python&component=instrumentation).

## Common connection settings {#common-config}

Regardless of the language, to send traces to {{ traces-name }}, specify the connection settings using environment variables:

```bash
export OTEL_EXPORTER_OTLP_PROTOCOL="grpc"
```

```bash
export OTEL_SERVICE_NAME=<application_name>
```

```bash
export OTEL_EXPORTER_OTLP_ENDPOINT="{{ api-host-monium }}:443"
```

```bash
export OTEL_EXPORTER_OTLP_HEADERS="Authorization=Api-Key <API_key>,x-monium-project=folder__<folder_ID>"
```

```bash
export OTEL_RESOURCE_ATTRIBUTES="cluster=<environment>"
```

Where:

* `OTEL_SERVICE_NAME`: Your application's name. It is used as the `service.name` value in the resource attributes.
* `OTEL_EXPORTER_OTLP_ENDPOINT`: {{ monium-name }} endpoint.
* `OTEL_EXPORTER_OTLP_HEADERS`: Authorization headers and project bindings. To get an API key, [create a service account](../../../iam/operations/sa/create.md) with the `monium.traces.writer` role and [API key](../../../iam/operations/authentication/manage-api-keys.md) with the `yc.monium.traces.write` scope.
* `OTEL_RESOURCE_ATTRIBUTES`: Resource attributes. `cluster` sets the environment. The default value is `default`.

## Connection by languages {#languages}

### Python {#python}

1. Install the OpenTelemetry distribution and exporter:

   ```bash
   pip install opentelemetry-distro opentelemetry-exporter-otlp
   ```

1. Install instrumentation for the libraries your application uses:

   ```bash
   opentelemetry-bootstrap -a install
   ```

   The command will automatically detect any installed libraries, such as Flask, Django, requests, psycopg2, etc., and install the matching instrumentation packages.

1. Run the application using the `opentelemetry-instrument` wrapper:

   ```bash
   opentelemetry-instrument python my_app.py
   ```

### Java {#java}

1. Download the [OpenTelemetry Java agent](https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases):

   ```bash
   curl -L -o opentelemetry-javaagent.jar \
     https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/latest/download/opentelemetry-javaagent.jar
   ```

1. Run the application with the agent:

   ```bash
   java -javaagent:opentelemetry-javaagent.jar -jar my_app.jar
   ```

   The agent automatically instruments Spring, Servlet, JAX-RS, JDBC, Kafka, gRPC, and other libraries.

### Node.js {#nodejs}

1. Install the automatic instrumentation package:

   ```bash
   npm install @opentelemetry/auto-instrumentations-node
   ```

1. Run the application with automatic registration:

   ```bash
   node --require @opentelemetry/auto-instrumentations-node/register app.js
   ```

## Limitations {#limitations}

Automatic instrumentation covers only those operations for which ready-to-use libraries exist. It does not create spans for:

* Internal application business logic.
* Custom components and protocols.
* Operations where you need to add specific attributes.

To trace such operations, use [manual instrumentation](manual.md).
