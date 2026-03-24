# Manual instrumentation

With manual instrumentation, you have full control over which operations to trace, and which attributes and events to record. You can use it to create spans in code sections not covered by [auto-instrumentation](auto.md): business logic, custom handlers, internal calls. Manual instrumentation uses the [OpenTelemetry SDK](https://opentelemetry.io/docs/languages/).

In real-world scenarios, auto and manual instrumentation are complementary. Start with auto-instrumentation to cover your typical protocols. Then proceed to add manual spans in places that lack context for diagnostics.

The examples in this section are in Python. For other languages, the API is similar. For details, see [this OpenTelemetry SDK guide](https://opentelemetry.io/docs/languages/).

## Initializing a tracer {#init}

A _tracer_ is the object used to create spans. Get it once per module and use it across all functions.

```python
from opentelemetry import trace

tracer = trace.get_tracer("my_service.orders")
```

The `get_tracer` argument is the module or component name. For naming, you can use `__name__` (to easily identify the code file) or a fixed string, e.g., `my_service.orders`, for the component name not to change when refactoring or moving files.

If your application uses [auto-instrumentation](auto.md), `TracerProvider` is configured automatically. Otherwise, initialize the provider before calling `get_tracer`.

## Creating spans {#creating-spans}

The main method of creating a span is the `start_as_current_span` context manager. As the name suggests, it creates a span and sets it as _current_ in the context, the nested spans thus automatically becoming child spans. The span ends as it leaves the block.

```python
def handle_order(order_id):
    with tracer.start_as_current_span("handle_order") as span:
        span.set_attribute("order.id", order_id)
        result = process(order_id)
        return result
```

### Nested spans {#nested-spans}

Spans created within another span automatically become child spans, thus forming an operation tree in the trace:

```python
def handle_order(order_id):
    with tracer.start_as_current_span("handle_order"):

        with tracer.start_as_current_span("validate_payment"):
            validate(order_id)

        with tracer.start_as_current_span("update_inventory"):
            update(order_id)
```

In the {{ traces-name }} interface, this code will create three spans: `handle_order` and its two child spans, `validate_payment` and `update_inventory`.

### Naming spans {#naming}

Use short, stable, low cardinality names:

* `checkout.calculate_total` is good.
* `process_order_a3f82c1` is bad (contains a unique ID).

For network calls, follow the OpenTelemetry conventions: `GET /api/orders` for HTTP and `mypackage.MyService/GetOrder` for gRPC.

### Kinds of spans {#span-kind}

When creating a span, you can specify its kind. The kind determines the operation's role in distributed communication:

```python
from opentelemetry.trace import SpanKind

with tracer.start_as_current_span("GET /api/orders", kind=SpanKind.SERVER):
    ...
```

#|
|| Kind | Description ||
|| `SERVER` | Processing an incoming request from another service ||
|| `CLIENT` | Outgoing request to another service ||
|| `INTERNAL` | Internal operation not related to a remote call (default) ||
|| `PRODUCER` | Sending a message to a queue ||
|| `CONSUMER` | Receiving and processing a message from a queue (the span covers the whole cycle from receiving to end of processing) ||
|#

## Attributes {#attributes}

Attributes are key-value pairs that add context to a span. They are used for search and filtering in the {{ traces-name }} interface.

```python
with tracer.start_as_current_span("handle_order") as span:
    span.set_attribute("order.id", order_id)
    span.set_attribute("order.type", "online")
    span.set_attribute("order.items_count", len(items))
```

For common operations, use attributes from the [OpenTelemetry semantic conventions](https://opentelemetry.io/docs/specs/semconv/). Specific key names depend on your convention version and instrumentation settings: refer to the relevant specification for your operation type ([HTTP](https://opentelemetry.io/docs/specs/semconv/http/http-spans/), [DB](https://opentelemetry.io/docs/specs/semconv/database/), [Messaging](https://opentelemetry.io/docs/specs/semconv/messaging/)).

## Events {#events}

Events record the key points within the span. Each event includes a timestamp, a name, and optional attributes.

```python
with tracer.start_as_current_span("process_batch") as span:
    span.add_event("Batch processing started", {"batch.size": 100})
    process(batch)
    span.add_event("Batch processing completed")
```

Typical use cases include the start or end of a stage, cache miss, retry, validation result.

## Statuses and errors {#status}

Each span has a status. By default, a new span gets the `UNSET` status, which indicates a successful end of operation without errors. Use `OK` only if you want an explicit safeguard against status being overridden by auto-instrumentation or other code.

There are two ways to reflect errors in a trace.

**The exception is thrown outside.** By default, the `start_as_current_span` context manager intercepts any exception leaving the `with` block, records it as an event, sets the status to `ERROR`, and rethrows it. It is enough not to catch the exception inside the block:

```python
# The exception will leave the `with` block. OTel will record it to the span, set to ERROR, and rethrow it.
with tracer.start_as_current_span("charge_payment"):
    if order_id < 0:
        raise ValueError(f"Invalid order ID: {order_id}")
```

**The exception is caught and processed.** If you process an error inside the block, the exception does not leave the `with` block, and the context manager does not record it automatically. Call `record_exception` and `set_status` manually.

Important! `record_exception` and `set_status` are independent operations. `record_exception` creates an `exception`-type event with a message and stack trace but **does not** set the status to `ERROR`. Without an explicit `set_status` call, the span will not be marked as erroneous. According to the OTel specification, an exception should be recorded as an event only together with setting the `ERROR` status. This pattern reflects the actual error in the trace.

```python
from opentelemetry.trace import Status, StatusCode

with tracer.start_as_current_span("handle_order") as span:
    try:
        result = process(order_id)
        return result
    except Exception as e:
        # Event: type, message, stack trace
        span.record_exception(e)
         # Marks the span as erroneous
        span.set_status(Status(StatusCode.ERROR, str(e)))
```

The {{ traces-name }} interface highlights spans with the `ERROR` status.

## Context propagation {#context}

The trace context (`trace_id`, `span_id`) is propagated between services via request headers in [W3C Trace Context](https://www.w3.org/TR/trace-context/) format. This allows spans from different services to form a single trace.

Within a single process, the context is propagated automatically: each new span created via `start_as_current_span` inherits the current context and becomes a child span.

In cross-service interactions, you need to propagate the context explicitly. If you are using auto-instrumentation for HTTP or gRPC, this happens automatically. For other protocols, inject the context manually:

```python
from opentelemetry.propagate import inject, extract

headers = {}
inject(headers)
# headers now contains traceparent and tracestate,
# provide them together with the header

# On the receiving side:
ctx = extract(incoming_headers)
with tracer.start_as_current_span("process", context=ctx):
    ...
```

## Full example {#full-example}

A console app with manual instrumentation. The example demonstrates all the core methods: provider initialization, creating nested spans, attributes, events, and error processing.

```python
from opentelemetry import trace
from opentelemetry.trace import Status, StatusCode, SpanKind
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor
from opentelemetry.sdk.resources import Resource
from opentelemetry.exporter.otlp.proto.grpc.trace_exporter import OTLPSpanExporter

# Provider initialization.
# Connection parameters are taken from OTEL_* environment variables.
resource = Resource.create()
provider = TracerProvider(resource=resource)
provider.add_span_processor(BatchSpanProcessor(OTLPSpanExporter()))
trace.set_tracer_provider(provider)

tracer = trace.get_tracer("my_service.orders")


def validate_order(order_id: int) -> None:
    """
    The exception is thrown outside the `with` block.
    The context manager will intercept it, record it into the span, and set to ERROR automatically.
    """
    with tracer.start_as_current_span("validate_order") as span:
        span.set_attribute("order.id", order_id)

        if order_id <= 0:
            raise ValueError(f"Invalid order ID: {order_id}")

        span.add_event("Validation passed")


def charge_payment(order_id: int, amount: float) -> bool:
    """
    The exception is intercepted inside the `with` block.
    No automatic recording takes place. Let's call record_exception and set_status explicitly.
    """
    with tracer.start_as_current_span("charge_payment") as span:
        span.set_attribute("order.id", order_id)
        span.set_attribute("payment.amount", amount)

        try:
            if amount <= 0:
                raise ValueError(f"Invalid payment amount: {amount}")
            span.add_event("Payment charged")
            return True
        except Exception as e:
            # record_exception records the event with type, message, and stack trace.
            # set_status must be called separately; otherwise, the span will not be marked as erroneous.
            span.record_exception(e)
            span.set_status(Status(StatusCode.ERROR, str(e)))
            return False


def update_inventory(order_id: int) -> None:
    with tracer.start_as_current_span("update_inventory") as span:
        span.set_attribute("order.id", order_id)
        span.add_event("Inventory updated")


def process_order(order_id: int, amount: float) -> None:
    # SpanKind.SERVER is the entry point processing the incoming requests.
    # Child spans are created inside and inherit the context automatically.
    with tracer.start_as_current_span("process_order", kind=SpanKind.SERVER) as span:
        span.set_attribute("order.id", order_id)
        span.set_attribute("order.amount", amount)
        span.add_event("Order processing started")

        try:
            validate_order(order_id)
        except ValueError as e:
            span.set_status(Status(StatusCode.ERROR, str(e)))
            print(f"Order {order_id} failed: {e}")
            return

        if not charge_payment(order_id, amount):
            span.set_status(Status(StatusCode.ERROR, "Payment failed"))
            print(f"Order {order_id} failed: payment rejected")
            return

        update_inventory(order_id)
        span.add_event("Order processing completed")
        print(f"Order {order_id} processed successfully")

if __name__ == "__main__":
    process_order(1, 50.0)   # success scenario
    process_order(-1, 50.0)  # validation error
    process_order(2, -1.0)   # payment error

    # Waiting for all buffered spans to be sent before the process ends
    provider.shutdown()
```

To run, install the dependencies and set the environment variables from the [Connection setup](../index.md#connection-setup) section:

```bash
pip install opentelemetry-api opentelemetry-sdk opentelemetry-exporter-otlp
```

```bash
export OTEL_EXPORTER_OTLP_PROTOCOL="grpc"
```

```bash
export OTEL_SERVICE_NAME=my-service
```

```bash
export OTEL_EXPORTER_OTLP_ENDPOINT="{{ api-host-monium }}:443"
```

```bash
export OTEL_EXPORTER_OTLP_HEADERS="Authorization=Api-Key <API_key>,x-monium-project=folder__<folder_ID>"
```

```bash
python app.py
```
