# Recognition of long audio fragments

Long audio fragment recognition can be used for multi-channel audio files up to {{ stt-long-fileSize }}.

Long audio fragment recognition is somewhat cheaper than other [recognition methods](index.md#stt-ways), but it is not suitable for online speech recognition as it has a longer response time. For more information about pricing, see [#T](../pricing.md).

## Before getting started

1. A recognition request should be sent on behalf of a [service account](../../iam/concepts/users/service-accounts.md). If you don't have a service account yet, [create one](../../iam/operations/sa/create.md).

1. Make sure the service account has access to the folder where it was created. If you want to use a different folder for authorization, you need to specify the folder ID in your request.

1. [Get an IAM token](../../iam/operations/iam-token/create-for-sa.md) for your service account.

1. Upload an audio file to {{ objstorage-full-name }} and get a link to the uploaded file:

    1. If you don't have a bucket in {{ objstorage-name }}, [create](../../storage/operations/buckets/create.md) one.

    1. [Upload an audio file](../../storage/operations/objects/upload.md) to your bucket. In {{ objstorage-name }} terms, uploaded files are called _objects_.

    1. [Get a link](../../storage/operations/objects/link-for-download.md) to the uploaded file. Use this link in your audio recognition request.

        The link to the downloaded file has the following format:

        ```
        https://{{ s3-storage-host }}/<bucket-name>/<path-to-file>
        ```

        The link will contain additional query parameters (after `?`) for buckets with restricted access. You do not need to pass these parameters in {{ speechkit-name }} as they are ignored.

## Send a file for recognition

Send your file for recognition using a POST request:

### HTTP request

```
POST https://transcribe.api.cloud.yandex.net/speech/stt/v2/longRunningRecognize
```

### Parameters in the request body

```json
{
    "config": {
        "specification": {
            "languageCode": "string",
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
| ----- | ----- |
| config | **object**<br>Field with the recognition settings and folder ID. |
| config.<br>specification | **object**<br>Recognition settings. |
| config.<br>specification.<br>languageCode | **string**<br>The language to use for recognition.<br/>Acceptable values:<ul><li>`ru-RU` (by default) — Russian.</li><li>`en-US` — English.</li><li>`tr-TR` — Turkish.</li></ul> |
| config.<br>specification.<br>profanityFilter | **boolean**<br>The profanity filter.<br/>Acceptable values:<ul><li>`true` — Exclude profanity from recognition results.</li><li>`false` (by default) — Do not exclude profanity from recognition results.</li></ul> |
| config.<br>specification.<br>audioEncoding | **string**<br>[The format](formats.md) of the submitted audio.<br/>Acceptable values:<ul><li>`LINEAR16_PCM` — [LPCM with no WAV header](formats.md#lpcm).</li><li>`OGG_OPUS` (by default) — [OggOpus](formats.md#oggopus) format.</li></ul> |
| config.<br>specification.<br>sampleRateHertz | **integer** (int64)<br>The sampling frequency of the submitted audio.<br/>Required if `format` is set to `LINEAR16_PCM`. Acceptable values:<ul><li>`48000` (default) — Sampling rate of 48 kHz.</li><li>`16000` — Sampling rate of 16 kHz.</li><li>`8000` — Sampling rate of 8 kHz.</li></ul> |
| config.<br>specification.<br>audioChannelCount | **integer** (int64)<br>The number of channels in [LPCM](formats.md#lpcm) files. By default, `1`.<br>Do not use this field for [OggOpus](formats.md#oggopus) files. |
| audio.<br>uri | **string**<br>The URI of the audio file for recognition. Supports only links to files stored in [Yandex Object Storage](/docs/storage/). |

### Response

If your request is written correctly, the service returns the [Operation object](../../api-design-guide/concepts/operation.md) with the recognition operation ID (`id`):

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

## Get recognition results

[Monitor the recognition results](../../api-design-guide/concepts/operation.md#monitoring) using the received ID. The number of result monitoring requests is [limited](../concepts/limits.md), so consider the recognition speed: it takes about 10 seconds to recognize 1 minute of single-channel audio.

{% note important %}

Recognition results are stored on the {{ stt-long-resultsStorageTime }} server. You can then request the recognition results using the received ID.

{% endnote %}

### HTTP request

```
GET https://operation.api.cloud.yandex.net/operations/{operationId}
```

### Path parameters

| Parameter | Description |
| ----- | ----- |
| operationId | The operation ID received when sending the recognition request. |

### Response

Once the recognition is complete, the `done` field will be set to `true` and the `response` field will contain a list of recognition results (`chunks[]`).

Each result in the `chunks[]` list contains the following fields:

* `alternatives[]` — List of alternative recognition results. Each alternative contains the following fields:
    * `words[]` — List of recognized words.
      * `startTime` — Time stamp of the beginning of the word in the recording.
      * `endTime` — Time stamp of the end of the word.
      * `word` — Recognized word. Recognized numbers are written in words (for example, `twelve` rather than `12`).
      * `confidence` — Recognition accuracy. Currently the service always returns `1`, which is equivalent to 100%.
    * `text` — Entire recognized text.
    * `confidence` — Recognition accuracy. Currently the service always returns `1`, which is equivalent to 100%.
* `channelTag` — Audio channel that recognition was performed for.

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

## Examples {#examples}

* [#T](#examples_ogg)
* [#T](#examples_lpcm)

### Recognize Russian speech in OggOpus format {#examples_ogg}

To recognize speech in the [OggOpus](formats.md#oggopus) format, just specify the recognition language in the configuration's `languageCode` field. If no language is specified, the service will use Russian.

Enter the link to the uploaded audio file in the `uri` field.

1. Create a request body and save it to a file (for example, `body.json`):

    ```json
    {
        "config": {
            "specification": {
                "languageCode": "ru-RU"
            }
        },
        "audio": {
            "uri": "https://storage.yandexcloud.net/speechkit/speech.ogg"
        }
    }
    ```

1. Send a recognition request:

    ```bash
    $ export IAM_TOKEN=CggaATEVAgA...
    $ curl -X POST \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d @body.json \
        https://transcribe.api.cloud.yandex.net/speech/stt/v2/longRunningRecognize

    {
        "done": false,
        "id": "e03sup6d5h1qr574ht99",
        "createdAt": "2019-04-21T22:49:29Z",
        "createdBy": "ajes08feato88ehbbhqq",
        "modifiedAt": "2019-04-21T22:49:29Z"
    }
    ```

    Save the recognition operation ID that you received in the response.

1. Wait a while for the recognition to complete. It takes about 10 seconds to recognize 1 minute of a single-channel audio file.

1. Send a request to [get information about the operation](../../api-design-guide/concepts/operation.md#monitoring):

    ```bash
    $ curl -H "Authorization: Bearer ${IAM_TOKEN}" \
        https://operation.api.cloud.yandex.net/operations/e03sup6d5h1qr574ht99

    {
    "done": true, "response": {
     "@type": "type.googleapis.com/yandex.cloud.ai.stt.v2.LongRunningRecognitionResponse",
     "chunks": [
      {
       "alternatives": [
        {
         "text": "your number is 212-85-06",
         "confidence": 1
        }
       ],
       "channelTag": "1"
      }
     ]
    },
    "id": "e03sup6d5h1qr574ht99",
    "createdAt": "2019-04-21T22:49:29Z",
    "createdBy": "ajes08feato88ehbbhqq",
    "modifiedAt": "2019-04-21T22:49:36Z"
    }
    ```

### Recognize speech in LPCM format {#examples_lpcm}

To recognize speech in the [LPCM](formats.md#lpcm) format, specify in the recognition settings the file sampling frequency and the number of audio channels in it. Set the recognition language in the `languageCode` field. If no language is specified, the service will use Russian.

1. Create a request body and save it to a file (for example, `body.json`):

    ```json
    {
        "config": {
            "specification": {
                "languageCode": "ru-RU",
                "audioEncoding": "LINEAR16_PCM",
                "sampleRateHertz": 8000,
                "audioChannelCount": 1
            }
        },
        "audio": {
            "uri": "https://storage.yandexcloud.net/speechkit/speech.pcm"
        }
    }
    ```

1. Send a recognition request:

    ```bash
    $ export IAM_TOKEN=CggaATEVAgA...
    $ curl -X POST \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d @body.json \
        https://transcribe.api.cloud.yandex.net/speech/stt/v2/longRunningRecognize

    {
        "done": false,
        "id": "e03sup6d5h1qr574ht99",
        "createdAt": "2019-04-21T22:49:29Z",
        "createdBy": "ajes08feato88ehbbhqq",
        "modifiedAt": "2019-04-21T22:49:29Z"
    }
    ```

    Save the recognition operation ID that you received in the response.

1. Wait a while for the recognition to complete. It takes about 10 seconds to recognize 1 minute of a single-channel audio file.

1. Send a request to [get information about the operation](../../api-design-guide/concepts/operation.md#monitoring):

    ```bash
    $ curl -H "Authorization: Bearer ${IAM_TOKEN}" \
        https://operation.api.cloud.yandex.net/operations/e03sup6d5h1qr574ht99

    {
    "done": true, "response": {
     "@type": "type.googleapis.com/yandex.cloud.ai.stt.v2.LongRunningRecognitionResponse",
     "chunks": [
      {
       "alternatives": [
        {
         "text": "hello world",
         "confidence": 1
        }
       ],
       "channelTag": "1"
      }
     ]
    },
    "id": "e03sup6d5h1qr574ht99",
    "createdAt": "2019-04-21T22:49:29Z",
    "createdBy": "ajes08feato88ehbbhqq",
    "modifiedAt": "2019-04-21T22:49:36Z"
    }
    ```

