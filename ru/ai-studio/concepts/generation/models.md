---
title: Доступные генеративные модели
description: Из статьи вы узнаете о моделях генерации, доступных в сервисе {{ foundation-models-name }}.
---

# Модели базового инстанса

Сервис {{ foundation-models-full-name }} предоставляет доступ к большим генеративным моделям, разработанных разными компаниями. Если стандартных моделей вам недостаточно, вы можете [дообучить](../tuning/index.md) некоторые модели, чтобы они точнее отвечали на ваши запросы. Все роли, необходимые для работы с моделями, перечислены в разделе [{#T}](../../security/index.md).

В базовом инстансе ресурсы модели доступны всем пользователям {{ yandex-cloud }} и делятся между ними, поэтому при большой нагрузке время работы моделей может увеличиваться. При этом другие пользователи гарантированно не могут получить доступ к контексту ваших переписок с моделью: даже при включенном режиме логирования запросы хранятся в обезличенном виде, а потенциально чувствительная информация маскируется. Однако если вы обрабатываете конфиденциальную информацию с помощью моделей, рекомендуем [отключать](../../operations/disable-logging.md) логирование данных.

Для моделей базового инстанса действуют правила обновления, описанные в разделе [Жизненный цикл модели](#model-lifecycle). При обновлении моделей поколения, доступные в разных ветках (сегменты `/latest`, `/rc` и `/deprecated`), могут меняться. Модифицированные модели делят [квоты](../limits.md#quotas) на использование со своими базовыми моделями.

#|
|| **Модель и URI** | **Контекст** | **Доступные API** ||
|| **{{ alice-ai }}** </br>`gpt://<идентификатор_каталога>/aliceai-llm`       | 32 768 | API генерации текста, {{ openai }}-совместимые API ||
|| **{{ gpt-pro }} 5.1** </br>`gpt://<идентификатор_каталога>/yandexgpt/rc`   | 32 768 | API генерации текста, {{ openai }}-совместимые API ||
|| **{{ gpt-pro }} 5** </br>`gpt://<идентификатор_каталога>/yandexgpt/latest` | 32 768 | API генерации текста, {{ openai }}-совместимые API ||
|| **{{ gpt-lite }} 5** </br>`gpt://<идентификатор_каталога>/yandexgpt-lite`	| 32 768 | API генерации текста, {{ openai }}-совместимые API ||
|| **Qwen3 235B** </br>`gpt://<идентификатор_каталога>/qwen3-235b-a22b-fp8/latest` | 262 144 | {{ openai }}-совместимые API ||
|| **gpt-oss-120b** </br>`gpt://<идентификатор_каталога>/gpt-oss-120b/latest` | 131 072 | {{ openai }}-совместимые API ||
|| **gpt-oss-20b** </br>`gpt://<идентификатор_каталога>/gpt-oss-20b/latest` | 131 072 | {{ openai }}-совместимые API ||  
|| [**Дообученная {{ gpt-lite }}**](../tuning/index.md) </br>`gpt://<идентификатор_каталога>/yandexgpt-lite/latest@<суффикс>` | 32 768 | API генерации текста, {{ openai }}-совместимые API ||
|| **Gemma 3 27B**
`gpt://<идентификатор_каталога>/gemma-3-27b-it/latest`
[Условия использования Gemma]({{ license-gemma }}) | 131 072 | {{ openai }}-совместимые API ||
|| **{{ yandexart-name }}** </br>`art://<идентификатор_каталога>/yandex-art/latest` | 500 символов | API генерации изображений ||
|#  

Модель Gemma 3 27B работает с изображениями в кодировке Base64. Модель может обрабатывать изображения с любым соотношением сторон благодаря адаптивному алгоритму, который масштабирует изображения до 896 пикселей по большей стороне, сохраняя важные визуальные детали. Каждое изображение использует 256 [токенов](./tokens.md) контекста.

{% include [release-cycle](../../../_includes/ai-studio/release-cycle.md) %}

## Обращение к моделям {#addressing-models}

Вы можете обращаться к моделям генерации текста разных версий несколькими способами.

{% list tabs group=programming_language %}

- SDK {#sdk}

  При работе с моделями генерации текста через [{{ ml-sdk-full-name }}](../../sdk/index.md) используйте один из следующих форматов:

  * **Название модели**, передается в виде строки. Доступны только версии `Latest`.

    ```python
    # Генерация текста
    model = (
      sdk.models.completions("yandexgpt")
    )

    # Генерация изображений 
    model = (
      sdk.models.image_generation("yandex-art")
    )
    ```

  * **Название и версия модели**, передаются в виде строк в полях `model_name` и `model_version` соответственно.

    ```python
    # Генерация текста
    model = (
      sdk.models.completions(model_name="yandexgpt-lite", model_version="rc")
    )

    # Генерация изображений 
    model = (
      sdk.models.image_generation(model_name="yandex-art", model_version="latest")
    )
    ```

    В приведенном примере явно заданы модели `{{ gpt-lite }}` версии `Release Candidate` и `{{ yandexart-name }}` версии `Latest`.

  * **URI модели**, передается в виде строки, содержащей полный [URI](#generation) нужной версии модели. Также используйте этот способ для обращения к дообученным моделям.

    ```python
    # Генерация текста
    model = (
      sdk.models.completions("gpt://b1gt6g8ht345********/yandexgpt/deprecated")
    )

    # Генерация изображений 
    model = (
      sdk.models.image_generation("art://b1gt6g8ht345********/yandex-art/latest")
    )
    ```

      В приведенном примере явно заданы модели `{{ gpt-pro }}` версии `Deprecated` и `{{ yandexart-name }}` версии `Latest`. 

- API {#curl}

  Чтобы [обратиться](../../operations/generation/create-prompt.md) к моделям {{ yagpt-name }} через [REST API](../../text-generation/api-ref/index.md) или [gRPC API](../../text-generation/api-ref/grpc/index.md), в поле `modelUri` тела запроса укажите [URI модели](#generation), содержащий [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md). Сегменты `/latest`, `/rc` и `/deprecated` указывают на [версию](#model-lifecycle) модели. По умолчанию используется сегмент `/latest`.

  Для [обращения](../../operations/generation/yandexart-request.md) к модели {{ yandexart-name }} через [REST API](../../image-generation/api-ref/index.md) или [gRPC API](../../image-generation/api-ref/grpc/index.md), в поле `modelUri` тела запроса укажите URI модели, содержащий [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md). Сегмент `/latest` указывает на версию модели и является необязательным.

  * Обращение к версиям `Latest`:

    ```json
    {

      "modelUri": "gpt://b1gt6g8ht345********/yandexgpt-lite/latest"
      ...

      "modelUri": "art://b1gt6g8ht345********/yandex-art/latest"
    }
    ```

  * Обращение к версии `RC` (при наличии):
  
    ```json
    {

      "modelUri": "gpt://b1gt6g8ht345********/yandexgpt-lite/rc"
      ...
    }
    ```
    
{% endlist %}

#### См. также {#see-also}

* [{#T}](../../operations/generation/create-prompt.md)
* [{#T}](../../operations/generation/async-request.md)
* [{#T}](../../operations/generation/yandexart-request.md)
* [{#T}](../../operations/batch/create.md)