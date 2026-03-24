---
title: Viewing and analyzing LLM traces
description: 'Description of the special-purpose interface for LLM monitoring: search results, view page structure, conversation feed, available tools, switching to full trace, and logging.'
---

# Viewing and analyzing LLM traces

In the {{ traces-name }} interface, traces containing spans with GenAI attributes are displayed in the special LLM monitoring mode. This interface is there to analyze and debug AI agents: it focuses on large texts (prompts, model responses, system instructions), not raw attributes. This makes diagnostics simpler: the key information that affects the agent’s logic is brought to the foreground.

**Main features:**
* Span search and filtering based on GenAI attributes and other parameters.
* Visualization of call hierarchy within a trace (span tree).
* Detailed view of prompts and LLM responses in a structured representation.

You can open a trace from [search results](../operations/traces-explorer.md) or by its known `trace_id`. If a trace contains spans with GenAI attributes, the interface will automatically switch to the LLM view mode.

## LLM span search results {#search-results}

In span search mode, the results present only LLM-related spans, which is figured by the presence of the `gen_ai.response.model` attribute. The search results show the following for each such span:

* **Agent and span name**: Forms as `service.name` / span name, e.g., `my-ai-agent/openai.chat`.
* **Model input**: Input data provided to the LLM within the current span.
* **Model output**: LLM-generated response.
* **Tokens**: Number of input and output tokens.
* **Duration**: Duration of the operation.

You can use this data for a quick look at the contents and performance of the call to select a span for detailed view.

## Structure of the LLM trace view page {#page-layout}

The view page displays only spans of the services that have attributes with the `gen_ai.*` mask. Spans of other services (backends, databases, etc.) will be hidden on this page: this focuses the interface on the conversation with the model. To see the full trace with all spans, click **Show full trace** at the top of the page. This will open the [standard trace view](../operations/trace-view.md).

The interface has two areas:

1. **Span tree**: Hierarchical view of all LLM spans in the trace. It allows you to see the prompt structure and duration of each operation.
1. **Span feed**: Each span is represented by an expanded section with key information in the header (execution time, number of tokens, model) and grouped content below.

Spans without attributes containing the conversation texts (e.g., if message content capture is disabled) are collapsed by default. You can see all the span attributes in their original form on the **Details** tab.

## Prompt and response feed {#messages}

In the span feed, each generation span contains grouped sections:

* **System instructions**: Prompt that shapes the agent's behavior, e.g., "You are a helpful assistant. Answer briefly."
* **Conversation**: Message history between the user and the agent, which includes the input messages (user prompts, tool call results) and the model's response. 
* **Available tools**: See [below](#tools).

Messages under **Conversation** are shown in chronological order. The role (user, assistant, system, tool) and message part type (text, tool_call, tool_call_response) are shown explicitly so you could quickly trace the chain: user request → model's response with a tool call → tool output → next request to the model → final response.

If no message texts were provided during instrumentation (e.g., the `OTEL_INSTRUMENTATION_GENAI_CAPTURE_MESSAGE_CONTENT` variable is disabled), the feed will show the structure and roles, but not the contents.

## Available tools {#tools}

Each generation span contains an **Available tools** section, which is a list of functions or APIs the agent can call within this span, e.g., `get_weather`, `search_menu`, `place_order`. The data is taken from the `gen_ai.tool.definitions` attribute and usually contains the names and descriptions of tools in JSON Schema format.

From this section, you can see which tools the agent was viewing at the time of the call. If the model has called one of the tools, the relevant child span with the `execute_tool` operation type is displayed below the generation span. It displays the call arguments and the output (the `gen_ai.tool.call.arguments` and `gen_ai.tool.call.result` attributes). For more on what attributes you need to display tools, see [Tool call spans](manual_instrumentation.md#tool-spans).

## Span measures {#metrics}

Next to the conversation feed and tool section, there are the key span measures:

* **Model**: `gen_ai.request.model` or `gen_ai.response.model` value.
* **Tokens**: Number of input and output tokens (`gen_ai.usage.input_tokens`, `gen_ai.usage.output_tokens`).
* **Duration**: Operation (span) duration.

You can use these to quickly estimate the cost and latency of the span, compare different steps within a single trace or different traces between themselves.

## Filtering and search {#filtering}

In [trace and span search](../operations/traces-explorer.md), you can use GenAI attributes just like any others attributes: by model, span duration, or error. Examples of requests for LLM scenarios:

* By model name: `gen_ai.request.model="gpt-4o-mini"`
* By span duration: `span.duration>=5s`
* By status: `span.status=ERROR`

For syntax and the full list of supported keys, see [{#T}](../operations/query-language.md).
