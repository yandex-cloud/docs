# Specifics of API implementation in {{ ai-studio-full-name }}

{{ ai-studio-full-name }} offers a broad choice of APIs you can use to build various applications and address your business needs with the help of AI models. The APIs fall into two groups:
* {{ openai }}-compatible APIs providing a unified interface for models, text and voice agents, files, and search. 
* Specialized APIs developed by {{ yandex-cloud }} for text and image generation, [classification](classifier/index.md), [model fine-tuning](./tuning/index.md), and [batch processing](./generation/batch-processing.md).

## {{ openai }}-compatible APIs {#openai}

Choose the {{ openai }}-compatible APIs to create agents, implement RAG scenarios, and for simple model prompting.

| API | Technology | Description |
|---|---|---|
| [Models API](../models/index.md) | REST | Getting a list of available models and their IDs |
| [Chat Completions API](../chat/index.md) | REST | Prompt-based text generation without dialog management |
| [Conversations API](../conversations/index.md) | REST | Working with dialog history and context |
| [Responses API](../responses/index.md) | REST | Creating agents. Allows you to generate text, call tools, get structured responses, implement RAG scenarios, and create multi-agent systems |
| Realtime API | WebSocket | Low-latency streaming generation of text and audio for voice-input scenarios |
| [Files API](../files/index.md) | REST | File upload, storage and management for RAG scenarios |
| [Embeddings API](../embeddings/index.md) | REST | Obtaining embeddings for semantic tasks |
| Vector Store API | REST | Data indexing and extraction for RAG |

## Specialized {{ yandex-cloud }} APIs {#yc}

Use specialized {{ ai-studio-name }} APIs for the {{ gpt-lite }}, {{ gpt-pro }}, and {{ yandexart-name }} models, batch processing, text classification, model fine-tuning, and MCP server management.

{{ yandex-cloud }} APIs are designed based on gRPC. The API methods and data structures are described using Protocol Buffers (proto 3).

Unlike the APIs of most {{ yandex-cloud }} services, model APIs do not support the resource-based approach because they do not operate resources. Queries to {{ ai-studio-name }} models are not idempotent.

| API | Technology | Description |
|---|---|---|
| Text Generation API     | [gRPC](../text-generation/api-ref/grpc/index.md)</br>[REST](../text-generation/api-ref/index.md) | Prompt-based text generation, function invocation, structured response |
| Image Generation API    | [gRPC](../image-generation/api-ref/grpc/index.md)</br>[REST](../image-generation/api-ref/index.md) | Image generation based on text description |
| Batch Inference API     | [gRPC](../batch-inference/api-ref/grpc/index.md) | Asynchronous processing of large request batches |
| Text Classification API | [gRPC](../text-classification/api-ref/grpc/index.md)</br>[REST](../text-classification/api-ref/index.md) | Classification, moderation, and topic spotting |
| Embeddings API          | [gRPC](../embeddings/api-ref/grpc/index.md)</br>[REST](../embeddings/api-ref/index.md) |  Text vectorization |
| Files API   | [gRPC](../files/api-ref/grpc/index.md)</br>[REST](../files/api-ref/index.md) | Loading and storing files and data |
| Dataset API | [gRPC](../dataset/api-ref/grpc/index.md) | Training dataset management |
| Tuning API  | [gRPC](../mcp-gateway/api-ref/grpc/index.md) | Domain-based model fine-tuning  |
| MCP Gateway API | [gRPC](../mcp-gateway/api-ref/grpc/index.md)</br>[REST](../mcp-gateway/api-ref/index.md) | Creating, listing, and deleting MCP servers |


#### See also {#see-also}

* [gRPC documentation](https://grpc.io/docs/)
* [Protocol Buffers documentation](https://developers.google.com/protocol-buffers/docs/proto3)
* [{{ yandex-cloud }} API concepts](../../api-design-guide/concepts/general.md#resource-oriented-design)
