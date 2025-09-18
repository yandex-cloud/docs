---
title: Обучение {{ yagpt-name }} для проектов в {{ speechsense-full-name }}
description: Следуя данной инструкции, вы сможете подключить обучение {{ yagpt-name }} к одному или нескольким проектам в {{ speechsense-name }} или отключить его.
---

# Обучение {{ yagpt-name }}

[{{ yagpt-name }}](../../../foundation-models/concepts/generation/models.md) используется в [диалогах](../../concepts/dialogs.md) {{ speechsense-name }} для анализа данных. Чтобы анализ был более качественным (например, для разметки смысловыми тегами или для распознавания аудиоданных), модели {{ yagpt-name }} могут обучаться на данных вашего проекта.

С 1 сентября 2025 года при создании проекта обучение {{ yagpt-name }} включено по умолчанию. При необходимости его можно [отключить](#disable-yandexgpt-training). Для проектов, созданных до 1 сентября 2025 года, обучение {{ yagpt-name }} нужно [включить](#enable-yandexgpt-training) вручную.

Сбор данных начинается сразу, как только обучение было включено, а обновление модели {{ yagpt-name }} на основе собранных данных происходит каждые три месяца. Результат обучения модели внедряется только в ваш проект.

Для включения или отключения обучения {{ yagpt-name }} нужна роль `{{ roles-speechsense-admin }}` в пространстве.

## Включить обучение {{ yagpt-name }} {#enable-yandexgpt-training}

{% note warning %}

Подключая к проекту обучение [{{ yagpt-name }}](../../../foundation-models/concepts/generation/models.md), вы разрешаете использовать данные вашего проекта для обучения модели. [Подробнее об использовании данных](https://yandex.ru/legal/cloud_terms_speechsense/).

{% endnote %}

Чтобы включить обучение {{ yagpt-name }} для одного или нескольких проектов:

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство.
1. Перейдите на вкладку **{{ ui-key.yc-ui-talkanalytics.common.settings }}**.
1. В блоке **{{ ui-key.yc-ui-talkanalytics.spaces.gpt-learning.title }}** нажмите ![image](../../../_assets/console-icons/pencil-to-line.svg) **{{ ui-key.yc-ui-talkanalytics.common.customize }}**.
1. Отметьте один или несколько проектов, к которым вы хотите подключить обучение {{ yagpt-name }}, и нажмите **Сохранить**.

С этого момента все новые данные, добавляемые в проект, будут собираться для обучения {{ yagpt-name }}. Старые данные не используются для обучения.

## Отключить обучение {{ yagpt-name }} {#disable-yandexgpt-training}

Чтобы отключить обучение {{ yagpt-name }} для одного или нескольких проектов:

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство.
1. Перейдите на вкладку **{{ ui-key.yc-ui-talkanalytics.common.settings }}**.
1. В блоке **{{ ui-key.yc-ui-talkanalytics.spaces.gpt-learning.title }}** нажмите ![image](../../../_assets/console-icons/pencil-to-line.svg) **{{ ui-key.yc-ui-talkanalytics.common.customize }}**.
1. Снимите отметку у тех проектов, для которых вы хотите отключить обучение {{ yagpt-name }}, и нажмите **Сохранить**.
