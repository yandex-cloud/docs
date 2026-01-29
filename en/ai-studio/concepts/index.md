---
title: About {{ ai-studio-full-name }}
description: '{{ ai-studio-full-name }} is a {{ yandex-cloud }} platform for building AI-based solutions. It has everything you need to build an intelligent agent to help your business deal with its day-to-day challenges: a broad choice of text models, built-in tools for web and file search, MCP servers, and a visual constructor. There are OpenAI-compatible APIs for developers.'
---

# About {{ ai-studio-full-name }}

{{ ai-studio-full-name }} is a {{ yandex-cloud }} platform for creating AI applications and AI agents based on large generative models. {{ ai-studio-name }} provides everything you need through all stages – from experiments and prototyping to production deployment.

## Models and basic features {#model-gallery}

[{{ model-gallery-name }}](./generation/index.md) offers a broad choice of models for text, voice, and image generation, [text classification](./classifier/index.md), and [embeddings](./embeddings.md). They will help you deal with the application tasks of creating and analyzing content, classifying data, building document search, or processing large arrays of uniform data.

### Using the models {#model-usage}

Select an interface and a model – {{ ai-studio-name }} has everything you need:

* [{{ ai-playground }}]({{ link-console-main }}/link/ml/ai-studio/playground): For experiments, model testing, and image generation.
* [{{ agents-atelier-name }}]({{ link-console-main }}link/ml/ai-studio/agents): For creating and managing agents via the management console.
* {{ openai }}-compatible APIs, {{ openai }} SDK, and {{ ml-sdk-full-name }}: For integrating models into applications.
* [Common instance models](./generation/models.md): For most business scenarios.
* [Dedicated instances](./generation/dedicated-instance.md): To deploy models not included in the common instance.
* [Batch processing](./generation/batch-processing.md): For asynchronous data processing.

## AI application development {#ai-apps}

The [{{ agents-atelier-name }}](./agents/index.md) development environment allows you to create text and voice AI agent-based solutions using out-of-the-box and customizable [tools](./agents/index.md#tools). If the out-of-the-box toolkit is not enough, you can always build an MCP server of your own in {{ mcp-hub-name }} for your agent to be able to use any external tools and APIs.

For visual design, {{ ai-studio-name }} provides the {{ sw-full-name }} low-code constructor.

## APIs and integrations {#api}

{{ ai-studio-name }} provides REST APIs compatible with {{ openai }}:
* {{ responses-api }}: For creating text agents. 
* {{ realtime-api }}: For voice agents.
* Files API and {{ vector-store-name }} API: For file uploading and file search. 

{{ openai }}-compatible APIs support integration with the popular LangChain and LangGraph frameworks.

In addition, {{ ai-studio-name }} offers gRPC and REST APIs for specific generation, analysis, and training tasks. 

For more on available APIs, see [{{ ai-studio-full-name }} API overview](./api.md).

## Limitations {#quotas}

For current {{ ai-studio-name }} technical and organizational limitations, see [{#T}](limits.md).
