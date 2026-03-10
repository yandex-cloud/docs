# LLM monitoring

The LLM agent trace view interface enables you to analyze and debug AI agents. It provides detailed insights into the order of operations, prompts, model responses, and performance metrics.

**Key features:**
- Search and filtering of spans by various parameters.
- Visualization of call hierarchy within a trace.
- Detailed view of prompts and LLM responses.

## Span search results

You can use the LLM monitoring search interface to find spans using [search by labels](#labels-search). The search results show:

- **Agent and span names**, e.g., `learn assistant/check homework`, in this format: `service.name/span name`.
- **Model input**: Input data provided to the LLM within the span.
- **Model output**: Response the LLM has generated within the span.
- **Tokens**: Number of input and output tokens.
- **Duration**: Span duration.

This information helps you quickly evaluate performance and content of LLM operations and select a span for in-depth analysis. Search results will include only those spans associated with the use of LLMs, which is indicated by the `gen_ai.response.model` attribute in the span.

## LLM trace view page

This interface displays a selected LLM agent trace. The displayed data mostly consists of large texts (prompts, model responses, etc.). This allows you to analyze agent traces faster, since texts are key information having direct impact on the operation logic.

The view page displays `service` spans for the given LLM agent. Such services are identified by having at least one attribute in spans with the `gen_ai.*` mask. Spans of other services, e.g., backends or databases, are hidden. To quickly switch to viewing the entire trace with all its spans, click **Go to traces** at the top of the page.

The interface has two areas:

1. **Span tree**
   
   This is a hierarchical view of all spans in the trace. It allows you to see the full prompt structure and timings for each operation.

1. **Span feed**

   This area displays all spans of the trace as a feed. Each span header displays key information: operation time, number of input and output tokens, and the used LLM. Each span contains grouped sections:
    
    — **System instructions**: Prompt that defines the agent's behavior, e.g., "You are an assistant helping with home assignments. Be polite and accurate in responses."
    
    — **Dialog**: Message history between the agent and user.
    
    — **Available tools**. List of API functions the agent can call, e.g., `search_error()`, `add_suggestion()`, or `give_grade()`.

   To see all attributes of a span in the initial view, go to the **Details** tab. From each span, you can navigate to its logs or open trace logs. Spans without attributes containing AI agent texts are hidden by default.