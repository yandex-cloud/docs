# Migration from API v1alpha to YandexGPT API v1 and Embeddings API v1

[API v1alpha](../api-ref/v1alpha/) is obsolete and will be discontinued soon. To work with {{ yagpt-name }}, use [YandexGPT API v1](../text-generation/api-ref/) and [Embeddings API v1](../embeddings/api-ref/). In the new API version, the maximum total number of [tokens](../concepts/tokens.md) allowed per user request and model response is {{ yagpt-max-tokens }}.

If your product adopts methods of the obsolete API, migrate it to the new interface. Below is the detailed overview of the changes required for the REST API. Similar changes apply to the gRPC API.

## Model selection {#model-choice}

In YandexGPT API v1 and Embeddings API v1, specify the [model](../concepts/models.md#yandexgpt-generation) name in the `modelUri` parameter (instead of `model` in the obsolete API):

| Model | API v1alpha | YandexGPT API v1 and Embeddings API v1 |
| --- | --- | --- |
| {{ yagpt-name }} | `"model": "yagpt-2.0:hq"` | `"modelUri": "gpt://<folder_ID>/yandexgpt/latest"` |
| {{ yagpt-name }} Lite | `"model": "general"` | `"modelUri": "gpt://<folder_ID>/yandexgpt-lite/latest"` |

## Generation {#generation}

{% list tabs %}

- Synchronous mode

   **TextGeneration.instruct (prompt mode)**

   API endpoint:

   | API v1alpha | YandexGPT API v1 |
   | --- | --- |
   | `https://{{ api-host-llm }}/llm/v1alpha/instruct` | `https://{{ api-host-llm }}/foundationModels/v1/completion` |

   General request structure:

   #|
   ||**API v1alpha**|**YandexGPT API v1**||
   ||```json
   {
    "model": "string",
    "generationOptions": {
      "partialResults": true,
      "temperature": "number",
      "maxTokens": "integer"
    },

    /*
    includes only one of the fields:
    either `instructionText` or `instructionUri`
    */

    "instructionText": "string",
    "instructionUri": "string",

    /* end of the list of possible fields */

    "requestText": "string"
   }
   ```|```json
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
   ```||
   |#

   Request body fields:

   #|
   ||**API v1alpha**|**YandexGPT API v1**|**Description**||
   ||model|modelUri|[ID of the model](../concepts/models.md) to use for generating a response. The parameter contains the {{ yandex-cloud }} [folder ID](../../resource-manager/operations/folder/get-id.md) or the ID of a model [fine-tuned](../tutorials/yagpt-tuning.md) in {{ ml-platform-name }}.||
   ||instructionText|```json
   "messages": [
     {
       "role": "system",
       "text": "string"
     }
   ]
   ```|In YandexGPT API v1, the `messages` section is the list of messages setting the request context for the model.
   * `role`: When the value is `system`, it allows you to set the request context and define the model's behavior.
   * `text`: Text that sets the request context.||
   ||instructionUri|modelUri|In YandexGPT API v1, the `instructionUri` parameter is not used; instead, the `modelUri` parameter defines the URI.||
   ||requestText|```json
   "messages": [
     {
       "role": "user",
       "text": "string"
     }
   ]
   ```|In YandexGPT API v1, the `messages` section is the list of messages setting the request context for the model.
   * `role`: When the value is `user`, it allows sending user messages to the model.
   * `text`: Text message of the request.||
   ||partialResults|stream|It enables streaming of partially generated text. Possible values are `true` or `false`.||
   ||generationOptions|completionOptions|It sets the request's configuration parameters.||
   ||maxTokens|maxTokens|The name of the `maxTokens` parameter remains the same, but the value has changed. In **API v1alpha**, the `maxTokens` parameter defined the limit on the total number of tokens per request and response. In **YandexGPT API v1**, the value of `maxTokens` is the maximum number of tokens per response only.||
   |#

   **TextGeneration.chat (chat mode)**

   API endpoint:

   | API v1alpha | YandexGPT API v1 |
   | --- | --- |
   | `https://{{ api-host-llm }}/llm/v1alpha/chat` | `https://{{ api-host-llm }}/foundationModels/v1/completion` |

   General request structure:

   #|
   ||**API v1alpha**|**YandexGPT API v1**||
   ||```json
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
   ```|```json
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
   ```||
   |#

   Request body fields:

   #|
   ||**API v1alpha**|**YandexGPT API v1**|**Description**||
   ||model|modelUri|[ID of the model](../concepts/models.md) to use for generating a response. The parameter contains the {{ yandex-cloud }} [folder ID](../../resource-manager/operations/folder/get-id.md) or the ID of a model [fine-tuned](../tutorials/yagpt-tuning.md) in {{ ml-platform-name }}.||
   ||instructionText|```json
   "messages": [
     {
       "role": "system",
       "text": "string"
     }
   ]
   ```|In YandexGPT API v1, the `messages` section is the list of messages setting the request context for the model.
   * `role`: When the value is `system`, it allows you to set the request context and define the model's behavior.
   * `text`: Text that sets the request context.||
   ||partialResults|stream|It enables streaming of partially generated text. Possible values are `true` or `false`.||
   ||generationOptions|completionOptions|It sets the request's configuration parameters.||
   ||maxTokens|maxTokens|The name of the `maxTokens` parameter remains the same, but the value has changed. In **API v1alpha**, the `maxTokens` parameter defined the limit on the total number of tokens per request and response. In **YandexGPT API v1**, the value of `maxTokens` is the maximum number of tokens per response only.||
   ||role|role|The name of the `role` parameter remains the same, but the list of possible values has changed. In **API v1alpha**, the possible values of the parameter were `Assistant` and `User`. In **YandexGPT API v1**, the possible values of the parameter are `assistant`, `user`, and `system`.||
   |#

- Asynchronous mode

   API endpoint:

   | API v1alpha | YandexGPT API v1 |
   | --- | --- |
   | `https://{{ api-host-llm }}/llm/v1alpha/instructAsync` | `https://{{ api-host-llm }}/foundationModels/v1/completionAsync` |

   General request structure:

   #|
   ||**API v1alpha**|**YandexGPT API v1**||
   ||```json
   {
    "model": "string",
    "generationOptions": {
      "partialResults": true,
      "temperature": "number",
      "maxTokens": "integer"
    },

    /*
    includes only one of the fields:
    either `instructionText` or `instructionUri`
    */

    "instructionText": "string",
    "instructionUri": "string",

    /* end of the list of possible fields */

    "requestText": "string"
   }
   ```|```json
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
   ```||
   |#

   Request body fields:

   #|
   ||**API v1alpha**|**YandexGPT API v1**|**Description**||
   ||model|modelUri|[ID of the model](../concepts/models.md) to use for generating a response. The parameter contains the {{ yandex-cloud }} [folder ID](../../resource-manager/operations/folder/get-id.md) or the ID of a model [fine-tuned](../tutorials/yagpt-tuning.md) in {{ ml-platform-name }}.||
   ||instructionText|```json
   "messages": [
     {
       "role": "system",
       "text": "string"
     }
   ]
   ```|In YandexGPT API v1, the `messages` section is the list of messages setting the request context for the model.
   * `role`: When the value is `system`, it allows you to set the request context and define the model's behavior.
   * `text`: Text that sets the request context.||
   ||instructionUri|modelUri|In YandexGPT API v1, the `instructionUri` parameter is not used; instead, the `modelUri` parameter defines the URI.||
   ||requestText|```json
   "messages": [
     {
       "role": "user",
       "text": "string"
     }
   ]
   ```|In YandexGPT API v1, the `messages` section is the list of messages setting the request context for the model.
   * `role`: When the value is `user`, it allows sending user messages to the model.
   * `text`: Text message of the request.||
   ||partialResults|stream|It enables streaming of partially generated text. Possible values are `true` or `false`.||
   ||generationOptions|completionOptions|It sets the request's configuration parameters.||
   ||maxTokens|maxTokens|The name of the `maxTokens` parameter remains the same, but the value has changed. In **API v1alpha**, the `maxTokens` parameter defined the limit on the total number of tokens per request and response. In **YandexGPT API v1**, the value of `maxTokens` is the maximum number of tokens per response only.||
   |#

{% endlist %}

## Tokenization {#tokenization}

{% list tabs %}

- Tokenizer.tokenizeCompletion

   You can use this method with generation methods only.

   API endpoint:

   | API v1alpha | YandexGPT API v1 |
   | --- | --- |
   | `https://{{ api-host-llm }}/llm/v1alpha/tokenize` | `https://{{ api-host-llm }}/foundationModels/v1/tokenizeCompletion` |

   General request structure:

   #|
   ||**API v1alpha**|**YandexGPT API v1**||
   ||```json
   {
    "model": "string",
    "text": "string"
   }
   ```|```json
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
   ```||
   |#

   Request body fields:

   #|
   ||**API v1alpha**|**YandexGPT API v1**|**Description**||
   ||model|modelUri|[ID of the model](../concepts/models.md) to use for generating a response. The parameter contains the {{ yandex-cloud }} [folder ID](../../resource-manager/operations/folder/get-id.md) or the ID of a model [fine-tuned](../tutorials/yagpt-tuning.md) in {{ ml-platform-name }}.||
   |#

- Tokenizer.tokenize

   You can use this method with any methods other than generation.

   API endpoint:

   | API v1alpha | YandexGPT API v1 |
   | --- | --- |
   | `https://{{ api-host-llm }}/llm/v1alpha/tokenize` | `https://{{ api-host-llm }}/foundationModels/v1/tokenize` |

   General request structure remains the same:

   #|
   ||**API v1alpha**|**YandexGPT API v1**||
   ||```json
   {
    "model": "string",
    "text": "string"
   }
   ```|```json
   {
    "modelUri": "string",
    "text": "string"
   }
   ```||
   |#

   Request body fields:

   #|
   ||**API v1alpha**|**YandexGPT API v1**|**Description**||
   ||model|modelUri|[ID of the model](../concepts/models.md) to use for generating a response. The parameter contains the {{ yandex-cloud }} [folder ID](../../resource-manager/operations/folder/get-id.md) or the ID of a model [fine-tuned](../tutorials/yagpt-tuning.md) in {{ ml-platform-name }}.||
   |#


{% endlist %}

## Vectorization {#vectorization}

API endpoint:

| API v1alpha | Embeddings API v1 |
| --- | --- |
| `https://{{ api-host-llm }}/llm/v1alpha/embedding` | `https://{{ api-host-llm }}/foundationModels/v1/textEmbedding` |

General request structure:

#|
||**API v1alpha**|**Embeddings API v1**||
||```json
{
  "embeddingType": "string",
  "model": "string",
  "text": "string"
}
```|```json
{
"modelUri": "string",
"text": "string"
}
```||
|#

Request body fields:

#|
||**API v1alpha**|**Embeddings API v1**|**Description**||
||model|—|In Embeddings API v1, the `modelUri` parameter defines the model for text vectorization.||
||`"embeddingType" = "EMBEDDING_TYPE_QUERY"`|`"modelUri" = "emb://<folder_ID>/text-search-query/latest"`|Vectorization of short texts, such as search requests, queries, etc.||
||`"embeddingType" = "EMBEDDING_TYPE_DOCUMENT"`|`"modelUri" = "emb://<folder_ID>/text-search-doc/latest"`|Vectorization of large source texts, e.g., documentation articles.||
|#
