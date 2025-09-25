---
title: Создать голосового агента в {{ foundation-models-full-name }}
description: Следуя этой инструкции, вы сможете создать голосового агента с помощью {{ realtime-api }} в {{ foundation-models-full-name }}.
---

# Создать голосового агента

В {{ foundation-models-full-name }} вы можете создать [голосового агента](../../concepts/agents/realtime.md), способного взаимодействовать с пользователем в голосовом и текстовом форматах и поддерживать диалог, близкий к естественному человеческому общению.

## Перед началом работы {#before-begin}

Чтобы воспользоваться примером:

1. Получите [API-ключ](../../../iam/concepts/authorization/api-key.md) для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), от имени которого будет выполняться взаимодействие с [{{ realtime-api }}](../../concepts/agents/realtime.md#realtime-api). Подробнее см. в разделе [{#T}](../get-api-key.md).
1. {% include [sdk-before-begin-step3](../../../_includes/ai-studio/sdk-before-begin-step3.md) %}
1. {% include [sdk-before-begin-step4](../../../_includes/ai-studio/sdk-before-begin-step4.md) %}
1. {% include [sdk-before-begin-step5](../../../_includes/ai-studio/sdk-before-begin-step5.md) %}

## Создайте голосового агента {#create-agent}

Приведенный пример иллюстрирует процесс взаимодействия клиента с сервером через {{ realtime-api }}. Чтобы создать голосового агента:

1. Создайте файл `voice-agent.py` и добавьте в него следующий код:

    {% include [change-seat-agent](../../../_includes/ai-studio/agents/voice-agent-change-seat.md) %}

    Где:

    * `API_KEY` — [API-ключ](../../../iam/concepts/authorization/api-key.md) [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), от имени которого вызываются методы {{ realtime-api }}. 
    * `FOLDER` — идентификатор [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вызывается {{ realtime-api }}.
    * `INPUT_FILE` — путь к файлу, содержащему входное аудиосообщение. В этом примере в качестве входного аудиосообщения вы можете использовать любой аудиофайл, в том числе [сгенерированный](../../../speechkit/operations/tts-playground.md) с помощью {{ speechkit-name }} Playground.
    * `CONVERTED_FILE` — путь к временному файлу, в который будет сохранено входное аудиосообщение при конвертации его в нужный формат (mono, 24 kHz, 16-bit PCM).
    * `OUTPUT_FILE` — путь к сгенерированному аудиофайлу с ответом модели.
1. Выполните созданный файл:

    ```bash
    python3 voice-agent.py
    ```

    В результате выполнения кода ответ модели в текстовом формате будет выведен на экран, а в аудиоформате — сохранен в файл, путь к которому задан в переменной `OUTPUT_FILE`.

#### См. также {#see-also}

[{#T}](../../concepts/agents/realtime.md)