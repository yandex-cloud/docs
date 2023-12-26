1. [Get a link to an audio file](../../storage/operations/objects/link-for-download.md) in {{ objstorage-name }}.
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

   * `languageCode`: [Recognition language](../../speechkit/stt/models.md#languages)
   * `model`: [Language model](../../speechkit/stt/models.md#tags)
   * `audioEncoding`: [Format](../../speechkit/formats.md) of the submitted audio
   * `sampleRateHertz`: Audio file sampling rate in Hz
   * `audioChannelCount`: Number of audio channels
   * `uri`: Link to the audio file in {{ objstorage-name }}, e.g., `https://{{ s3-storage-host }}/speechkit/speech.pcm`

      The link contains additional query parameters (after `?`) for buckets with restricted access. You do not need to provide these parameters in {{ speechkit-name }} as they are ignored.

1. Run the created file:

   ```bash
   export IAM_TOKEN=<service_account_IAM_token> && \
   curl -X POST \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d "@body.json"\
        https://transcribe.{{ api-host }}/speech/stt/v2/longRunningRecognize
   ```

   Where `IAM_TOKEN` is the [IAM token](../../iam/concepts/authorization/iam-token.md) of the service account.

   Result example:

   ```text
   {
      "done": false,
      "id": "e03sup6d5h1q********",
      "createdAt": "2019-04-21T22:49:29Z",
      "createdBy": "ajes08feato8********",
      "modifiedAt": "2019-04-21T22:49:29Z"
   }
   ```

   Save the recognition operation `id` that you received in the response.

1. Wait for the recognition to complete. It takes about 10 seconds to recognize one minute of a single-channel audio file.
1. Send a request to [get information about the operation](../../api-design-guide/concepts/operation.md#monitoring):

   ```bash
   curl -H "Authorization: Bearer ${IAM_TOKEN}" \
      https://operation.{{ api-host }}/operations/<recognition_operation_ID>
   ```

   Result example:

   ```text
   {
      "done": true,
      "response": {
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
      "id": "e03sup6d5h1q********",
      "createdAt": "2019-04-21T22:49:29Z",
      "createdBy": "ajes08feato8********",
      "modifiedAt": "2019-04-21T22:49:36Z"
   }
   ```
