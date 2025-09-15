---
title: Доступные генеративные модели
description: Из статьи вы узнаете о моделях генерации, доступных в сервисе {{ foundation-models-name }}.
---

# Доступные генеративные модели

Сервис {{ foundation-models-full-name }} предоставляет доступ к большим генеративным моделям, разработанным разными компаниями. Если стандартных моделей вам недостаточно, вы можете [дообучить](../tuning/index.md) некоторые модели, чтобы они точнее отвечали на ваши запросы.

## Модели, доступные в базовом инстансе {#generation}

Для всех базовых моделей действуют правила обновления, описанные в разделе [Жизненный цикл модели](#model-lifecycle). При обновлении моделей поколения, доступные в разных ветках (сегменты `/latest`, `/rc` и `/deprecated`), могут меняться. Модифицированные модели делят [квоты](../limits.md#quotas) на использование со своими базовыми моделями.

#|
|| **Модель и URI** | **Поколение** | **Контекст** | **[Режимы работы](../index.md#working-mode)** ||
|| **{{ gpt-lite }}** </br>`gpt://<идентификатор_каталога>/yandexgpt-lite`	| Deprecated 5</br>Latest 5</br>RC 5 | 32 000 | Асинхронный, синхронный ||
|| **{{ gpt-pro }}** </br>`gpt://<идентификатор_каталога>/yandexgpt` | Deprecated 5</br>Latest 5</br>RC 5.1 | 32 000 | Асинхронный, синхронный ||
|| **{{ llama }} 8B**^1^ </br>`gpt://<идентификатор_каталога>/llama-lite` | Deprecated 3.1</br>Latest 3.1</br>RC 3.1 | 8 192 | Асинхронный, синхронный ||
|| **{{ llama }} 70B**^1^ </br>`gpt://<идентификатор_каталога>/llama` | Deprecated 3.3</br>Latest 3.3</br>RC 3.3 | 8 192 | Асинхронный, синхронный ||
|| **Qwen3 235B** </br>`gpt://<идентификатор_каталога>/qwen3-235b-a22b-fp8/latest` | — | 256 000 | [{{ openai }} API](../openai-compatibility.md) ||
|| **gpt-oss-120b** </br>`gpt://<идентификатор_каталога>/gpt-oss-120b/latest` | — | 128 000 | [{{ openai }} API](../openai-compatibility.md) ||
|| **gpt-oss-20b** </br>`gpt://<идентификатор_каталога>/gpt-oss-20b/latest` | — | 128 000 | [{{ openai }} API](../openai-compatibility.md) ||  
|| [**Дообученные текстовые модели**](../tuning/index.md) </br>`gpt://<идентификатор_каталога>/<базовая_модель>/<версия>@<суффикс>` | Зависит от базовой модели | Зависит от базовой модели | Асинхронный, синхронный ||
|| **Gemma3 27B**
`gpt://<идентификатор_каталога>/gemma-3-27b-it/latest`
[Условия использования Gemma]({{ license-gemma }}) | — | 128 000 | [{{ openai }} API](../openai-compatibility.md) ||
|| **{{ yandexart-name }}** </br>`art://<идентификатор_каталога>/yandex-art/latest` | — | — | Асинхронный ||
|#

^1^ {{ meta-disclaimer }}

Модель Gemma 3 27B работает с изображениями в кодировке Base64. Модель может обрабатывать изображения с любым соотношением сторон благодаря адаптивному алгоритму, который масштабирует изображения до 896 пикселей по большей стороне, сохраняя важные визуальные детали. Каждое изображение использует 256 [токенов](./tokens.md) контекста.

{% include [release-cycle](../../../_includes/foundation-models/release-cycle.md) %}


## Модели, доступные в пакетном режиме работы {#batch}

### Модели генерации текста {#text-batch}

#|
|| **Модель** | **URI** | **Контекст** ||
|| **Qwen2.5 7B Instruct** 
[Карточка модели](https://huggingface.co/Qwen/Qwen2.5-7B-Instruct)
Лицензия [Apache 2.0]({{ license-apache }})  | `gpt://<идентификатор_каталога>/qwen2.5-7b-instruct` | 32 768 ||
|| **Qwen2.5 72B Instruct** 
[Карточка модели](https://huggingface.co/Qwen/Qwen2.5-72B-Instruct)
[Лицензия Qwen](https://huggingface.co/Qwen/Qwen2.5-72B-Instruct/blob/main/LICENSE)  | `gpt://<идентификатор_каталога>/qwen2.5-72b-instruct` | 16 384 ||
|| **QwQ 32B Instruct** 
[Карточка модели](https://huggingface.co/Qwen/QwQ-32B)
Лицензия [Apache 2.0]({{ license-apache }}) | `gpt://<идентификатор_каталога>/qwq-32b` | 32 768 ||
|| **Llama-3.3-70B-Instruct**^2^ 
[Карточка модели](https://huggingface.co/meta-llama/Llama-3.3-70B-Instruct)
[Лицензия Llama 3.3](https://huggingface.co/meta-llama/Llama-3.3-70B-Instruct/blob/main/LICENSE) | `gpt://<идентификатор_каталога>/llama3.3-70b-instruct` | 8 192 ||
|| **Llama-3.1-70B-Instruct**^2^
[Карточка модели](https://huggingface.co/meta-llama/Llama-3.1-70B-Instruct)
[Лицензия Llama 3.1](https://huggingface.co/meta-llama/Llama-3.1-70B-Instruct/blob/main/LICENSE)  | `gpt://<идентификатор_каталога>/llama3.1-70b-instruct` | 8 192 ||
|| **DeepSeek-R1-Distill-Llama-70B** 
[Карточка модели](https://huggingface.co/deepseek-ai/DeepSeek-R1-Distill-Llama-70B)
Лицензия [MIT]({{ license-mit }})
Основана на модели Llama-3.3-70B-Instruct. [Условия использования Llama-3.3-70B-Instruct](https://huggingface.co/meta-llama/Llama-3.3-70B-Instruct/blob/main/LICENSE) | `gpt://<идентификатор_каталога>/deepseek-r1-distill-llama-70b` | 8 192 ||
|| **Qwen2.5 32B Instruct** 
[Карточка модели](https://huggingface.co/Qwen/Qwen2.5-32B-Instruct)
Лицензия [Apache 2.0]({{ license-apache }}) | `gpt://<идентификатор_каталога>/qwen2.5-32b-instruct` | 32 768 ||
|| **DeepSeek-R1-Distill-Qwen-32B** 
[Карточка модели](https://huggingface.co/deepseek-ai/DeepSeek-R1-Distill-Qwen-32B)
Лицензия [MIT]({{ license-mit }}) | `gpt://<идентификатор_каталога>/deepseek-r1-distill-qwen-32b` | 32 768 ||
|| **phi-4** 
[Карточка модели](https://huggingface.co/microsoft/phi-4)
Лицензия [MIT]({{ license-mit }})  | `gpt://<идентификатор_каталога>/phi-4` | 16 384 ||
|| **Gemma3 1B it**
[Карточка модели](https://huggingface.co/google/gemma-3-1b-it)
[Условия использования Gemma]({{ license-gemma }}) | `gpt://<идентификатор_каталога>/gemma-3-1b-it` | 32 768 ||
|| **Gemma3 4B it**
[Карточка модели](https://huggingface.co/google/gemma-3-4b-it)
[Условия использования Gemma]({{ license-gemma }}) | `gpt://<идентификатор_каталога>/gemma-3-4b-it` | 131 072 ||
|| **Gemma3 12B it**
[Карточка модели](https://huggingface.co/google/gemma-3-4b-it)
[Условия использования Gemma]({{ license-gemma }}) | `gpt://<идентификатор_каталога>/gemma-3-12b-it` | 65 536 ||
|| **Gemma3 27B it**
[Карточка модели](https://huggingface.co/google/gemma-3-4b-it)
[Условия использования Gemma]({{ license-gemma }}) | `gpt://<идентификатор_каталога>/gemma-3-27b-it` | 32 768 ||
|| **Qwen3-0.6B** 
[Карточка модели](https://huggingface.co/Qwen/Qwen3-0.6B)
Лицензия [Apache 2.0]({{ license-apache }}) | `gpt://<идентификатор_каталога>/qwen3-0.6b` | 32 768 ||
|| **Qwen3-1.7B** 
[Карточка модели](https://huggingface.co/Qwen/Qwen3-1.7B)
Лицензия [Apache 2.0]({{ license-apache }}) | `gpt://<идентификатор_каталога>/qwen3-1.7b` | 32 768 ||
|| **Qwen3-4B** 
[Карточка модели](https://huggingface.co/Qwen/Qwen3-4B)
Лицензия [Apache 2.0]({{ license-apache }}) | `gpt://<идентификатор_каталога>/qwen3-4b` | 32 768 ||
|| **Qwen3-8B** 
[Карточка модели](https://huggingface.co/Qwen/Qwen3-8B)
Лицензия [Apache 2.0]({{ license-apache }}) | `gpt://<идентификатор_каталога>/qwen3-8b` | 32 768 ||
|| **Qwen3-14B** 
[Карточка модели](https://huggingface.co/Qwen/Qwen3-14B)
Лицензия [Apache 2.0]({{ license-apache }}) | `gpt://<идентификатор_каталога>/qwen3-14b` | 32 768 ||
|| **Qwen3-32B** 
[Карточка модели](https://huggingface.co/Qwen/Qwen3-32B)
Лицензия [Apache 2.0]({{ license-apache }}) | `gpt://<идентификатор_каталога>/qwen3-32b` | 32 768 ||
|| **Qwen3-30B-A3B** 
[Карточка модели](https://huggingface.co/Qwen/Qwen3-30B-A3B)
Лицензия [Apache 2.0]({{ license-apache }}) | `gpt://<идентификатор_каталога>/qwen3-30b-a3b` | 32 768 ||
|| **Qwen3-235B-A22B** 
[Карточка модели](https://huggingface.co/Qwen/Qwen3-235B-A22B)
Лицензия [Apache 2.0]({{ license-apache }}) | `gpt://<идентификатор_каталога>/qwen3-235b-a22b` | 32 768 ||
|#

^2^ {{ meta-disclaimer }}

### Multimodal models {#multimodels-batch}

#|
|| **Модель** | **URI** | **Контекст** ||
|| **Qwen2 VL 7B**</br>[Карточка модели](https://huggingface.co/Qwen/Qwen2-VL-7B-Instruct)</br>Лицензия [Apache 2.0]({{ license-apache }}) | `gpt://<идентификатор_каталога>/qwen2-vl-7b-instruct/` | 4096 ||
|| **Qwen2.5 VL 7B**</br>[Карточка модели](https://huggingface.co/Qwen/Qwen2.5-VL-7B-Instruct)</br>Лицензия [Apache 2.0]({{ license-apache }})  | `gpt://<идентификатор_каталога>/qwen2.5-vl-7b-instruct/` | 4096 ||
|| **Qwen 2.5 VL 32B Instruct**</br>[Карточка модели](https://huggingface.co/Qwen/Qwen2.5-VL-32B-Instruct)</br>Лицензия [Apache 2.0]({{ license-apache }}) | `gpt://<идентификатор_каталога>/qwen2.5-vl-32b-instruct/` | 4096 ||
|| **DeepSeek VL2**</br>[Карточка модели](https://huggingface.co/deepseek-ai/deepseek-vl2)</br>[Лицензия DeepSeek](https://github.com/deepseek-ai/DeepSeek-LLM/blob/HEAD/LICENSE-MODEL) | `gpt://<идентификатор_каталога>/deepseek-vl2/` | 4096 ||
|| **DeepSeek VL2 Tiny**</br>[Карточка модели](https://huggingface.co/deepseek-ai/deepseek-vl2-tiny)</br>[Лицензия DeepSeek](https://github.com/deepseek-ai/DeepSeek-LLM/blob/HEAD/LICENSE-MODEL) | `gpt://<идентификатор_каталога>/deepseek-vl2-tiny/` | 4096 ||
|| **Gemma3 4B it**</br>[Карточка модели](https://huggingface.co/google/gemma-3-4b-it)</br>[Условия использования Gemma]({{ license-gemma }}) | `gpt://<идентификатор_каталога>/gemma-3-4b-it/` | 4096 ||
|| **Gemma3 12B it**</br>[Карточка модели](https://huggingface.co/google/gemma-3-12b-it)</br>[Условия использования Gemma]({{ license-gemma }}) | `gpt://<идентификатор_каталога>/gemma-3-12b-it/` | 4096 ||
|| **Gemma3 27B it**</br>[Карточка модели](https://huggingface.co/google/gemma-3-27b-it)</br>[Условия использования Gemma]({{ license-gemma }}) | `gpt://<идентификатор_каталога>/gemma-3-27b-it/` | 4096 ||
|# 

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
      sdk.models.completions("gpt://b1gt6g8ht345********/llama/deprecated")
    )

    # Генерация изображений 
    model = (
      sdk.models.image_generation("art://b1gt6g8ht345********/yandex-art/latest")
    )
    ```

      В приведенном примере явно заданы модели `{{ llama }} 70B` версии `Deprecated` и `{{ yandexart-name }}` версии `Latest`. 

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
