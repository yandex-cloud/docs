# Text generation overview

{{ foundation-models-full-name }} provides access to large text models which can quickly generate text content, e.g., product descriptions, articles, news stories, newsletters, blog posts, and more. The quality of the neural network's response depends directly on the accuracy of the instructions you provide. With a more specific prompt, you are more likely to get the result you expect. You can increase the accuracy of answers to some requests by activating the [reasoning mode](./chain-of-thought.md).

{{ yagpt-name }} models understand prompts in more than 20 languages, including English and Japanese; however, Russian texts are its first priority. In addition to a text description, prompts must contain a special parameter called _temperature_ that determines the variability of the model's response: the higher the temperature value, the less predictable the model's output is going to be.

{{ foundation-models-name }} also provides access to the {{ llama }} 3.1 8B and {{ llama }} 3.3 70B^1^ models. 

## Interfaces for working with models {#interfaces}

To interact with text generation models in {{ yandex-cloud }}, there are two interfaces available. You can submit requests to [{{ ai-playground }}]({{ link-console-main }}/link/foundation-models/) or integrate the model into your applications using the API. You can use the [REST](../../text-generation/api-ref/index.md) and [gRPC](../../text-generation/api-ref/grpc/index.md) interfaces for integration. You can also use the API to work with models in [asynchronous mode](../index.md#working-mode). You can view the examples of working with {{ yagpt-name }} via the API in [Step-by-step guides for {{ yagpt-full-name }}](../../operations/index.md#yandexgpt-api).

{{ ai-playground }} is a good option for introduction and testing: use it to submit synchronous requests to different models, set up parameters, and choose prompts. When communicating, the model saves the dialog context, but you can also create a new experiment if you need to change the context. Additionally, {{ yagpt-name }} Playground interfaces in chat format or prompt mode are available in the left-hand navigation menu. Use them when you need to fully repeat the model's behavior via the API and you do not want to save the results of the dialog. 

To use the {{ yagpt-name }} models, you need the `ai.languageModels.user` [role](../../security/index.md#languageModels-user) or higher for the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).

To learn more about the {{ yagpt-full-name }} models, see [{#T}](models.md).

## Formatting of model responses {#answers-formatting}

By default, the model returns a response formatted using [Markdown](https://en.wikipedia.org/wiki/Markdown). Use the prompt text to get a response with additional formatting, e.g., with [emoji](https://en.wikipedia.org/wiki/Emoji), or in a different format, e.g., [JSON](https://en.wikipedia.org/wiki/JSON), [XML](https://en.wikipedia.org/wiki/XML), etc.

Example:

```json
{
  "modelUri": "gpt://<folder_ID>/yandexgpt/latest",
  "completionOptions": {
    "stream": false,
    "temperature": 0.6,
    "maxTokens": "2000",
    "reasoningOptions": {
      "mode": "DISABLED"
    }
  },
  "messages": [
    {
      "role": "system",
      "text": "You are a smart assistant."
    },
    {
      "role": "user",
      "text": "Name any three groups of products one can find in a grocery store. For each group, provide three subgroups. Present the result as a JSON object, where each group of products is represented by a key in the JSON object, and arrays from the relevant subgroups are the values. No introductory phrases or explanations needed, just data. Do not use Markdown."
    }
  ]
}
```

Result:

```json
{
  "result": {
    "alternatives": [
      {
        "message": {
          "role": "assistant",
          "text": "{\n    \"meat\": [\"beef\", \"pork\", \"mutton\"],\n    \"dairy products\": [\"milk\", \"curd\", \"sour cream\"],\n    \"fruit\": [\"apples\", \"bananas\", \"oranges\"]\n}"
        },
        "status": "ALTERNATIVE_STATUS_FINAL"
      }
    ],
    "usage": {
      "inputTextTokens": "87",
      "completionTokens": "58",
      "totalTokens": "145"
    },
    "modelVersion": "07.03.2024"
  }
}
```

The model returned a response in JSON format with line breaks replaced with `\n` and quotation marks escaped.

If you do not get the result you expect using the prompt, try [fine-tuning](../tuning/index.md) the model.

^1^ {{ meta-disclaimer }}

#### See also {#see-also}

* 
* [{#T}](./chain-of-thought.md)
* [{#T}](../../operations/yandexgpt/create-prompt.md)
* [{#T}](../../operations/yandexgpt/create-chat.md)
* [{#T}](../../operations/yandexgpt/async-request.md)