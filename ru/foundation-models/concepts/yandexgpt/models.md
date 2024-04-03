# Модели {{ yagpt-full-name }}

{{ yagpt-full-name }} предоставляет доступ к большим текстовым генеративным нейросетям: стандартной {{ gpt-lite }}, подходящей для решения задач в режиме реального времени, большой {{ gpt-pro }} на базе {{ yagpt-name }} 3, которая дает более точные ответы на сложные запросы, и специальной модели краткого пересказа, работающей на базе {{ gpt-lite }}.

Если стандартных моделей вам недостаточно, вы можете [дообучить](../../tutorials/yagpt-tuning) {{ gpt-pro }} в сервисе [{{ ml-platform-full-name }}]({{ link-datasphere-main }}), чтобы модель точнее отвечала на ваши запросы. 

Чтобы [обратиться](../../operations/yandexgpt/create-prompt.md) к модели по API, в параметре `modelUri` укажите ее [URI](https://ru.wikipedia.org/wiki/URI), содержащий [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md). Опция `/latest` указывает версию вызываемой модели и является опциональной. 

## Модели генерации {{ yagpt-full-name }} {#yandexgpt-generation}

| Модель | Поколение {{ yagpt-name}} | URI | Режим работы |
|---|---|---|---|
| {{ gpt-pro }} | 3 | `gpt://<идентификатор_каталога>/yandexgpt/latest` | [Асинхронный, синхронный](../index.md#working-mode)|
| {{ gpt-lite }} | 2 | `gpt://<идентификатор_каталога>/yandexgpt-lite/latest` | Асинхронный, синхронный |
| Краткий пересказ | 2 | `gpt://<идентификатор_каталога>/summarization/latest` | Асинхронный, синхронный |
| Модель, дообученная в {{ ml-platform-full-name}} | 3 | `ds://<идентификатор_дообученной_модели>` | Синхронный |

Модифицированные модели делят [квоты](../limits.md#quotas) на использование со своими базовыми моделями.

## Возможности дообучения {#tuning-abilities}

{% include [tuning-abilities](../../../_includes/yandexgpt/tuning-abilities.md) %}
