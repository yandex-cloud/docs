# Как распознать длинные аудиофайлы в {{ speechkit-name }}

Сервис позволяет распознавать речь [различными способами](../stt/index.md#stt-ways). В примере ниже аудиофайл распознается с помощью [асинхронного распознавания](../stt/transcribation.md). В нем действуют ограничения:

* максимальная длительность аудио — {{ stt-long-audioLength }};
* максимальный размер файла — {{ stt-long-fileSize }}.

Для асинхронного распознавания поддерживаются две версии API: v3 и v2. Ниже рассмотрено, как выполнить распознавание речи с помощью обеих версий.

Для работы с API в примере ниже используется утилита [cURL](https://curl.se/). Если вы хотите использовать Python-скрипт для работы с API, обратитесь к [практическим руководствам](../tutorials/index.md#async-stt).

## Перед началом работы {#before-you-begin}

1. [Создайте](../../storage/operations/buckets/create.md) бакет и [загрузите](../../storage/operations/objects/upload.md) в него аудиофайл, который вы хотите распознать.
1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт.

   {% note warning %}

   Асинхронно распознать аудиофайлы можно только от имени сервисного аккаунта. Не используйте для этого [другие аккаунты в {{ yandex-cloud }}](../../iam/concepts/users/accounts.md).

   {% endnote %}

1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роли `storage.uploader` и `ai.speechkit-stt.user` на каталог, в котором вы ранее создали бакет.
1. [Получите API-ключ](../../iam/operations/api-key/create.md) для созданного сервисного аккаунта.
1. Скачайте пример аудиофайла:

   * для API v3 — [файл WAV](https://{{ s3-storage-host }}/doc-files/speech.wav);
   * для API v2 — [файл LPCM](https://{{ s3-storage-host }}/speechkit/speech.pcm).

## Распознавание речи {#speech-recognition}

{% include [async-recognition](../../_includes/speechkit/async-recognition.md) %}

#### См. также {#what-is-next}

* [{#T}](../stt/index.md)
* [API v3 асинхронного распознавания](../stt-v3/api-ref/AsyncRecognizer/getRecognition.md)
* [{#T}](../stt/api/transcribation-api.md)
* [{#T}](../concepts/auth.md)
* [{#T}](../stt/api/transcribation-api-v3.md)
* [{#T}](../stt/api/transcribation-ogg.md)
