# Recognizing speech in LPCM format

To recognize speech in [LPCM](../../formats.md#lpcm) format, specify the file sampling frequency and the number of audio channels in the recognition settings. Set the recognition language in the `languageCode` field and the language model in the `model` field.

{% include [ai-before-beginning](../../../_includes/ai-before-beginning.md) %}

1. Create a request body and save it to a file (such as `body.json`).

   {% note info %}

   To use the default language `model`, don't pass the model field in the request.

   {% endnote %}

   ```json
   {
       "config": {
           "specification": {
               "languageCode": "ru-RU",
               "model": "general:rc",
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

1. Send a recognition request, specifying the [IAM token](../../../iam/concepts/authorization/iam-token/) in the `IAM_TOKEN` parameter:

   ```bash
   export IAM_TOKEN=<IAM token>
   curl -X POST \
       -H "Authorization: Bearer ${IAM_TOKEN}" \
       -d '@body.json' \
       https://transcribe.{{ api-host }}/speech/stt/v2/longRunningRecognize
   
   {
       "done": false,
       "id": "e03sup6d5h1qr574ht99",
       "createdAt": "2019-04-21T22:49:29Z",
       "createdBy": "ajes08feato88ehbbhqq",
       "modifiedAt": "2019-04-21T22:49:29Z"
   }
   ```

   Save the recognition operation ID that you receive in the response.
1. Wait a while for the recognition to complete. It takes about 10 seconds to recognize 1 minute of a single-channel audio file.
1. Send a request to [get information about the operation](../../../api-design-guide/concepts/operation.md#monitoring):

   ```bash
   curl -H "Authorization: Bearer ${IAM_TOKEN}" \
       https://operation.{{ api-host }}/operations/e03sup6d5h1qr574ht99
   
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
