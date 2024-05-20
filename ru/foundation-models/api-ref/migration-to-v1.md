# Миграция с API v1alpha на YandexGPT API v1 и Embeddings API v1

[API версии v1alpha](../api-ref/v1alpha/) устарел и больше не поддерживается. Для работы с {{ yagpt-name }} используйте [YandexGPT API v1](../text-generation/api-ref/) и [Embeddings API v1](../embeddings/api-ref/). Максимальное суммарное количество [токенов](../concepts/yandexgpt/tokens.md), которое может содержаться в запросе пользователя и ответе модели в новой версии API, составляет {{ yagpt-max-tokens }}.

Если ваш продукт использует методы устаревшего API, переведите его на использование нового интерфейса. Подробный обзор необходимых изменений для REST API приведен ниже. Изменения для gRPC API аналогичны.

## Выбор модели {#model-choice}

В YandexGPT API v1 и Embeddings API v1 указывайте название [модели](../concepts/yandexgpt/models.md#yandexgpt-generation) в параметре `modelUri` (вместо `model` в устаревшем API):

| Модель | API v1alpha | YandexGPT API v1 и Embeddings API v1 |
| --- | --- | --- |
| {{ gpt-pro }} | `"model": "yagpt-2.0:hq"` | `"modelUri": "gpt://<идентификатор_каталога>/yandexgpt/latest"` |
| {{ gpt-lite }} | `"model": "general"` | `"modelUri": "gpt://<идентификатор_каталога>/yandexgpt-lite/latest"` |

## Генерация {#generation}

{% list tabs %}

- Синхронный режим

  **TextGeneration.instruct (промт-режим)**

  API-эндпойнт:

  | API v1alpha | YandexGPT API v1 |
  | --- | --- |
  | `https://{{ api-host-llm }}/llm/v1alpha/instruct` | `https://{{ api-host-llm }}/foundationModels/v1/completion` |

  Общая структура запроса:

  #|
  || **API v1alpha** |  **YandexGPT API v1** ||
  || 
  ```json
  {
    "model": "string",
    "generationOptions": {
      "partialResults": true,
      "temperature": "number",
      "maxTokens": "integer"
    },

    // только одно из полей: `instructionText` или `instructionUri`
    "instructionText": "string",
    "instructionUri": "string",

    "requestText": "string"
  }
  ```
  |
  ```json
  {
    "modelUri": "string",
    "completionOptions": {
      "stream": true,
      "temperature": "number",
      "maxTokens": "integer"
    },
    "messages": [
      {
        "role": "string",
        "text": "string"
      }
    ]
  }
  ```
  ||
  |#

  Поля тела запроса:

  #|
  || **API v1alpha** | **YandexGPT API v1** | **Описание** ||
  || model | modelUri|[Идентификатор модели](../concepts/yandexgpt/models.md), которая будет использоваться для генерации ответа. Параметр содержит [идентификатор каталога](../../resource-manager/operations/folder/get-id.md) {{ yandex-cloud }} или идентификатор [дообученной](../tutorials/yagpt-tuning.md) в {{ ml-platform-name }} модели.||
  || instructionText | 
  ```json
  "messages": [
    {
      "role": "system",
      "text": "string"
    }
  ]
  ``` 
  | В YandexGPT API v1 блок `messages` — список сообщений, которые задают контекст запроса для модели.
  * `role` — в значении `system` позволяет задать контекст запроса и определить поведение модели.
  * `text` — текст, задающий контекст запроса. ||
  || instructionUri | modelUri | В YandexGPT API v1 параметр `instructionUri` не используется, URI задается в параметре `modelUri`.||
  || requestText | 
  ```json
  "messages": [
    {
      "role": "user",
      "text": "string"
    }
  ]
  ``` 
  | В YandexGPT API v1 блок `messages` — список сообщений, которые задают контекст запроса для модели.
  * `role` — в значении `user` позволяет отправлять пользовательские сообщения к модели.
  * `text` — текстовое сообщение запроса.||
  || partialResults | stream | Включает потоковую передачу частично сгенерированного текста. Принимает значения `true` или `false`. ||
  || generationOptions | completionOptions | Задает параметры конфигурации запроса. ||
  || maxTokens | maxTokens | Имя параметра `maxTokens` осталось прежним, но его значение изменилось. В **API v1alpha** в параметре `maxTokens` задавалось ограничение на суммарное количество токенов в запросе и ответе. В **YandexGPT API v1** значение параметра `maxTokens` — это максимальное количество токенов только в ответе.||
  |#

  **TextGeneration.chat (режим чата)**

  API-эндпойнт:

  | API v1alpha | YandexGPT API v1 |
  | --- | --- |
  | `https://{{ api-host-llm }}/llm/v1alpha/chat` | `https://{{ api-host-llm }}/foundationModels/v1/completion` |

  Общая структура запроса:

  #|
  || **API v1alpha**|**YandexGPT API v1** ||
  || 
  ```json
  {
    "model": "string",
    "generationOptions": {
      "partialResults": true,
      "temperature": "number",
      "maxTokens": "integer"
    },
    "messages": [
      {
        "role": "string",
        "text": "string"
      }
    ],
    "instructionText": "string"
  }
  ``` 
  | 
  ```json
  {
    "modelUri": "string",
    "completionOptions": {
      "stream": true,
      "temperature": "number",
      "maxTokens": "integer"
    },
    "messages": [
      {
        "role": "string",
        "text": "string"
      }
    ]
  }
  ```
  ||
  |#

  Поля тела запроса:

  #|
  || **API v1alpha** | **YandexGPT API v1** | **Описание** ||
  || model | modelUri | [Идентификатор модели](../concepts/yandexgpt/models.md), которая будет использоваться для генерации ответа. Параметр содержит [идентификатор каталога](../../resource-manager/operations/folder/get-id.md) {{ yandex-cloud }} или идентификатор [дообученной](../tutorials/yagpt-tuning.md) в {{ ml-platform-name }} модели. ||
  || instructionText |
  ```json
  "messages": [
    {
      "role": "system",
      "text": "string"
    }
  ]
  ```
  | В YandexGPT API v1 блок `messages` — список сообщений, которые задают контекст запроса для модели.
  * `role` — в значении `system` позволяет задать контекст запроса и определить поведение модели.
  * `text` — текст, задающий контекст запроса. ||
  || partialResults | stream | Включает потоковую передачу частично сгенерированного текста. Принимает значения `true` или `false`.||
  || generationOptions | completionOptions | Задает параметры конфигурации запроса. ||
  || maxTokens | maxTokens | Имя параметра `maxTokens` осталось прежним, но значение изменилось. В **API v1alpha** в параметре `maxTokens` задавалось ограничение на суммарное количество токенов в запросе и ответе. В **YandexGPT API v1** значение параметра `maxTokens` — это максимальное количество токенов только в ответе. ||
  || role | role | Имя параметра `role` осталось прежним, но список возможных значений изменился. В **API v1alpha** возможными значениями параметра были `Ассистент` и `Пользователь`. В **YandexGPT API v1** возможные значения параметра — `assistant`, `user` и `system`. ||
  |#

- Асинхронный режим

  API-эндпойнт:

  | API v1alpha | YandexGPT API v1 |
  | --- | --- |
  | `https://{{ api-host-llm }}/llm/v1alpha/instructAsync` | `https://{{ api-host-llm }}/foundationModels/v1/completionAsync` |

  Общая структура запроса:

  #|
  ||**API v1alpha**|**YandexGPT API v1**||
  ||
  ```json
  {
    "model": "string",
    "generationOptions": {
      "partialResults": true,
      "temperature": "number",
      "maxTokens": "integer"
    },

    // только одно из полей: `instructionText` или `instructionUri` 
    "instructionText": "string",
    "instructionUri": "string",

    "requestText": "string"
  }
  ```
  |
  ```json
  {
    "modelUri": "string",
    "completionOptions": {
      "stream": true,
      "temperature": "number",
      "maxTokens": "integer"
    },
    "messages": [
      {
        "role": "string",
        "text": "string"
      }
    ]
  }
  ```
  ||
  |#

  Поля тела запроса:

  #|
  || **API v1alpha** | **YandexGPT API v1** | **Описание** ||
  || model | modelUri | [Идентификатор модели](../concepts/yandexgpt/models.md), которая будет использоваться для генерации ответа. Параметр содержит [идентификатор каталога](../../resource-manager/operations/folder/get-id.md) {{ yandex-cloud }} или идентификатор [дообученной](../tutorials/yagpt-tuning.md) в {{ ml-platform-name }} модели. ||
  || instructionText |
  ```json
  "messages": [
    {
      "role": "system",
      "text": "string"
    }
  ]
  ```
  | В YandexGPT API v1 блок `messages` — список сообщений, которые задают контекст запроса для модели.
  * `role` — в значении `system` позволяет задать контекст запроса и определить поведение модели.
  * `text` — текст, задающий контекст запроса. ||
  || instructionUri | modelUri | В YandexGPT API v1 параметр `instructionUri` не используется, URI задается в параметре `modelUri`. ||
  || requestText |
  ```json
  "messages": [
    {
      "role": "user",
      "text": "string"
    }
  ]
  ```
  | В YandexGPT API v1 блок `messages` — список сообщений, которые задают контекст запроса для модели.
  * `role` — в значении `user` позволяет отправлять пользовательские сообщения к модели.
  * `text` — текстовое сообщение запроса.||
  ||partialResults|stream|Включает потоковую передачу частично сгенерированного текста. Принимает значения `true` или `false`.||
  ||generationOptions|completionOptions|Задает параметры конфигурации запроса.||
  ||maxTokens|maxTokens|Имя параметра `maxTokens` осталось прежним, но значение изменилось. В **API v1alpha** в параметре `maxTokens` задавалось ограничение на суммарное количество токенов в запросе и ответе. В **YandexGPT API v1** значение параметра `maxTokens` — это максимальное количество токенов только в ответе.||
  |#

{% endlist %}

## Токенизация {#tokenization}

{% list tabs %}

- Tokenizer.tokenizeCompletion

  Метод используется только с методами генерации.

  API-эндпойнт:

  | API v1alpha | YandexGPT API v1 |
  | --- | --- |
  | `https://{{ api-host-llm }}/llm/v1alpha/tokenize` | `https://{{ api-host-llm }}/foundationModels/v1/tokenizeCompletion` |

  Общая структура запроса:

  #|
  || **API v1alpha** | **YandexGPT API v1** ||
  ||
  ```json
  {
    "model": "string",
    "text": "string"
  }
  ```
  |
  ```json
  {
    "modelUri": "string",
    "completionOptions": {
      "stream": true,
      "temperature": "number",
      "maxTokens": "integer"
    },
    "messages": [
      {
        "role": "string",
        "text": "string"
      }
    ]
  }
  ```
  ||
  |#

  Поля тела запроса:

  #|
  || **API v1alpha** | **YandexGPT API v1** | **Описание** ||
  || model | modelUri | [Идентификатор модели](../concepts/yandexgpt/models.md), которая будет использоваться для генерации ответа. Параметр содержит [идентификатор каталога](../../resource-manager/operations/folder/get-id.md) {{ yandex-cloud }} или идентификатор [дообученной](../tutorials/yagpt-tuning.md) в {{ ml-platform-name }} модели. ||
  |#

- Tokenizer.tokenize

  Метод используется со всеми методами, кроме генерации.

  API-эндпойнт:

  | API v1alpha | YandexGPT API v1 |
  | --- | --- |
  | `https://{{ api-host-llm }}/llm/v1alpha/tokenize` | `https://{{ api-host-llm }}/foundationModels/v1/tokenize` |

  Общая структура запроса осталась без изменений:

  #|
  || **API v1alpha** | **YandexGPT API v1** ||
  ||
  ```json
  {
    "model": "string",
    "text": "string"
  }
  ```
  |
  ```json
  {
    "modelUri": "string",
    "text": "string"
  }
  ```
  ||
  |#

  Поля тела запроса:

  #|
  || **API v1alpha** | **YandexGPT API v1** | **Описание** ||
  || model | modelUri | [Идентификатор модели](../concepts/yandexgpt/models.md), которая будет использоваться для генерации ответа. Параметр содержит [идентификатор каталога](../../resource-manager/operations/folder/get-id.md) {{ yandex-cloud }} или идентификатор [дообученной](../tutorials/yagpt-tuning.md) в {{ ml-platform-name }} модели. ||
  |#

{% endlist %}

## Векторизация {#vectorization}

API-эндпойнт:

| API v1alpha | Embeddings API v1 |
| --- | --- |
| `https://{{ api-host-llm }}/llm/v1alpha/embedding` | `https://{{ api-host-llm }}/foundationModels/v1/textEmbedding` |

Общая структура запроса:

#|
|| **API v1alpha** | **Embeddings API v1** ||
||
```json
{
  "embeddingType": "string",
  "model": "string",
  "text": "string"
}
```
|
```json
{
  "modelUri": "string",
  "text": "string"
}
```
||
|#

Поля тела запроса:

#|
|| **API v1alpha** | **Embeddings API v1** | **Описание** ||
|| model | — | В Embeddings API v1 модель векторного представления текста задается в параметре `modelUri`. ||
|| `"embeddingType" = "EMBEDDING_TYPE_QUERY"` | `"modelUri" = "emb://<идентификатор_каталога>/text-search-query/latest"` | Векторизация коротких текстов: поисковых запросов, обращений и т.п. ||
|| `"embeddingType" = "EMBEDDING_TYPE_DOCUMENT"` | `"modelUri" = "emb://<идентификатор_каталога>/text-search-doc/latest"` | Векторизация больших текстов исходных данных, например статей документации. ||
|#