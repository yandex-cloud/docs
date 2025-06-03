1. [Get a link to an audio file](../../storage/operations/objects/link-for-download.md) in {{ objstorage-name }}.
1. Create a file, e.g., `request.json`, and add the following code to it:

    ```json
    {
      "uri": "https://{{ s3-storage-host }}/<bucket_name>/<path_to_WAV_file_in_bucket>",
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

    * `model`: Speech recognition model.
    * `container_audio_type`: Audio container format.

1. Run the request using one of the service account authentication methods:
    * With an [IAM token](../../iam/concepts/authorization/iam-token.md):

      ```bash
      export IAM_TOKEN=<service_account_IAM_token> && \
      curl \
        --insecure \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data @request.json https://{{ api-host-sk-stt }}:443/stt/v3/recognizeFileAsync
      ```

      Where `IAM_TOKEN` is the IAM token of the service account.

    * With an [API key](../../iam/concepts/authorization/api-key).

      {% include [api-keys-disclaimer](../../_includes/iam/api-keys-disclaimer.md) %}

      ```bash
      export API_KEY=<service_account_API_key> && \
      curl \
        --insecure \
        --header "Authorization: Api-Key ${API_KEY}" \
        --data @request.json https://{{ api-host-sk-stt }}:443/stt/v3/recognizeFileAsync
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

    Save the recognition operation `id` you get in the response.

1. Wait until the recognition is complete. It takes about 10 seconds to recognize one minute of audio.
1. [Request information](../../api-design-guide/concepts/operation.md#monitoring) about the operation:

    * Authentication with an IAM token:

        ```bash
        curl \
          --insecure \
          --request GET \
          --header "Authorization: Bearer ${IAM_TOKEN}" \
          https://operation.{{ api-host-sk }}/operations/<recognition_operation_ID>
        ```

    * Authentication with an API key:

        ```bash
        curl \
          --insecure \
          --request GET \
          --header "Authorization: Api-key ${API_KEY}" \
          https://operation.{{ api-host-sk }}/operations/<recognition_operation_ID>
        ```

    Result example:

    ```text
    {
       "done": true,
       "id": "f8ddr61b30fk********",
       "description": "STT v3 async recognition",
       "createdAt": "2024-07-15T07:39:36Z",
       "createdBy": "ajehumcuv38h********",
       "modifiedAt": "2024-07-15T07:39:37Z"
    }
    ```

1. Request the operation result:

    * Authentication with an IAM token:

        ```bash
        curl \
          --insecure \
          --request GET \
          --header "Authorization: Bearer ${IAM_TOKEN}" \
          https://{{ api-host-sk-stt }}:443/stt/v3/getRecognition?operation_id=<recognition_operation_ID>
        ```

    * Authentication with an API key:

        ```bash
        curl \
          --insecure \
          --request GET \
          --header "Authorization: Api-key ${API_KEY}" \
          https://{{ api-host-sk-stt }}:443/stt/v3/getRecognition?operation_id=<recognition_operation_ID>
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
                         "text": "I",
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
                         "text": "turn",
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
                            "text": "I",
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
                            "text": "turn",
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
