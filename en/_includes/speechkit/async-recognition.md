1. [Get a link to an audio file](../../storage/operations/objects/link-for-download.md) in {{ objstorage-name }}.
1. Create a file named `body.json` and add the following code to it:

   ```json
   {
      "config": {
         "specification": {
            "languageCode": "ru-RU",
            "model": "general",
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

   * `languageCode`: Recognition [language](../../speechkit/stt/models.md#languages).
   * `model`: [Speech recognition model](../../speechkit/stt/models.md#tags).
   * `audioEncoding`: [Format](../../speechkit/formats.md) of the submitted audio file.
   * `sampleRateHertz`: Audio file sampling rate in Hz.
   * `audioChannelCount`: Number of audio channels.
   * `uri`: Link to the audio file in {{ objstorage-name }}. Here is an example of such a link: `https://{{ s3-storage-host }}/speechkit/speech.pcm`.

      The link contains additional query parameters (after `?`) for buckets with restricted access. You do not need to provide these parameters in {{ speechkit-name }} as they are ignored.

1. Run the created file:

   ```bash
   export API_KEY=<service_account_API_key> && \
   curl -k \
        -H "Authorization: Api-Key ${API_KEY}" \
        -d "@body.json"\
        https://transcribe.{{ api-host }}/speech/stt/v2/longRunningRecognize
   ```

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

   Save the recognition operation `id` you get in the response.

1. Wait for the recognition to complete. It takes about 10 seconds to recognize one minute of single-channel audio.
1. Send a request to [get information about the operation](../../api-design-guide/concepts/operation.md#monitoring):

   ```bash
   curl -k -H "Authorization: Api-key ${API_KEY}" \
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
                     "words": [
                        {
                           "startTime": "0.160s",
                           "endTime": "0.500s",
                           "word": "hello",
                           "confidence": 1
                        },
                        {
                           "startTime": "0.580s",
                           "endTime": "0.800s",
                           "word": "world",
                           "confidence": 1
                        }
                     ],
                     "text": "Hello world",
                     "confidence": 1
                  }
               ],
               "channelTag": "1"
            }
         ]
      },
      "id": "e03jjenu23uc********",
      "createdAt": "2024-08-22T11:39:22Z",
      "createdBy": "aje3bg430agh********",
      "modifiedAt": "2024-08-22T11:39:23Z"
   }
   ```
