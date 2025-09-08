# Вызвать функцию из модели

При работе с моделями {{ gpt-pro }} и {{ llama }} 70B^1^ вы можете обращаться к внешним инструментам, API и базам данных с помощью [вызова функций](../../concepts/generation/function-call.md). 

Например, у вас есть функция `weatherTool`, которая в качестве входного параметра принимает название города и возвращает текущую температуру в нем. Обработку ответов модели, работу функции и формирование запросов вам нужно предусмотреть самостоятельно.

Чтобы модель могла вызвать функцию, если это будет необходимо:

{% list tabs group=programming_language %}

- cURL {#curl}

  1. Сформируйте запрос к модели, например, в файле `body.json`:

     ```json
     {
         "modelUri": "gpt://<идентификатор_каталога>/yandexgpt",
         "tools": [
             {
                 "function": {
                     "name": "weatherTool",
                     "description": "Получает текущую погоду в указанном городе.",
                     "parameters": {
                         "type": "object",
                         "properties": {
                             "city": {
                                 "type": "string",
                                 "description": "Название города, например, Москва"
                             }
                         },
                         "required": [
                             "city"
                         ]
                     }
                 }
             }
         ],
         "messages": [
             {
                 "role": "user",
                 "text": "Какая погода в Санкт-Петербурге?"
             }
         ]
     }
     ```

     Где:

     * `modelUri` — [идентификатор модели](../../concepts/generation/models.md), которая будет использоваться для вызова функций. Параметр содержит [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md) {{ yandex-cloud }} или идентификатор [дообученной](../../concepts/tuning/index.md) модели.
     * `tools` — массив всех передаваемых модели функций.
     * `function` — описание и параметры функции `weatherTool`.

     {% include [the-messages-parameter](../../../_includes/foundation-models/yandexgpt/the-messages-parameter.md) %}

  1. Отправьте запрос к модели:

      ```bash
      export FOLDER_ID=<идентификатор_каталога>
      export IAM_TOKEN=<IAM-токен>
      curl \
        --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --header "x-folder-id: ${FOLDER_ID}" \
        --data "@<путь_до_файла_json>" \
        "https://llm.{{ api-host }}/foundationModels/v1/completion"
      ```

      Где:

      * `FOLDER_ID` — идентификатор каталога, на который у вашего аккаунта есть роль `{{ roles-yagpt-user }}` или выше.
      * `IAM_TOKEN` — [IAM-токен](../../../iam/operations/iam-token/create.md) вашего аккаунта.

  1. Модель вернет ответ с [полем `ToolCallList`](../../text-generation/api-ref/TextGeneration/completion.md#yandex.cloud.ai.foundation_models.v1.ToolCallList2), содержащим обращение к вызываемой функции и необходимые параметры в виде [JSON Schema](https://json-schema.org/).
  
     Пример ответа:

     ```json
     {
         "result": {
           "alternatives": [
             {
               "message": {
                 "role": "assistant",
                 "toolCallList": {
                   "toolCalls": [
                     {
                       "functionCall": {
                         "name": "weatherTool",
                         "arguments": {
                           "city": "Санкт-Петербург"
                         }
                       }
                     }
                   ]
                 }
               },
               "status": "ALTERNATIVE_STATUS_TOOL_CALLS"
             }
           ],
           "usage": {
             "inputTextTokens": "74",
             "completionTokens": "14",
             "totalTokens": "88",
             "completionTokensDetails": {
               "reasoningTokens": "0"
             }
           },
           "modelVersion": "23.10.2024"
         }
     }
     ```

  1. Обработайте ответ модели (поле `toolCallList`) и инициируйте работу функции `weatherTool`, передав в нее пришедшие параметры.

  1. Дополните массив `messages` в файле `body.json` ответом модели и результатами вызова функции.

     {% cut "Пример запроса" %}
  
     ```json
     {
         "modelUri": "gpt://<идентификатор_каталога>/yandexgpt",
         "tools": [
           {
             "function": {
               "name": "weatherTool",
               "description": "Получает текущую погоду в указанном городе.",
               "parameters": {
                 "type": "object",
                 "properties": {
                   "city": {
                     "type": "string",
                     "description": "Название города, например, Москва"
                   }
                 },
                 "required": ["city"]
               }
             }
           }
         ],
         "messages": [
           {
             "role": "user",
             "text": "Какая погода в Санкт-Петербурге?"
           },
           {
             "role": "assistant",
             "toolCallList": {
               "toolCalls": [
                 {
                   "functionCall": {
                     "name": "weatherTool",
                     "arguments": {
                       "city": "Санкт-Петербург"
                     }
                   }
                 }
               ]
             }
           },
           {
             "role": "user",
             "toolResultList": {
               "toolResults": [
                 {
                   "functionResult": {
                     "name": "weatherTool",
                     "content": "8°C"
                   }
                 }
               ]
             }
           }
         ]
     }
     ```

     Где `toolResultList` — результаты вызова функции.   
  
     {% endcut %}

  1. Отправьте новый запрос к модели, повторив второй шаг инструкции. Модель сформулирует ответ с учетом результатов вызова функции:

     ```json
     {
       "result": {
         "alternatives": [
           {
             "message": {
               "role": "assistant",
               "text": "В Санкт-Петербурге сейчас 8°C."
             },
             "status": "ALTERNATIVE_STATUS_FINAL"
           }
         ],
         "usage": {
           "inputTextTokens": "108",
           "completionTokens": "10",
           "totalTokens": "118",
           "completionTokensDetails": {
             "reasoningTokens": "0"
           }
         },
         "modelVersion": "23.10.2024"
       }
     }
     ```

{% endlist %}

^1^ {{ meta-disclaimer }}