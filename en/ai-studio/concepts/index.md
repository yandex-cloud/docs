---
title: About {{ ai-studio-full-name }}
description: '{{ ai-studio-full-name }} is a platform for building AI solutions. It offers everything you need to build an intelligent agent that will help your business address everyday tasks. {{ gpt-lite }} and {{ gpt-pro }} can generate product descriptions, articles, news stories, newsletters, blog posts, and much more. {{ yandexart-name }} can create an image from a description. The quality of the neural network''s response directly depends on the accuracy of the instructions you provide. With a more specific prompt, you are more likely to get the result you expect.'
---

# About {{ ai-studio-full-name }}

{{ ai-studio-full-name }} is a platform for building AI agents and leveraging large generative models effectively. 

[{{ model-gallery-name }}](./generation/index.md) offers a wide range of generative models for working with text and images. You can use them to: 
Generate product descriptions, articles, news stories, newsletters, blog posts, advertising images, logos, and much more. To access the models running in the _common instance_, use {{ ai-playground }} or integrate them into your apps with {{ ml-sdk-name }} and various APIs. If the model is missing from the common instance or is required for heavy workloads, you can deploy a _[dedicated instance](./generation/dedicated-instance.md)_ right in the management console. For large amounts of homogenous data, you might want to use [batch processing mode](./generation/dedicated-instance.md).

In addition to generative models, {{ model-gallery-name }} offers text [classifiers](./classifier/index.md) and [embedding models](./embeddings.md). If you are not satisfied with the response format of generative models or the behavior of classifiers and embeddings, you can [fine-tune](./tuning/index.md) them.

The [{{ agents-atelier-name }}](./agents/index.md) development environment supports building text and voice AI agents that can use ready-made customizable [tools](./agents/index.md#tools). If ready-to-use tools are not enough, you can always build a custom MCP server in {{ mcp-hub-name }} to enable the agent to use any external tools and APIs.

For those who prefer creating agents in a graphical editor, {{ ai-studio-name }} offers a {{ sw-full-name }} builder.

The {{ ai-studio-name }} API is fully compatible with the {{ openai }} API: use the Responses API to build text agents, the Realtime API to create voice agents, and the Vector Store API for search through documents. The APIs support integration with such widely used frameworks as LangChain and LangGraph.

For information on the {{ foundation-models-name }} restrictions, refer to [{#T}](limits.md).
