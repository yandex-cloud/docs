# Токены

Нейросети работают с текстами, представляя слова и предложения в виде _токенов_ — смысловых отрывков или часто встречающихся последовательностей символов, характерных для естественного языка. Токены позволяют нейросетям находить закономерности и обрабатывать естественный язык.

{{ yagpt-full-name }} использует свой токенизатор для обработки текстов. Вы можете [оценить](../../operations/yandexgpt/evaluate-request.md) размер текстового поля в токенах с помощью специальных методов [Tokenizer](../../text-generation/api-ref/Tokenizer/index.md) или [{{ ml-sdk-full-name }}](../../sdk/index.md). Число токенов в одном и том же тексте может различаться для каждой [модели](./models.md).

Чтобы использовать токенизатор {{ yagpt-full-name }}, необходима [роль](../../security/index.md#languageModels-user) `ai.languageModels.user` или выше на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).

## Пример {#example}

### Параметры запроса на русском языке {#params-ru}

* **Текст промта**: Управление генеративными моделями осуществляется с помощью промтов. Эффективный промт должен содержать контекст запроса (инструкцию) для модели и непосредственно задание, которое модель должна выполнить, учитывая переданный контекст. Чем конкретнее составлен промт, тем более точными будут результаты работы модели.\n Кроме промта на результаты генерации моделей будут влиять и другие параметры запроса. Используйте AI Playground, доступный в консоли управления, чтобы протестировать ваши запросы.
* **Количество символов в промте**: 497.
* **Количество токенов в промте**: 86.
* **Модель**: {{ gpt-pro }}.

### Параметры запроса на английском языке {#params-en}

* **Текст промта**: Generative models are managed using prompts. A good prompt should contain the context of your request to the model (instruction) and the actual task the model should complete based on the provided context. The more specific your prompt, the more accurate will be the results returned by the model.\n Apart from the prompt, other request parameters will impact the model's output too. Use Foundation Models Playground available from the management console to test your requests.
* **Количество символов в промте**: 477.
* **Количество токенов в промте**: 89.
* **Модель**: {{ gpt-pro }}.

### Структура запроса {#structure}

1. Создайте файл `tbody.json`, содержащий параметры запроса:

   ```json
   {
     "modelUri": "gpt://<идентификатор_каталога>/yandexgpt",
     "text": "Управление генеративными моделями осуществляется с помощью промтов. Эффективный промт должен содержать контекст запроса (инструкцию) для модели и непосредственно задание, которое модель должна выполнить, учитывая переданный контекст. Чем конкретнее составлен промт, тем более точными будут результаты работы модели.\n Кроме промта на результаты генерации моделей будут влиять и другие параметры запроса. Используйте AI Playground, доступный в консоли управления, чтобы протестировать ваши запросы."
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


   {% cut "Результат" %}
   
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
       },
       {
         "id": "3",
         "text": "[NL]",
         "special": true
       },
       {
         "id": "8816",
         "text": "▁Кроме",
         "special": false
       },
       {
         "id": "68740",
         "text": "▁пром",
         "special": false
       },
       {
         "id": "330",
         "text": "та",
         "special": false
       },
       {
         "id": "324",
         "text": "▁на",
         "special": false
       },
       {
         "id": "11306",
         "text": "▁результаты",
         "special": false
       },
       {
         "id": "103637",
         "text": "▁генерации",
         "special": false
       },
       {
         "id": "16028",
         "text": "▁моделей",
         "special": false
       },
       {
         "id": "3315",
         "text": "▁будут",
         "special": false
       },
       {
         "id": "54120",
         "text": "▁влиять",
         "special": false
       },
       {
         "id": "286",
         "text": "▁и",
         "special": false
       },
       {
         "id": "3669",
         "text": "▁другие",
         "special": false
       },
       {
         "id": "16564",
         "text": "▁параметры",
         "special": false
       },
       {
         "id": "43640",
         "text": "▁запроса",
         "special": false
       },
       {
         "id": "125820",
         "text": ".",
         "special": false
       },
       {
         "id": "38756",
         "text": "▁Используйте",
         "special": false
       },
       {
         "id": "15418",
         "text": "▁AI",
         "special": false
       },
       {
         "id": "118637",
         "text": "▁Playground",
         "special": false
       },
       {
         "id": "125827",
         "text": ",",
         "special": false
       },
       {
         "id": "58115",
         "text": "▁доступный",
         "special": false
       },
       {
         "id": "273",
         "text": "▁в",
         "special": false
       },
       {
         "id": "43319",
         "text": "▁консоли",
         "special": false
       },
       {
         "id": "5320",
         "text": "▁управления",
         "special": false
       },
       {
         "id": "125827",
         "text": ",",
         "special": false
       },
       {
         "id": "1387",
         "text": "▁чтобы",
         "special": false
       },
       {
         "id": "114781",
         "text": "▁протестировать",
         "special": false
       },
       {
         "id": "8523",
         "text": "▁ваши",
         "special": false
       },
       {
         "id": "39192",
         "text": "▁запросы",
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


