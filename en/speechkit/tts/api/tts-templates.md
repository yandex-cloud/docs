# Pattern-based speech synthesis using the API v3

Pattern-based synthesis in {{ brand-voice-premium }} and {{ brand-voice-core }} is only available for [{{ brand-voice-name }}](../brand-voice/index.md) voices.

{% note warning %}

Access to {{ brand-voice-premium }} and {{ brand-voice-core }} services is available on request. To access the technology, [fill out this form](#contact-form).

{% endnote %}

To synthesize a phrase based on a template:

1. [Prepare an audio recording template](#prepare-template).
1. [Send data to API v3](#send-to-api).

## Getting started {#before-you-begin}

{% include [template-synthesis-before-you-begin](../../../_includes/speechkit/api-v3-template-synthesis-before.md) %}

## Prepare an audio template {#prepare-template}

A template consists of a pattern phrase audio recording and its text with markup.

Template parameter restrictions:

* A phrase for synthesis cannot be longer than {{ tts-v3-time }} (the API limit), including the variable part. A phrase ideal for perception is under 16 seconds, as in a regular conversation.
* Template length: not more than {{ tts-v3-count }} of normalized text.
* The normalized text of the variable part must not exceed 25% of the template length. The same restriction applies to the duration of the variable part relative to the duration of the final audio.

{% note warning %}

Submit templates with variable parts to the API for synthesis. There is no need to submit fixed phrases.

>Examples of fixed phrases:
>
>Hello, I am calling from the MedCity clinic.
>
>Hello, this is 'Junk It Out,' a construction waste management company.

{% endnote %}

{% include [prepare-template-synthesis](../../../_includes/speechkit/prepare-template-synthesis.md) %}

## Send data to the API v3 {#send-to-api}

Create and run a client app to send your data to the API:

{% list tabs group=programming_language %}

- Python 3 {#python}

    1. Clone the [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi) repository:

       ```bash
       git clone https://github.com/yandex-cloud/cloudapi
       ```

    1. Install dependencies using the [PIP package manager](https://pip.pypa.io/en/stable/):

        ```bash
        pip install grpcio-tools && \
        pip install pydub
        ```

        You need the `grpcio-tools` package to generate the interface code for the API v3 synthesis client.

        You need the `pydub` package to process the resulting audio files.

    1. [Download the FFmpeg utility](https://www.ffmpeg.org/download.html) for correct operation of the `pydub` package.
    1. Add the path to the folder with the FFmpeg executable to the `PATH` variable:

        ```bash
        export PATH=$PATH:<path_to_folder_with_FFmpeg_executable>
        ```

    1. Go to the folder hosting the cloned {{ yandex-cloud }} API repository, create a folder named `output`, and generate the client interface code in it:

        ```bash
        cd <path_to_cloudapi_folder> && \
        mkdir output && \
        python3 -m grpc_tools.protoc -I . -I third_party/googleapis \
          --python_out=output \
          --grpc_python_out=output \
          google/api/http.proto \
          google/api/annotations.proto \
          yandex/cloud/api/operation.proto \
          google/rpc/status.proto \
          yandex/cloud/ai/tts/v3/tts_service.proto \
          yandex/cloud/ai/tts/v3/tts.proto
        ```

        The `tts_pb2.py`, `tts_pb2_grpc.py`, `tts_service_pb2.py`, and `tts_service_pb2_grpc.py` client interface files, as well as dependency files, will be created in the `output` folder.

    1. Create a file named `test.py` in the `output` folder root and add the code for API v3 template-based synthesis to it.

          {% cut "test.py" %}

          ```python
          import io
          import pydub
          import argparse

          import yandex.cloud.ai.tts.v3.tts_pb2 as tts_pb2
          import yandex.cloud.ai.tts.v3.tts_service_pb2_grpc as tts_service_pb2_grpc

          def synthesize(iam_token, bytes_array) -> pydub.AudioSegment:
              template = "<template_phrase_with_markup>"
              # Template example: 'This is to remind you that your child has an appointment for {procedure} on {date} at {time}.'
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
                          # List template variables.
                          # The number of tts_pb2.TextVariable() list items depends on the number of template variables.
                          tts_pb2.TextVariable(
                              variable_name = "<variable_name_in_template>",
                              # Example: '{time}'.
                              variable_value = "<text_for_synthesis>"
                              # Example: 'eight hours and thirty minutes'.
                          )
                      ]
                  ),
                  hints = [
                      tts_pb2.Hints(
                          audio_template = tts_pb2.AudioTemplate(
                              audio = tts_pb2.AudioContent(
                                  # Upload a source audio for your template.
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
                                      # List template variables.
                                      # The number of tts_pb2.TextVariable() list items depends on the number of template variables.
                                      tts_pb2.TextVariable(
                                          variable_name = "<variable_name_in_template>",
                                          variable_value = "<phrase_variable_part_text_in_template_audio_file>"
                                      )
                                  ]
                              ),
                              variables = [
                                  # List the audio parameters of template variables.
                                  # The number of tts_pb2.AudioVariable() list items depends on the number of template variables.
                                  tts_pb2.AudioVariable(
                                      variable_name = "<variable_name_in_template>",
                                      # Length of the variable part of the phrase in the template audio (ms).
                                      variable_length_ms = <variable_length>,
                                      # Start of the variable part of the phrase in the template audio (ms).
                                      variable_start_ms = <variable_start_time>
                                  )
                              ]
                          )
                     ),
                     tts_pb2.Hints(
                         voice = "<your_voice_ID>"
                     )
                  ],
              )

              # Establish a connection with the server.
              cred = grpc.ssl_channel_credentials()
              channel = grpc.secure_channel('{{ api-host-sk-tts }}:443', cred)
              stub = tts_service_pb2_grpc.SynthesizerStub(channel)

              # Send data for synthesis.
              it = stub.UtteranceSynthesis(request, metadata=(
                  ("authorization", f"Bearer {iam_token}"),
              ))

              # Process the server responses and write the output to a file.
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

    1. Execute the `test.py` file:

        ```bash
        export IAM_TOKEN=<service_account_IAM_token> && \
        python3 output/test.py \
          --token ${IAM_TOKEN} \
          --input sample.wav \
          --output speech.wav
        ```

        Where:

        * `IAM_TOKEN`: [Service account IAM token](../../../iam/concepts/authorization/iam-token.md).
        * `--input`: Name of the audio file with the template phrase.
        * `--output`: Name of the audio file with the synthesized phrase.

{% endlist %}

This will create a file named `speech.wav` with your synthesized pattern-based phrase in the `cloudapi` folder.

#### See also {#see-also}

* [{#T}](tts-examples-v3.md)
* [{#T}](../brand-voice/index.md)
* [{#T}](../templates.md)
