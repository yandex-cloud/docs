# Дообучение моделей

{{ foundation-models-full-name }} позволяет дообучать по методу [{{ lora }}](https://arxiv.org/abs/2106.09685) (_Low-Rank Adaptation of Large Language Models_) модели генерации текста {{ gpt-lite }} и {{ llama }} 8b^1^, а также [классификаторы](../classifier/index.md) на базе {{ gpt-lite }}.

_Дообучение моделей в {{ foundation-models-full-name }} находится на стадии [Preview](../../../overview/concepts/launch-stages.md) и предоставляется по запросу. Вы можете заполнить заявку в [консоли управления]({{ link-console-main }}/link/foundation-models/)._

## Возможности дообучения моделей генерации текста {#tuning-abilities}

{% include [tuning-abilities](../../../_includes/foundation-models/yandexgpt/tuning-abilities.md) %}


## Процесс дообучения в {{ foundation-models-name }} {#fm-tuning}

Требования к данным для дообучения см. в разделах [{#T}](./generating.md) и [{#T}](./classifier.md).

Подготовленные данные необходимо загрузить в {{ yandex-cloud }} в виде [_датасета_](../../dataset/api-ref/grpc/index.md). По умолчанию вы можете загрузить до 5 ГБ данных для дообучения в один датасет. Со всеми ограничениями вы можете ознакомиться в разделе [{#T}](../limits.md).

После загрузки датасета [запустите дообучение](../../tuning/api-ref/grpc/Tuning/tune.md), указав его тип и, опционально, задав параметры. Дообучение займет от 1 часа до 1 суток в зависимости от объема данных и загруженности системы.

Пример дообучения модели см. в разделе [{#T}](../../operations/tuning/create.md).

Для дообучения моделей в {{ foundation-models-name }} вам понадобится [роль](../../security/index.md) `ai.editor`. Она позволит загрузить данные и запустить дообучение.

## Примеры {#examples}

[{#T}](../../operations/tuning/create.md).

^1^ {{ meta-disclaimer }}