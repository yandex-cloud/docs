# AI agents

AI agents represent a modern application building approach based around artificial intelligence and neural networks. Agents expand the capabilities of large language models and lay the groundwork for building chatbots, assistants, and voice interfaces, thus helping to automate various routine tasks.

Agents comprise four key components:

* _LLM_: Actual language model with fixed setting.
* _Prompt_: Describes the agent's behavior and role.
* _Tools_: Allow the agent to leverage external capabilities, such as APIs, functions, or internet search.
* _Memory_: Stores context and interaction history.

Such architecture enables the creation of text and voice agents that behave more naturally and autonomously than classic chatbots.

## Developing agents in {{ ai-studio-name }} {#agent-development}

{{ ai-studio-name }} has everything you need to create AI agents: models that support [function calling](../generation/function-call.md) and [response formatting](../generation/structured-output.md), ready-made customizable RAG and internet search [tools](#tools), as well as {{ mcp-hub-name }} that allows connecting external APIs via MCP servers.

{{ ai-studio-name }} allows you to create agents in various ways:

* In [{{ ai-playground }}]({{ link-console-main }}/link/foundation-models/playground).
* Using the {{ sw-full-name }} [specification constructor]({{ link-console-main }}/link/serverless-integrations/workflows/workflows).
* Using the {{ responses-api }} or {{ realtime-api }}.
* Via open source frameworks, for example, OpenAI SDK, LangGraph, or LangChain.

### Tools {#tools}

Agents can automatically invoke tools to get additional info for generation or perform the necessary actions. {{ ai-studio-name }} comes with these bundled tools:
* _{{ retrieval-tool-name }} Tool_ implements the RAG scenario and allows the AI agent to search through your files (knowledge base) for the information for its response. You can upload your knowledge base documents in the management console, via the {{ vector-store-name }} API, or via the [Files API](../assistant/files.md) and create a search index. [Search indexes](../search/vectorstore.md) store information from your documents in vector form and allow agents to use it to respond.
* _Web Search Tool_ allows the agent to search for information on the internet via the Yandex search base to enrich its responses with up-to-date relevant information. Learn more about using the [Web Search Tool](./tools/websearch.md).
* _MCP Tool_ is responsible for connections to MCP servers to engage third-party APIs.
  In the {{ mcp-hub-name }} section, you can create and set up connections to new and existing MCP servers and monitor their status.
 
### Agent creation API {#api}

{{ ai-studio-name }} provides two {{ openai }}-compatible APIs for development of different types of agents. Both APIs save data on client states between requests and basically perform the same functions of connecting models, tools, and memory, but are optimized for different types of interactions depending on the agent.
* The {{ responses-api }} is an API for text scenarios. Agents created using the {{ responses-api }} take note of the conversation context and can automatically invoke connected tools. The {{ responses-api }} supports [any models](../generation/models.md).
* The {{ realtime-api }} is an API for voice scenarios. This API is designed to work with specialized multimodal models accepting audio input and synthesizing an audio response. The {{ realtime-api }} supports all available tools, including {{ retrieval-tool-name }} and WebSearch.
 
### Workflow constructor {#workflows}

The workflow constructor allows you to build complex AI-based scenarios using out-of-the-box automation and management steps. The constructor will suit those of you who prefer visual editors and low-code platforms. 

You can learn more about workflows and automation steps in the [{{ sw-full-name }} guide](../../../serverless-integrations/concepts/workflows/workflow.md).
