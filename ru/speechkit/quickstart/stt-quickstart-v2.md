---
title: Как распознать длинные аудиофайлы в {{ speechkit-full-name }}
description: Следуя данной инструкции, вы научитесь распознавать длинные аудиофайлы в {{ speechkit-name }}.
---

# Как распознать длинные аудиофайлы в {{ speechkit-name }}

Сервис позволяет распознавать речь [различными способами](../stt/index.md#stt-ways). В примере аудиофайл распознается с помощью [асинхронного распознавания](../stt/transcribation.md). Асинхронное распознавание доступно в API v3 и API v2. Для асинхронного распознавания действуют ограничения:

* максимальная длительность аудио — {{ stt-long-audioLength }};
* максимальный размер файла — {{ stt-long-fileSize }}.

Для работы с API в примере используется утилита [cURL](https://curl.se/). Если вы хотите использовать Python-скрипт для работы с API, обратитесь к [практическим руководствам](../tutorials/index.md#async-stt).

## Перед началом работы {#before-you-begin}

1. [Создайте](../../storage/operations/buckets/create.md) бакет и [загрузите](../../storage/operations/objects/upload.md) в него аудиофайл, который вы хотите распознать.
1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт.

   {% note warning %}

   Асинхронно распознать аудиофайлы можно только от имени сервисного аккаунта. Не используйте для этого [другие аккаунты в {{ yandex-cloud }}](../../iam/concepts/users/accounts.md).

   {% endnote %}

1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роли `storage.uploader` и `ai.speechkit-stt.user` на каталог, в котором вы ранее создали бакет.
1. [Получите API-ключ](../../iam/operations/api-key/create.md) или [IAM-токен](../../iam/operations/iam-token/create-for-sa.md) для созданного сервисного аккаунта.
1. Скачайте пример аудиофайла:

   * для API v3 — [файл WAV](https://{{ s3-storage-host }}/doc-files/speech.wav);
   * для API v2 — [файл LPCM](https://{{ s3-storage-host }}/speechkit/speech.pcm).

## Распознавание речи {#speech-recognition}

{% list tabs %}

- API v3

  {% include [async-recognition](../../_includes/speechkit/async-recognition-v3.md) %}

- API v2

  {% include [async-recognition](../../_includes/speechkit/async-recognition.md) %}

{% endlist %}

#### См. также {#what-is-next}

* [{#T}](../stt/index.md)
* [API v3 асинхронного распознавания](../stt-v3/api-ref/AsyncRecognizer/getRecognition.md)
* [{#T}](../stt/api/transcribation-api.md)
* [{#T}](../concepts/auth.md)
* [{#T}](../stt/api/transcribation-api-v3.md)
* [{#T}](../stt/api/transcribation-ogg.md)
