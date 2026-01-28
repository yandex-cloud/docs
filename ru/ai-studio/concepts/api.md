# Особенности реализации API в сервисе {{ ai-studio-full-name }}

{{ ai-studio-full-name }} предоставляет большой выбор API для создания различных приложений и решения бизнес-задач с помощью моделей искусственного интеллекта. Все API можно разделить на две группы:
* {{ openai }}-совместимые API, которые обеспечивают единый интерфейс для работы с моделями, текстовыми и голосовыми агентами, файлами и поиском. 
* Специализированные API, разработанные в {{ yandex-cloud }} для генерации текста и изображений, [классификации](classifier/index.md), [дообучения моделей](./tuning/index.md) и [пакетной обработки](./generation/batch-processing.md).

## {{ openai }}-совместимые API {#openai}

Выбирайте {{ openai }}-совместимые API для создания агентов, реализации RAG-сценариев и простых запросов к моделям.

| API | Технология | Описание |
|---|---|---|
| [Models API](../models/index.md) | REST | Получение списка доступных моделей и их идентификаторов |
| [Chat Completions API](../chat/index.md) | REST | Генерация текста по промпту без управления диалогом |
| [Conversations API](../conversations/index.md) | REST | Работа с историей диалога и контекстом |
| [Responses API](../responses/index.md) | REST | Создание агентов. Позволяет генерировать текст, вызывать инструменты, получать структурированные ответы, реализовывать RAG-сценарии и создавать мультиагентные системы |
| [Realtime API](./agents/realtime.md) | WebSocket | Потоковая генерация текста и аудио с низкой задержкой для сценариев с голосовым входом |
| [Files API](../files/index.md) | REST | Загрузка, хранение и работа с файлами для RAG-сценариев |
| [Embeddings API](../embeddings/index.md) | REST | Получение эмбеддингов для семантических задач |
| [Vector Store API](../vectorStores/index.md) | REST | Индексация данных и извлечение данных для RAG |

## Специализированные API {{ yandex-cloud }} {#yc}

Используйте специализированные API {{ ai-studio-name }} для работы с моделями {{ gpt-lite }}, {{ gpt-pro }}, {{ yandexart-name }}, пакетной обработки, классификации текстов, дообучения моделей и управления MCP-серверами.

API {{ yandex-cloud }} спроектированы на основе [механизма gRPC](../../glossary/grpc.md). Для описания методов и структур данных в API используется Protocol Buffers (proto 3).

В отличие от большинства API сервисов {{ yandex-cloud }}, API для работы с моделями не поддерживают ресурсо-ориентированный подход, так как не оперирует ресурсами. Запросы к моделям {{ ai-studio-name }} не идемпотентны.

| API | Технология | Описание |
|---|---|---|
| Text Generation API     | [gRPC](../text-generation/api-ref/grpc/index.md)</br>[REST](../text-generation/api-ref/index.md) | Генерация текстов про промту, вызов функций, поддержка структурированного ответа |
| Image Generation API    | [gRPC](../image-generation/api-ref/grpc/index.md)</br>[REST](../image-generation/api-ref/index.md) | Генерация изображений по текстовому описанию |
| Batch Inference API     | [gRPC](../batch-inference/api-ref/grpc/index.md) | Асинхронная обработка большого количества запросов |
| Text Classification API | [gRPC](../text-classification/api-ref/grpc/index.md)</br>[REST](../text-classification/api-ref/index.md) | Классификация, модерация, определение тематик |
| Embeddings API          | [gRPC](../embeddings/api-ref/grpc/index.md)</br>[REST](../embeddings/api-ref/index.md) |  Векторное представление текста |
| Files API   | [gRPC](../files/api-ref/grpc/index.md)</br>[REST](../files/api-ref/index.md) | Загрузка и хранение файлов и данных |
| Dataset API | [gRPC](../dataset/api-ref/grpc/index.md) | Управление датасетами для обучения |
| Tuning API  | [gRPC](../tuning/api-ref/grpc/index.md) | Дообучение моделей под предметную область  |
| MCP Gateway API | [gRPC](../mcp-gateway/api-ref/grpc/index.md)</br>[REST](../mcp-gateway/api-ref/index.md) | Создание, получение списка и удаление MCP-серверов |


#### Читайте также {#see-also}

* [Документация gRPC](https://grpc.io/docs/)
* [Документация Protocol Buffers](https://developers.google.com/protocol-buffers/docs/proto3)
* [Концепции API {{ yandex-cloud }}](../../api-design-guide/concepts/general.md#resource-oriented-design)
