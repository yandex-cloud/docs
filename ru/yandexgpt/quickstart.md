# Как начать работать с {{ yagpt-full-name }}

В этом разделе вы научитесь использовать нейросеть для генерации текста.

О стоимости использования сервиса {{ yagpt-full-name }} см. [{#T}](pricing.md).

{% include notitle [preview-stage](../_includes/yandexgpt/preview.md) %}

## Перед началом работы {#before-begin}

Для работы из консоли управления подготовительные действия не требуются.

Чтобы воспользоваться примерами запроса через API, установите [cURL](https://curl.haxx.se). 

{% include notitle [ai-before-beginning](../_includes/yandexgpt/ai-before-beginning.md) %}

## Сгенерируйте текст {#generate-text}

{% note info %}

Чтобы повышать качество генерируемых ответов, {{ yagpt-full-name }} логирует промты пользователей. Не передавайте в запросах чувствительную информацию и персональные данные.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, на который у вашего аккаунта есть роль `{{ roles-yagpt-user }}` или выше.
  1. В списке сервисов выберите **{{ yagpt-name }}**.
  1. На панели слева выберите ![image](../_assets/console-icons/dice-3.svg) **{{ ui-key.yacloud.yagpt.label_promt }}**.
  1. В блоке **{{ ui-key.yacloud.yagpt.label_instruction-text }}** опишите контекст запроса.
  1. В блоке **{{ ui-key.yacloud.yagpt.label_request-text }}** опишите свой запрос к модели.
  1. В поле **{{ ui-key.yacloud.yagpt.label_temperature-text }}** укажите значение от `0` до `1`, которое определяет вариативность ответа модели: чем выше значение, тем более непредсказуемым будет результат выполнения запроса.
  1. Нажмите кнопку **{{ ui-key.yacloud.yagpt.label_button-instruct-submit }}**. Ответ отобразится в правой части экрана.

- API {#api}

  1. Создайте файл с телом запроса (например, `prompt.json`):

     ```json
     {
       "modelUri": "gpt://<идентификатор_каталога>/yandexgpt-lite",
       "completionOptions": {
         "stream": false,
         "temperature": 0.6,
         "maxTokens": "2000"
       },
       "messages": [
         {
           "role": "system",
           "text": "Найди ошибки в тексте и исправь их"
         },
         {
           "role": "user",
           "text": "Ламинат подойдет для укладке на кухне или в детской комнате – он не боиться влаги и механических повреждений благодаря защитному слою из облицованных меламиновых пленок толщиной 0,2 мм и обработанным воском замкам."
         }
       ]
     }
     ```

     Где:

     {% include [api-parameters](../_includes/yandexgpt/api-parameters.md) %}

  1. Отправьте запрос нейросети с помощью метода [completion](./api-ref/v1/TextGeneration/completion.md), выполнив команду:

     ```bash
     export FOLDER_ID=<идентификатор_каталога>
     export IAM_TOKEN=<IAM-токен>
     curl --request POST \
       -H "Content-Type: application/json" \
       -H "Authorization: Bearer ${IAM_TOKEN}" \
       -H "x-folder-id: ${FOLDER_ID}" \
       -d "@prompt.json" \
       "https://llm.{{ api-host }}/foundationModels/v1/completion"
     ```

     Где:

     * `FOLDER_ID`— идентификатор каталога, на который у вашего аккаунта есть роль `{{ roles-yagpt-user }}` или выше.
     * `IAM_TOKEN` — IAM-токен, полученный [перед началом работы](#before-begin).

     В ответе сервис вернет сгенерированный текст:

     ```json
     {
       "result": {
         "alternatives": [
           {
             "message": {
               "role": "assistant",
               "text": "Ламинат подходит для укладки на кухне и в детской комнате. Он не боится влажности и механических повреждений, благодаря защитному слою, состоящему из меланиновых плёнок толщиной 0.2 мм, и обработанным воском замкам."
             },
             "status": "ALTERNATIVE_STATUS_TRUNCATED_FINAL"
           }
         ],
         "usage": {
           "inputTextTokens": "67",
           "completionTokens": "50",
           "totalTokens": "117"
         },
         "modelVersion": "06.12.2023"
       }
     }
     ```

{% endlist %}

#### См. также {#see-also}

* [Узнайте подробнее о сервисе](concepts/index.md)
* [Прочитайте про способы аутентификации в API](api-ref/authentication.md)
