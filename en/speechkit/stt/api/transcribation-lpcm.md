# Asynchronously recognizing audio files in LPCM format

Below is an example of [asynchronous recognition of speech](../transcribation.md) from an audio file using the {{ speechkit-name }} [API v2](transcribation-api.md). This example uses the following parameters:

* [Language](../models.md#languages): Russian
* [Language model](../models.md#tags): `general:rc`
* Format of the submitted audio: [LPCM](../../formats.md#LPCM) with a sampling rate of 8000 Hz
* [Number of audio channels](transcribation-api.md#sendfile-params): 1 (default)
* Other parameters left by default.

You can generate and send a speech recognition request using [cURL](https://curl.haxx.se).

An [IAM token](../../../iam/concepts/authorization/iam-token.md) is used to authenticate the service account. Learn more about [authentication in the {{speechkit-name}} API](../../concepts/auth.md).

## Getting started {#before-you-begin}

{% include [transcribation-before-you-begin](../../../_includes/speechkit/transcribation-before-you-begin.md) %}

If you do not have an LPCM audio file, you can download a [sample file](https://{{ s3-storage-host }}/speechkit/speech.pcm).

## Perform speech recognition via the API {#recognize-using-api}

{% list tabs %}

- cURL

   1. [Get a link to an audio file](../../../storage/operations/objects/link-for-download.md) in {{ objstorage-name }}.
   1. Create a file, e.g., `body.json`, and paste the following code to it:

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
              "uri": "<link_to_audio_file>"
          }
      }
      ```

      Where:

      * `languageCode`: [Recognition language](../models.md#languages)
      * `model`: [Language model](../models.md#tags)
      * `audioEncoding`: [Format](../../formats.md) of the submitted audio
      * `sampleRateHertz`: Audio file sampling rate in Hz
      * `audioChannelCount`: Number of audio channels
      * `uri`: Link to audio file in {{ objstorage-name }}. Sample link: `https://{{ s3-storage-host }}/speechkit/speech.pcm`.

         The link contains additional query parameters (after `?`) for buckets with restricted access. You do not need to provide these parameters in {{ speechkit-name }} as they are ignored.

   1. Run the created file:

      ```bash
      export IAM_TOKEN=<service_account_IAM_token> && \
      curl -X POST \
          -H "Authorization: Bearer ${IAM_TOKEN}" \
          -d "@body.json"\
          https://transcribe.{{ api-host }}/speech/stt/v2/longRunningRecognize
      ```

      Where `IAM_TOKEN` is an [IAM token](../../../iam/concepts/authorization/iam-token.md) of the service account.

      Result example:

      ```text
      {
          "done": false,
          "id": "e03sup6d5h1qr574ht99",
          "createdAt": "2019-04-21T22:49:29Z",
          "createdBy": "ajes08feato88ehbbhqq",
          "modifiedAt": "2019-04-21T22:49:29Z"
      }
      ```

      Save the recognition operation `id` that you receive in the response.

   1. Wait a while for the recognition to complete. It takes about 10 seconds to recognize one minute of a single-channel audio file.
   1. Send a request to [get information about the operation](../../../api-design-guide/concepts/operation.md#monitoring):

      ```bash
      curl -H "Authorization: Bearer ${IAM_TOKEN}" \
          https://operation.{{ api-host }}/operations/<recognition_operation_ID>
      ```

      Result example:

      ```text
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
