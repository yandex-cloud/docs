# Asynchronously recognizing audio files in LPCM format

The example shows how the [API v2](transcribation-api.md) helps [asynchronously recognize](../transcribation.md) speech in LPCM audio file format.


The example uses the following parameters:

* [Language](../index.md#langs): Russian.
* [Language model](../models.md): `general:rc`.
* Format of the submitted audio: [LPCM](../../formats.md#LPCM) with a sampling rate of 8000 Hz.
* [Number of audio channels](transcribation-api.md#sendfile-params): 1 (default).
* Other parameters were left with their default values.

{% note info %}

To use the default parameter value, don't pass this parameter in the request.

{% endnote %}

Use the [cURL](https://curl.haxx.se) utility to generate and send a request to the server for recognition.

An [IAM token](../../../iam/concepts/authorization/iam-token.md) is used to authenticate the service account. Learn more about [authentication in the {{speechkit-name}} API](../../concepts/auth.md).

## Getting started {#before-you-begin}

{% include [transcribation-before-you-begin](../../../_includes/speechkit/transcribation-before-you-begin.md) %}

## Perform speech recognition via the API {#recognize-using-api}

{% list tabs %}

- cURL

   1. Create a file (for example, `body.json`), and add the following code to it:

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
              "uri": "https://{{ s3-storage-host }}/speechkit/speech.pcm"
          }
      }
      ```

      Where:

      * `languageCode`: [Language](../index.md#langs) that recognition is performed for.
      * `model`: [Language model](../models.md).
      * `audioEncoding`: [Format](../../formats.md) of the submitted audio.
      * `sampleRateHertz`: Sampling rate of the audio file.
      * `audioChannelCount`: Number of audio channels.
      * `uri`: Link to audio file in {{ objstorage-name }}.

   1. Run the created file:

      ```bash
      export IAM_TOKEN=<service_account_IAM_token>
      curl -X POST \
          -H "Authorization: Bearer ${IAM_TOKEN}" \
          -d "@body.json"\
          https://transcribe.{{ api-host }}/speech/stt/v2/longRunningRecognize
      ```

      Where `IAM_TOKEN` is an [IAM token](../../../iam/concepts/authorization/iam-token.md) of the service account.

      Result:

      ```bash
      {
          "done": false,
          "id": "e03sup6d5h1qr574ht99",
          "createdAt": "2019-04-21T22:49:29Z",
          "createdBy": "ajes08feato88ehbbhqq",
          "modifiedAt": "2019-04-21T22:49:29Z"
      }
      ```

      Save the recognition operation `id` that you receive in the response.

   1. Wait a while for the recognition to complete. It takes about 10 seconds to recognize one minute of a single-channel audio file.
   1. Send a request to [get information about the operation](../../../api-design-guide/concepts/operation.md#monitoring):

      ```bash
      curl -H "Authorization: Bearer ${IAM_TOKEN}" \
          https://operation.{{ api-host }}/operations/e03sup6d5h1qr574ht99
      ```

      Result:

      ```bash
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

{% endlist %}

#### See also {#see-also}

* [{#T}](transcribation-api.md)
* [{#T}](transcribation-ogg.md)
* [{#T}](batch-transcribation.md)
* [{#T}](../../concepts/auth.md)