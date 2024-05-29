# Фундаментальные модели в {{ ml-platform-name }}

{{ ml-platform-full-name }} предоставляет возможность работать с [фундаментальными моделями](../../../glossary/ml-models.md#foundation), чтобы вы могли использовать их для решения своих задач и при необходимости дообучать на своих данных. [Дообучение](../../../glossary/ml-models.md#fine-tuning) производится по методу Fine-tuning, результаты дообучения хранятся в {{ ml-platform-name }}.

{% note info %}

Дообучение фундаментальных моделей находится на стадии [Preview](../../../overview/concepts/launch-stages.md).

{% endnote %}

## Модели, доступные для дообучения {#available-models}

В разделе **[Фундаментальные модели]({{ link-datasphere-main }}/foundation-models/ygpt)** вы можете найти модели, развернутые в {{ yandex-cloud}}. Их можно использовать в {{ ml-platform-name }} как есть или дообучить на своих данных, чтобы ответы моделей точнее отражали специфику ваших задач. 

Сейчас для дообучения доступны следующие модели:
* [базовая модель {{ gpt-pro }}](#tuning-abilities). 
* [классификаторы на базе {{ yagpt-name }}](#classifier-training). 

Вы сможете обращаться к дообученным моделям из проекта {{ ml-platform-name }} и через [API сервиса {{ foundation-models-full-name }}](../../../foundation-models/api-ref/authentication.md).

В интерфейсе {{ ml-platform-name }} создайте новую дообученную фундаментальную модель, задайте темп обучения и загрузите данные. Дообучение займет некоторое время.

{% note warning %}

Модели на базе {{ gpt-lite }} (созданные до 27 марта 2024 года) перестанут работать 29 апреля 2024 года.

{% endnote %}

## Данные для дообучения {{ gpt-pro }} {#yagpt-tuning}

{% include [logging](../../../_includes/foundation-models/yandexgpt/logging-disclaimer.md) %}

{% include [fine-tuning-file-requirements](../../../_includes/datasphere/fine-tuning-file-requirements.md) %}

### Возможности дообучения {{ gpt-pro }} {#tuning-abilities}

{% include [tuning-abilities](../../../_includes/foundation-models/yandexgpt/tuning-abilities.md) %}

## Данные для дообучения классификаторов на базе {{ yagpt-name }} {#classifier-training}

Для дообучения классификаторов на базе {{ yagpt-name }} подготовьте файл в формате [JSON Lines](https://jsonlines.org/) в кодировке [UTF-8](https://ru.wikipedia.org/wiki/UTF-8) c примерами текстов и их принадлежности к классам. Структура данных в примерах будет зависеть от типа классификации, для которой обучается модель.

{% include [classifier-training](../../../_includes/datasphere/classifier-training.md) %}

## Запросы к дообученным моделям {#requests}

Обращаться к дообученной модели можно через интерфейс {{ ml-platform-name }} Playground или через [API {{ foundation-models-name }}](../../../foundation-models/concepts/api.md) из {{ ml-platform-name }} и других приложений. Запросы в Playground осуществляются от имени пользователя. 

Для отправки запросов через API добавьте пользовательский или сервисный аккаунт, от имени которого будут выполняться запросы, в список участников проекта {{ ml-platform-name }} . Аккаунт должен иметь роль `ai.languageModels.user`.


#### См. также {#see-also}

* [{#T}](../../tutorials/yagpt-tuning.md)
* [{#T}](../../tutorials/yagpt-tuning-classifier.md)