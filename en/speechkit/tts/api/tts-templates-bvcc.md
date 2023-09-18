# Pattern-based speech synthesis in {{ brand-voice-cc-name }}

To synthesize a phrase based on a template:

1. [{#T}](#prepare-template)
1. [{#T}](#send-to-api)

## Getting started {#before-you-begin}

{% include [template-synthesis-before-you-begin](../../../_includes/speechkit/api-v3-template-synthesis-before.md) %}

## Prepare an audio recording template {#prepare-template}

Template parameter restrictions are as follows:

* A phrase for synthesis must not be longer than {{ tts-v3-time }} (the API limit), including the variable part. A phrase ideal for perception is under 16 seconds, as in a regular conversation.
* Pattern length: not more than {{ tts-v3-count }} of normalized text.
* The text of the variable part must not exceed 25% of the pattern length.

{% include [prepare-template-synthesis](../../../_includes/speechkit/prepare-template-synthesis.md) %}

## Send data to the {#send-to-api} API


{% note warning %}

Access to the {{ brand-voice-cc-name }} service is available on request. To get access to the technology, [fill out this form](#contact-form).

{% endnote %}


Create and run a client app to send your data to the API:

{% list tabs %}

- Python 3

   1. Install dependencies using the [PIP package manager](https://pip.pypa.io/en/stable/):

      ```bash
      pip install grpcio-tools && \
      pip install pydub
      ```

      You need the `grpcio-tools` package to generate client interface code for the API v3 synthesis.

      The `pydub` package is needed to process the resulting audio files.

   1. [Download the FFmpeg utility](https://www.ffmpeg.org/download.html) for correct operation of the `pydub` package.
   1. Add the path to the directory with the FFmpeg executable file to the `PATH` variable:

      ```bash
      export PATH=$PATH:<path_to_directory_with_executable_FFmpeg_file>
      ```

   1. Go to the directory hosting the {{ yandex-cloud }} API repository, create an `output` directory, and generate the client interface code there:

      ```bash
      cd <path_to_cloudapi_directory> && \
      mkdir output && \
      python -m grpc_tools.protoc -I . -I third_party/googleapis \
        --python_out=output \
        --grpc_python_out=output \
        google/api/http.proto \
        google/api/annotations.proto \
        yandex/cloud/api/operation.proto \
        google/rpc/status.proto \
        yandex/cloud/ai/tts/v3/tts_service.proto \
        yandex/cloud/ai/tts/v3/tts.proto
      ```

      As a result, the `tts_pb2.py`, `tts_pb2_grpc.py`, `tts_service_pb2.py`, and `tts_service_pb2_grpc.py` client interface files, as well as dependency files, will be created in the `output` directory.

   1. Create a `test.py` file in the root of the `output` directory and add the code for API v3 pattern-based synthesis to it.

      {% cut "test.py" %}

      ```python
      import io
      import grpc
      import pydub
      import argparse

      import yandex.cloud.ai.tts.v3.tts_pb2 as tts_pb2
      import yandex.cloud.ai.tts.v3.tts_service_pb2_grpc as tts_service_pb2_grpc

      def synthesize(iam_token, bytes_array) -> pydub.AudioSegment:
          template = "<pattern_phrase_with_markup>"
          # Pattern example: 'This is to remind you that your child has an appointment for {treatment name} tomorrow at {time}.'
          request = tts_pb2.UtteranceSynthesisRequest(
              output_audio_spec=tts_pb2.AudioFormatOptions(
                  container_audio=tts_pb2.ContainerAudio(
                      container_audio_type=tts_pb2.ContainerAudio.WAV
                  )
              ),
              loudness_normalization_type=tts_pb2.UtteranceSynthesisRequest.LUFS,
              text_template = tts_pb2.TextTemplate(
                  text_template = template,
                  variables = [
                      # List the template variables.
                      # The number of tts_pb2.TextVariable() list items depends on the number of template variables.
                      tts_pb2.TextVariable(
                          variable_name = "<variable_name_in_the_pattern>",
                          # Example: '{time}'
                          variable_value = "<text_for_synthesis>"
                          # Example: 'eight thirty'
                      )
                  ]
              ),
              hints = [
                  tts_pb2.Hints(
                      audio_template = tts_pb2.AudioTemplate(
                          audio = tts_pb2.AudioContent(
                              # Upload source audio for the template.
                              content = bytes_array,
                              audio_spec = tts_pb2.AudioFormatOptions(
                                  container_audio = tts_pb2.ContainerAudio(
                                      container_audio_type = tts_pb2.ContainerAudio.WAV
                                  )
                              )
                          ),
                          text_template = tts_pb2.TextTemplate(
                              text_template = template,
                              variables = [
                                  # List the template variables.
                                  # The number of tts_pb2.TextVariable() list items depends on the number of template variables.
                                  tts_pb2.TextVariable(
                                      variable_name = "<template_variable_name>",
                                      variable_value = "<text of the phrase's variable part in the template audio file>"
                                  )
                              ]
                          ),
                          variables = [
                              # List the audio parameters of template variables.
                              # The number of tts_pb2.AudioVariable() list items depends on the number of template variables.
                              tts_pb2.AudioVariable(
                                  variable_name = "<variable_name_in_the_pattern>",
                                  #  Duration of the variable phrase part in the template audio (ms).
                                  variable_length_ms = <variable_length>,
                                  # Start of the phrase variable part in the template audio (ms).
                                  variable_start_ms = <variable_start_time>
                              )
                          ]
                      )
                  )
              ],
              model = "zsl"
          )

          # Establish a server connection.
          cred = grpc.ssl_channel_credentials()
          channel = grpc.secure_channel('{{ api-host-sk-tts }}:443', cred)
          stub = tts_service_pb2_grpc.SynthesizerStub(channel)

          # Send data for synthesis.
          it = stub.UtteranceSynthesis(request, metadata=(
              ("authorization", f"Bearer {iam_token}"),
          ))

          # Process the server responses and write the result to a file.
          try:
              audio = io.BytesIO()
              for response in it:
                  audio.write(response.audio_chunk.data)
              audio.seek(0)
              return pydub.AudioSegment.from_wav(audio)
          except grpc._channel._Rendezvous as err:
              print(f'Error code {err._state.code}, message: {err._state.details}')
              raise err


      if __name__ == '__main__':
          parser = argparse.ArgumentParser()
          parser.add_argument('--token', required=True, help='IAM token')
          parser.add_argument('--input', required=True, help='Template WAV file')
          parser.add_argument('--output', required=True, help='Output WAV file with synthesized speech')
          args = parser.parse_args()

          with open(args.input, 'rb') as file:
              speech = file.read()

          audio = synthesize(args.token, speech)
          with open(args.output, 'wb') as fp:
              audio.export(fp, format='wav')
      ```

      {% endcut %}

   1. Run the `test.py` file:

      ```bash
      export IAM_TOKEN=<service_account_IAM_token> && \
      python output/test.py \
        --token ${IAM_TOKEN} \
        --input sample.wav \
        --output speech.wav
      ```

      Where:

      * `IAM_TOKEN`: [IAM token](../../../iam/concepts/authorization/iam-token.md) of the service account.
      * `--input`: Name of the audio file with the pattern phrase.
      * `--output`: Name of the audio file with the synthesized phrase.

{% endlist %}

As a result, the `speech.wav` file with the phrase synthesized based on the template will be created in the `cloudapi` directory.

#### See also {#see-also}

* [{#T}](tts-examples-v3.md)
* [{#T}](../brand-voice/index.md)
* [{#T}](../templates.md)
