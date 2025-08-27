---
title: Дообучение моделей в {{ foundation-models-full-name }}
description: '{{ foundation-models-full-name }} позволяет дообучать по методу {{ lora }} модели генерации текста {{ gpt-lite }} и {{ llama }} 8B, а также классификаторы на базе {{ gpt-lite }}.'
---

# Дообучение моделей

{{ foundation-models-full-name }} позволяет дообучать по методу [{{ lora }}](https://arxiv.org/abs/2106.09685) (_Low-Rank Adaptation of Large Language Models_) модели генерации текста {{ gpt-lite }} и {{ llama }} 8B^1^, [классификаторы](../classifier/index.md) на базе {{ gpt-lite }} и модель [эмбеддингов](../embeddings.md).

_Дообучение моделей в {{ foundation-models-full-name }} находится на стадии [Preview](../../../overview/concepts/launch-stages.md)._

## Возможности дообучения моделей генерации текста {#tuning-abilities}

{% include [tuning-abilities](../../../_includes/foundation-models/yandexgpt/tuning-abilities.md) %}


## Процесс дообучения в {{ foundation-models-name }} {#fm-tuning}

Требования к данным для дообучения см. в разделах [{#T}](../resources/dataset.md#generating), [{#T}](../resources/dataset.md#classifier) и [{#T}](../resources/dataset.md#embeddings).

Подготовленные данные необходимо загрузить в {{ yandex-cloud }} в виде [_датасета_](../resources/dataset.md). По умолчанию вы можете загрузить до 5 ГБ данных для дообучения в один датасет. Со всеми ограничениями вы можете ознакомиться в разделе [{#T}](../limits.md).

После загрузки датасета запустите дообучение, указав его тип и, опционально, задав параметры. Дообучение займет от 1 часа до 1 суток в зависимости от объема данных и загруженности системы.

Примеры дообучения моделей доступны в разделах [{#T}](../../operations/tuning/create.md), [{#T}](../../operations/tuning/tune-classifiers.md) и [{#T}](../../operations/tuning/create-embeddings.md).

Для дообучения моделей в {{ foundation-models-name }} вам понадобится [роль](../../security/index.md) `ai.editor`. Она позволит загрузить данные и запустить дообучение.

## Запросы к дообученным моделям {#requests}

После завершения обучения вы получите идентификатор дообученной модели. Этот идентификатор нужно передавать в поле `modelUri` тела запроса. Обращаться к дообученной модели генерации текста можно через [API генерации текста](../../text-generation/api-ref/index.md), [{{ assistant-api }}](../../assistants/api-ref/grpc/Assistant/index.md), из {{ ml-platform-full-name }} и других приложений. Чтобы отправить запрос дообученному классификатору, используйте метод [classify](../../text-classification/api-ref/TextClassification/classify.md) Text Classification API. Вы также можете использовать [{{ ml-sdk-full-name }}](../../sdk/index.md) для работы с дообученными моделями. 

{% note info %}

Для корректной работы дообученной модели указывайте инструкцию, использованную при обучении, в сообщении с ролью отправителя `system`.

{% endnote %}

Чтобы отправлять запросы через API в ноутбуках [{{ ml-platform-name }}]({{ link-datasphere-main }}), добавьте пользовательский или сервисный аккаунт, от имени которого будут выполняться запросы, в список участников проекта {{ ml-platform-name }}. Аккаунт должен иметь роль `ai.languageModels.user`.

## Примеры использования {#examples}

* [{#T}](../../operations/tuning/create.md)
* [{#T}](../../operations/tuning/tune-classifiers.md)
* [{#T}](../../tutorials/models-fine-tuning.md)
* [{#T}](../../operations/resources/create-dataset-gpt.md)
* [{#T}](../../operations/resources/create-dataset-classifier.md)


^1^ {{ meta-disclaimer }}