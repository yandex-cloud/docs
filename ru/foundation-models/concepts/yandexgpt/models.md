# Модели {{ yagpt-full-name }}

{{ yagpt-full-name }} предоставляет доступ к большим текстовым моделям:

* стандартной {{ gpt-lite }}, подходящей для решения задач в режиме реального времени;
* большой {{ gpt-pro }} на базе {{ yagpt-name }} 3, которая дает более точные ответы на сложные запросы;
* специальной модели краткого пересказа, работающей на базе {{ gpt-lite }}.

Если стандартных моделей вам недостаточно, вы можете [дообучить](../../tutorials/yagpt-tuning) {{ gpt-pro }} в сервисе [{{ ml-platform-full-name }}]({{ link-datasphere-main }}), чтобы модель точнее отвечала на ваши запросы.

Чтобы [обратиться](../../operations/yandexgpt/create-prompt.md) к модели по API, в параметре `modelUri` укажите ее [URI](https://ru.wikipedia.org/wiki/URI), содержащий [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md). Сегменты `/latest`, `/rc` и `/deprecated` указывают версию модели. По умолчанию используется сегмент `/latest`.

## Модели генерации {{ yagpt-full-name }} {#yandexgpt-generation}

{% note info %}

При обновлении моделей поколения {{ yagpt-name }}, доступные в разных ветках (сегменты `/latest`, `/rc` и `/deprecated`), могут меняться.

{% endnote %}

#|
|| **Модель** | **URI** | **Поколение {{ yagpt-name }}** | **[Режимы работы](../index.md#working-mode)** ||
|| **{{ gpt-lite }}** | `gpt://<идентификатор_каталога>/yandexgpt-lite/latest` | 3</br>3 |  Асинхронный, синхронный ||
|| **{{ gpt-pro }}** | `gpt://<идентификатор_каталога>/yandexgpt/latest` | 3 | Асинхронный, синхронный ||
|| **Краткий пересказ** | `gpt://<идентификатор_каталога>/summarization/latest` | 2 | Асинхронный, синхронный ||
|| **Модель, дообученная в {{ ml-platform-full-name }}** | `ds://<идентификатор_дообученной_модели>` | 3 | Асинхронный, синхронный ||
|#

Модифицированные модели делят [квоты](../limits.md#quotas) на использование со своими базовыми моделями.

## Возможности дообучения {#tuning-abilities}

{% include [tuning-abilities](../../../_includes/foundation-models/yandexgpt/tuning-abilities.md) %}
