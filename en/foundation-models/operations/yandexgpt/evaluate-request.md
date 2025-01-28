---
title: How to learn prompt size in tokens
description: Follow this guide to learn how to figure the size of prompts to {{ yagpt-full-name }} models in tokens.
---

# Estimating prompt size in tokens

Neural networks work with texts by representing words and sentences as [tokens](../../concepts/yandexgpt/tokens.md).

{{ foundation-models-name }} uses its own tokenizer for text processing. To calculate the token size of a text or prompt to a {{ yagpt-name }} model, use the [Tokenize](../../text-generation/api-ref/Tokenizer/index.md) method of the text generation API or [{{ ml-sdk-full-name }}](../../sdk/index.md).

The token count of the same text may vary from one [model](../../concepts/yandexgpt/models.md) to the next.

## Getting started {#before-begin}

To use the examples:

{% list tabs group=programming_language %}

- SDK {#sdk}

  {% include [sdk-before-begin-ai-langmodel-user](../../../_includes/foundation-models/sdk-before-begin-ai-langmodel-user.md) %}

- cURL {#curl}

  {% include [ai-before-beginning](../../../_includes/foundation-models/yandexgpt/ai-before-beginning.md) %}

  {% include [curl](../../../_includes/curl.md) %}

{% endlist %}

## Calculating prompt size {#evaluate}

The example below estimates the size of a prompt to a {{ yagpt-name }} model.

{% list tabs group=programming_language %}

- SDK {#sdk}

  1. Create a file named `tokenize.py` and paste the following code into it:

      {% include [yandexgpt-tokenize-sdk](../../../_includes/foundation-models/examples/yandexgpt-tokenize-sdk.md) %}

      Where:

      {% note info %}

      {% include [sdk-input-format](../../../_includes/foundation-models/sdk-input-format.md) %}

      {% endnote %}

      * `messages`: Message text.

      {% include [sdk-code-legend](../../../_includes/foundation-models/examples/sdk-code-legend.md) %}

      * `model`: Model version value. For more information, see [{#T}](../../concepts/yandexgpt/models.md#addressing-models).

  1. Run the created file:

      ```bash
      python3 tokenize.py
      ```

      {% cut "The result of a prompt is a list of tokens obtained by the tokenizer:" %}

      ```text
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
        {"id":"125820","text":".","special":false}],
      "modelVersion":"23.10.2024"
      }
      ```

      {% endcut %}

- cURL {#curl}

  1. Create a file named `tbody.json` with the request parameters:
  
     ```json
     {
       "modelUri": "gpt://<folder_ID>/yandexgpt",
       "text": "Управление генеративными моделями осуществляется с помощью промтов. Эффективный промт должен содержать контекст запроса (инструкцию) для модели и непосредственно задание, которое модель должна выполнить, учитывая переданный контекст. Чем конкретнее составлен промт, тем более точными будут результаты работы модели."
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
  
     {% cut "The result of a prompt is a list of tokens obtained by the tokenizer:" %}
     
     ```json
     {
       "tokens": [
         {
           "id": "1",
           "text": "<s>",
           "special": true
         },
         {
           "id": "19078",
           "text": "▁Управление",
           "special": false
         },
         {
           "id": "10810",
           "text": "▁генера",
           "special": false
         },
         {
           "id": "26991",
           "text": "тивными",
           "special": false
         },
         {
           "id": "77514",
           "text": "▁моделями",
           "special": false
         },
         {
           "id": "10578",
           "text": "▁осуществляется",
           "special": false
         },
         {
           "id": "277",
           "text": "▁с",
           "special": false
         },
         {
           "id": "4390",
           "text": "▁помощью",
           "special": false
         },
         {
           "id": "68740",
           "text": "▁пром",
           "special": false
         },
         {
           "id": "769",
           "text": "тов",
           "special": false
         },
         {
           "id": "125820",
           "text": ".",
           "special": false
         },
         {
           "id": "43429",
           "text": "▁Good",
           "special": false
         },
         {
           "id": "7146",
           "text": "тивный",
           "special": false
         },
         {
           "id": "68740",
           "text": "▁пром",
           "special": false
         },
         {
           "id": "125810",
           "text": "т",
           "special": false
         },
         {
           "id": "4923",
           "text": "▁должен",
           "special": false
         },
         {
           "id": "29443",
           "text": "▁содержать",
           "special": false
         },
         {
           "id": "24719",
           "text": "▁контек",
           "special": false
         },
         {
           "id": "269",
           "text": "ст",
           "special": false
         },
         {
           "id": "43640",
           "text": "▁запроса",
           "special": false
         },
         {
           "id": "355",
           "text": "▁(",
           "special": false
         },
         {
           "id": "98434",
           "text": "инструк",
           "special": false
         },
         {
           "id": "1511",
           "text": "цию",
           "special": false
         },
         {
           "id": "125855",
           "text": ")",
           "special": false
         },
         {
           "id": "571",
           "text": "▁для",
           "special": false
         },
         {
           "id": "6234",
           "text": "▁модели",
           "special": false
         },
         {
           "id": "286",
           "text": "▁и",
           "special": false
         },
         {
           "id": "15616",
           "text": "▁непосредственно",
           "special": false
         },
         {
           "id": "19633",
           "text": "▁задание",
           "special": false
         },
         {
           "id": "125827",
           "text": ",",
           "special": false
         },
         {
           "id": "6050",
           "text": "▁которое",
           "special": false
         },
         {
           "id": "7549",
           "text": "▁модель",
           "special": false
         },
         {
           "id": "7160",
           "text": "▁должна",
           "special": false
         },
         {
           "id": "18879",
           "text": "▁выполнить",
           "special": false
         },
         {
           "id": "125827",
           "text": ",",
           "special": false
         },
         {
           "id": "31323",
           "text": "▁учитывая",
           "special": false
         },
         {
           "id": "818",
           "text": "▁пере",
           "special": false
         },
         {
           "id": "56857",
           "text": "данный",
           "special": false
         },
         {
           "id": "24719",
           "text": "▁контек",
           "special": false
         },
         {
           "id": "269",
           "text": "ст",
           "special": false
         },
         {
           "id": "125820",
           "text": ".",
           "special": false
         },
         {
           "id": "10500",
           "text": "▁Чем",
           "special": false
         },
         {
           "id": "8504",
           "text": "▁конкре",
           "special": false
         },
         {
           "id": "93886",
           "text": "тнее",
           "special": false
         },
         {
           "id": "73199",
           "text": "▁составлен",
           "special": false
         },
         {
           "id": "68740",
           "text": "▁пром",
           "special": false
         },
         {
           "id": "125810",
           "text": "т",
           "special": false
         },
         {
           "id": "125827",
           "text": ",",
           "special": false
         },
         {
           "id": "1819",
           "text": "▁тем",
           "special": false
         },
         {
           "id": "1800",
           "text": "▁более",
           "special": false
         },
         {
           "id": "470",
           "text": "▁то",
           "special": false
         },
         {
           "id": "10969",
           "text": "чными",
           "special": false
         },
         {
           "id": "3315",
           "text": "▁будут",
           "special": false
         },
         {
           "id": "11306",
           "text": "▁результаты",
           "special": false
         },
         {
           "id": "1630",
           "text": "▁работы",
           "special": false
         },
         {
           "id": "6234",
           "text": "▁модели",
           "special": false
         },
         {
           "id": "125820",
           "text": ".",
           "special": false
         }
       ],
       "modelVersion": "23.10.2024"
     }
     ```
   
     {% endcut %}

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/yandexgpt/tokens.md)
* [{#T}](../../concepts/yandexgpt/index.md)
* Examples of working with ML SDK on [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/completions)