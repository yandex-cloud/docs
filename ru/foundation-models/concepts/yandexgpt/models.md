---
title: Модели генерации текста
description: Из статьи вы узнаете о моделях генерации текста, доступных в сервисе {{ foundation-models-name }}.
---

# Модели генерации текста

Сервис {{ foundation-models-full-name }} предоставляет доступ к большим текстовым моделям, разработанных разными компаниями. Если стандартных моделей вам недостаточно, вы можете [дообучить](../tuning/index.md) некоторые модели, чтобы они точнее отвечали на ваши запросы.

{% include [release-cycle](../../../_includes/foundation-models/release-cycle.md) %}

## Модели, доступные в синхронном и асинхронном режиме работы {#generation}

Для всех базовых моделей действуют правила обновления, описанные в разделе [Жизненный цикл модели](#model-lifecycle). При обновлении моделей поколения, доступные в разных ветках (сегменты `/latest`, `/rc` и `/deprecated`), могут меняться. Модифицированные модели делят [квоты](../limits.md#quotas) на использование со своими базовыми моделями.

#|
|| **Модель и URI** | **Поколение** | **Контекст** | **[Режимы работы](../index.md#working-mode)** ||
|| **{{ gpt-lite }}** </br>`gpt://<идентификатор_каталога>/yandexgpt-lite`	| Deprecated 4</br>Latest 5</br>RC 5 | {{ yagpt-max-tokens }}</br>32 000</br>32 000 | Асинхронный, синхронный ||
|| **{{ gpt-pro }}** </br>`gpt://<идентификатор_каталога>/yandexgpt` | Deprecated 4</br>Latest 5</br>RC 5 | {{ yagpt-max-tokens }}</br>32 000</br>32 000 | Асинхронный, синхронный ||
|| **{{ gpt-pro }} 32k**^1^ </br>`gpt://<идентификатор_каталога>/yandexgpt-32k`| Deprecated 4 | 32 000 | Синхронный ||
|| **{{ llama }} 8B**^2^ </br>`gpt://<идентификатор_каталога>/llama-lite` | Deprecated 3.1</br>Latest 3.1</br>RC 3.1 | 8 192 | Асинхронный, синхронный ||
|| **{{ llama }} 70B**^2^ </br>`gpt://<идентификатор_каталога>/llama` | Deprecated 3.3</br>Latest 3.3</br>RC 3.3 | 8 192 | Асинхронный, синхронный ||
|| [**Дообученные модели**](../tuning/index.md) </br>`gpt://<URI_базовой_модели>/<версия>@<суффикс_дообучения>` | Зависит от базовой модели | Зависит от базовой модели | Асинхронный, синхронный ||
|#

^1^ Модель {{ gpt-pro }} 32k обладает расширенным контекстом по сравнению с {{ gpt-pro }} 4 поколения. Модель создавалась специально для обработки больших текстов в синхронном режиме. Модели {{ gpt-pro }} 5 поколения совпадают по размеру контекста в синхронном и асинхронном режиме. Рекомендуем использовать их вместо устаревающей {{ gpt-pro }} 32k. 

^2^ {{ meta-disclaimer }}

## Модели, доступные в пакетном режиме работы {#batch}

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

## Обращение к моделям {#addressing-models}

Вы можете обращаться к моделям генерации текста разных версий несколькими способами.

{% list tabs group=programming_language %}

- SDK {#sdk}

  При работе с моделями генерации текста через [{{ ml-sdk-full-name }}](../../sdk/index.md) используйте один из следующих форматов:

  * **Название модели**, передается в виде строки. Доступны только версии `Latest`.

      ```python
      model = (
        sdk.models.completions("yandexgpt")
      )
      ```

  * **Название и версия модели**, передаются в виде строк в полях `model_name` и `model_version` соответственно.

      ```python
      model = (
        sdk.models.completions(model_name="yandexgpt-lite", model_version="rc")
      )
      ```

      В приведенном примере явно задана модель `{{ gpt-lite }}` версии `Release Candidate`.

  * **URI модели**, передается в виде строки, содержащей полный [URI](#generation) нужной версии модели. Также используйте этот способ для обращения к дообученным моделям.

      ```python
      model = (
        sdk.models.completions("gpt://b1gt6g8ht345********/llama/deprecated")
      )
      ```

      В приведенном примере явно задана модель `{{ llama }} 70B` версии `Deprecated` модели. 

- API {#curl}

  Чтобы [обратиться](../../operations/yandexgpt/create-prompt.md) к модели через [REST API](../../text-generation/api-ref/index.md) или [gRPC API](../../text-generation/api-ref/grpc/index.md), в поле `modelUri` тела запроса укажите [URI модели](#generation), содержащий [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md). Сегменты `/latest`, `/rc` и `/deprecated` указывают на [версию](#model-lifecycle) модели. По умолчанию используется сегмент `/latest`.

  **Примеры:**

  * Обращение к версии `Latest` модели `{{ gpt-lite }}`:

      ```json
      {
        "modelUri": "gpt://b1gt6g8ht345********/yandexgpt-lite/latest"
        ...
      }
      ```

      Для обращения к `Latest` версиям моделей необязательно задавать версию модели явно, поскольку версия `Latest` используется по умолчанию.
      
      Например, по данному URI также произойдет обращение к версии `Latest` модели `{{ gpt-lite }}`: `gpt://<идентификатор_каталога>/yandexgpt-lite`.

  * Обращение к версии `RC` модели `{{ llama }} 70B`:

      ```json
      {
        "modelUri": "gpt://b1gt6g8ht345********/llama/rc"
        ...
      }
      ```

{% endlist %}


#### См. также {#see-also}

* [{#T}](../../operations/yandexgpt/create-prompt.md)
* [{#T}](../../operations/yandexgpt/async-request.md)
