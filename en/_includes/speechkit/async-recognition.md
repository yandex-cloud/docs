1. [Get a link to an audio file](../../storage/operations/objects/link-for-download.md) in {{ objstorage-name }}.
1. Create a file named `body.json` and add the following code to it:

   {% list tabs %}

   - API v3

      ```json
      {
        "uri": "https://storage.yandexcloud.net/<bucket_name>/<path_to_WAV_file_in_bucket>",
        "recognition_model": {
          "model": "general",
          "audio_format": {
            "container_audio": {
              "container_audio_type": "WAV"
            }
          }
        }
      }
      ```

      Where:

      * `uri`: Link to the audio file in {{ objstorage-name }}. Here is an example of such a link: `https://{{ s3-storage-host }}/speechkit/speech.wav`.

         The link contains additional query parameters (after `?`) for buckets with restricted access. You do not need to provide these parameters in {{ speechkit-name }} as they are ignored.

      * `model`: [Speech recognition model](../../speechkit/stt/models.md#tags).
      * `container_audio_type`: Audio container format.

   - API v2

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

   {% endlist %}

1. Run the created file:

   {% list tabs %}

   - API v3

      ```bash
      export API_KEY=<service_account_API_key> && \
      curl -k \
           -H "Authorization: Api-Key ${API_KEY}" \
           -d "@body.json"\
           https://stt.{{ api-host }}:443/stt/v3/recognizeFileAsync
      ```

      Result example:

      ```text
      {
         "id":"f8ddr61b30fk********",
         "description":"STT v3 async recognition",
         "createdAt":"2024-07-15T07:39:36Z",
         "createdBy":"ajehumcuv38h********",
         "modifiedAt":"2024-07-15T07:39:36Z",
         "done":false,
         "metadata":null
      }
      ```

   - API v2

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

   {% endlist %}

   Save the recognition operation `id` you get in the response.

1. Wait for the recognition to complete. It takes about 10 seconds to recognize one minute of single-channel audio.
1. Send a request to [get information about the operation](../../api-design-guide/concepts/operation.md#monitoring):

   {% list tabs %}

   - API v3

      ```bash
      curl -k -H "Authorization: Api-key ${API_KEY}" \
           https://operation.{{ api-host }}/operations/<recognition_operation_ID>
      ```

      {% cut "Result example" %}

      ```text
      {
         "result": {
            "sessionUuid": {
               "uuid": "24935f24-2c1f62dc-8dd49006-********",
               "userRequestId": "f8d2h7m07t4i********"
            },
            "audioCursors": {
               "receivedDataMs": "7400",
               "resetTimeMs": "0",
               "partialTimeMs": "7400",
               "finalTimeMs": "7400",
               "finalIndex": "0",
               "eouTimeMs": "0"
            },
            "responseWallTimeMs": "189",
            "final": {
               "alternatives": [
                  {
                     "words": [
                        {
                           "text": "I’m",
                           "startTimeMs": "459",
                           "endTimeMs": "520"
                        },
                        {
                           "text": "Yandex",
                           "startTimeMs": "640",
                           "endTimeMs": "1060"
                        },
                        {
                           "text": "SpeechKit",
                           "startTimeMs": "1120",
                           "endTimeMs": "1959"
                        },
                        {
                           "text": "I",
                           "startTimeMs": "2480",
                           "endTimeMs": "2520"
                        },
                        {
                           "text": "can",
                           "startTimeMs": "2580",
                           "endTimeMs": "2800"
                        },
                        {
                           text: "turn”,
                           "startTimeMs": "2860",
                           "endTimeMs": "3360"
                        },
                        {
                           "text": "any",
                           "startTimeMs": "3439",
                           "endTimeMs": "3709"
                        },
                        {
                           "text": "text",
                           "startTimeMs": "3800",
                           "endTimeMs": "4140"
                        },
                        {
                           "text": "into",
                           "startTimeMs": "4200",
                           "endTimeMs": "4220"
                        },
                        {
                           "text": "speech",
                           "startTimeMs": "4279",
                           "endTimeMs": "4740"
                        },
                        {
                           "text": "now",
                           "startTimeMs": "5140",
                           "endTimeMs": "5759"
                        },
                        {
                           "text": "you",
                           "startTimeMs": "5859",
                           "endTimeMs": "5900"
                        },
                        {
                           "text": "can",
                           "startTimeMs": "5980",
                           "endTimeMs": "6399"
                        },
                        {
                           "text": "too",
                           "startTimeMs": "6660",
                           "endTimeMs": "7180"
                        }
                     ],
                     "text": "I'm Yandex SpeechKit I can turn any text into speech now you can too",
                     "startTimeMs": "0",
                     "endTimeMs": "7400",
                     "confidence": 0,
                     "languages": []
                  }
               ],
               "channelTag": "0"
            },
            "channelTag": "0"
         }
      }
      {
         "result": {
            "sessionUuid": {
               "uuid": "24935f24-2c1f62dc-8dd49006-********",
               "userRequestId": "f8d2h7m07t4i********"
            },
            "audioCursors": {
               "receivedDataMs": "7400",
               "resetTimeMs": "0",
               "partialTimeMs": "7400",
               "finalTimeMs": "7400",
               "finalIndex": "0",
               "eouTimeMs": "0"
            },
            "responseWallTimeMs": "189",
            "finalRefinement": {
               "finalIndex": "0",
               "normalizedText": {
                  "alternatives": [
                     {
                        "words": [
                           {
                              "text": "I’m",
                              "startTimeMs": "459",
                              "endTimeMs": "520"
                           },
                           {
                              "text": "Yandex",
                              "startTimeMs": "640",
                              "endTimeMs": "1060"
                           },
                           {
                              "text": "SpeechKit",
                              "startTimeMs": "1120",
                              "endTimeMs": "1959"
                           },
                           {
                              "text": "I’m",
                              "startTimeMs": "2480",
                              "endTimeMs": "2520"
                           },
                           {
                              "text": "can",
                              "startTimeMs": "2580",
                              "endTimeMs": "2800"
                           },
                           {
                              text: "turn",
                              "startTimeMs": "2860",
                              "endTimeMs": "3360"
                           },
                           {
                              "text": "any",
                              "startTimeMs": "3439",
                              "endTimeMs": "3709"
                           },
                           {
                              "text": "text",
                              "startTimeMs": "3800",
                              "endTimeMs": "4140"
                           },
                           {
                              "text": "into",
                              "startTimeMs": "4200",
                              "endTimeMs": "4220"
                           },
                           {
                              "text": "speech",
                              "startTimeMs": "4279",
                              "endTimeMs": "4740"
                           },
                           {
                              "text": "now",
                              "startTimeMs": "5140",
                              "endTimeMs": "5759"
                           },
                           {
                              "text": "you",
                              "startTimeMs": "5859",
                              "endTimeMs": "5900"
                           },
                           {
                              "text": "can",
                              "startTimeMs": "5980",
                              "endTimeMs": "6399"
                           },
                           {
                              "text": "too",
                              "startTimeMs": "6660",
                              "endTimeMs": "7180"
                           }
                        ],
                        "text": "I'm Yandex SpeechKit I can turn any text into speech now you can too",
                        "startTimeMs": "0",
                        "endTimeMs": "7400",
                        "confidence": 0,
                        "languages": []
                     }
                  ],
                  "channelTag": "0"
               }
            },
            "channelTag": "0"
         }
      }
      {
         "result": {
            "sessionUuid": {
               "uuid": "24935f24-2c1f62dc-8dd49006-********",
               "userRequestId": "f8d2h7m07t4i********"
            },
            "audioCursors": {
               "receivedDataMs": "7400",
               "resetTimeMs": "0",
               "partialTimeMs": "7400",
               "finalTimeMs": "7400",
               "finalIndex": "0",
               "eouTimeMs": "7400"
            },
            "responseWallTimeMs": "190",
            "eouUpdate": {
               "timeMs": "7400"
            },
            "channelTag": "0"
         }
      }
      ```

      {% endcut %}

   - API v2

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

   {% endlist %}
