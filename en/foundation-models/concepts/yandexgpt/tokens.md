# Tokens

Neural networks work with texts by representing words and sentences as _tokens_. Tokens are logical fragments or frequently used character sequences that are common for a natural language. Tokens help neural networks detect patterns and process natural language.

{{ yagpt-full-name }} uses its own tokenizer for text processing. You can [estimate](../../operations/yandexgpt/evaluate-request.md) the text field size in tokens using these special methods: [Tokenizer](../../text-generation/api-ref/Tokenizer/index.md) or [{{ ml-sdk-full-name }}](../../sdk/index.md). The token count of the same text may vary from one [model](./models.md) to the next.

To use a {{ yagpt-full-name }} tokenizer, you need the `ai.languageModels.user` [role](../../security/index.md#languageModels-user) or higher for the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder).

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

  ```json
  {"tokens":
      [{"id":"1","text":"\u003cs\u003e","special":true},
      {"id":"6010","text":"▁Gener","special":false},
      {"id":"1748","text":"ative","special":false},
      {"id":"7789","text":"▁models","special":false},
      {"id":"642","text":"▁are","special":false},
      {"id":"15994","text":"▁managed","special":false},
      {"id":"1772","text":"▁using","special":false},
      {"id":"80536","text":"▁prompts","special":false},
      {"id":"125820","text":".","special":false},
      {"id":"379","text":"▁A","special":false},
      {"id":"1967","text":"▁good","special":false},
      {"id":"19099","text":"▁prompt","special":false},
      {"id":"1696","text":"▁should","special":false},
      {"id":"11195","text":"▁contain","special":false},
      {"id":"292","text":"▁the","special":false},
      {"id":"7210","text":"▁context","special":false},
      {"id":"346","text":"▁of","special":false},
      {"id":"736","text":"▁your","special":false},
      {"id":"4104","text":"▁request","special":false},
      {"id":"342","text":"▁to","special":false},
      {"id":"292","text":"▁the","special":false},
      {"id":"2718","text":"▁model","special":false},
      {"id":"355","text":"▁(","special":false},
      {"id":"105793","text":"instruction","special":false},
      {"id":"125855","text":")","special":false},
      {"id":"353","text":"▁and","special":false},
      {"id":"292","text":"▁the","special":false},
      {"id":"9944","text":"▁actual","special":false},
      {"id":"7430","text":"▁task","special":false},
      {"id":"292","text":"▁the","special":false},
      {"id":"2718","text":"▁model","special":false},
      {"id":"1696","text":"▁should","special":false},
      {"id":"7052","text":"▁complete","special":false},
      {"id":"4078","text":"▁based","special":false},
      {"id":"447","text":"▁on","special":false},
      {"id":"292","text":"▁the","special":false},
      {"id":"6645","text":"▁provided","special":false},
      {"id":"7210","text":"▁context","special":false},
      {"id":"125820","text":".","special":false},
      {"id":"671","text":"▁The","special":false},
      {"id":"1002","text":"▁more","special":false},
      {"id":"4864","text":"▁specific","special":false},
      {"id":"736","text":"▁your","special":false},
      {"id":"19099","text":"▁prompt","special":false},
      {"id":"125827","text":",","special":false},
      {"id":"292","text":"▁the","special":false},
      {"id":"1002","text":"▁more","special":false},
      {"id":"16452","text":"▁accurate","special":false},
      {"id":"912","text":"▁will","special":false},
      {"id":"460","text":"▁be","special":false},
      {"id":"292","text":"▁the","special":false},
      {"id":"4168","text":"▁results","special":false},
      {"id":"13462","text":"▁returned","special":false},
      {"id":"711","text":"▁by","special":false},
      {"id":"292","text":"▁the","special":false},
      {"id":"2718","text":"▁model","special":false},
      {"id":"125820","text":".","special":false},
      {"id":"3","text":"[NL]","special":true},
      {"id":"29083","text":"▁Apart","special":false},
      {"id":"728","text":"▁from","special":false},
      {"id":"292","text":"▁the","special":false},
      {"id":"19099","text":"▁prompt","special":false},
      {"id":"125827","text":",","special":false},
      {"id":"1303","text":"▁other","special":false},
      {"id":"4104","text":"▁request","special":false},
      {"id":"9513","text":"▁parameters","special":false},
      {"id":"912","text":"▁will","special":false},
      {"id":"8209","text":"▁impact","special":false},
      {"id":"292","text":"▁the","special":false},
      {"id":"2718","text":"▁model","special":false},
      {"id":"125886","text":"'","special":false},
      {"id":"125811","text":"s","special":false},
      {"id":"5925","text":"▁output","special":false},
      {"id":"2778","text":"▁too","special":false},
      {"id":"125820","text":".","special":false},
      {"id":"7597","text":"▁Use","special":false},
      {"id":"12469","text":"▁Foundation","special":false},
      {"id":"27947","text":"▁Models","special":false},
      {"id":"118637","text":"▁Playground","special":false},
      {"id":"2871","text":"▁available","special":false},
      {"id":"728","text":"▁from","special":false},
      {"id":"292","text":"▁the","special":false},
      {"id":"7690","text":"▁management","special":false},
      {"id":"15302","text":"▁console","special":false},
      {"id":"342","text":"▁to","special":false},
      {"id":"2217","text":"▁test","special":false},
      {"id":"736","text":"▁your","special":false},
      {"id":"14379","text":"▁requests","special":false},
      {"id":"125820","text":".","special":false}],
  "modelVersion":"23.10.2024"
  }
  ```

  {% endcut %}

