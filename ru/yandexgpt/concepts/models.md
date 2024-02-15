# Модели {{ yagpt-full-name }}

{% include notitle [preview-stage](../../_includes/yandexgpt/preview.md) %}

{{ yagpt-full-name }} предоставляет доступ к двум большим текстовым генеративным нейросетям: стандартной {{ yagpt-name }} Lite, подходящей для решения задач в режиме реального времени, и большой {{ yagpt-name }}, которая дает более точные ответы на сложные запросы.

Если стандартных моделей вам недостаточно, вы можете [дообучить](../tutorials/yagpt-tuning) {{ yagpt-name }} Lite в сервисе [{{ ml-platform-full-name }}]({{ link-datasphere-main }}), чтобы модель точнее отвечала на ваши запросы. 

Обращение к модели по API возможно по ее [URI](https://ru.wikipedia.org/wiki/URI), содержащем [идентификатор каталога](../../resource-manager/operations/folder/get-id.md). Опция `/latest` указывает версию вызываемой модели и является опциональной. 

## Модели генерации {{ yagpt-full-name }} {#yandexgpt-generation}

| Модель | URI | Режим работы |
|---|---|---|
| {{ yagpt-name }} | `gpt://<идентификатор_каталога>/yandexgpt/latest` | [Асинхронный, синхронный](./index.md#working-mode) ^1^ |
| {{ yagpt-name }} Lite | `gpt://<идентификатор_каталога>/yandexgpt-lite/latest` | Асинхронный, синхронный |
| Краткий пересказ | `gpt://<идентификатор_каталога>/summarization/latest` | Асинхронный, синхронный |
| Модель, дообученная в {{ ml-platform-full-name}} | `ds://<идентификатор_дообученной_модели>` | Синхронный |

Модели краткого пересказа и модели, дообученные в {{ ml-platform-full-name}}, работают на основе {{ yagpt-name }} Lite и делят [квоты](./limits.md#quotas) на использование.

## Возможности дообучения {#tuning-abilities}

{% include [tuning-abilities](../../_includes/yandexgpt/tuning-abilities.md) %}
