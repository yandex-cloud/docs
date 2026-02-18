# Tokens

Neural networks work with texts by representing words and sentences as _tokens_. Tokens are logical fragments or frequently used character sequences that are common for a natural language. Tokens help neural networks detect patterns and process natural language.

Each model uses its own tokenizer for text processing, so the number of tokens in the same text will differ. When working with models through {{ openai }}-compatible APIs, each model response returns the number of used tokens in the `usage` field. To estimate how many tokens a text contains, use the selected model's tokenizer.

Yandex models use a tokenizer specifically tailored to Russian-language texts to achieve a higher average number of characters per token and lower text processing costs. You can [estimate](../../operations/generation/evaluate-request.md) the token count in your text for Yandex models using the dedicated [Tokenizer](../../text-generation/api-ref/Tokenizer/index.md) methods or [{{ ml-sdk-full-name }}](../../sdk/index.md), free of charge. 

To use the tokenizer in {{ ai-studio-name }}, you need the `ai.languageModels.user` [role](../../security/index.md#languageModels-user) or higher for the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).

## Example {#example}

{% note info %}

The examples below only serve to illustrate the concept of tokens and do not indicate the actual number of tokens you may spend in your tasks. We estimated the number of tokens in the texts with online tokenizers and then calculated the averages.

{% endnote %}

* **Text in Russian**: Управление генеративными моделями осуществляется с помощью промптов. Эффективный промпт должен содержать контекст запроса (инструкцию) для модели и непосредственно задание, которое модель должна выполнить, учитывая переданный контекст. Чем конкретнее составлен промпт, тем более точными будут результаты работы модели.\n Кроме промпта на результаты генерации моделей будут влиять и другие параметры запроса. Используйте AI Playground, доступный в консоли управления, чтобы протестировать ваши запросы.
   **Number of characters in the text**: 501.

   | | {{ gpt-pro }} | Qwen3 235B | gpt-oss-120b |
   |---|---|---|---|
   | Number of tokens in the text | 96 | 139 | 109 |
   | Average number of symbols per token | 5,2 | 3,6 | 4,6 |

* **Text in English**: Generative models are managed using prompts. A good prompt should contain the context of your request to the model (instruction) and the actual task the model should complete based on the provided context. The more specific your prompt, the more accurate will be the results returned by the model.\n Apart from the prompt, other request parameters will impact the model's output too. Use Foundation Models Playground available from the management console to test your requests.
   **Number of prompt characters**: 477.

   | | {{ alice-ai }} | Qwen3 235B | gpt-oss-120b |
   |---|---|---|---|
   | Number of tokens in the text | 89 | 87 | 87 |
   | Average number of symbols per token | 5,36 | 5,48 | 5,48 |

### Tokenizing text for {{ gpt-pro }} {#structure}

1. Create a file named `tbody.json` with the request parameters:



   ```json
   {
     "modelUri": "gpt://<folder_ID>/yandexgpt",
     "text": "Generative models are managed using prompts. A good prompt should contain the context of your request to the model (instruction) and the actual task the model should complete based on the provided context. The more specific your prompt, the more accurate will be the results returned by the model.\n Apart from the prompt, other request parameters will impact the model's output too. Use Foundation Models Playground available from the management console to test your requests."
   }
   ```


   {% include [folder-id](../../../_includes/ai-studio/yandexgpt/folder-id.md) %}

1. Send a request to the model:

   ```bash
   export IAM_TOKEN=<IAM_token>
   curl --request POST \
     --header "Authorization: Bearer ${IAM_TOKEN}" \
     --data "@tbody.json" \
     "https://ai.api.cloud.yandex.net/foundationModels/v1/tokenize"
   ```

   Where:

   * `<IAM_token>`: Value of the [IAM token](../../../iam/concepts/authorization/iam-token.md) you got for your account.
   * `tbody.json`: JSON file with the request parameters.



  {% cut "Result" %}

  {% include [token-result](../../../_untranslatable/ai-studio/tokens-result-en.md) %}

  {% endcut %}

