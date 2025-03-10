# Invoking a function from a model

If using {{ gpt-pro }} and {{ llama }} 70b^1^, you can access external tools, API, and databases with the help of [function calls](../../concepts/yandexgpt/function-call.md). 

For example, you have a function called `weatherTool` that accepts a city name as the input parameter and returns the current air temperature for the city. It is up to you to contribute the model response processing, the usability of the function, and the generation of requests.

To enable the model to invoke the function when needed:

{% list tabs group=programming_language %}

- cURL {#curl}

  1. Generate a request to the model, e.g., in the `body.json` file.

     ```json
     {
         "modelUri": "gpt://<folder_ID>/yandexgpt",
         "tools": [
             {
                 "function": {
                     "name": "weatherTool",
                     "description": "Getting current weather in the specified city.",
                     "parameters": {
                         "type": "object",
                         "properties": {
                             "city": {
                                 "type": "string",
                                 "description": "City name, e.g., Moscow"
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
                 "text": "What is the weather like in Saint Petersburg?"
             }
         ]
     }
     ```

     Where:

     * `modelUri`: [ID of the model](../../concepts/yandexgpt/models.md) that will be used to invoke functions. The parameter contains the {{ yandex-cloud }} [folder ID](../../../resource-manager/operations/folder/get-id.md) or the [tuned model's](../../concepts/tuning/index.md) ID.
     * `tools`: Array of all functions provided to the model.
     * `function`: Description and parameters of the `weatherTool` function.

     {% include [the-messages-parameter](../../../_includes/foundation-models/yandexgpt/the-messages-parameter.md) %}

  1. Send a request to the model:

      ```bash
      export FOLDER_ID=<folder_ID>
      export IAM_TOKEN=<IAM_token>
      curl \
        --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --header "x-folder-id: ${FOLDER_ID}" \
        --data "@<path_to_JSON_file>" \
        "https://llm.{{ api-host }}/foundationModels/v1/completion"
      ```

      Where:

      * `FOLDER_ID`: ID of the folder for which your account has the `{{ roles-yagpt-user }}` role or higher.
      * `IAM_TOKEN`: Your account's [IAM token](../../../iam/operations/iam-token/create.md).

  1. The model will return a response with the [`ToolCallList` field](../../text-generation/api-ref/TextGeneration/completion.mc#yandex.cloud.ai.foundation_models.v1.ToolCallList2) containing a call to the invoked function and required parameters as a [JSON Schema](https://json-schema.org/).
  
     Response example:

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
                           "city": "Saint Petersburg"
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

  1. Process the model's response (the `toolCallList` field) and initiate the `weatherTool` function by providing to it the parameters you received.

  1. Add the model's response and the result of invoking the function to the `messages` array in the `body.json` file.

     {% cut "Request example" %}
  
     ```json
     {
         "modelUri": "gpt://<folder_ID>/yandexgpt",
         "tools": [
           {
             "function": {
               "name": "weatherTool",
               "description": "Getting current weather in the specified city.",
               "parameters": {
                 "type": "object",
                 "properties": {
                   "city": {
                     "type": "string",
                     "description": "City name, e.g., Moscow"
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
             "text": "What is the weather like in Saint Petersburg?"
           },
           {
             "role": "assistant",
             "toolCallList": {
               "toolCalls": [
                 {
                   "functionCall": {
                     "name": "weatherTool",
                     "arguments": {
                       "city": "Saint Petersburg"
                     }
                   }
                 }
               ]
             }
           },
           {
             "role": "assistant",
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

     Where `toolResultList` is the result of invoking the function.   
  
     {% endcut %}

  1. Send a new request to the model by repeating Step 2 of this guide. The model will formulate its response based on the result of invoking the function:

     ```json
     {
       "result": {
         "alternatives": [
           {
             "message": {
               "role": "assistant",
               "text": "It is currently 8°C above zero in Saint Petersburg."
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