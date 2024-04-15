# Модели {{ yagpt-full-name }}

{% include notitle [preview-stage](../../_includes/foundation-models/yandexgpt/preview.md) %}

{{ yagpt-full-name }} предоставляет доступ к двум большим текстовым генеративным нейросетям: стандартной {{ gpt-lite }}, подходящей для решения задач в режиме реального времени, и большой {{ yagpt-name }}, которая дает более точные ответы на сложные запросы.

Если стандартных моделей вам недостаточно, вы можете [дообучить](../tutorials/yagpt-tuning) {{ gpt-lite }} в сервисе [{{ ml-platform-full-name }}]({{ link-datasphere-main }}), чтобы модель точнее отвечала на ваши запросы. 

Чтобы [обратиться](../operations/create-prompt.md) к модели по API, в параметре `modelUri` укажите ее [URI](https://ru.wikipedia.org/wiki/URI), содержащий [идентификатор каталога](../../resource-manager/operations/folder/get-id.md). Опция `/latest` указывает версию вызываемой модели и является опциональной.

## Модели генерации {{ yagpt-full-name }} {#yandexgpt-generation}

| Модель | URI | Режим работы |
|---|---|---|
| {{ gpt-pro }} | `gpt://<идентификатор_каталога>/yandexgpt/latest` | [Асинхронный, синхронный](./index.md#working-mode)|
| {{ gpt-lite }} | `gpt://<идентификатор_каталога>/yandexgpt-lite/latest` | Асинхронный, синхронный |
| Краткий пересказ | `gpt://<идентификатор_каталога>/summarization/latest` | Асинхронный, синхронный |
| Модель, дообученная в {{ ml-platform-full-name}} | `ds://<идентификатор_дообученной_модели>` | Синхронный |

Модель краткого пересказа работает на основе {{ gpt-lite }}. Модели, дообученные в {{ ml-platform-full-name}}, работают на основе {{ gpt-pro }}. Модифицированные модели делят [квоты](./limits.md#quotas) на использование со своими базовыми моделями.

## Возможности дообучения {#tuning-abilities}

{% include [tuning-abilities](../../_includes/foundation-models/yandexgpt/tuning-abilities.md) %}
