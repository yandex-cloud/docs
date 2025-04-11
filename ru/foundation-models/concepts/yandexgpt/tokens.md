# Токены

Нейросети работают с текстами, представляя слова и предложения в виде _токенов_ — смысловых отрывков или часто встречающихся последовательностей символов, характерных для естественного языка. Токены позволяют нейросетям находить закономерности и обрабатывать естественный язык.

{{ foundation-models-full-name }} использует свой токенизатор для обработки текстов. Вы можете [оценить](../../operations/yandexgpt/evaluate-request.md) размер текстового поля в токенах с помощью специальных методов [Tokenizer](../../text-generation/api-ref/Tokenizer/index.md) или [{{ ml-sdk-full-name }}](../../sdk/index.md). Число токенов в одном и том же тексте может различаться для каждой [модели](./models.md).

Чтобы использовать токенизатор {{ foundation-models-full-name }}, необходима [роль](../../security/index.md#languageModels-user) `ai.languageModels.user` или выше на [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder).

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
   
   {% include [token-result](../../../_untranslatable/foundation-models/tokens-result-en.md) %}
 
   {% endcut %}


