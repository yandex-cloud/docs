---
title: Как узнать размер запроса в токенах
description: Следуя данной инструкции, вы научитесь определять размер запросов к моделям {{ gpt-lite }} и {{ gpt-pro }} в токенах.
---

# Оценить размер в токенах

Нейросети работают с текстами, представляя слова и предложения в виде [токенов](../../concepts/generation/tokens.md).

{{ foundation-models-name }} использует свой токенизатор для обработки текстов. Чтобы рассчитать размер текста или запроса к модели {{ yagpt-name }} в токенах, используйте методы [Tokenize](../../text-generation/api-ref/Tokenizer/index.md) API генерации текста или [{{ ml-sdk-full-name }}](../../sdk/index.md).

Число токенов в одном и том же тексте может различаться для каждой [модели](../../concepts/generation/models.md).

## Перед началом работы {#before-begin}

Чтобы воспользоваться примерами:

{% list tabs group=programming_language %}

- SDK {#sdk}

  {% include [sdk-before-begin-ai-langmodel-user](../../../_includes/ai-studio/sdk-before-begin-ai-langmodel-user.md) %}

- cURL {#curl}

  {% include [ai-before-beginning](../../../_includes/ai-studio/yandexgpt/ai-before-beginning.md) %}

  {% include [curl](../../../_includes/curl.md) %}

{% endlist %}

## Рассчитать размер запроса {#evaluate}

В приведенном примере оценивается размер запроса к модели {{ yagpt-name }}.

{% list tabs group=programming_language %}

- SDK {#sdk}

  1. Создайте файл `token.py` и добавьте в него следующий код:

      {% include [yandexgpt-tokenize-sdk](../../../_includes/ai-studio/examples/yandexgpt-tokenize-sdk.md) %}

      Где:

      {% note info %}

      {% include [sdk-input-format](../../../_includes/ai-studio/sdk-input-format.md) %}

      {% endnote %}

      * `messages` — текстовое содержимое сообщения.

      {% include [sdk-code-legend](../../../_includes/ai-studio/examples/sdk-code-legend.md) %}

      * `model` — URI модели. Подробнее см. в разделе [{#T}](../../sdk-ref/sync/chat/completions#yandex_ai_studio_sdk._chat.completions.function.ChatCompletions.md).

  1. Выполните созданный файл:

      ```bash
      python3 token.py
      ```

      Результат выполнения запроса содержит список всех полученных токенов. 

      
      {% cut "Результат" %}

      {% include [token-result](../../../_untranslatable/ai-studio/tokens-result-ru.md) %}

      {% endcut %}




- cURL {#curl}

  1. Создайте файл `tbody.json`, содержащий параметры запроса:
  
     ```json
     {
       "modelUri": "gpt://<идентификатор_каталога>/yandexgpt",
       "text": "Управление генеративными моделями осуществляется с помощью промптов. Эффективный промпт должен содержать контекст запроса (инструкцию) для модели и непосредственно задание, которое модель должна выполнить, учитывая переданный контекст. Чем конкретнее составлен промпт, тем более точными будут результаты работы модели."
     }
     ```
  
     {% include [folder-id](../../../_includes/ai-studio/yandexgpt/folder-id.md) %}
  
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
  
     Результат выполнения запроса содержит список всех полученных токенов. 

     
     {% cut "Результат" %}

     {% include [token-result](../../../_untranslatable/ai-studio/tokens-result-ru.md) %}

     {% endcut %}



{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/generation/tokens.md)
* [{#T}](../../concepts/generation/index.md)
* Примеры работы с {{ ml-sdk-name }} на [GitHub](https://github.com/yandex-cloud/yandex-ai-studio-sdk/tree/master/examples/sync/completions)