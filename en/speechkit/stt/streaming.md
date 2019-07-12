# Streaming mode for short audio recognition

Data streaming mode allows you to simultaneously send audio for recognition and get recognition results over the same connection.

Unlike other [recognition methods](index.md#stt-ways), you can get intermediate results while speech is in progress. After a pause, the service returns final results and starts recognizing the next utterance.

> For example, as soon as the user starts talking to [Yandex.Station](https://station.yandex.ru/), the speaker begins transmitting the speech to the server for recognition. The server processes the data and returns the intermediate and final results of each utterance recognition. The intermediate results are used for showing the user the progress of speech recognition. Once the final results are available, Yandex.Station performs the requested action, such as playing a movie.

To use the service, create an app that will perform speech recognition in data streaming mode, i.e., send audio fragments and process responses with recognition results.

## Using the service

### Creating a client app

For speech recognition, the app should first send a [message with recognition settings](#specification-msg) and then send [messages with audio fragments](#audio-msg).

As the audio fragments are being sent, the service returns [recognized text fragments](#response) to be processed (for example, to output them to the console).

To enable the app to access the service, you need to generate the client interface code for the programming language you use. Generate this code from the [stt_service.proto](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/ai/stt/v2/stt_service.proto) file hosted in the [Yandex.Cloud API](https://github.com/yandex-cloud/cloudapi) repository.

See [examples](#examples) of client apps below. In addition, see the [gRPC documentation](https://grpc.io/docs/tutorials/) for detailed instructions on how to generate interfaces and deploy client apps for various programming languages.

### Authorization in the service

In each request, the application must transmit [the ID of folder](../../resource-manager/operations/folder/get-id.md) that you have been granted the `editor` role or higher for. For more information, see [Access management](../security/index.md).

The application must also be authenticated for each request, such as with an IAM token[Read more about service authentication](../concepts/auth.md).

### Recognition result

During the recognition process, the speech is segmented into phrases (known as utterances). An utterance is a fragment of speech consisting of one or more words, followed by a period of silence. An utterance may contain multiple sentences if there is no pause between them.

A speech recognition result provides alternative versions of a single utterance. The response from the service may contain multiple utterances.

_Final results_ of speech recognition are formed when the speech recognition system detects the end of an utterance. You can send multiple messages with an audio fragment and it will be a single utterance.

_Intermediate results_ of speech recognition are formed during utterance recognition. Getting intermediate results allows you to quickly respond to the recognized speech without waiting for the end of the utterance to get the final result.

You can configure the service to return intermediate recognition results. In the [message with recognition settings](#specification-msg), set `config.specification.partial_results=true`. In the response, `final=false` indicates the intermediate results and `final=true` indicates the final results.

### Limitations of a speech recognition session

After receiving the message with the recognition settings, the service starts a recognition session. The following limitations apply to each session:

* The time between sending messages to the service must not exceed 5 seconds.
* Maximum duration of transmitted audio for the entire session: 5 minutes.
* Maximum size of transmitted audio data: 10 MB.

If messages have not been sent to the service within 5 seconds or the limit on the duration or size of data has been reached, the session is terminated. To continue speech recognition, reconnect and send a new message with the speech recognition settings.

## Service API

The service is located at: `stt.api.cloud.yandex.net:443`

### Message with recognition settings {#specification-msg}

| Parameter | Description |
| ----- | ----- |
| config | **object**<br>Field with the recognition settings and folder ID. |
| config<br>.specification | **object**<br>Recognition settings. |
| config<br>.specification<br>.languageCode | **string**<br>The language to use for recognition.<br/>Acceptable values:<ul><li>`ru-RU` (by default) — Russian.</li><li>`en-US` — English.</li><li>`tr-TR` — Turkish.</li></ul> |
| config<br>.specification<br>.model | **string**<br>The language model to be used for recognition.<br/>The closer the model is matched, the better the recognition result. You can only specify one model per request.<br/>[Acceptable values](models.md) depend on the selected language. Default parameter value: `general`. |
| config<br>.specification<br>.profanityFilter | **boolean**<br>The profanity filter.<br/>Acceptable values:<ul><li>`true` — Exclude profanity from recognition results.</li><li>`false` (by default) — Do not exclude profanity from recognition results.</li></ul> |
| config<br>.specification<br>.partialResults | **boolean**<br>The intermediate results filter.<br/>Acceptable values:<ul><li>`true` — Return intermediate results (part of the recognized utterance). For intermediate results, `final` is set to `false`.</li><li>`false` (default) — Return only the final results (the entire recognized utterance). |
| config<br>.specification<br>.audioEncoding | **string**<br>[The format](formats.md) of the submitted audio.<br/>Acceptable values:<ul><li>`LINEAR16_PCM` — [LPCM with no WAV header](formats.md#lpcm).</li><li>`OGG_OPUS` (by default) — [OggOpus](formats.md#oggopus) format.</li></ul> |
| config<br>.specification<br>.sampleRateHertz | **integer** (int64)<br>The sampling frequency of the submitted audio.<br/>Required if `format` is set to `LINEAR16_PCM`. Acceptable values:<ul><li>`48000` (default) — Sampling rate of 48 kHz.</li><li>`16000` — Sampling rate of 16 kHz.</li><li>`8000` — Sampling rate of 8 kHz.</li></ul> |
| folderId | **string**<br><p>ID of the folder that you have access to. Required for authorization with a user account (see the <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a> resource). Don't specify this field if you make a request on behalf of a service account.</p> <p>Maximum string length: 50 characters.</p> |

### Audio message  {#audio-msg}

| Parameter | Description |
| ----- | ----- |
| `audio_content` | An audio fragment represented as an array of bytes. The audio must have the format specified in the [message with recognition settings](#specification-msg). |

### Response structure {#response}

If speech fragment recognition is successful, you will receive a message containing a list of recognition results (`chunks[]`). Each result contains the following fields:

* `alternatives[]` —  List of recognized text alternatives. Each alternative contains the following fields:
    * `text` — Recognized text.
    * `confidence` — Recognition accuracy. Currently the service always returns `1`, which is equivalent to 100%.
* `final` — Set to `true` if the result is final and to `false` if it is intermediate.

### Error codes returned by the server {#error_codes}

To see how gRPC statuses correspond to HTTP codes, see [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto).

List of possible gRPC errors returned by the service:

| Code | Status | Description |
| ----- | ----- | ----- |
| 3 | `INVALID_ARGUMENT` | Incorrect request parameters specified. Details are provided in the `details` field. |
| 16 | `UNAUTHENTICATED` | The operation requires authentication. Check the IAM token and the ID of the folder that you passed |
| 13 | `INTERNAL` | Internal server error. This error means that the operation cannot be performed due to a server-side technical problem. For example, due to insufficient computing resources. |

## Examples {#examples}

To try the examples in this section:

1. Clone the [Yandex.Cloud API](https://github.com/yandex-cloud/cloudapi) repository:

    ```
    git clone https://github.com/yandex-cloud/cloudapi
    ```
1. [Get the ID of the folder](../../resource-manager/operations/folder/get-id.md) your account has been granted access to.
1. In the examples, an [IAM token](../iam/concepts/authorization/iam-token) is used for authentication ([other authentication methods](../concepts/auth.md)). Get an IAM token:
    * [Instructions](../../iam/operations/iam-token/create.md) for a Yandex account.
    * [Instructions](../../iam/operations/iam-token/create-for-sa.md) for a service account.
1. Select an audio file for recognition. The examples use the `speech.pcm` audio file in the [LPCM](https://en.wikipedia.org/wiki/Pulse-code_modulation) format with a sampling rate of 8000.

    {% note info %}

    Don't have an audio file for speech recognition? Download a prepared [sample](https://storage.yandexcloud.net/speechkit/speech.pcm).

    {% endnote %}

Then proceed to creating a client app.

{% list tabs %}

- Python 3
  
  1. Install the grpcio-tools package using the [pip](https://pip.pypa.io/en/stable/) package manager:
  
      ```bash
      $ pip install grpcio-tools
      ```
  
  1. Go to the directory hosting the [Yandex.Cloud API](https://github.com/yandex-cloud/cloudapi) repository, create an `output` directory, and generate the client interface code there:
  
      ```bash
      $ cd cloudapi
      $ mkdir output
      $ python -m grpc_tools.protoc -I . -I third_party/googleapis --python_out=output --grpc_python_out=output google/api/http.proto google/api/annotations.proto yandex/api/operation.proto google/rpc/status.proto yandex/cloud/operation/operation.proto yandex/cloud/ai/stt/v2/stt_service.proto
      ```
  
      As a result, the `stt_service_pb2.py` and `stt_service_pb2_grpc.py` client interface files as well as dependency files will be created in the `output` directory.
  
  1. Create a file (for example, `test.py`) in the root of the `output` directory and add the following code to it:
  
      ```python
      #coding=utf8
      import argparse
  
      import grpc
  
      import yandex.cloud.ai.stt.v2.stt_service_pb2 as stt_service_pb2
      import yandex.cloud.ai.stt.v2.stt_service_pb2_grpc as stt_service_pb2_grpc
  
  
      CHUNK_SIZE = 16000
  
      def gen(folder_id, audio_file_name):
          # Specify the recognition settings.
          specification = stt_service_pb2.RecognitionSpec(
              language_code='ru-RU',
              profanity_filter=True,
              model='general',
              partial_results=True,
              audio_encoding='LINEAR16_PCM',
              sample_rate_hertz=8000
          )
          streaming_config = stt_service_pb2.RecognitionConfig(specification=specification, folder_id=folder_id)
  
          # Send a message with the recognition settings.
          yield stt_service_pb2.StreamingRecognitionRequest(config=streaming_config)
  
          # Read the audio file and send its contents in chunks.
          with open(audio_file_name, 'rb') as f:
              data = f.read(CHUNK_SIZE)
              while data != b'':
                  yield stt_service_pb2.StreamingRecognitionRequest(audio_content=data)
                  data = f.read(CHUNK_SIZE)
  
  
      def run(folder_id, iam_token, audio_file_name):
          # Establish a connection with the server.
          cred = grpc.ssl_channel_credentials()
          channel = grpc.secure_channel('stt.api.cloud.yandex.net:443', cred)
          stub = stt_service_pb2_grpc.SttServiceStub(channel)
  
          # Send data for recognition.
          it = stub.StreamingRecognize(gen(folder_id, audio_file_name), metadata=(('authorization', 'Bearer %s' % iam_token),))
  
          # Process server responses and output the result to the console.
          try:
              for r in it:
                  try:
                      print('Start chunk: ')
                      for alternative in r.chunks[0].alternatives:
                          print('alternative: ', alternative.text)
                      print('Is final: ', r.chunks[0].final)
                      print('')
                  except LookupError:
                      print('Not available chunks')
          except grpc._channel._Rendezvous as err:
              print('Error code %s, message: %s' % (err._state.code, err._state.details))
  
  
      if __name__ == '__main__':
          parser = argparse.ArgumentParser()
          parser.add_argument('--token', required=True, help='IAM token')
          parser.add_argument('--folder_id', required=True, help='folder ID')
          parser.add_argument('--path', required=True, help='audio file path')
          args = parser.parse_args()
  
          run(args.folder_id, args.token, args.path)
      ```
  
  1. Execute the created file by passing arguments with the IAM token, folder ID, and path to the audio file to recognize:
  
      ```bash
      $ export FOLDER_ID=b1gvmob95yysaplct532
      $ export IAM_TOKEN=CggaATEVAgA...
      $ python test.py --token ${IAM_TOKEN} --folder_id ${FOLDER_ID} --path speech.pcm
      Start chunk:
      alternative: Hello
      Is final: False
  
      Start chunk:
      alternative: Hello world
      Is final: True
      ```
  
{% endlist %}

