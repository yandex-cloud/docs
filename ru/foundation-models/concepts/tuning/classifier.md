# Дообучение моделей классификации

_Дообучение моделей в {{ foundation-models-full-name }} находится на стадии [Preview](../../../overview/concepts/launch-stages.md) и предоставляется по запросу. Вы можете заполнить заявку в [консоли управления]({{ link-console-main }}/link/foundation-models/)._

В {{ foundation-models-full-name }} вы можете дообучить классификаторы на базе {{ gpt-lite }}.

{% include [logging](../../../_includes/foundation-models/yandexgpt/logging-disclaimer.md) %}

## Данные для дообучения {#data}

Для дообучения классификаторов на базе {{ gpt-lite }} подготовьте файл в формате [JSON Lines](https://jsonlines.org/) в кодировке [UTF-8](https://ru.wikipedia.org/wiki/UTF-8) c примерами текстов и их принадлежности к классам. Структура данных в примерах будет зависеть от [типа классификации](../classifier/index.md), для которой обучается модель.

{% include [classifier-training](../../../_includes/datasphere/classifier-training.md) %}

## Запросы к дообученным моделям {#requests}

После завершения обучения вы получите идентификатор модели, дообученной под задачи классификации. Этот идентификатор нужно передавать в поле `modelUri` тела запроса в методе [classify](../../text-classification/api-ref/TextClassification/classify.md) Text Classification API. Вы также можете использовать [{{ ml-sdk-full-name }}](../../sdk/index.md) для работы с дообученными классификаторами.

{% note info %}

Для корректной работы дообученной модели указывайте инструкцию, использованную при обучении, в сообщении с ролью отправителя `system`.

{% endnote %}

Чтобы отправлять запросы через API в ноутбуках [{{ ml-platform-name }}]({{ link-datasphere-main }}), добавьте пользовательский или сервисный аккаунт, от имени которого будут выполняться запросы, в список участников проекта {{ ml-platform-name }}. Аккаунт должен иметь роль `ai.languageModels.user`.

## Примеры {#examples}

[{#T}](../../operations/tuning/tune-classifiers.md)

