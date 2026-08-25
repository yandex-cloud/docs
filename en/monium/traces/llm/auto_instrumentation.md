---
title: Auto-instrumentation of LLM applications
description: Guide on auto-instrumentation of LLM applications to send traces to {{ traces-name }}.
---

# Auto-instrumentation of LLM applications

Auto-instrumentation is the fastest way to start sending LLM traces to {{ traces-name }}. Auto-instrumentation libraries intercept calls to LLM providers and frameworks at the SDK level and automatically generate spans with the GenAI attributes: prompts, model responses, token count, model used. There is almost no need to modify the application code: just install the library and call a single function.

## Supported frameworks {#supported-frameworks}

There are auto-instrumentation libraries for popular agent SDKs. Install a package for your SDK to have all LLM calls automatically covered by traces:

* [OpenAI SDK](https://github.com/open-telemetry/opentelemetry-python-contrib/tree/main/instrumentation-genai/opentelemetry-instrumentation-openai-v2): [`opentelemetry-instrumentation-openai-v2`](https://pypi.org/project/opentelemetry-instrumentation-openai-v2/)
* [OpenAI Agents SDK](https://github.com/open-telemetry/opentelemetry-python-contrib/blob/main/instrumentation-genai/opentelemetry-instrumentation-openai-agents-v2/README.rst): [`opentelemetry-instrumentation-openai-agents`](https://pypi.org/project/opentelemetry-instrumentation-openai-agents/)
* [LangChain](https://docs.langchain.com/langsmith/trace-with-opentelemetry): [`opentelemetry-instrumentation-langchain`](https://pypi.org/project/opentelemetry-instrumentation-langchain/)


## Configuration example {#working-example}

Below is a standalone example of a basic AI agent based on the OpenAI SDK (chat with tool calls) instrumented to automatically generate and send spans to {{ traces-name }}.

The example is prepared in two versions:
* Using a generative model by OpenAI. Availability depends on your location.
* Using a generative model by [{{ ai-studio-full-name }}]({{ link-docs-ai }}), subject to the [pricing policy]({{ link-docs-ai }}ai-studio/pricing.md).

### Set up your environment {#prepare-env}

#### Set up your infrastructure {#setup-yc}

{% list tabs group=instructions %}

- OpenAI {#openai}

  1. [Create a service account](../../../iam/operations/sa/create.md) and assign the `monium.traces.writer` [role](*roles) to it.
  1. [Create an API key](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) with the `yc.monium.traces.write` [scope](*scope).

- {{ ai-studio-full-name }} {#ai-studio}

  1. [Create a service account](../../../iam/operations/sa/create.md) and assign the following [roles](*roles) to it:

      * `monium.traces.writer`
      * `ai.languageModels.user`
  1. [Create an API key](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) with the following [scopes](*scope):

      * `yc.monium.traces.write`
      * `yc.ai.languageModels.execute`

{% endlist %}

#### Install the dependencies {#install-dependencies}

```bash
pip install openai \
    opentelemetry-sdk \
    opentelemetry-exporter-otlp-proto-grpc \
    opentelemetry-instrumentation-openai
```

#### Configure the environment variables {#set-env-variables}

{% list tabs group=instructions %}

- OpenAI {#openai}

  {% include [batch-run](../../../_includes/monium/llm-instrumentation-example-vars.md) %}

  * Create a variable containing your OpenAI API key:

      ```bash
      export OPENAI_API_KEY="<your_OpenAI_key>"
      ```

- {{ ai-studio-full-name }} {#ai-studio}

  {% include [batch-run](../../../_includes/monium/llm-instrumentation-example-vars.md) %}

  * Create a variable containing the service account API key created earlier:

      ```bash
      export API_KEY="<your_API_key>"
      ```
  * Create a variable containing the [ID of the folder](../../../resource-manager/operations/folder/get-id.md) in which the agent will access the {{ ai-studio-full-name }} generative model:

      ```bash
      export YANDEX_FOLDER_ID="<folder_ID>"
      ```

{% endlist %}


### Create an agent file {#create-agent}

Save the code below to the `agent.py` file. This example uses `SimpleSpanProcessor`, which sends each span immediately after completion. Therefore, by the time of exiting the script, all traces are already gone to {{ traces-name }}.

{% list tabs group=instructions %}

- OpenAI {#openai}

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

- {{ ai-studio-full-name }} {#ai-studio}

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

  YANDEX_MODEL = "yandexgpt-lite"
  YANDEX_API_KEY = os.getenv("API_KEY")
  YANDEX_FOLDER_ID = os.getenv("YANDEX_FOLDER_ID")
  model=f"gpt://{YANDEX_FOLDER_ID}/{YANDEX_MODEL}"

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
      client = OpenAI(
          api_key=YANDEX_API_KEY,
          base_url="https://{{ api-host-llm }}/v1",
          project=YANDEX_FOLDER_ID
      )
      messages = [
          {"role": "system", "content": "You are a helpful assistant. Answer briefly. Use the get_weather tool to retrieve weather information."},
          {"role": "user", "content": user_query},
      ]
      while True:
          response = client.chat.completions.create(
              model=model,
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

{% endlist %}

### Run the agent {#run-agent}

```bash
python agent.py
```

Once the script is executed, the {{ traces-name }} interface will show a new trace with spans covering the agent's activity: model calls, optional tool calls and repeat requests, final response. For each generation span, the auto-instrumentation will extract the following:

- Prompts and model responses (if message content capture is enabled).
- Model used (`gen_ai.request.model`).
- Number of input and output tokens (`gen_ai.usage.input_tokens` and `gen_ai.usage.output_tokens`).
- Execution time of each step.

This data will be shown conveniently formatted in a dedicated LLM monitoring interface. For more information on how to use the interface, see [{#T}](./traces.md).

## Limitations {#limitations}

While auto-instrumentation makes it easy to get started quickly, it follows the "black box" principle by intercepting only standardized calls from supported libraries. In practical terms, however, this entails a number of limitations.

**Lack of business context.**: Auto-instrumentation is unaware of your subject domain. If you want to link a trace to a specific user, chat session ID, prompt version, or A/B experiment, you have to add these attributes manually.

**Invisible logic between calls.**: Everything that takes place between LLM calls (input preprocessing, response postprocessing, agent routing, database access) is left outside the auto-generated spans.

**Custom tools.**: Auto-instrumentation generates spans for LLM calls, but if your agent calls custom functions (access to an external API, knowledge base query, code execution), they will not be fully traced.

**Limited configurability.**: The attributes to collect and the span structure are decided by the auto-instrumentation library. You cannot rename spans, add random attributes, or modify the span hierarchy without manual intervention.

For complete control over traces – adding business attributes, using custom logic for the agent, or instrumenting an unsupported framework, etc. – use manual instrumentation.

[*roles]: A role is a set of permissions that defines the allowed scope of operations with {{ yandex-cloud }} resources. For more information, see [{#T}](../../../iam/concepts/access-control/roles.md).

[*scope]: A scope is the total of the actions a service account is allowed to perform with the service's resources. You cannot use an API key with specified scopes in other services or scopes. For more information, see [{#T}](../../../iam/concepts/authorization/api-key.md#scoped-api-keys).