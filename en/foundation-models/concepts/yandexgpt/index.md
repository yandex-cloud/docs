# {{ yagpt-full-name }} overview

{{ yagpt-full-name }} allows you to quickly create text content, e.g., product descriptions, articles, news stories, newsletters, blog posts, and many other things. The quality of the neural network's response depends directly on the accuracy of the instructions you provide. With a more specific prompt, you are more likely to get the result you expect.

The model understands prompts both in Russian and English; however, Russian texts are its first priority. In addition to a text description, prompts must contain a special parameter called _temperature_ that determines the variability of the model's response: the higher the temperature value, the less predictable the model's output is going to be.

There are two interfaces for {{ yagpt-full-name }} in {{ yandex-cloud }}. You can send requests to [{{ foundation-models-name }} Playground]({{ link-console-main }}/link/foundation-models/) or integrate the model into your applications using the API. You can use the [REST](../../text-generation/api-ref/index.md) and [gRPC](../../text-generation/api-ref/grpc/index.md) interfaces for integration.

{{ foundation-models-name }} Playground is a good option for introduction and testing: use it to send synchronous requests to {{ yagpt-full-name }} models. You can communicate with a model in these two formats:

* In **Prompt mode**, you submit a ready-made prompt to the model and get the result. The model treats each new question as a stand-alone task without saving the context of the previous request. In this format, you can choose between the {{ gpt-lite }} and {{ gpt-pro }} models in the management console.

* In **Chat mode**, you can chat with the model to update your instructions and elaborate on your previous inputs. The communication context is transmitted in every message and maintained throughout the current session until you explicitly start a new one. To work in chat mode, use the {{ gpt-pro }} model.

Both the [prompt mode](../../operations/yandexgpt/create-prompt.md) and [chat mode](../../operations/yandexgpt/create-chat.md) are available via the API. You can use the API to work with models in [asynchronous mode](../../operations/yandexgpt/async-request.md).

To learn more about the {{ yagpt-full-name }} models, see [{#T}](models.md).

## Formatting of model responses {#answers-formatting}

By default, the model returns a response formatted using [Markdown](https://en.wikipedia.org/wiki/Markdown). Use the prompt text to get a response with additional formatting, e.g., with [emoji](https://en.wikipedia.org/wiki/Emoji), or in a different format, e.g., [JSON](https://en.wikipedia.org/wiki/JSON), [XML](https://en.wikipedia.org/wiki/XML), etc.

Examples:

```json
{
  "modelUri": "gpt://<folder_ID>/yandexgpt/latest",
  "completionOptions": {
    "stream": false,
    "temperature": 0.6,
    "maxTokens": "2000"
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

If you do not get the result you expect using the prompt, try [fine-tuning](../../tutorials/yagpt-tuning.md) the model in [{{ ml-platform-full-name}}]({{ link-datasphere-main }}).

#### See also {#see-also}

* [{#T}](../../operations/yandexgpt/create-prompt.md)
* [{#T}](../../operations/yandexgpt/create-chat.md)
* [{#T}](../../operations/yandexgpt/async-request.md)
