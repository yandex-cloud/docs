---
title: Дообучение моделей генерации текста
description: В {{ foundation-models-full-name }} вы можете дообучить модели генерации текста {{ gpt-lite }} и {{ llama }} 8B.
---

# Дообучение моделей генерации текста

_Дообучение моделей в {{ foundation-models-full-name }} находится на стадии [Preview](../../../overview/concepts/launch-stages.md) и предоставляется по запросу. Вы можете заполнить заявку в [консоли управления]({{ link-console-main }}/link/foundation-models/)._

В {{ foundation-models-full-name }} вы можете дообучить модели генерации текста {{ gpt-lite }} и {{ llama }} 8B^1^.

{% include [logging](../../../_includes/foundation-models/yandexgpt/logging-disclaimer.md) %}

## Данные для дообучения {#data}

{% include [fine-tuning-file-requirements](../../../_includes/datasphere/fine-tuning-file-requirements.md) %}

## Запросы к дообученным моделям {#requests}

Обращаться к дообученной модели можно через [API генерации текста](../../text-generation/api-ref/index.md), [{{ assistant-api }}](../../assistants/api-ref/grpc/Assistant/index.md), из {{ ml-platform-full-name }} и других приложений. Вы также можете использовать [{{ ml-sdk-full-name }}](../../sdk/index.md) для работы с дообученными моделями. 

{% note info %}

Для корректной работы дообученной модели указывайте инструкцию, использованную при обучении, в сообщении с ролью отправителя `system`.

{% endnote %}

Чтобы отправлять запросы через API в ноутбуках [{{ ml-platform-name }}]({{ link-datasphere-main }}), добавьте пользовательский или сервисный аккаунт, от имени которого будут выполняться запросы, в список участников проекта {{ ml-platform-name }}. Аккаунт должен иметь роль `ai.languageModels.user`.

## Примеры {#examples}

[{#T}](../../operations/tuning/create.md)

^1^ {{ meta-disclaimer }}
