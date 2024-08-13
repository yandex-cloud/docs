---
title: "Асинхронное распознавание {{ speechkit-full-name }}"
description: "Асинхронное распознавание позволяет преобразовывать в текст многоканальные аудиофайлы. Результаты распознавания хранятся на сервере {{ stt-long-resultsStorageTime }}, после чего вы не сможете их получить."
---

# Асинхронное распознавание

Асинхронное распознавание позволяет преобразовывать в текст многоканальные аудиофайлы следующих характеристик:
* Максимальная длительность записи — {{ stt-long-audioLength }}.
* Максимальный размер файла — {{ stt-long-fileSize }}.

Результаты распознавания хранятся на сервере {{ stt-long-resultsStorageTime }}, после чего вы не сможете их получить.

Асинхронное распознавание не подходит для распознавания диалога в режиме реального времени. Если вам нужны промежуточные результаты и минимальное время ответа, используйте [потоковое распознавание](streaming.md).

Список поддерживаемых языков см. в разделе [{#T}](models.md#languages).

## Режимы работы асинхронного распознавания {#modes}

{% include [async-stt-modes](../../_includes/speechkit/async-modes.md) %}

## Как асинхронно распознать предзаписанное аудио {#async-recognition}

Для асинхронного распознавания речи используются API v2 и v3 {{ speechkit-name }}. Чтобы распознать предзаписанное аудио:

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md).
1. [Назначьте ему роли](../../iam/operations/sa/assign-role-for-sa.md):

   * `{{ roles-speechkit-stt }}` — для распознавания речи;
   * `storage.uploader` — для загрузки аудиофайла в [бакет {{ objstorage-full-name }}](../../storage/concepts/bucket.md);
   * (Опционально) `storage.configurer`, `kms.keys.encrypter` и `kms.keys.decrypter` — для шифрования и расшифровки объектов в бакете. Эти роли нужны, только если вы используете [шифрование в {{ objstorage-name }}](../../storage/concepts/encryption.md).

1. Получите [IAM-токен](../../iam/operations/iam-token/create-for-sa.md) или [API-ключ](../../iam/operations/api-key/create.md) для вашего сервисного аккаунта, они понадобятся для аутентификации в API.
1. [Создайте бакет {{ objstorage-full-name }}](../../storage/operations/buckets/create.md).
1. [Загрузите аудиофайл в бакет](../../storage/operations/objects/upload.md).
1. [Получите ссылку](../../storage/operations/objects/link-for-download.md) на загруженный файл.

   Для бакета с ограниченным доступом в ссылке присутствуют дополнительные query-параметры (после знака `?`). Эти параметры не нужно передавать в {{ speechkit-name }} — они игнорируются.

1. Отправьте API-запрос на распознавание файла через [gRPC API](../stt-v3/api-ref/grpc/AsyncRecognizer) или [REST API](../stt-v3/api-ref/AsyncRecognizer/index.md). В теле запроса передайте ссылку на аудиофайл. В HTTP-заголовке укажите данные аутентификации:

   * `Authorization: Bearer <IAM-токен>` — для аутентификации с IAM-токеном;
   * `Authorization: Api-Key <API-ключ>` — для аутентификации с API-ключом.

   В ответе на запрос возвращается идентификатор операции распознавания. Сохраните его — он понадобится в следующем запросе.

   {% note warning %}

   Результаты хранятся на сервере {{ stt-long-resultsStorageTime }}. После этого вы не сможете запросить результаты распознавания, используя полученный идентификатор.

   {% endnote %}

1. Подождите, пока закончится распознавание. Одна минута одноканального аудио распознается примерно за 10 секунд.
1. Отправьте API-запрос на получение результатов распознавания:
   * при помощи [API v2](api/transcribation-api.md#get-result);
   * при помощи [API v3]:
       * [REST](../stt-v3/api-ref/AsyncRecognizer/getRecognition.md);
       * [gRPC](../stt-v3/api-ref/grpc/AsyncRecognizer.md#GetRecognition).

   В HTTP-заголовке укажите те же данные аутентификации.

   Результаты содержат распознанный текст целиком и список распознанных слов.


## Примеры использования API асинхронного распознавания {#examples}

* [{#T}](api/transcribation-lpcm.md).
* [{#T}](api/transcribation-ogg.md).
* [{#T}](api/transcribation-api-v3.md).
* [{#T}](api/batch-transcribation.md).

