---
title: "Асинхронное распознавание аудиофайлов в формате LPCM в {{ speechkit-full-name }}"
description: "Следуя данной инструкции, вы сможете использовать асинхронное распознавание аудиофайлов в формате LPCM." 
---

# Асинхронное распознавание аудиофайлов в формате LPCM

Ниже рассмотрен пример [асинхронного распознавания речи](../transcribation.md) из аудиофайла с помощью [API v2](transcribation-api.md) {{ speechkit-name }}. В примере заданы параметры:

* [язык](../models.md#languages) — русский;
* [языковая модель](../models.md#tags) — `general:rc`;
* формат передаваемого аудиофайла — [LPCM](../../formats.md#LPCM) с частотой дискретизации 8000 Гц;
* [количество аудиоканалов](transcribation-api.md#sendfile-params) — 1 (значение по умолчанию);
* остальные параметры оставлены по умолчанию.

Вы можете сформировать и отправить запрос на распознавание речи с помощью утилиты [cURL](https://curl.haxx.se).

Аутентификация происходит от имени сервисного аккаунта с помощью [IAM-токена](../../../iam/concepts/authorization/iam-token.md). Подробнее об [аутентификации в API {{speechkit-name}}](../../concepts/auth.md).

## Перед началом работы {#before-you-begin}

{% include [transcribation-before-you-begin](../../../_includes/speechkit/transcribation-before-you-begin.md) %}

Если у вас нет аудиофайла формата LPCM, вы можете скачать [пример файла](https://{{ s3-storage-host }}/speechkit/speech.pcm).

## Выполните распознавание с помощью API {#recognize-using-api}

{% list tabs group=programming_language %}

- cURL {#curl}

   {% include [async-recognition](../../../_includes/speechkit/async-recognition.md) %}

{% endlist %}

#### См. также {#see-also}

* [{#T}](transcribation-api.md)
* [{#T}](transcribation-ogg.md)
* [{#T}](batch-transcribation.md)
* [{#T}](../../concepts/auth.md)
