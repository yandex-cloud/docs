# API асинхронного распознавания

## Перед началом {#before-you-begin}

1. Запрос на распознавание необходимо отправлять от имени [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md) с ролью [`editor`](../../../iam/concepts/access-control/roles.md#editor) на каталог, в котором он создан.

   Если необходимо, воспользуйтесь инструкциями:
   * [{#T}](../../../iam/operations/sa/create.md). В консоли управления вы можете назначить необходимые роли при создании сервисного аккаунта.
   * [{#T}](../../../iam/operations/roles/get-assigned-roles.md).
   * [{#T}](../../../iam/operations/sa/assign-role-for-sa.md).

1. [Получите IAM-токен](../../../iam/operations/iam-token/create-for-sa.md) или [API-ключ](../../../iam/operations/api-key/create.md) для вашего сервисного аккаунта. В примерах для аутентификации используется IAM-токен.

   Чтобы использовать API-ключ, передайте его в заголовке `Authorization` в следующем формате:
    ```
    Authorization: Api-Key <API-ключ>
    ```
1. Загрузите аудиофайл в сервис {{ objstorage-full-name }} и получите ссылку на загруженный файл:

   1. Если у вас еще нет бакета в {{ objstorage-name }}, [создайте](../../../storage/operations/buckets/create.md) его.
   1. [Загрузите аудиофайл](../../../storage/operations/objects/upload.md) в ваш бакет. В терминах {{ objstorage-name }} загружаемые файлы называются _объектами_.
   1. [Получите ссылку](../../../storage/operations/objects/link-for-download.md) на загруженный файл. Используйте эту ссылку в запросе на распознавание аудио.

      Ссылка на загруженный файл имеет вид:
       ```
       https://{{ s3-storage-host }}/<имя-бакета>/<путь-к-файлу>
       ```

      Для бакета с ограниченным доступом в ссылке будут дополнительные query-параметры (после знака `?`). В {{ speechkit-name }} эти параметры не надо передавать — они игнорируются.


#### HTTP-Запрос {#sendfile-request}

```
POST https://transcribe.{{ api-host }}/speech/stt/v2/longRunningRecognize
```

#### Параметры в теле запроса {#sendfile-params}

```json
{
    "config": {
        "specification": {
            "languageCode": "string",
            "model": "string",
            "profanityFilter": "string",
            "audioEncoding": "string",
            "sampleRateHertz": "integer",
            "audioChannelCount": "integer"
        }
    },
    "audio": {
        "uri": "string"
    }
}
```

Параметр | Описание
----- | -----
config | **object**<br>Поле с настройками распознавания.
config.<br>specification | **object**<br>Настройки распознавания.
config.<br>specification.<br>languageCode | **string**<br>Язык, для которого будет выполнено распознавание.<br/>Список доступных языков см. в [описании модели](../models.md). Значение по умолчанию — `ru-RU`  — русский язык.
config.<br>specification.<br>model | **string**<br>Языковая модель, которую следует использовать при распознавании.<br/>Чем точнее выбрана модель, тем лучше результат распознавания. В одном запросе можно указать только одну модель.<br/>[Допустимые значения](../models.md) зависят от выбранного языка. Значение параметра по умолчанию: `general`. В зависимости от выбранной модели может измениться [тарификация](../../pricing.md#rules-stt-long).
config.<br>specification.<br>profanityFilter | **boolean**<br>Фильтр ненормативной лексики.<br/>Допустимые значения:<ul><li>`true` — исключать ненормативную лексику из результатов распознавания.</li><li>`false` (по умолчанию) — не исключать ненормативную лексику.</li></ul>
config.<br>specification.<br>literature_text | **boolean**<br>Включает режим <q>нормализации</q> текста — в первую очередь, расстановку пунктуации.
config.<br>specification.<br>audioEncoding | **string**<br>[Формат](../../formats.md) передаваемого аудио.<br/>Допустимые значения:<ul><li>`LINEAR16_PCM` — [LPCM без WAV-заголовка](../../formats.md#lpcm).</li><li>`OGG_OPUS` (по умолчанию) — формат [OggOpus](../../formats.md#oggopus).</li><li>`MP3` — формат [MP3](../../formats.md#MP3).</li></ul>
config.<br>specification.<br>sampleRateHertz | **integer** (int64)<br>Частота дискретизации передаваемого аудио.<br/>Этот параметр обязателен, если значение `format` равно `LINEAR16_PCM`. Допустимые значения:<ul><li>`48000` (по умолчанию) — частота дискретизации 48 кГц;</li><li>`16000` — частота дискретизации 16 кГц;</li><li>`8000` — частота дискретизации 8 кГц.</li></ul>
config.<br>specification.<br>audioChannelCount | **integer** (int64)<br>Количество каналов для файлов в [формате LPCM](../../formats.md#lpcm). По умолчанию используется значение `1`.<br>Не используйте это поле для файлов в формате [OggOpus](../../formats.md#oggopus) и [MP3](../../formats.md#MP3).
config.<br>specification.<br>rawResults | **boolean** <br>Флаг, указывающий, как писать числа. `true` — писать прописью, `false` (по умолчанию) — писать цифрами.
audio.<br>uri | **string**<br>URI аудиофайла для распознавания. Поддерживаются только ссылки на файлы, которые хранятся в [Yandex Object Storage](../../../storage/).

#### Ответ {#sendfile-response}

Если запрос был составлен правильно, сервис возвращает [объект Operation](../../../api-design-guide/concepts/operation.md), в котором содержится идентификатор операции распознавания (`id`):

```json
{
 "done": false,
 "id": "e03sup6d5h7rq574ht8g",
 "createdAt": "2019-04-21T22:49:29Z",
 "createdBy": "ajes08feato88ehbbhqq",
 "modifiedAt": "2019-04-21T22:49:29Z"
}
```

Используйте полученный идентификатор на следующем шаге.

### Получить результаты распознавания {#get-result}

[Проверяйте результаты распознавания](../../../api-design-guide/concepts/operation.md#monitoring), используя полученный идентификатор. Количество запросов на проверку результатов [ограничено](../../concepts/limits.md), поэтому учитывайте скорость распознавания: 1 минута одноканального аудио распознается примерно за 10 секунд.

{% note warning %}

Результаты распознавания хранятся на сервере {{ stt-long-resultsStorageTime }}. После этого вы не сможете запросить результаты распознавания используя полученный идентификатор.

{% endnote %}

#### HTTP-запрос {#get-result-request}

```
GET https://operation.{{ api-host }}/operations/{operationId}
```

#### Path-параметры {#get-result-params}

Параметр | Описание
----- | -----
operationId | Идентификатор операции, полученный при отправке запроса на распознавание.

#### Ответ {#get-result-response}

Когда распознавание будет закончено, значение поля `done` будет `true`, а в поле `response` будет список результатов распознавания `chunks[]`.

Каждый результат в `chunks[]` содержит поля:

* `alternatives[]` - список вариантов распознанного текста. Каждый вариант содержит поля:
   * `words[]` - список распознанных слов.
      * `startTime` — временная отметка начала слова на аудиозаписи. Возможна погрешность в пределах 1-2 секунд.
      * `endTime` — временная отметка конца слова. Возможна погрешность в пределах 1-2 секунд.
      * `word` — распознанное слово. Распознанные числа пишутся прописью, например не `12`, а `двенадцать`.
      * `confidence` - это поле сейчас не поддерживается, не используйте его.
   * `text` - распознанный текст целиком. По умолчанию числа пишутся цифрами. Чтобы весь текст был прописью, укажите `true` в поле `raw_results`.
   * `confidence` - это поле сейчас не поддерживается, не используйте его.
* `channelTag` - аудиоканал, для которого выполнено распознавание.

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
 "id": "e03sup6d5h7rq574ht8g",
 "createdAt": "2019-04-21T22:49:29Z",
 "createdBy": "ajes08feato88ehbbhqq",
 "modifiedAt": "2019-04-21T22:49:36Z"
}
```
