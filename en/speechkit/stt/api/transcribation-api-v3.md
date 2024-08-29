---
title: "Asynchronous WAV audio file recognition using the {{ speechkit-full-name }} API v3"
description: "Follow this guide to use asynchronous WAV audio file recognition in the API v3."
---

# Asynchronous WAV audio file recognition using the API v3

The example below illustrates how to use the {{ speechkit-name }} [API v3](../../stt-v3/api-ref/grpc/index.md) to perform asynchronous speech recognition on a WAV audio file. This example uses the following parameters:

* Audio stream format: WAV.
* [Speech recognition model](../models.md): `General`.
* Other parameters left by default.

Authentication is performed under a service account using an [API key](../../../iam/concepts/authorization/api-key.md) or [IAM token](../../../iam/concepts/authorization/iam-token.md). For more information about authentication in the {{ speechkit-name }} API, see the [API reference](../../concepts/auth.md).

## Getting started {#before-you-begin}

{% include [transcribation-before-you-begin](../../../_includes/speechkit/transcribation-before-you-begin.md) %}

If you do not have a WAV audio file, you can use a [sample file](https://{{ s3-storage-host }}/doc-files/speech.wav).

## Perform speech recognition via the API v3 {#recognize-using-api-v3}

{% list tabs group=programming_language %}

- cURL {#curl}

   1. [Get a link to an audio file](../../../storage/operations/objects/link-for-download.md) in {{ objstorage-name }}.
   1. Create a file, e.g., `request.json`, and paste the following code to it:

      ```json
      {
        "uri": "https://storage.yandexcloud.net/<bucket_name>/<path_to_wav_file_in_bucket>",
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

      * `uri`: Link to the audio file in {{ objstorage-name }}, e.g., `https://{{ s3-storage-host }}/speechkit/speech.opus`.

         The link contains additional query parameters (after `?`) for buckets with restricted access. You do not need to provide these parameters in {{ speechkit-name }} as they are ignored.

      * `model`: [Speech recognition model](../models.md).
      * `container_audio_type`: Audio container format.

   1. Run the request using one of the service account authentication methods:
      * With an [IAM token](../../../iam/concepts/authorization/iam-token.md):

         ```bash
         export IAM_TOKEN=<service_account_IAM_token> && \
         curl -k \
              -H "Authorization: Bearer ${IAM_TOKEN}" \
              -d @request.json https://stt.api.cloud.yandex.net:443/stt/v3/recognizeFileAsync
         ```

         Where `IAM_TOKEN` is the IAM token of the service account.

      * With [API keys](../../../iam/concepts/authorization/api-key).

         {% include [api-keys-disclaimer](../../../_includes/iam/api-keys-disclaimer.md) %}

         ```bash
         export API_KEY=<service_account_API_key> && \
         curl -k \
              -H "Authorization: Api-Key ${API_KEY}" \
              -d @request.json https://stt.api.cloud.yandex.net:443/stt/v3/recognizeFileAsync
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

      Save the recognition operation `id` that you received in the response.

   1. Wait for the recognition to complete. It takes about 10 seconds to recognize one minute of an audio file.
   1. [Request information](../../../api-design-guide/concepts/operation.md#monitoring) about the operation:

      * Authorization using an IAM token:

         ```bash
         curl -k \
              -X GET \
              -H "Authorization: Bearer ${IAM_TOKEN}" \
              https://operation.api.cloud.yandex.net/operations/<recognition_operation_ID>
         ```

      * Authorization using an API key:

         ```bash
         curl -k \
              -X GET \
              -H "Authorization: Api-key ${API_KEY}" \
              https://operation.api.cloud.yandex.net/operations/<recognition_operation_ID>
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

      * Authorization using an IAM token:

         ```bash
         curl -k \
              -X GET \
              -H "Authorization: Bearer ${IAM_TOKEN}" \
              https://stt.api.cloud.yandex.net:443/stt/v3/getRecognition?operation_id=<recognition_operation_ID>
         ```

      * Authorization using an API key:

         ```bash
         curl -k \
              -X GET \
              -H "Authorization: Api-key ${API_KEY}" \
              https://stt.api.cloud.yandex.net:443/stt/v3/getRecognition?operation_id=<recognition_operation_ID>
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
                           "text": "I'm",
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
                             "text": "I'm",
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

- Python 3 {#python}

   1. Clone the [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi) repository:

      ```bash
      git clone https://github.com/yandex-cloud/cloudapi
      ```

   1. Install the `grpcio-tools` package using the [pip](https://pip.pypa.io/en/stable/) package manager:

      ```bash
      pip install grpcio-tools
      ```

   1. Go to the folder hosting the cloned {{ yandex-cloud }} API repository, create a folder named `output`, and generate the client interface code there:

      ```bash
      cd <path_to_cloudapi_folder>
      mkdir output
      python3 -m grpc_tools.protoc -I . -I third_party/googleapis \
        --python_out=output \
        --grpc_python_out=output \
        google/api/http.proto \
        google/api/annotations.proto \
        yandex/cloud/api/operation.proto \
        google/rpc/status.proto \
        yandex/cloud/operation/operation.proto \
        yandex/cloud/validation.proto \
        yandex/cloud/ai/stt/v3/stt_service.proto \
        yandex/cloud/ai/stt/v3/stt.proto
      ```

      The `stt_pb2.py`, `stt_pb2_grpc.py`, `stt_service_pb2.py`, and `stt_service_pb2_grpc.py` client interface files, as well as dependency files, will be created in the `output` folder.

   1. Create a file, e.g., `test.py`, in the `output` folder root and add the following API request code to it:

      ```python
      import grpc
      from yandex.cloud.ai.stt.v3 import stt_pb2, stt_service_pb2_grpc

      request = stt_pb2.RecognizeFileRequest(
        uri='https://storage.yandexcloud.net/<bucket_name>/<path_to_wav_file_in_bucket>',
        recognition_model=stt_pb2.RecognitionModelOptions(
          model='general',
          audio_format=stt_pb2.AudioFormatOptions(
            container_audio=stt_pb2.ContainerAudio(
              container_audio_type=stt_pb2.ContainerAudio.WAV
            )
          )
        )
      )

      cred = grpc.ssl_channel_credentials()
      chan = grpc.secure_channel('stt.api.cloud.yandex.net:443', cred)
      stub = stt_service_pb2_grpc.AsyncRecognizerStub(chan)

      # Select one of the authentication methods:

      # Authentication with an IAM token
      response = stub.RecognizeFile(request, metadata=[('authorization', 'Bearer <IAM_token>')])

      # Authentication with an API key
      # response = stub.RecognizeFile(request, metadata=[('authorization', 'Api-Key <API_key>')])

      print(response)
      ```

   1. Run the following query:

      ```bash
      python3 test.py
      ```

      Result:

      ```bash
      id: "f8dem628l2mq********"
      description: "STT v3 async recognition"
      created_at {
        seconds: 1721032219
      }
      created_by: "ajehumcuv38h********"
      modified_at {
        seconds: 1721032219
      }
      ```

      Save the recognition operation `id` that you received in the response.

   1. Create a file, e.g., `results.py`, in the `output` folder root and add the following code to it to get the operation result:

      ```python
      import grpc
      from yandex.cloud.ai.stt.v3 import stt_pb2, stt_service_pb2_grpc, stt_service_pb2

      request = stt_service_pb2.GetRecognitionRequest(
          operation_id="<operation_ID>"
      )

      cred = grpc.ssl_channel_credentials()
      chan = grpc.secure_channel('stt.api.cloud.yandex.net:443', cred)
      stub = stt_service_pb2_grpc.AsyncRecognizerStub(chan)

      # Authentication with an IAM token
      response = stub.GetRecognition(request, metadata=[('authorization', 'Bearer <IAM_token>')])

      # Authentication with an API key
      # response = stub.GetRecognition(request, metadata=[('authorization', 'Api-Key <API_key>')])

      print(list(response))
      ```

   1. Run the following query:

      ```bash
      python3 results.py
      ```

      {% cut "Result example" %}

      ```bash
      [session_uuid {
        uuid: "df49eaa2-25a55218-ae967fa1-********"
        user_request_id: "f8dkup42nmhk********"
      }
      audio_cursors {
        received_data_ms: 6600
        partial_time_ms: 6600
        final_time_ms: 6600
      }
      response_wall_time_ms: 204
      final {
        alternatives {
          words {
            text: "I'm"
            start_time_ms: 380
            end_time_ms: 420
          }
          words {
            text: "Yandex"
            start_time_ms: 539
            end_time_ms: 919
          }
          words {
            text: "SpeechKit"
            start_time_ms: 960
            end_time_ms: 1719
          }
          words {
            text: "I"
            start_time_ms: 2159
            end_time_ms: 2200
          }
          words {
            text: "can"
            start_time_ms: 2260
            end_time_ms: 2440
          }
          words {
            text: "turn"
            start_time_ms: 2520
            end_time_ms: 3000
          }
          words {
            text: "any"
            start_time_ms: 3060
            end_time_ms: 3320
          }
          words {
            text: "text"
            start_time_ms: 3419
            end_time_ms: 3740
          }
          words {
            text: "into"
            start_time_ms: 3780
            end_time_ms: 3800
          }
          words {
            text: "speech"
            start_time_ms: 3860
            end_time_ms: 4279
          }
          words {
            text: "now"
            start_time_ms: 4680
            end_time_ms: 5240
          }
          words {
            text: "you"
            start_time_ms: 5339
            end_time_ms: 5380
          }
          words {
            text: "can"
            start_time_ms: 5460
            end_time_ms: 5766
          }
          words {
            text: "too"
            start_time_ms: 5920
            end_time_ms: 6393
          }
          text: "I'm Yandex SpeechKit I can turn any text into speech now you can too"
          end_time_ms: 6600
        }
        channel_tag: "0"
      }
      channel_tag: "0"
      , session_uuid {
        uuid: "df49eaa2-25a55218-ae967fa1-********"
        user_request_id: "f8dkup42nmhk********"
      }
      audio_cursors {
        received_data_ms: 6600
        partial_time_ms: 6600
        final_time_ms: 6600
      }
      response_wall_time_ms: 204
      final_refinement {
        normalized_text {
          alternatives {
            words {
              text: "I'm"
              start_time_ms: 380
              end_time_ms: 420
            }
            words {
              text: "Yandex"
              start_time_ms: 539
              end_time_ms: 919
            }
            words {
              text: "SpeechKit"
              start_time_ms: 960
              end_time_ms: 1719
            }
            words {
              text: "I"
              start_time_ms: 2159
              end_time_ms: 2200
            }
            words {
              text: "can"
              start_time_ms: 2260
              end_time_ms: 2440
            }
            words {
              text: "turn"
              start_time_ms: 2520
              end_time_ms: 3000
            }
            words {
              text: "any"
              start_time_ms: 3060
              end_time_ms: 3320
            }
            words {
              text: "text"
              start_time_ms: 3419
              end_time_ms: 3740
            }
            words {
              text: "into"
              start_time_ms: 3780
              end_time_ms: 3800
            }
            words {
              text: "speech"
              start_time_ms: 3860
              end_time_ms: 4279
            }
            words {
              text: "now"
              start_time_ms: 4680
              end_time_ms: 5240
            }
            words {
              text: "you"
              start_time_ms: 5339
              end_time_ms: 5380
            }
            words {
              text: "can"
              start_time_ms: 5460
              end_time_ms: 5766
            }
            words {
              text: "too"
              start_time_ms: 5920
              end_time_ms: 6393
            }
            text: "I'm Yandex SpeechKit I can turn any text into speech now you can too"
            end_time_ms: 6600
          }
          channel_tag: "0"
        }
      }
      channel_tag: "0"
      , session_uuid {
        uuid: "df49eaa2-25a55218-ae967fa1-********"
        user_request_id: "f8dkup42nmhk********"
      }
      audio_cursors {
        received_data_ms: 6600
        partial_time_ms: 6600
        final_time_ms: 6600
        eou_time_ms: 6600
      }
      response_wall_time_ms: 204
      eou_update {
        time_ms: 6600
      }
      channel_tag: "0"
      ]
      ```

      {% endcut %}

{% endlist %}
