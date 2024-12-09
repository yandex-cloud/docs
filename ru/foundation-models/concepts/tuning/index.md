# Дообучение моделей

{{ yandex-cloud }} предоставляет несколько способов дообучения моделей генерации текста и классификации на базе {{ yagpt-name }}:

* дообучение по методу [{{ lora }}](https://arxiv.org/abs/2106.09685) (_Low-Rank Adaptation of Large Language Models_) для моделей {{ gpt-lite }} и {{ llama }} 8b^1^;
* дообучение классификаторов на базе {{ yagpt-name }} в {{ ml-platform-full-name }}.

_Дообучение моделей по методу {{ lora }} находится на стадии [Preview](../../../overview/concepts/launch-stages.md) и предоставляется по запросу. Вы можете заполнить заявку в [консоли управления]({{ link-console-main }}link/foundation-models/)._

_Дообучение классификаторов в {{ ml-platform-name }} находится на стадии [Preview](../../../overview/concepts/launch-stages.md) и доступно всем._

{% note info %}

В ближайшее время для дообучения классификаторов появится новый инструмент, а дообучение {{ ml-platform-name }} станет недоступно. Модели и классификаторы, дообученные в {{ ml-platform-name }} ранее, остаются доступными для использования.

{% endnote %}

## Возможности дообучения моделей генерации текста {#tuning-abilities}

{% include [tuning-abilities](../../../_includes/foundation-models/yandexgpt/tuning-abilities.md) %}

## Данные для дообучения моделей генерации текста {#generation-data}

{% include [logging](../../../_includes/foundation-models/yandexgpt/logging-disclaimer.md) %}

{% include [fine-tuning-file-requirements](../../../_includes/datasphere/fine-tuning-file-requirements.md) %}

## Дообучение в {{ foundation-models-name }} {#fm-tuning}

Подготовленные данные необходимо загрузить в {{ yandex-cloud }} в виде [_датасета_](../../dataset/api-ref/grpc/index.md). По умолчанию вы можете загрузить до 5 ГБ данных для дообучения в один датасет. Со всеми ограничениями вы можете ознакомиться в разделе [{#T}](../limits.md).

После загрузки датасета вы сможете [запустить дообучение](../../tuning/api-ref/grpc/Tuning/tune.md), указав тип дообучения и, опционально, задать параметры. Дообучение займет от 1 часа до 1 суток в зависимости от объема данных и загруженности системы.

Пример дообучения модели см. в разделе [{#T}](../../operations/tuning/create.md).

Для дообучения моделей в {{ foundation-models-name }} вам понадобится [роль](../../security/index.md) `ai.editor`. Она позволит загрузить данные и запустить дообучение.


^1^ {{ meta-disclaimer }}

#### См. также {#see-also}

[{#T}](../../operations/tuning/create.md).