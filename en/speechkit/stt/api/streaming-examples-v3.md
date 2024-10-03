---
title: Audio file streaming recognition using the API v3 in {{ speechkit-full-name }}
description: Follow this guide to use streaming recognition of your audio files in the API v3.
---

# Audio file streaming recognition using the API v3

Below, we provide an example of streaming recognition of speech from an audio file using the {{ speechkit-name }} [API v3](../../stt-v3/api-ref/grpc/index.md). This example uses the following parameters:

* [Language](../models.md#languages): Russian.
* Format of the audio stream: [LPCM](../../formats.md#LPCM) with a sampling rate of 8000 Hz.
* [Number of audio channels](../../stt-v3/api-ref/grpc/stt_service#RawAudio): 1 (default).
* [Profanity filter](../../stt-v3/api-ref/grpc/stt_service#TextNormalizationOptions) enabled.
* Other parameters left by default.

Authentication is performed under a service account using an [API key](../../../iam/concepts/authorization/api-key.md) or [IAM token](../../../iam/concepts/authorization/iam-token.md). Learn more about [authentication in the {{ speechkit-name }} API](../../concepts/auth.md).

To implement an example from this section:

1. [Create](../../../iam/operations/sa/create.md) a service account to work with the {{ speechkit-short-name }} API.
1. [Assign](../../../iam/operations/sa/assign-role-for-sa.md) the `{{ roles-speechkit-stt }}` role or higher to the service account, which will allow it to work with {{ speechkit-name }} in the folder it was created in.
1. Get an [API key](../../../iam/operations/api-key/create.md) or [IAM token](../../../iam/operations/api-key/create.md) for your service account.
1. Download the [sample](https://{{ s3-storage-host }}/speechkit/speech.pcm) audio file or use your own.
1. Create a client application:

   {% list tabs group=programming_language %}

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

         As a result, the `stt_pb2.py`, `stt_pb2_grpc.py`, `stt_service_pb2.py`, and `stt_service_pb2_grpc.py` client interface files as well as dependency files will be created in the `output` directory.

      1. In the root of the `output` directory, create a file, e.g., `test.py`, and add to it the following code:

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

             # Read the audio file and send its contents in chunks.
             with open(audio_file_name, 'rb') as f:
                 data = f.read(CHUNK_SIZE)
                 while data != b'':
                     yield stt_pb2.StreamingRequest(chunk=stt_pb2.AudioChunk(data=data))
                     data = f.read(CHUNK_SIZE)

         # When authorizing with an API key
         # as a service account, provide api_key instead of iam_token.
         # def run(api_key, audio_file_name):
         def run(iam_token, audio_file_name):
             # Establish a server connection.
             cred = grpc.ssl_channel_credentials()
             channel = grpc.secure_channel('{{ api-host-sk-stt }}:443', cred)
             stub = stt_service_pb2_grpc.RecognizerStub(channel)

             # Send data for recognition.
             it = stub.RecognizeStreaming(gen(audio_file_name), metadata=(
             # Parameters for authorization with an IAM token
                 ('authorization', f'Bearer {iam_token}'),
             # Parameters for authorization as a service account with an API key
             #   ('authorization', f'Api-Key {api_key}'),
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
             parser.add_argument('--token', required=True, help='IAM token or API key')
             parser.add_argument('--path', required=True, help='audio file path')
             args = parser.parse_args()
             run(args.token, args.path)
         ```

         Where:

         * `audio_encoding`: [Format](../../formats.md) of the audio stream.
         * `sample_rate_hertz`: Sampling rate of the audio stream.
         * `audio_channel_count`: Number of audio channels.
         * `profanity_filter`: [Profanity filter](../../stt-v3/api-ref/grpc/stt_service#TextNormalizationOptions).
         * `literature_text`: [Flag to generate the recognized text in a literary style](../../stt-v3/api-ref/grpc/stt_service#TextNormalizationOptions).
         * `language_code`: [Recognition language](../index.md#langs).

      1. Use the [IAM token](../../../iam/concepts/authorization/iam-token.md) of the service account:

         ```bash
         export IAM_TOKEN=<service_account_IAM_token>
         ```

      1. Run the created file:

         ```bash
         python3 output/test.py --token ${IAM_TOKEN} --path <path_to_speech.pcm>
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

   - Java {#java}

      1. Install the dependencies:

         ```bash
         sudo apt update && sudo apt install --yes default-jdk maven
         ```

      1. Clone the [repository](https://github.com/yandex-cloud-examples/yc-speechkit-stt-java) with a Java application configuration:

         ```bash
         git clone https://github.com/yandex-cloud-examples/yc-speechkit-stt-java
         ```

      1. Go to the repository directory:

         ```bash
         cd yc-speechkit-stt-java
         ```

      1. Download a [sample](https://{{ s3-storage-host }}/doc-files/speech.wav) audio file in [WAV format](https://en.wikipedia.org/wiki/WAV). Save the audio file to the directory with the repository.
      1. Compile a project in this directory:

         ```bash
         mvn clean install
         ```

      1. Go to the `target` directory you created:

         ```bash
         cd target
         ```

      1. Specify the service account's [API key](../../../iam/concepts/authorization/api-key.md):

         ```bash
         export API_KEY=<API_key>
         ```

      1. Run the Java program for speech recognition:

         ```bash
         java -cp speechkit_examples-1.0-SNAPSHOT.jar yandex.cloud.speechkit.examples.SttV3Client <path_to_audio_file>
         ```

         In the command, specify the absolute path to the sample audio file you downloaded.

         Result:

         ```text
         sending initial request
         Done sending
         Stt stream completed
         Recognized text is I'm Yandex SpeechKit. I can turn any text into speech. Now you can, too!
         ```

   {% endlist %}

#### See also {#see-also}

* [{#T}](microphone-streaming.md)
* [Learn more about the API v3](../../stt-v3/api-ref/grpc/index.md)
* [{#T}](../../concepts/auth.md)
