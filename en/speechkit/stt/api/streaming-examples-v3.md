# Example use of streaming recognition with API v3

The example shows how you can recognize speech in LPCM format in real time using the {{ speechkit-short-name }} [API v3](../../stt-v3/api-ref/grpc/index.md).

The example uses the following parameters:

* [Language](../index.md#langs): Russian.
* Format of the audio stream: [LPCM](../../formats.md#LPCM) with a sampling rate of 8000 Hz.
* [Number of audio channels](../../stt-v3/api-ref/grpc/stt_service#RawAudio): 1 (default).
* [Profanity filter](../../stt-v3/api-ref/grpc/stt_service#TextNormalizationOptions) enabled.
* Other parameters were left with their default values.

To use the API, you need the `grpcio-tools` package.

An [IAM token](../../../iam/concepts/authorization/iam-token.md) is used to authenticate the service account. Learn more about [authentication in the {{speechkit-name}} API](../../concepts/auth.md).

To implement an example from this section:

1. Clone the [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi) repository:

   ```bash
   git clone https://github.com/yandex-cloud/cloudapi
   ```

1. Download a [sample](https://{{ s3-storage-host }}/speechkit/speech.pcm) audio file for recognition.

1. Create a client application:

{% list tabs %}

- Python 3

   1. Install the `grpcio-tools` package using the [pip](https://pip.pypa.io/en/stable/) package manager:

      ```bash
      pip install grpcio-tools
      ```

   1. Go to the directory hosting the cloned {{ yandex-cloud }} API repository, create the `output` directory, and generate the client interface code there:

      ```bash
      cd <path_to_cloudapi_directory>
      mkdir output
      python -m grpc_tools.protoc -I . -I third_party/googleapis \
        --python_out=output \
        --grpc_python_out=output \
          google/api/http.proto \
          google/api/annotations.proto \
          yandex/cloud/api/operation.proto \
          google/rpc/status.proto \
          yandex/cloud/operation/operation.proto \
          yandex/cloud/ai/stt/v3/stt_service.proto \
          yandex/cloud/ai/stt/v3/stt.proto
      ```

      As a result, the `stt_pb2.py`, `stt_pb2_grpc.py`, `stt_service_pb2.py`, `stt_service_pb2_grpc.py` client interface files as well as dependency files will be created in the `output` directory.

   1. Create a file (for example, `test.py`) in the root of the `output` directory and add the following code to it:

      ```python
      #coding=utf8
      import argparse

      import grpc

      import yandex.cloud.ai.stt.v3.stt_pb2 as stt_pb2
      import yandex.cloud.ai.stt.v3.stt_service_pb2_grpc as stt_service_pb2_grpc

      CHUNK_SIZE = 4000

      def gen(audio_file_name):
          # Specify the recognition settings.
          recognize_options = stt_pb2.StreamingOptions(
              recognition_model=stt_pb2.RecognitionModelOptions(
                  audio_format=stt_pb2.AudioFormatOptions(
                      raw_audio=stt_pb2.RawAudio(
                          audio_encoding=stt_pb2.RawAudio.LINEAR16_PCM,
                          sample_rate_hertz=8000,
                          audio_channel_count=1
                      )
                  ),
                  text_normalization=stt_pb2.TextNormalizationOptions(
                      text_normalization=stt_pb2.TextNormalizationOptions.TEXT_NORMALIZATION_ENABLED,
                      profanity_filter=True,
                      literature_text=False
                  ),
                  language_restriction=stt_pb2.LanguageRestrictionOptions(
                      restriction_type=stt_pb2.LanguageRestrictionOptions.WHITELIST,
                      language_code=['ru-RU']
                  ),
                  audio_processing_type=stt_pb2.RecognitionModelOptions.REAL_TIME
              )
          )

          # Send a message with recognition settings.
          yield stt_pb2.StreamingRequest(session_options=recognize_options)

          # Read the audio file and send its contents in portions.
          with open(audio_file_name, 'rb') as f:
              data = f.read(CHUNK_SIZE)
              while data != b'':
                  yield stt_pb2.StreamingRequest(chunk=stt_pb2.AudioChunk(data=data))
                  data = f.read(CHUNK_SIZE)

      def run(iam_token, audio_file_name):
          # Establish a connection with the server.
          cred = grpc.ssl_channel_credentials()
          channel = grpc.secure_channel('{{ api-host-sk-stt }}:443', cred)
          stub = stt_service_pb2_grpc.RecognizerStub(channel)

          # Send data for recognition.
          it = stub.RecognizeStreaming(gen(audio_file_name), metadata=(
              ('authorization', f'Bearer {iam_token}'),
          ))

          # Process the server responses and output the result to the console.
          try:
              for r in it:
                  event_type, alternatives = r.WhichOneof('Event'), None
                  if event_type == 'partial' and len(r.partial.alternatives) > 0:
                      alternatives = [a.text for a in r.partial.alternatives]
                  if event_type == 'final':
                      alternatives = [a.text for a in r.final.alternatives]
                  if event_type == 'final_refinement':
                      alternatives = [a.text for a in r.final_refinement.normalized_text.alternatives]
                  print(f'type={event_type}, alternatives={alternatives}')
          except grpc._channel._Rendezvous as err:
              print(f'Error code {err._state.code}, message: {err._state.details}')
              raise err

      if __name__ == '__main__':
          parser = argparse.ArgumentParser()
          parser.add_argument('--token', required=True, help='IAM token')
          parser.add_argument('--path', required=True, help='audio file path')
          args = parser.parse_args()
          run(args.token, args.path)
      ```

      Where:

      * `audio_encoding`: [Format](../../formats.md) of the audio stream.
      * `sample_rate_hertz`: Sampling rate.
      * `audio_channel_count`: Number of audio channels.
      * `profanity_filter`: [Profanity filter](../../stt-v3/api-ref/grpc/stt_service#TextNormalizationOptions).
      * `literature_text`: [Flag to generate the recognized text in a literary style](../../stt-v3/api-ref/grpc/stt_service#TextNormalizationOptions).
      * `language_code`: [Language](../index.md#langs) that recognition is performed for.

   1. Use the [IAM token](../../../iam/concepts/authorization/iam-token.md) of the service account:

      ```bash
      export IAM_TOKEN=<service_account_IAM_token>
      ```

   1. Run the created file:

      ```bash
      python output/test.py --token ${IAM_TOKEN} --path <path_to_speech.pcm>
      ```

      Where `path` is the path to the audio file to recognize:

      Result:

      ```bash
      type=status_code, alternatives=None
      type=partial, alternatives=None
      type=partial, alternatives=['hello world']
      type=final, alternatives=['hello world']
      type=final_refinement, alternatives=['Hello world']
      type=eou_update, alternatives=None
      type=partial, alternatives=None
      type=status_code, alternatives=None
      ```

{% endlist %}

#### See also {#see-also}

* [Learn more about the API v3](../../stt-v3/api-ref/grpc/)
* [{#T}](../../concepts/auth.md)
