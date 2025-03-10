---
title: Как узнать размер запроса в токенах
description: Следуя данной инструкции, вы научитесь определять размер запросов к моделям {{ gpt-lite }} и {{ gpt-pro }} в токенах.
---

# Оценить размер в токенах

Нейросети работают с текстами, представляя слова и предложения в виде [токенов](../../concepts/yandexgpt/tokens.md).

{{ foundation-models-name }} использует свой токенизатор для обработки текстов. Чтобы рассчитать размер текста или запроса к модели {{ yagpt-name }} в токенах, используйте методы [Tokenize](../../text-generation/api-ref/Tokenizer/index.md) API генерации текста или [{{ ml-sdk-full-name }}](../../sdk/index.md).

Число токенов в одном и том же тексте может различаться для каждой [модели](../../concepts/yandexgpt/models.md).

## Перед началом работы {#before-begin}

Чтобы воспользоваться примерами:

{% list tabs group=programming_language %}

- SDK {#sdk}

  {% include [sdk-before-begin-ai-langmodel-user](../../../_includes/foundation-models/sdk-before-begin-ai-langmodel-user.md) %}

- cURL {#curl}

  {% include [ai-before-beginning](../../../_includes/foundation-models/yandexgpt/ai-before-beginning.md) %}

  {% include [curl](../../../_includes/curl.md) %}

{% endlist %}

## Рассчитать размер запроса {#evaluate}

В приведенном примере оценивается размер запроса к модели {{ yagpt-name }}.

{% list tabs group=programming_language %}

- SDK {#sdk}

  1. Создайте файл `tokenize.py` и добавьте в него следующий код:

      {% include [yandexgpt-tokenize-sdk](../../../_includes/foundation-models/examples/yandexgpt-tokenize-sdk.md) %}

      Где:

      {% note info %}

      {% include [sdk-input-format](../../../_includes/foundation-models/sdk-input-format.md) %}

      {% endnote %}

      * `messages` — текстовое содержимое сообщения.

      {% include [sdk-code-legend](../../../_includes/foundation-models/examples/sdk-code-legend.md) %}

      * `model` — значение версии модели. Подробнее см. в разделе [{#T}](../../concepts/yandexgpt/models.md#addressing-models).

  1. Выполните созданный файл:

      ```bash
      python3 tokenize.py
      ```

      {% cut "Результат выполнения запроса — список полученных токенизатором токенов:" %}

      ```text
      {"tokens":
        [{"id":"1","text":"\u003cs\u003e","special":true},
        {"id":"19078","text":"▁Управление","special":false},
        {"id":"10810","text":"▁генера","special":false},
        {"id":"26991","text":"тивными","special":false},
        {"id":"77514","text":"▁моделями","special":false},
        {"id":"10578","text":"▁осуществляется","special":false},
        {"id":"277","text":"▁с","special":false},
        {"id":"4390","text":"▁помощью","special":false},
        {"id":"68740","text":"▁пром","special":false},
        {"id":"769","text":"тов","special":false},
        {"id":"125820","text":".","special":false},
        {"id":"43429","text":"▁Эффек","special":false},
        {"id":"7146","text":"тивный","special":false},
        {"id":"68740","text":"▁пром","special":false},
        {"id":"125810","text":"т","special":false},
        {"id":"4923","text":"▁должен","special":false},
        {"id":"29443","text":"▁содержать","special":false},
        {"id":"24719","text":"▁контек","special":false},
        {"id":"269","text":"ст","special":false},
        {"id":"43640","text":"▁запроса","special":false},
        {"id":"355","text":"▁(","special":false},
        {"id":"98434","text":"инструк","special":false},
        {"id":"1511","text":"цию","special":false},
        {"id":"125855","text":")","special":false},
        {"id":"571","text":"▁для","special":false},
        {"id":"6234","text":"▁модели","special":false},
        {"id":"286","text":"▁и","special":false},
        {"id":"15616","text":"▁непосредственно","special":false},
        {"id":"19633","text":"▁задание","special":false},
        {"id":"125827","text":",","special":false},
        {"id":"6050","text":"▁которое","special":false},
        {"id":"7549","text":"▁модель","special":false},
        {"id":"7160","text":"▁должна","special":false},
        {"id":"18879","text":"▁выполнить","special":false},
        {"id":"125827","text":",","special":false},
        {"id":"31323","text":"▁учитывая","special":false},
        {"id":"818","text":"▁пере","special":false},
        {"id":"56857","text":"данный","special":false},
        {"id":"24719","text":"▁контек","special":false},
        {"id":"269","text":"ст","special":false},
        {"id":"125820","text":".","special":false},
        {"id":"10500","text":"▁Чем","special":false},
        {"id":"8504","text":"▁конкре","special":false},
        {"id":"93886","text":"тнее","special":false},
        {"id":"73199","text":"▁составлен","special":false},
        {"id":"68740","text":"▁пром","special":false},
        {"id":"125810","text":"т","special":false},
        {"id":"125827","text":",","special":false},
        {"id":"1819","text":"▁тем","special":false},
        {"id":"1800","text":"▁более","special":false},
        {"id":"470","text":"▁то","special":false},
        {"id":"10969","text":"чными","special":false},
        {"id":"3315","text":"▁будут","special":false},
        {"id":"11306","text":"▁результаты","special":false},
        {"id":"1630","text":"▁работы","special":false},
        {"id":"6234","text":"▁модели","special":false},
        {"id":"125820","text":".","special":false}],
      "modelVersion":"23.10.2024"
      }
      ```

      {% endcut %}

- cURL {#curl}

  1. Создайте файл `tbody.json`, содержащий параметры запроса:
  
     ```json
     {
       "modelUri": "gpt://<идентификатор_каталога>/yandexgpt",
       "text": "Управление генеративными моделями осуществляется с помощью промтов. Эффективный промт должен содержать контекст запроса (инструкцию) для модели и непосредственно задание, которое модель должна выполнить, учитывая переданный контекст. Чем конкретнее составлен промт, тем более точными будут результаты работы модели."
     }
     ```
  
     {% include [folder-id](../../../_includes/foundation-models/yandexgpt/folder-id.md) %}
  
  1. Отправьте запрос к модели:
  
     ```bash
     export IAM_TOKEN=<IAM-токен>
     curl --request POST \
       --header "Authorization: Bearer ${IAM_TOKEN}" \
       --data "@tbody.json" \
       "https://llm.api.cloud.yandex.net/foundationModels/v1/tokenize"
     ```
  
     Где:
  
     * `<IAM-токен>` — значение [IAM-токена](../../../iam/concepts/authorization/iam-token.md), полученного для вашего аккаунта.
     * `tbody.json` — файл в формате JSON, содержащий параметры запроса.
  
     {% cut "Результат выполнения запроса — список полученных токенизатором токенов:" %}
     
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
           "text": "▁Эффек",
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

#### См. также {#see-also}

* [{#T}](../../concepts/yandexgpt/tokens.md)
* [{#T}](../../concepts/yandexgpt/index.md)
* Примеры работы с ML SDK на [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/completions)