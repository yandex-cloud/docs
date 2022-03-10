# Streaming mode for short audio recognition

Data streaming mode allows you to simultaneously send audio for recognition and get recognition results over the same connection.

Unlike other [recognition methods](./index.md#stt-ways), you can get intermediate results while speech is in progress. After a pause, the service returns final results and starts recognizing the next utterance.

> For example, as soon as the user starts talking to [Yandex.Station](https://station.yandex.ru/), the speaker begins transmitting the speech to the server for recognition. The server processes the data and returns the intermediate and final results of each utterance recognition. The intermediate results are used for showing the user the progress of speech recognition. Once the final results are available, Yandex.Station performs the requested action, such as playing a movie.

To use the service, create an app that will perform speech recognition in data streaming mode, i.e., send audio fragments and process responses with recognition results.

{% note warning %}

Streaming mode is designed for real-time audio recognition. If you need to send a recorded audio file, use [a different method](./index.md#stt-ways).

{% endnote %}

## Using the service {#service-use}

### Creating a client app {#create-client-app}

For speech recognition, the app should first send a [message with recognition settings](#specification-msg) and then send [messages with audio fragments](#audio-msg).

While the audio fragments are sent, the service simultaneously returns [recognized text fragments](#response) for processing (such as outputting them to the console).

To enable the app to access the service, you need to generate the client interface code for the programming language you use. Generate this code from the [stt_service.proto](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/ai/stt/v2/stt_service.proto) file hosted in the [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi) repository.

See [examples](#examples) of client apps below. See also the [gRPC documentation](https://grpc.io/docs/tutorials/) for detailed instructions on how to generate interfaces and implement client apps in various programming languages.

### Authorization in the service {#auth}

In each request, the application must transmit [the ID of folder](../../resource-manager/operations/folder/get-id.md) that you have been granted the `editor` role or higher for. For more information, see [Access management](../security/index.md).

The application must also be authenticated for each request, such as with an IAM token. [Learn more about service authentication](../concepts/auth.md).

### Recognition result {#results}

In each [recognition result message](#response), the server returns one or more speech fragments that it managed to recognize during this period (`chunks`). A list of recognized text alternatives is specified for each speech fragment (`alternatives`).

During the recognition process, speech is split into utterances and the end of the utterance is marked with the `endOfUtterance` flag. By default, the server returns a response only after an utterance is fully recognized. You can use the `partialResults` flag to make the server return intermediate recognition results as well. Intermediate results let you quickly respond to the recognized speech without waiting for the end of the utterance.

### Limitations of a speech recognition session {#session-restrictions}

After receiving the message with the recognition settings, the service starts a recognition session. The following limitations apply to each session:

* You can't send audio fragments too often or too rarely. The time between messages to the service should be approximately the same as the duration of the audio fragments you send, but no more than 5 seconds.

    For example, send 400 ms of audio for recognition every 400 ms.

* Maximum duration of transmitted audio for the entire session: {{ stt-streaming-audioLength }}.
* Maximum size of transmitted audio data: {{ stt-streaming-fileSize }}.

If messages aren't sent to the service within 5 seconds or the data duration or size limit is reached, the session is terminated. To continue speech recognition, reconnect and send a new message with the speech recognition settings.

## Service API {#streaming-api}

The service is located at: `stt.api.cloud.yandex.net:443`

### Message with recognition settings {#specification-msg}

| Parameter | Description |
| ----- | ----- |
| config | **object**<br>Field with the recognition settings and folder ID. |
| config<br>.specification | **object**<br>Recognition settings. |
| config<br>.specification<br>.languageCode | **string**<br>The language to use for recognition.<br/>Acceptable values:<ul><li>`ru-ru` (case-insensitive, used by default): Russian.</li><li>`en-us` (case-insensitive): English.</li><li>`tr-tr` (case-insensitive): Turkish.</li></ul> |
| config<br>.specification<br>.model | **string**<br>The language model to be used for recognition.<br/>The closer the model is matched, the better the recognition result. You can only specify one model per request.<br/>[Acceptable values](models.md) depend on the selected language. Default value: `general`. |
| config<br>.specification<br>.profanityFilter | **boolean**<br>The profanity filter.<br/>Acceptable values:<ul><li>`true`: Exclude profanity from recognition results.</li><li>`false` (default): Do not exclude profanity from recognition results.</li></ul> |
| config<br>.specification<br>.partialResults | **boolean**<br>The intermediate results filter.<br/>Acceptable values:<ul><li>`true`: Return intermediate results (part of the recognized utterance). For intermediate results, `final` is set to `false`.</li><li>`false` (default): Return only the final results (the entire recognized utterance). |
| config<br>.specification<br>.singleUtterance | **boolean**<br>Flag that disables recognition after the first utterance.<br/>Acceptable values:<ul><li>`true`: Recognize only the first utterance, stop recognition, and wait for the user to disconnect.</li><li>`false` (default): Continue recognition until the end of the session.</li></ul> |
| config<br>.specification<br>.audioEncoding | **string**<br>[The format](formats.md) of the submitted audio.<br/>Acceptable values:<ul><li>`LINEAR16_PCM`: [LPCM with no WAV header](formats.md#lpcm).</li><li>`OGG_OPUS` (default): [OggOpus](formats.md#oggopus) format.</li></ul> |
| config<br>.specification<br>.sampleRateHertz | **integer** (int64)<br>The sampling frequency of the submitted audio.<br/>Required if `format` is set to `LINEAR16_PCM`. Acceptable values:<ul><li>`48000` (default): Sampling rate of 48 kHz.</li><li>`16000`: Sampling rate of 16 kHz.</li><li>`8000`: Sampling rate of 8 kHz.</li></ul> |
| config.<br>specification.<br>rawResults | **boolean** <br>Flag that indicates how to write numbers. `true`: In words. `false` (default): In figures. |
| folderId | **string**<br><p>ID of the folder that you have access to. Required for authorization with a user account (see the <a href="../../iam/api-ref/UserAccount/index#representation">UserAccount</a> resource). Don't specify this field if you make a request on behalf of a service account.</p> <p>Maximum string length: 50 characters.</p> |

### Experimental additional recognition settings {#additional-settings}

For streaming recognition models starting from the_Marcus Aurelius_ version and above, new recognition settings are supported. They are passed to a gRPC procedure via metadata.

| Parameter | Description |
| ----- | ----- |
| `x-sensitivity-reduction-flag` | **boolean**<br>A flag that reduces the sensitivity of background noise recognition.<br>Acceptable values:<ul><li>`true`: Sensitivity is reduced.</li><li>`false` (default): Sensitivity isn't reduced. |
| `x-normalize-partials` | **boolean**<br>A flag that lets you get intermediate recognition results (parts of a recognized utterance) in normalized form: numbers are passed as digits, the profanity filter is enabled, and so on.<br>Acceptable values:<ul><li>`true`: Return a normalized result.</li><li>`false` (default): Return an unnormalized result. |

### Audio message {#audio-msg}

| Parameter | Description |
| ----- | ----- |
| `audio_content` | An audio fragment represented as an array of bytes. The audio must match the format specified in the [message with recognition settings](#specification-msg). |

### Message with recognition results {#response}

If speech fragment recognition is successful, you will receive a message containing a list of recognition results (`chunks[]`). Each result contains the following fields:

* `alternatives[]`: List of recognized text alternatives. Each alternative contains the following fields:
    * `text`: Recognized text.
    * `confidence`: This field currently isn't supported. Don't use it.
* `final`: Flag that indicates that this recognition result is final and will not change anymore. If the value is `false`, it means that the recognition result is intermediate and may change as the following speech fragments are recognized.
* `endOfUtterance`: Flag that indicates that this result contains the end of the utterance. If the value is `true`, the new utterance will start with the next result obtained.

   {% note info %}

   If you specified `singleUtterance=true` in the settings, only one utterance will be recognized per session. After sending a message where `endOfUtterance` is `true`, the server doesn't recognize the following utterances and waits until you end the session.

   {% endnote %}

### Error codes returned by the server {#error_codes}

To see how gRPC statuses correspond to HTTP codes, see [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto).

List of possible gRPC errors returned by the service:

| Code | Status | Description |
| ----- | ----- | ----- |
| 3 | `INVALID_ARGUMENT` | Incorrect request parameters specified. Details are provided in the `details` field. |
| 9 | `RESOURCE_EXHAUSTED` | A client exceeded a quota. |
| 16 | `UNAUTHENTICATED` | The operation requires authentication. Check the IAM token and the folder ID that you passed. |
| 13 | `INTERNAL` | Internal server error. This error means that the operation cannot be performed due to a server-side technical problem. For example, due to insufficient computing resources. |

## Examples {#examples}

To try the examples in this section:

1. Clone the [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi) repository:

    ```
    git clone https://github.com/yandex-cloud/cloudapi
    ```

1. [Get the ID of the folder](../../resource-manager/operations/folder/get-id.md) your account has been granted access to.
1. For authentication, the examples use an [IAM token](../../iam/concepts/authorization/iam-token.md) ([see other authentication methods](../concepts/auth.md)). Get an IAM token:
    * [Instructions](../../iam/operations/iam-token/create.md) for a Yandex account.
    * [Instructions](../../iam/operations/iam-token/create-for-sa.md) for a service account.
1. Download a [sample](https://storage.yandexcloud.net/speechkit/speech.pcm) audio file for recognition. The audio file is in [LPCM](https://en.wikipedia.org/wiki/Pulse-code_modulation) format with a sampling rate of 8000.

Then proceed to creating a client app.

{% list tabs %}

- Python 3

  1. Install the grpcio-tools package using the [pip](https://pip.pypa.io/en/stable/) package manager:

      ```bash
      $ pip install grpcio-tools
      ```

  1. Go to the directory hosting the [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi) repository, create an `output` directory, and generate the client interface code there:

      ```bash
      $ cd cloudapi
      $ mkdir output
      $ python -m grpc_tools.protoc -I . -I third_party/googleapis --python_out=output --grpc_python_out=output google/api/http.proto google/api/annotations.proto yandex/cloud/api/operation.proto google/rpc/status.proto yandex/cloud/operation/operation.proto yandex/cloud/ai/stt/v2/stt_service.proto
      ```

      As a result, the `stt_service_pb2.py` and `stt_service_pb2_grpc.py` client interface files as well as dependency files will be created in the `output` directory.

  1. Create a file (for example, `test.py`) in the root of the `output` directory and add the following code to it:

      ```python
      #coding=utf8
      import argparse
      
      import grpc
      
      import yandex.cloud.ai.stt.v2.stt_service_pb2 as stt_service_pb2
      import yandex.cloud.ai.stt.v2.stt_service_pb2_grpc as stt_service_pb2_grpc
      
      
      CHUNK_SIZE = 4000
      
      def gen(folder_id, audio_file_name):
          # Configure recognition settings.
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

- Node.js

  1. Go to the directory with the [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi) repository, create a direct named `src`, and generate a dependency file named `package.json` in it:

      ```bash
      $ cd cloudapi
      $ mkdir src
      $ cd src
      $ npm init
      ```

  1. Install the necessary packages using npm:

      ```bash
      $ npm install grpc @grpc/proto-loader google-proto-files --save
      ```

  1. Download a gRPC [public key certificate](https://github.com/grpc/grpc/blob/master/etc/roots.pem) from the official repository and save it in the root of the `src` directory.
  1. Create a file, for example `index.js`, in the root of the `src` directory and add the following code to it:

      ```js
      const fs = require('fs');
      const grpc = require('grpc');
      const protoLoader = require('@grpc/proto-loader');
      const CHUNK_SIZE = 4000;
      
      // Get the folder ID and IAM token from the environment variables.
      const folderId = process.env.FOLDER_ID;
      const iamToken = process.env.IAM_TOKEN;
      
      // Read the file specified in the arguments.
      const audio = fs.readFileSync(process.argv[2]);
      
      // Specify the recognition settings.
      const request = {
          config: {
              specification: {
                  languageCode: 'ru-RU',
                  profanityFilter: true,
                  model: 'general',
                  partialResults: true,
                  audioEncoding: 'LINEAR16_PCM',
                  sampleRateHertz: '8000'
              },
              folderId: folderId
          }
      };
      
      // How often audio is sent in milliseconds.
      // For LPCM format, the frequency can be calculated using the formula: CHUNK_SIZE * 1000 / ( 2 * sampleRateHertz).
      const FREQUENCY = 250;
      
      const serviceMetadata = new grpc.Metadata();
      serviceMetadata.add('authorization', `Bearer ${iamToken}`);
      
      const packageDefinition = protoLoader.loadSync('../yandex/cloud/ai/stt/v2/stt_service.proto', {
          includeDirs: ['node_modules/google-proto-files', '..']
      });
      const packageObject = grpc.loadPackageDefinition(packageDefinition);
      
      // Establish a connection with the server.
      const serviceConstructor = packageObject.yandex.cloud.ai.stt.v2.SttService;
      const grpcCredentials = grpc.credentials.createSsl(fs.readFileSync('./roots.pem'));
      const service = new serviceConstructor('stt.api.cloud.yandex.net:443', grpcCredentials);
      const call = service['StreamingRecognize'](serviceMetadata);
      
      // Send a message with the recognition settings.
      call.write(request);
      
      // Read the audio file and send its contents in chunks.
      let i = 1;
      const interval = setInterval(() => {
          if (i * CHUNK_SIZE <= audio.length) {
              const chunk = new Uint16Array(audio.slice((i - 1) * CHUNK_SIZE, i * CHUNK_SIZE));
              const chunkBuffer = Buffer.from(chunk);
              call.write({audioContent: chunkBuffer});
              i++;
          } else {
              call.end();
              clearInterval(interval);
          }
      }, FREQUENCY);
      
      // Process server responses and output the result to the console.
      call.on('data', (response) => {
          console.log('Start chunk: ');
          response.chunks[0].alternatives.forEach((alternative) => {
              console.log('alternative: ', alternative.text)
          });
          console.log('Is final: ', Boolean(response.chunks[0].final));
          console.log('');
      });
      
      call.on('error', (response) => {
          // Handle errors.
          console.log(response);
      });
      ```

  1. Set the `FOLDER_ID` and `IAM_TOKEN` variables used in the script and run the created file. Specify the path to the audio file in the arguments:

      ```bash
      $ export FOLDER_ID=b1gvmob95yysaplct532
      $ export IAM_TOKEN=CggaATEVAgA...
      $  node index.js speech.pcm
      
      Start chunk:
      alternative: Hello world
      Is final:  true
      ```

{% endlist %}
