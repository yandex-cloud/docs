---
title: Auto-instrumentation of LLM applications
description: Guide on auto-instrumentation of LLM applications to send traces to {{ traces-name }}.
---

# Auto-instrumentation of LLM applications

Auto-instrumentation is the fastest way to start sending LLM traces to {{ traces-name }}. Auto-instrumentation libraries intercept calls to LLM providers and frameworks at the SDK level and automatically generate spans with the GenAI attributes: prompts, model responses, token count, model used. There is almost no need to modify the application code: just install the library and call a single function.

## Supported frameworks

Auto-instrumentation libraries are available for all widely used agent SDKs. Install the package for your SDK, and all LLM calls will be automatically traced.

#|
|| **Framework** | **pip package** | [OpenTelemetry guide](https://open-policy-agent.github.io/gatekeeper/website/docs/) ||
|| OpenAI SDK | [`opentelemetry-instrumentation-openai-v2`](https://pypi.org/project/opentelemetry-instrumentation-openai-v2/) | https://github.com/open-telemetry/opentelemetry-python-contrib/tree/main/instrumentation-genai/opentelemetry-instrumentation-openai-v2 ||
|| OpenAI Agents SDK | [`opentelemetry-instrumentation-openai-agents`](https://pypi.org/project/opentelemetry-instrumentation-openai-agents/) | https://github.com/open-telemetry/opentelemetry-python-contrib/blob/main/instrumentation-genai/opentelemetry-instrumentation-openai-agents-v2/README.rst ||
|| LangChain | [`opentelemetry-instrumentation-langchain`](https://pypi.org/project/opentelemetry-instrumentation-langchain/) | LangSmith: Trace with OpenTelemetry: https://docs.langchain.com/langsmith/trace-with-opentelemetry ||
|#


## Full example

Below is a standalone example of a basic AI agent based on the OpenAI SDK (chat with tool calls) instrumented to automatically generate and send spans to {{ traces-name }}.

### 1. Install the dependencies

```bash
pip install openai \
    opentelemetry-sdk \
    opentelemetry-exporter-otlp-proto-grpc \
    opentelemetry-instrumentation-openai
```

### 2. Configure the environment variables

Set the required variables for connection to {{ traces-name }}:

```bash
export OTEL_EXPORTER_OTLP_HEADERS="Authorization=Api-Key <your_API_key>,x-monium-project=<project_name>,x-monium-service=my-ai-agent"
```
```bash
export OTEL_SERVICE_NAME="my-ai-agent"
```
```bash
export OTEL_EXPORTER_OTLP_ENDPOINT="{{ api-host-monium }}:443"
```
```bash
export OPENAI_API_KEY="<your_OpenAI_key>"
```

Where:
- `<your_API_key>`: API key of the service account with the `monium.traces.writer` role.
- `<project_name>`: Project name in `folder__<folder_ID>` format, e.g., `folder__b1g2e3abc4def5ghij6k`.

For more information on special {{ monium-name }} headers, see [{#T}](../../collector/otlp-protocol.md#headers).

Additionally, set a variable to capture the content of prompts and model responses:

```bash
export OTEL_INSTRUMENTATION_GENAI_CAPTURE_MESSAGE_CONTENT=true
```

Without this variable, traces will feature the model, token count, and call duration but not the texts of prompts and responses.


### 3. Create a file with the agent code

Save the code below to the `agent.py` file. This example uses `SimpleSpanProcessor`, which sends each span immediately after completion. Therefore, by the time of exiting the script, all traces are already gone to {{ traces-name }}.

```python
import json
import os
from openai import OpenAI

from opentelemetry import trace
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import SimpleSpanProcessor
from opentelemetry.exporter.otlp.proto.grpc.trace_exporter import OTLPSpanExporter
from opentelemetry.sdk.resources import Resource

from opentelemetry.instrumentation.openai import OpenAIInstrumentor

resource = Resource(attributes={"service.name": os.getenv("OTEL_SERVICE_NAME", "my-ai-agent")})
exporter = OTLPSpanExporter()
provider = TracerProvider(resource=resource)
provider.add_span_processor(SimpleSpanProcessor(exporter))
trace.set_tracer_provider(provider)
tracer = trace.get_tracer("my-ai-agent")

OpenAIInstrumentor().instrument()

TOOLS = [
    {
        "type": "function",
        "function": {
            "name": "get_weather",
            "description": "Returns current weather in the specified city.",
            "parameters": {"type": "object", "properties": {"city": {"type": "string"}}, "required": ["city"]},
        },
    }
]


def get_weather(city: str) -> str:
    """Returns current weather in the specified city."""
    return f"It is 18°C and cloudy in {city} right now."


def run_agent(user_query: str) -> str:
    client = OpenAI()
    messages = [
        {"role": "system", "content": "You are a helpful assistant. Answer briefly. Use the get_weather tool to retrieve weather information."},
        {"role": "user", "content": user_query},
    ]
    while True:
        response = client.chat.completions.create(
            model="gpt-4o-mini",
            messages=messages,
            tools=TOOLS,
        )
        msg = response.choices[0].message
        if not msg.tool_calls:
            return (msg.content or "").strip()
        messages.append({
            "role": "assistant",
            "content": msg.content or "",
            "tool_calls": [
                {"id": t.id, "type": "function", "function": {"name": t.function.name, "arguments": t.function.arguments}}
                for t in msg.tool_calls
            ],
        })
        for tc in msg.tool_calls:
            args = json.loads(tc.function.arguments) if isinstance(tc.function.arguments, str) else tc.function.arguments
            result = get_weather(args.get("city", ""))
            messages.append({"role": "tool", "tool_call_id": tc.id, "content": result})


if __name__ == "__main__":
    with tracer.start_as_current_span("agent.run"):
        answer = run_agent("What is the weather like in Moscow now?")
        print(answer)
    provider.shutdown()
```

### 4. Run the agent

```bash
python agent.py
```

Once the script is executed, the {{ traces-name }} interface will show a new trace with spans covering the agent's activity: model calls, optional tool calls and repeat requests, final response. For each generation span, the auto-instrumentation will extract the following:

- Prompts and model responses (if message content capture is enabled).
- Model used (`gen_ai.request.model`).
- Number of input and output tokens (`gen_ai.usage.input_tokens` and `gen_ai.usage.output_tokens`).
- Execution time of each step.

This data will be shown conveniently formatted in a dedicated LLM monitoring interface. For more information on how to use the interface, see [{#T}](./traces.md).

## Auto-instrumentation limitations

While auto-instrumentation makes it easy to get started quickly, it follows the "black box" principle by intercepting only standardized calls from supported libraries. In practical terms, however, this entails a number of limitations.

**Lack of business context.**: Auto-instrumentation is unaware of your subject domain. If you want to link a trace to a specific user, chat session ID, prompt version, or A/B experiment, you have to add these attributes manually.

**Invisible logic between calls.**: Everything that takes place between LLM calls (input preprocessing, response postprocessing, agent routing, database access) is left outside the auto-generated spans.

**Custom tools.**: Auto-instrumentation generates spans for LLM calls, but if your agent calls custom functions (access to an external API, knowledge base query, code execution), they will not be fully traced.

**Limited configurability.**: The attributes to collect and the span structure are decided by the auto-instrumentation library. You cannot rename spans, add random attributes, or modify the span hierarchy without manual intervention.

For complete control over traces – adding business attributes, using custom logic for the agent, or instrumenting an unsupported framework, etc. – use manual instrumentation.