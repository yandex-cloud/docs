# Tokens

Neural networks work with texts by representing words and sentences as _tokens_. Tokens are logical fragments or frequently used character sequences that are common for a natural language. Tokens help neural networks detect patterns and process natural language.

{{ foundation-models-full-name }} uses its own tokenizer for text processing. You can [estimate](../../operations/generation/evaluate-request.md) the text field size in tokens using these special methods: [Tokenizer](../../text-generation/api-ref/Tokenizer/index.md) or [{{ ml-sdk-full-name }}](../../sdk/index.md). The token count of the same text may vary from one [model](./models.md) to the next.

To use a {{ foundation-models-full-name }} tokenizer, you need the `ai.languageModels.user` [role](../../security/index.md#languageModels-user) or higher for the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).

## Example {#example}

### Request parameters in Russian {#params-ru}

* **Prompt text**: Управление генеративными моделями осуществляется с помощью промтов. Эффективный промт должен содержать контекст запроса (инструкцию) для модели и непосредственно задание, которое модель должна выполнить, учитывая переданный контекст. Чем конкретнее составлен промт, тем более точными будут результаты работы модели.\n Кроме промта на результаты генерации моделей будут влиять и другие параметры запроса. Используйте AI Playground, доступный в консоли управления, чтобы протестировать ваши запросы.
* **Number of prompt characters**: 497.
* **Number of prompt tokens**: 86.
* **Model**: {{ gpt-pro }}.

### Request parameters in English {#params-en}

* **Prompt text**: Generative models are managed using prompts. A good prompt should contain the context of your request to the model (instruction) and the actual task the model should complete based on the provided context. The more specific your prompt, the more accurate will be the results returned by the model.\n Apart from the prompt, other request parameters will impact the model's output too. Use Foundation Models Playground available from the management console to test your requests.
* **Number of prompt characters**: 477.
* **Number of prompt tokens**: 89.
* **Model**: {{ gpt-pro }}.

### Request structure {#structure}

1. Create a file named `tbody.json` with the request parameters:



   ```json
   {
     "modelUri": "gpt://<folder_ID>/yandexgpt",
     "text": "Generative models are managed using prompts. A good prompt should contain the context of your request to the model (instruction) and the actual task the model should complete based on the provided context. The more specific your prompt, the more accurate will be the results returned by the model.\n Apart from the prompt, other request parameters will impact the model's output too. Use Foundation Models Playground available from the management console to test your requests."
   }
   ```


   {% include [folder-id](../../../_includes/foundation-models/yandexgpt/folder-id.md) %}

1. Send a request to the model:

   ```bash
   export IAM_TOKEN=<IAM_token>
   curl --request POST \
     --header "Authorization: Bearer ${IAM_TOKEN}" \
     --data "@tbody.json" \
     "https://llm.api.cloud.yandex.net/foundationModels/v1/tokenize"
   ```

   Where:

   * `<IAM_token>`: Value of the IAM token you got for your account.
   * `tbody.json`: JSON file with request parameters.



  {% cut "Result" %}

  {% include [token-result](../../../_untranslatable/foundation-models/tokens-result-en.md) %}

  {% endcut %}

