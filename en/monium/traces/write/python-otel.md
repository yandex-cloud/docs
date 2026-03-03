# Connecting a Python app to {{ traces-name }} over OpenTelemetry

## Install OpenTelemetry {#install-opentelemetry}

```bash
pip install opentelemetry-api opentelemetry-sdk opentelemetry-exporter-otlp
pip install opentelemetry-instrumentation-flask  # For Flask auto-instrumentation
pip install python-dotenv  # For handling environment variables
```

## Configure the environment variables {#configure-environment-variables}

In your app's root folder, create a `.env` file and add the following environment variables:

```bash
# Basic OpenTelemetry settings
OTEL_SERVICE_NAME=my-service
OTEL_EXPORTER_OTLP_ENDPOINT=http://x-collector:4317
OTEL_EXPORTER_OTLP_INSECURE=true

# Sampling settings (optional)
OTEL_TRACES_SAMPLER=traceidratio
OTEL_TRACES_SAMPLER_ARG=1.0

# Custom headers for system X
X_MONIUM_PROJECT=my-project
X_MONIUM_CLUSTER=production-cluster
```

## Configuring the transfer of traces {#configure-tracing}

Create a `tracing.py` file to initialize OpenTelemetry:

```python
import os
from dotenv import load_dotenv
from opentelemetry import trace
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor
from opentelemetry.exporter.otlp.proto.grpc.trace_exporter import OTLPSpanExporter
from opentelemetry.sdk.resources import Resource

# Loading environment variables from the `.env` file
load_dotenv()

def init_tracing():
    # Reading the configuration from the environment variables
    service_name = os.getenv("OTEL_SERVICE_NAME", "unknown-service")
    otlp_endpoint = os.getenv("OTEL_EXPORTER_OTLP_ENDPOINT", "http://localhost:4317")
    insecure = os.getenv("OTEL_EXPORTER_OTLP_INSECURE", "false").lower() == "true"
    
    # Setting the service metadata resource
    resource = Resource(attributes={
        "service.name": service_name
    })
    
    # Creating a trace provider
    provider = TracerProvider(resource=resource)
    
    # Configuring an exporter to send spans to Unified Agent
    otlp_exporter = OTLPSpanExporter(
        endpoint=otlp_endpoint,
        insecure=insecure
    )
    
    # Adding a batch span processor for efficient span sending
    provider.add_span_processor(BatchSpanProcessor(otlp_exporter))
    
    # Registering the provider globally
    trace.set_tracer_provider(provider)
    
    return provider
```

## Enable auto-instrumentation {#auto-instrumentation}

Here is an example for a Flask app:

```python
from flask import Flask
from opentelemetry.instrumentation.flask import FlaskInstrumentor
from tracing import init_tracing

app = Flask(__name__)

# Initializing tracing
init_tracing()

# Flask auto-instrumentation
FlaskInstrumentor().instrument_app(app)

@app.route("/")
def hello():
    return "Hello World"

@app.route("/order/<int:order_id>")
def process_order(order_id):
    result = handle_order(order_id)
    return result

def handle_order(order_id):
    # Business logic for order processing
    return {"status": "processed", "order_id": order_id}

if __name__ == "__main__":
    app.run()
```

## Check data flow {#check-data-flow}

1. Start your app and send a few test requests:

    ```bash
    curl http://localhost:5000/
    curl http://localhost:5000/order/123
    ```

1. In your target system, make sure that:

   * Traces from your app are present.
   * Spans include HTTP request details.
   * Timings are visualized correctly.
   * Traces are associated with the project and cluster specified in the {{ unified-agent-short-name }} configuration.

## Add custom spans to track your business logic {#custom-spans}

Auto-instrumentation generates spans for HTTP requests but does not cover your app's internal business logic. With custom spans, you can monitor the execution time of critical operations (such as database interactions, external API calls, or complex computations) and add contextual information to aid troubleshooting.

`tracer.start_as_current_span()` is the primary method for creating spans, which creates a new span and automatically sets it as the current one in the execution context. For a complete list of SDK methods, refer to the relevant guides.

### Add custom spans {#add-custom-spans}

Let's enhance our [auto-instrumentation](#auto-instrumentation) example with custom spans:

```python
from flask import Flask
from opentelemetry import trace
from opentelemetry.instrumentation.flask import FlaskInstrumentor
from opentelemetry.trace import Status, StatusCode
from tracing import init_tracing

app = Flask(__name__)

# Initializing tracing
init_tracing()

# Flask auto-instrumentation
FlaskInstrumentor().instrument_app(app)

# Getting a tracer for the current module
tracer = trace.get_tracer(__name__)

@app.route("/")
def hello():
    return "Hello World"

@app.route("/order/<int:order_id>")
def process_order(order_id):
    result = handle_order(order_id)
    return result

def handle_order(order_id):
    # Creating a new span to track function execution
    # `start_as_current_span` automatically makes the span current in the context
    with tracer.start_as_current_span("handle_order") as span:
        # Adding attributes to the span for filtering and analysis
        span.set_attribute("order.id", order_id)
        span.set_attribute("order.type", "online")
        
        # Creating a nested span for a sub-operation
        # It automatically becomes a child of the current span
        with tracer.start_as_current_span("validate_payment"):
            payment_valid = validate_payment(order_id)
            # Attributes help clarify the outcome of your operation
            span.set_attribute("payment.valid", payment_valid)
            
            if not payment_valid:
                # Marking the span as failed
                span.set_status(Status(StatusCode.ERROR, "Payment validation failed"))
                return {"status": "error", "message": "Invalid payment"}
        
        with tracer.start_as_current_span("update_inventory"):
            # `add_event` records important events within the span
            span.add_event("Inventory update started")
            update_inventory(order_id)
            span.add_event("Inventory update completed")
        
        # Explicitly marking the span as successful
        span.set_status(Status(StatusCode.OK))
        return {"status": "processed", "order_id": order_id}

def validate_payment(order_id):
    # Simulating payment validation
    return True

def update_inventory(order_id):
    # Simulating inventory update
    pass

if __name__ == "__main__":
    app.run()
```

Here is an example of exception handling with spans:

```python
def fetch_user_data(user_id):
    with tracer.start_as_current_span("fetch_user_data") as span:
        span.set_attribute("user.id", user_id)
        
        try:
            # Calling an external API or database
            user_data = external_api_call(user_id)
            span.set_attribute("user.country", user_data.get("country"))
            span.set_status(Status(StatusCode.OK))
            return user_data
        except Exception as e:
            # `record_exception` automatically adds a stack trace
            span.record_exception(e)
            span.set_status(Status(StatusCode.ERROR, str(e)))
            raise
```

### Check custom span transmission {#check-custom-spans}

1. Restart your application and send requests to the `/order` endpoint:

    ```bash
    curl http://localhost:5000/order/123
    curl http://localhost:5000/order/456
    ```

1. In your target system, make sure that:
   * Custom spans (`handle_order`, `validate_payment`, and `update_inventory`) are displayed in the trace hierarchy.
   * Your spans are correctly nested (parent-child relationships).
   * Added attributes (`order.id`, `order.type`, `payment.valid`) are visible in span details.
   * Events (`Inventory update started`, `Inventory update completed`) are displayed on span timeline.
   * Execution time for each span is accurately measured and visualized.
   * Spans are marked with relevant statuses if there are errors.
  
    With this data, you can analyze the performance of individual operations and quickly identify code segments with problems.

## Configure sampling

Sampling allows you to control the volume of traces you collect. In high-load systems, collecting 100% of traces can create excessive load on your network, storage, and budget. Sampling solves this issue while still offering a representative view of system behavior.

How sampling works:
OpenTelemetry makes the collection decision the moment the root span is created based on trace ID. If a trace is selected for collection, all its child spans will also be collected, ensuring end-to-end integrity of distributed traces across multiple services.

### Configuring via environment variables {#configuration-via-environment-variables}

In your `.env` file, set the following variables:

```bash
# Ratio-based sampling
OTEL_TRACES_SAMPLER=traceidratio
OTEL_TRACES_SAMPLER_ARG=0.1  # 10% of traces

# For development, collect all traces
# OTEL_TRACES_SAMPLER=always_on

# To disable tracing
# OTEL_TRACES_SAMPLER=always_off
```

### Programmatic setup {#app-configuration}

```python
import os
from dotenv import load_dotenv
from opentelemetry.sdk.trace.sampling import TraceIdRatioBased, ParentBased

load_dotenv()

def init_tracing():
    service_name = os.getenv("OTEL_SERVICE_NAME", "unknown-service")
    otlp_endpoint = os.getenv("OTEL_EXPORTER_OTLP_ENDPOINT", "http://localhost:4317")
    insecure = os.getenv("OTEL_EXPORTER_OTLP_INSECURE", "false").lower() == "true"
    
    # Reading custom headers for system X
    monium_project = os.getenv("X_MONIUM_PROJECT", "default-project")
    monium_cluster = os.getenv("X_MONIUM_CLUSTER", "default-cluster")
    
    # Reading the sampling parameter
    sampling_ratio = float(os.getenv("OTEL_TRACES_SAMPLER_ARG", "1.0"))
    
    resource = Resource(attributes={"service.name": service_name})
    
    # ParentBased preserves the parent span sampling decision
    # This is critical for correct distributed tracing
    sampler = ParentBased(root=TraceIdRatioBased(sampling_ratio))
    
    provider = TracerProvider(
        resource=resource,
        sampler=sampler
    )
    
    # Creating headers for sending to system X
    headers = {
        "x-monium-project": monium_project,
        "x-monium-cluster": monium_cluster,
        "x-monium-service": service_name
    }
    
    otlp_exporter = OTLPSpanExporter(
        endpoint=otlp_endpoint,
        insecure=insecure,
        headers=headers
    )
    provider.add_span_processor(BatchSpanProcessor(otlp_exporter))
    trace.set_tracer_provider(provider)
    
    return provider
```

Your application will now automatically generate traces for HTTP requests and send custom spans, providing detailed information about internal operations, to your target system for further analysis and visualization.