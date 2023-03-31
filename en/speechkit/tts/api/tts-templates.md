# Synthesize speech with a pattern using API v3

Pattern-based synthesis is only available for [{{ brand-voice-name }}](../brand-voice/index.md) voices. To get started with pattern-based synthesis, [fill out the form](#contact-form).

To synthesize a phrase based on a template:

1. [Prepare an audio recording template](#prepare-template).
1. [Send data to API v3](#send-to-api)

## Getting started {#before-you-begin}

1. Clone the [{{ yandex-cloud }} API repository](https://github.com/yandex-cloud/cloudapi):

   ```bash
   git clone https://github.com/yandex-cloud/cloudapi
   ```

1. [Create](../../../iam/operations/sa/create.md) a service account to work with the {{ speechkit-short-name }} API.
1. [Assign](../../../iam/operations/sa/assign-role-for-sa.md) the `{{ roles-speechkit-tts }}` role, or higher, to the service account, which will allow it to work with {{ speechkit-name }} in the folder it was created in.
1. [Get](../../../iam/operations/iam-token/create-for-sa.md) an IAM token for the service account.

## Prepare an audio recording template {#prepare-template}

{% note warning %}

A template consists of a pattern phrase audio recording and its text with markup. You should only send templates with variable parts to the service API for synthesis. There is no need to send fixed phrases.

{% endnote %}

Examples of fixed phrases: 
> Hello, I am calling from the MedCity clinic.
>
> This is 'Junk It Out', a construction waste management company.
>

To prepare a template:

* Make an audio recording of your pattern phrase.
* Mark up the text of the pattern phrase following the [requirements](../templates.md#requirements) and enclose the variable parts in `{}` (curly brackets).

   Sample markups:
   > You have an appointment with doctor {Smith} on {March twenty} at {twelve pm}.
   >
   > This is to remind you that a garbage truck will arrive at your place {tomorrow} at {two pm}.
   >

* For each variable part, set its start time and duration in the audio recording (in milliseconds).

{% note info %}

A phrase to synthesize should not be longer than {{ tts-v3-time }} (the API limit), including the variable part. Optimal perception is achieved if a phrase is up to 16 seconds long as in a regular conversation.

The pattern cannot be longer than 250 characters of normalized text.

{% endnote %}

## Send data to the {#send-to-api} API

Create a client app to send your data to the API:

{% list tabs %}

- Python 3

   1. Install dependencies using the [PIP package manager](https://pip.pypa.io/en/stable/):

      ```bash
      pip install grpcio-tools && \
      pip install pydub
      ```

      You need the `grpcio-tools` package to generate client interface code for the API v3 synthesis.

      The `pydub` package is needed to process the received audio files.

   1. [Download the FFmpeg utility](https://www.ffmpeg.org/download.html) for correct operation of the `pydub` package.
   1. Add the path to the directory with the FFmpeg executable file to the `PATH` variable:

      ```bash
      export PATH=$PATH:<path_to_directory_with_executable_FFmpeg_file>
      ```

   1. Go to the directory hosting the cloned {{ yandex-cloud }} API repository, create an `output` directory, and generate the client interface code there:

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

   1. Create a file, e.g., `test.py`, in the root of the `output` directory and add the following code to it:

      ```python
      import io
      import grpc
      import pydub
      import argparse

      import yandex.cloud.ai.tts.v3.tts_pb2 as tts_pb2
      import yandex.cloud.ai.tts.v3.tts_service_pb2_grpc as tts_service_pb2_grpc

      def synthesize(iam_token, bytes_array) -> pydub.AudioSegment:
          template = '<pattern_phrase_with_markup>'
          # Example: 'This is to remind you that your kid has an appointment for {treatment name} treatment session tomorrow at {time}.'
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
                                  # The number of tts_pb2.TextVariable() list items depends on the number of template variables.
                                  tts_pb2.TextVariable(
                                      variable_name = "<variable_name_in_the_pattern>",
                                      # Example: '{time}'
                                      variable_value ="<text_for_synthesis>"
                                      # Example: 'eight thirty'
                                  )
                              ]
                         ),
              hints = [
                 tts_pb2.Hints(
                      audio_template = tts_pb2.AudioTemplate(
                          audio = tts_pb2.AudioContent(
                              # Source audio for the pattern
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
                                  # Number of variables in the tts_pb2.TextVariable() list is the same as in the pattern.
                                  tts_pb2.TextVariable(
                                      variable_name = "<variable_name_in_the_pattern>",
                                      variable_value ="<text_of_the_variable_part_for_pattern_audio_file>"
                                  )
                              ]
                          ),
                          variables = [
                              # The number of variables in the tts_pb2.AudioVariable() list is the same as in the pattern.
                              tts_pb2.AudioVariable(
                                  variable_name = '<name_of_variable_in_pattern>',
                                  # Duration of the variable phrase part in the pattern audio (ms).
                                  variable_length_ms = <length_of_variable>,
                                  # Start of the phrase variable part in the template audio (ms).
                                  variable_start_ms = <start_time>
                              )
                          ]
                      )
                  ),
                 # Do not provide this parameter if you use {{ brand-voice-cc-name }}
                 tts_pb2.Hints(
                    voice = "<your_voice_ID>"
                 )
              ],
              # Set this parameter if you use {{ brand-voice-cc-name }}
              model = "zsl"
          )

          # Establish connection with the server.
          cred = grpc.ssl_channel_credentials()
          channel = grpc.secure_channel("{{ api-host-sk-tts }}", cred)
          stub = tts_service_pb2_grpc.SynthesizerStub(channel)

          # Send data for synthesis.
          it = stub.UtteranceSynthesis(request, metadata=(
              ("authorization", f"Bearer {iam_token}"),
          ))

          # Process server responses and save the result to a file.
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
          parser.add_argument('--output', required=True, help='Output WAV file with synthesis voice')
          args = parser.parse_args()

          with open(args.input, 'rb') as file:
              speech = file.read()

          audio = synthesize(args.token, speech)
          with open(args.output, 'wb') as fp:
              audio.export(fp, format='wav')
      ```

   1. Run the created file (in our example, it is called `test.py`):

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
