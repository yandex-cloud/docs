# Basic terms

This section explains the key concepts you need to use {{ traces-name }}: data model, instrumentation strategies, and sampling.

## Data model {#data-model}

### Trace {#trace}

A _trace_ is a combination of related spans forming the execution path of a particular request in the system. A trace shows you the following:

* Sequence of operations and order of their execution.
* Time spent on each step.
* Interaction between services and components.
* Error and delay points.

### Span {#span}

A _span_ is a basic distributed tracing element representing a single operation in your system, e.g., HTTP request, database call, or function execution.

Each span contains:

* **Name**: Brief description of the operation. Use low-cardinality names without including unique IDs. For example, `GET /api/orders` is a good name, `GET /api/orders/a3f82c1` is not.

* **Status**: Result of the operation. OpenTelemetry defines three possible values:

  * `UNSET`: Status not explicitly set.
  * `OK`: Operation completed successfully.
  * `ERROR`: Operation threw an error.

* **Timestamps**: Operation start and end times. Unlike logs, spans have a duration: a span describes a process, whereas a log an instantaneous event.

* **Attributes**: Key-value pairs containing the operation metadata. Attributes add context for analysis and are used for search (e.g., `http.status_code`, `db.system`, `order_id`).

* **Span events**: Structured records within a span capturing the key points of the operation. Each event contains a timestamp, a name, and attributes. Typical use: records of error details (`exception.message`, `exception.stacktrace`).

  {% note warning %}

  Events are not indexed and not available for search. If you need to search through this data, send it to [logs](operations/traces-logs.md).

  {% endnote %}

* **Span links**: Links between spans, including spans from different traces. Links are used to represent asynchronous interactions and batch operations. For example, when a consumer processes a batch of queued messages each one of which was sent by a separate producer.

### Data organization {#data-organization}

{{ traces-name }} organizes tracing data into three levels aligned with the {{ monium-name }} project model.

#|
|| Entity | Description | Example ||
|| **Project** | Logical grouping of services, quotas, and access permissions. | {{ yandex-cloud }} folder ||
|| **Cluster** | Environment the application runs in. | `production`, `staging`, `testing` ||
|| **Service** | Specific application or component sending traces. | `api-gateway`, `billing-service`, `postgres` ||
|#

The project, cluster, and service values are set when [configuring data export](../collector/index.md).

## Instrumentation {#instrumentation}

Instrumentation is a process of upgrading the application code with mechanisms used to create and send spans. Without instrumentation, the system remains a "black box", where you see the inputs and outputs but cannot follow what is going on inside.

{{ monium-name }} receives data via the OpenTelemetry protocol. To send telemetry, use the OpenTelemetry SDK or compatible libraries. {{ traces-name }} will contribute processing, storage, and visualization.

There are two approaches to instrumentation: auto and manual. They address different needs and are complementary in real-world scenarios.

### Auto-instrumentation {#auto-instrumentation}

Auto-instrumentation creates spans without changing the business logic of the the application. OpenTelemetry libraries and agents intercept calls of standard frameworks and protocols (HTTP, gRPC, database clients) and generate spans with required attributes all by themselves.

Features:

* Easy to implement: simply hook up an agent or library.
* Automatic tracking of HTTP requests, database calls, gRPC, and external APIs.
* Limited flexibility: only for supported libraries and frameworks can be traced.

### Manual instrumentation {#manual-instrumentation}

With manual instrumentation, the developer creates spans directly in the application code via the OpenTelemetry SDK. This approach allows tracing operations not covered by auto-instrumentation: internal business logic, custom handlers, use of non-standard components.

Features:

* Full control over spans, attributes, and events.
* Tracing of business logic and nuanced operations.
* Adding custom metadata for debugging.
* Longer to implement.

### A combination of approaches {#combining}

In real-world scenarios, auto and manual instrumentation are complementary:

1. Start with auto-instrumentation to cover your typical protocols (HTTP, gRPC) and standard components (databases, caches, message queues).
1. Review the resulting traces. This will often be enough for diagnostics.
1. Apply manual instrumentation where context is lacking: critical business logic areas, internal calls, error handling.

## Sampling {#sampling}

If you choose to trace all requests, data can quickly pile up. You normally do not need full tracing for successful requests, which make up the majority. With sampling, you can limit the volume of data you send to reduce your storage and processing costs.

### Head sampling {#head-sampling}

{{ traces-name }} supports client-side sampling, also known as head sampling. The decision on whether to save a trace is made when creating the root span and propagated to all the child spans through the context. This ensures the completeness of the sampled trace, without any missed spans.

The main limitation of head sampling is that the decision cannot be made based on the data of the whole trace. For example, it cannot guarantee that all traces with errors will be saved.

The OpenTelemetry SDK has several built-in samplers to help you configure head sampling – from full save of all traces to percentage-based selection. For more information, see [this OpenTelemetry guide](https://opentelemetry.io/docs/concepts/sampling/).

{% note warning %}

Tail sampling is currently not supported.

{% endnote %}
