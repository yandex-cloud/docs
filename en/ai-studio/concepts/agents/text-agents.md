---
title: Text-based agents in {{ ai-studio-name }}
description: Text-based agents in {{ ai-studio-full-name }} enable you to create intelligent text interfaces with support for tools, memory, and external integrations — from simple chatbots to complex agent systems and business applications.
---

# Text-based agents

_Text-based agents_ is a {{ ai-studio-full-name }} tool for building intelligent applications with context and external integrations. Such agents can interact with the user in text form via chat, forms, APIs, and other application interfaces.

With text-based agents, you can create simple chatbots, advanced intelligent support systems, search and analysis interfaces, and automate your business processes.

{{ ai-studio-name }} text-based agents have the following capabilities:

* Maintaining a dialog based on chat history and context.
* Response generation in prescribed format, data structuring.
* Automatic invocation of tools for information search or actions.
* Working with organization's documents and internal data.
* Web search.
* Use of external APIs via MCP servers.
* State and memory preservation between requests.

## Text-based agent tools {#tools}

Text-based agents can automatically invoke tools to enhance their capabilities.

### File Search Tool {#filesearch}

The [_File Search_](./tools/filesearch.md) tool implements RAG (Retrieval Augmented Generation) scenarios and allows the agent to search for information in uploaded documents and knowledge bases.

Use this tool to:

* Upload documents via the management console, Files API, or Vector Store API.
* Create a search index based on the uploaded data.
* Use the found fragments in the agent's responses.

Search indexes store the information in vector form for semantic search through the content of the documents.

### Web Search Tool {#websearch}

The [_Web Search_](./tools/websearch.md) tool allows the agent to get relevant information from the internet using the Yandex search base. This enriches the outputs with up-to-date data and facts pertaining to your request.

Use this tool to:

* Name up to 5 domains for your search or use global search.
* Limit the search region.
* Limit search results to manage the completeness and level of detail of the output and the spending of tokens.

### MCP Tool {#mcp-tool}

The _MCP Tool_ connects text-based agents to third-party APIs via MCP servers.

Use this tool to:

* Configure connections to external services and tools.
* Manage MCP server configurations.
* Monitor connection status.

## API for creating text-based agents {#api}

For [text-based agent development](../../operations/index.md#agents), {{ ai-studio-name }} uses [_{{ responses-api }}_](../api.md), an OpenAI-compatible API optimized for text-based scenarios. With {{ responses-api }}, you work with models, tools, and agent memory from the same interface.

Main {{ responses-api }} features:

* Generation of context-aware text responses.
* Automatic tool invocation.
* Support for RAG scenarios for local data and web search.
* Formatted and structured responses.
* Interfacing with any available {{ ai-studio-name }} model.

{{ responses-api }} is suitable for most text-based agent scenarios and is the recommended API for text-based agents.

## Methods of creating text-based agents {#create}

In {{ ai-studio-name }}, you can create text-based agents in several ways:

* In {{ agents-atelier-name }}, for experiments and prototyping.
* In {{ responses-api }}, for software integration into applications.
* In {{ sw-full-name }}, for building complex scripts in low-code format.
* Via open-source frameworks compatible with the OpenAI API, such as the OpenAI SDK, LangChain, or LangGraph.

## When to use text-based agents {#when-to-use}

Text-based agents will suit many scenarios where:

* Precise wording and logic make a good response.
* The task involves working with documents and knowledge bases.
* You are looking for structured data in the output.
* Text interfaces or APIs are used.
* No real-time audio processing is required.