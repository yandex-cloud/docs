---
title: "API v2 асинхронного распознавания в {{ speechkit-full-name }}"
description: "Следуя данному руководству, вы научитесь использовать API v2 асинхронного распознавания." 
---

# API v2 асинхронного распознавания

Для работы с API v2 понадобятся:

* [Бакет {{ objstorage-full-name }}](../../../storage/operations/buckets/create.md), в который вы загружаете аудиофайл для распознавания.
* [Сервисный аккаунт](../../../iam/operations/sa/create.md) с ролями `{{ roles-speechkit-stt }}` и `storage.uploader`, которые нужны для работы со {{ speechkit-name }} и {{ objstorage-name }}.
* [IAM-токен](../../../iam/operations/iam-token/create-for-sa.md) или [API-ключ](../../../iam/operations/api-key/create.md) для аутентификации.

Подробнее о предварительной работе см. в разделе [{#T}](../transcribation.md#async-recognition).

{% note warning %}

Асинхронно распознать аудиофайлы можно только от имени сервисного аккаунта. Не используйте для этого [другие аккаунты в {{ yandex-cloud }}](../../../iam/concepts/users/accounts.md).

{% endnote %}

Сервис асинхронного распознавания для API v2 располагается по адресу: `transcribe.{{ api-host }}/speech/stt/v2/longRunningRecognize`

## Отправить файл на распознавание {#sendfile}

### Параметры в теле запроса {#sendfile-params}

Структура тела запроса:

```json
{
 "config": {
  "specification": {
   "languageCode": "string",
   "model": "string",
   "profanityFilter": boolean,
   "literature_text": boolean,
   "audioEncoding": "string",
   "sampleRateHertz": integer,
   "audioChannelCount": integer,
   "rawResults": boolean
  }
 },
 "audio": {
  "uri": "string"
 }
}
```

#|
|| **Параметр** | **Описание** ||
|| config | **object**<br>Поле с настройками распознавания. ||
|| config.<br>specification | **object**<br>Настройки распознавания. ||
|| config.<br>specification.<br>languageCode | **string**<br>[Язык речи](../models.md#languages) в аудиозаписи для распознавания.<br/>Значение по умолчанию — `ru-RU`  — русский язык. ||
|| config.<br>specification.<br>model | **string**<br>[Языковая модель](../models.md#tags) для распознавания речи.<br>Значение параметра по умолчанию: `general`.<br>Выбор модели влияет на [стоимость использования](../../pricing.md#rules-stt-long). ||
|| config.<br>specification.<br>profanityFilter | **boolean**<br>Фильтр ненормативной лексики.<br/>Допустимые значения:<ul><li>`true` — замаскировать ненормативную лексику звездочками в результатах распознавания.</li><li>`false` (по умолчанию) — не маскировать ненормативную лексику.</li></ul> ||
|| config.<br>specification.<br>literature_text | **boolean**<br>Включает [режим нормализации](../normalization.md). ||
|| config.<br>specification.<br>audioEncoding | **string**<br>[Формат](../../formats.md) передаваемого аудио.<br/>Допустимые значения:<ul><li>`LINEAR16_PCM` — [LPCM без WAV-заголовка](../../formats.md#lpcm).</li><li>`OGG_OPUS` (по умолчанию) — формат [OggOpus](../../formats.md#oggopus).</li><li>`MP3` — формат [MP3](../../formats.md#MP3).</li></ul> ||
|| config.<br>specification.<br>sampleRateHertz | **integer** (int64)<br>Частота дискретизации передаваемого аудио.<br/>Этот параметр обязателен, если значение `format` равно `LINEAR16_PCM`. Допустимые значения:<ul><li>`48000` (по умолчанию) — частота дискретизации 48 кГц;</li><li>`16000` — частота дискретизации 16 кГц;</li><li>`8000` — частота дискретизации 8 кГц.</li></ul> ||
|| config.<br>specification.<br>audioChannelCount | **integer** (int64)<br>Количество каналов для аудиофайлов в [формате LPCM](../../formats.md#lpcm). По умолчанию используется значение `1`.<br>Не используйте это поле для аудиофайлов в формате [OggOpus](../../formats.md#oggopus) и [MP3](../../formats.md#MP3). Информация о количестве каналов уже содержится в этих файлах. ||
|| config.<br>specification.<br>rawResults | **boolean** <br>Флаг, указывающий, как писать числа.</br>Допустимые значения:<ul><li>`true` — писать прописью.</li><li>`false` (по умолчанию) — писать цифрами.</li></ul> ||
|| audio.<br>uri | **string**<br>URI аудиофайла для распознавания. Поддерживаются только ссылки на файлы, которые хранятся в [{{ objstorage-full-name }}](../../../storage/). ||
|#

### Ответ {#sendfile-response}

Если запрос был составлен правильно, сервис возвращает [объект Operation](../../../api-design-guide/concepts/operation.md), в котором содержится идентификатор операции распознавания (`id`):

```json
{
 "done": false,
 "id": "e03sup6d5h1q********",
 "createdAt": "2019-04-21T22:49:29Z",
 "createdBy": "ajes08feato8********",
 "modifiedAt": "2019-04-21T22:49:29Z"
}
```

Используйте полученный идентификатор на следующем шаге.

## Получить результаты распознавания {#get-result}

Чтобы проверить статус операции и получить результат распознавания, отправьте запрос по адресу: `operation.api.cloud.yandex.net`

Проверяйте результаты распознавания, используя полученный идентификатор. Количество запросов на проверку результатов [ограничено](../../concepts/limits.md), 1 минута одноканального аудио распознается примерно за 10 секунд.

{% note warning %}

Результаты распознавания хранятся на сервере {{ stt-long-resultsStorageTime }}. После этого вы не сможете запросить результаты распознавания, используя полученный идентификатор.

{% endnote %}

### Path-параметры {#get-result-params}

Параметр | Описание
----- | -----
operationId | Идентификатор операции, полученный при отправке запроса на распознавание.

### Ответ {#get-result-response}

В ответе на запрос возвращается [объект Operation](../../../api-design-guide/concepts/operation.md). Пример ответа:

```json
{
 "done": true,
 "response": {
  "@type": "type.googleapis.com/yandex.cloud.ai.stt.v2.LongRunningRecognitionResponse",
  "chunks": [
   {
    "alternatives": [
     {
      "words": [
       {
        "startTime": "0.879999999s",
        "endTime": "1.159999992s",
        "word": "при",
        "confidence": 1
       },
       {
        "startTime": "1.219999995s",
        "endTime": "1.539999988s",
        "word": "написании",
        "confidence": 1
       },
       ...
      ],
      "text": "при написании хоббита толкин обращался к мотивам скандинавской мифологии древней английской поэмы беовульф",
      "confidence": 1
     }
    ],
    "channelTag": "1"
   },
   ...
  ]
 },
 "id": "e03sup6d5h1q********",
 "createdAt": "2019-04-21T22:49:29Z",
 "createdBy": "ajes08feato8********",
 "modifiedAt": "2019-04-21T22:49:36Z"
}
```

#|
|| **Параметр** | **Описание** ||
|| done | **boolean**
Содержит значение `true`, когда распознавание закончено. ||
|| response | **object**
Результаты асинхронного распознавания речи. ||
|| response.<br>@type | **string**
Тип ответа на запрос. ||
|| response.<br>chunks | **array**
Массив с результатами распознавания. ||
|| response.<br>chunks.<br>alternatives | **array**
Массив с вариантами распознанного текста. ||
|| response.<br>chunks.<br>alternatives.<br>words | **array**
Массив с распознанными словами и информацией о них. ||
|| response.<br>chunks.<br>alternatives.<br>words.<br>startTime | **string**
Время начала слова в аудиозаписи. Возможна погрешность в пределах 1–2 секунд. ||
|| response.<br>chunks.<br>alternatives.<br>words.<br>endTime | **string**
Время окончания слова в аудиозаписи. Возможна погрешность в пределах 1–2 секунд. ||
|| response.<br>chunks.<br>alternatives.<br>words.<br>word | **string**
Распознанное слово. Распознанные числа пишутся прописью, например не `12`, а `двенадцать`. ||
|| response.<br>chunks.<br>alternatives.<br>words.<br>confidence | **integer** (int64)
Поле не поддерживается, не используйте его. ||
|| response.<br>chunks.<br>alternatives.<br>text | **string**
Распознанный текст целиком. По умолчанию числа пишутся цифрами. Чтобы весь текст был прописью, укажите `true` в параметре `config.specification.rawResult`. ||
|| response.<br>chunks.<br>alternatives.<br>confidence | **integer** (int64)
Поле не поддерживается, не используйте его. ||
|| response.<br>chunks.<br>channelTag | **string**
Аудиоканал, для которого выполнено распознавание. ||
|| id | **string**
Идентификатор операции. Генерируется на стороне сервиса. ||
|| createdAt | [google.protobuf.Timestamp](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto)
Время запуска операции. Указывается в формате [RFC3339 (Timestamps)](https://www.ietf.org/rfc/rfc3339.txt). ||
|| createdBy | **string**
Идентификатор пользователя, запустившего операцию. ||
|| modifiedAt | [google.protobuf.Timestamp](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto)
Время последнего изменения ресурса. Указывается в формате [RFC3339 (Timestamps)](https://www.ietf.org/rfc/rfc3339.txt).
|#

Подробнее о формате и кодах ответов см. на странице [{#T}](../../concepts/response.md).

## Примеры использования {#examples}

* [{#T}](transcribation-lpcm.md).
* [{#T}](transcribation-ogg.md).
* [{#T}](batch-transcribation.md).
