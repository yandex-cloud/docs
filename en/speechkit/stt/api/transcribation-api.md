# Asynchronous Recognition API

## Before you begin {#before-you-begin}

1. A recognition request should be sent on behalf of a [service account](../../../iam/concepts/users/service-accounts.md) with the [`{{ roles-speechkit-stt }}`](../../../iam/concepts/access-control/roles.md#speechkit-roles) role for the folder where it was created.

   If necessary, follow the instructions:
   * [{#T}](../../../iam/operations/sa/create.md). In the management console, you can assign roles when creating a service account.
   * [{#T}](../../../iam/operations/roles/get-assigned-roles.md).
   * [{#T}](../../../iam/operations/sa/assign-role-for-sa.md).

1. [Get an IAM token](../../../iam/operations/iam-token/create-for-sa.md) or [API key](../../../iam/operations/api-key/create.md) for your service account. In our examples, an IAM token is used for authentication.

   To use an API key, pass it in the `Authorization` header in the following format:
   ```
   Authorization: Api-Key <API key>
   ```
1. Upload an audio file to {{ objstorage-full-name }} and get a link to the uploaded file:

   1. If you don't have a bucket in {{ objstorage-name }}, [create](../../../storage/operations/buckets/create.md) one.
   1. [Upload an audio file](../../../storage/operations/objects/upload.md) to your bucket. In {{ objstorage-name }}, uploaded files are called _objects_.
   1. [Get a link](../../../storage/operations/objects/link-for-download.md) to the uploaded file. Use this link in your audio recognition request.

      The link to the uploaded file has the following format:
      ```
      https://{{ s3-storage-host }}/<bucket name>/<file path>
      ```

      The link will contain additional query parameters (after `?`) for buckets with restricted access. You don't need to pass these parameters in {{ speechkit-name }} since they just get ignored.


#### HTTP request {#sendfile-request}

```
POST https://transcribe.{{ api-host }}/speech/stt/v2/longRunningRecognize
```

#### Parameters in the request body {#sendfile-params}

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

| Parameter | Description |
----- | -----
| config | **object**<br>Field with the recognition settings. |
| config.<br>specification | **object**<br>Recognition settings. |
| config.<br>specification.<br>languageCode | **string**<br>Language that recognition will be performed for.<br/>See a list of available languages in the [model description](../models.md). The default value is `ru-RU` (Russian). |
| config.<br>specification.<br>model | **string**<br>The language model to be used for recognition.<br/>The closer the model is matched, the better the recognition result. You can only specify one model per request.<br/>[Acceptable values](../models.md) depend on the selected language. Default value: `general`. Depending on the selected model, [pricing](../../pricing.md#rules-stt-long) may change. |
| config.<br>specification.<br>profanityFilter | **boolean**<br>Profanity filter.<br/>Acceptable values:<ul><li>`true`: Exclude profanities from recognition results.</li><li>`false` (default): Do not exclude profanities from recognition results.</li></ul> |
| config.<br>specification.<br>literature_text | **boolean**<br>Enable text <q>normalization</q> mode, primarily placing punctuation. |
| config.<br>specification.<br>audioEncoding | **string**<br>The [format](../../formats.md) of the synthesized audio.<br/>Acceptable values:<ul><li>`LINEAR16_PCM`: [LPCM without WAV header](../../formats.md#lpcm).</li><li>`OGG_OPUS` (default): [OggOpus](../../formats.md#oggopus) format.</li><li>`MP3`: [MP3](../../formats.md#MP3) format.</li></ul> |
| config.<br>specification.<br>sampleRateHertz | **integer** (int64)<br>The sampling frequency of the submitted audio.<br/>Required if `format` is set to `LINEAR16_PCM`. Acceptable values:<ul><li>`48000` (default): Sampling rate of 48 kHz.</li><li>`16000`: Sampling rate of 16 kHz.</li><li>`8000`: Sampling rate of 8 kHz.</li></ul> |
| config.<br>specification.<br>audioChannelCount | **integer** (int64)<br>The number of channels in [LPCM](../../formats.md#lpcm) files. The value of `1` is used by default.<br>Do not use this field for files in [OggOpus](../../formats.md#oggopus) or [MP3](../../formats.md#MP3) formats. |
| config.<br>specification.<br>rawResults | **boolean** <br>Flag that indicates how to write numbers. `true`: In words. `false` (by default): In numbers. |
| audio.<br>uri | **string**<br>The URI of the audio file for recognition. Supports only links to files stored in [Yandex Object Storage](../../../storage/). |

#### Response {#sendfile-response}

If your request is written correctly, the service returns the [Operation object](../../../api-design-guide/concepts/operation.md) with the recognition operation ID (`id`):

```json
{
 "done": false,
 "id": "e03sup6d5h7rq574ht8g",
 "createdAt": "2019-04-21T22:49:29Z",
 "createdBy": "ajes08feato88ehbbhqq",
 "modifiedAt": "2019-04-21T22:49:29Z"
}
```

Use this ID at the next step.

### Getting recognition results {#get-result}

[Monitor the recognition results](../../../api-design-guide/concepts/operation.md#monitoring) using the received ID. The number of result monitoring requests is [limited](../../concepts/limits.md), so consider the recognition speed: it takes about 10 seconds to recognize 1 minute of single-channel audio.

{% note warning %}

Recognition results are stored on the {{ stt-long-resultsStorageTime }} server. You can then request the recognition results using the received ID.

{% endnote %}

#### HTTP request {#get-result-request}

```
GET https://operation.{{ api-host }}/operations/{operationId}
```

#### {#get-result-params} path parameters

| Parameter | Description |
----- | -----
| operationId | The operation ID received when sending the recognition request. |

#### Response {#get-result-response}

Once the recognition is complete, the `done` field will be set to `true` and the `response` field will contain a list of recognition results `chunks[]`.

Each result in the `chunks[]` list contains the following fields:

* `alternatives[]`: List of recognized text alternatives. Each alternative contains the following fields:
   * `words[]`: List of recognized words.
      * `startTime`: Time stamp of the beginning of the word in the recording. An error of 1-2 seconds is possible.
      * `endTime`: Time stamp of the end of the word. An error of 1-2 seconds is possible.
      * `word`: Recognized word. Recognized numbers are written in words (for example, `twelve` rather than `12`).
      * `confidence`: This field currently isn't supported. Don't use it.
   * `text`: Full recognized text. By default, numbers are written in figures. To output the entire text in words, specify `true` in the `raw_results` field.
   * `confidence`: This field currently isn't supported. Don't use it.
* `channelTag`: Audio channel that recognition was performed for.

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
        "word": "when",
        "confidence": 1
       },
       {
        "startTime": "1.219999995s",
        "endTime": "1.539999988s",
        "word": "writing",
        "confidence": 1
       },
       ...
      ],
      "text": "when writing The Hobbit, Tolkien referred to the Norse mythology of the Old English poem Beowulf",
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
