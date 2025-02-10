---
title: Pattern-based speech synthesis in {{ brand-voice-cc-name }}
description: Follow this guide to run pattern-based speech synthesis in {{ brand-voice-cc-name }}.
---

# Pattern-based speech synthesis in {{ brand-voice-cc-name }}

{% note warning %}

Access to the [{{ brand-voice-cc-name }}](../templates.md) service is available on request. To access the technology, [fill out this form](#contact-form).

{% endnote %}

{{ brand-voice-cc-name }} allows you synthesize and record natural-sounding voice pattern phrases (templates) often used by call centers for customer calls.

{{ brand-voice-cc-name }} synthesizes audio with a sampling rate of 8 kHz. Yet the sampling rate of the synthesized speech file may be even higher. This is similar to recording a telephone conversation using high quality equipment. Even though you record at a high sampling rate, the telephone channel still reduces the audio signal to 8 kHz.

In {{ brand-voice-cc-name }}, you can adjust the sampling rate of the output audio files using various audio formats:

* OggOpus, MP3, or WAV container formats: The synthesized speech file is processed using standard {{ speechkit-name }} [specifications](../../formats.md) and audio compression algorithms.

    Use the [container_audio](../../tts-v3/api-ref/grpc/Synthesizer/utteranceSynthesis.md#speechkit.tts.v3.AudioFormatOptions) parameter for these audio formats when submitting your request to API v3.

* RAW format: No compression algorithms are used, and you can specify a custom sampling rate.

    For raw audio, use the [raw_audio](../../tts-v3/api-ref/grpc/Synthesizer/utteranceSynthesis.md#speechkit.tts.v3.AudioFormatOptions) parameter when submitting your request to API v3.

Below are some examples of how to use API v3 to synthesize speech into a standard or raw audio format. Use these examples to create a custom speech synthesis solution with {{ brand-voice-cc-name }}.

To synthesize template phrases for a call center:

1. [Prepare an audio recording template](#prepare-template).
1. [Send data to the API](#send-to-api).

## Getting started {#before-you-begin}

{% include [template-synthesis-before-you-begin](../../../_includes/speechkit/api-v3-template-synthesis-before.md) %}

## Prepare an audio template {#prepare-template}

Template parameter restrictions:

* A phrase for synthesis cannot be longer than {{ tts-v3-time }} (the API limit), including the variable part. A phrase ideal for perception is under 16 seconds, as in a regular conversation.
* Template length: not more than {{ tts-v3-count }} of normalized text.
* The normalized text of the variable part must not exceed 25% of the template length. The same restriction applies to the duration of the variable part relative to the duration of the final audio.

{% include [prepare-template-synthesis](../../../_includes/speechkit/prepare-template-synthesis.md) %}

## Send data to the API {#send-to-api}


Create and run a client app to send your data to the API:

{% list tabs group=programming_language %}

- Python 3 {#python}

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

    1. Go to the folder with the {{ yandex-cloud }} API repository, create a folder named `output` and generate the client interface code in it:

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

    1. Create a file named `test.py` in the root of the `output` folder and add into it the code for API v3 pattern-based synthesis.

        Use one of the files below depending on whether you want to use one of the container formats or the raw format:

          {% cut "Container formats: OggOpus, MP3, or WAV" %}

          ```python
          import io
          import grpc
          import pydub
          import argparse

          import yandex.cloud.ai.tts.v3.tts_pb2 as tts_pb2
          import yandex.cloud.ai.tts.v3.tts_service_pb2_grpc as tts_service_pb2_grpc

          def synthesize(iam_token, bytes_array) -> pydub.AudioSegment:
              template = "<template_phrase_with_markup>"

              # Template example: 'This is to remind you that your child has an appointment for {procedure} tomorrow at {time}.'
              request = tts_pb2.UtteranceSynthesisRequest(
                  output_audio_spec=tts_pb2.AudioFormatOptions(
                      container_audio=tts_pb2.ContainerAudio(
                          # This example uses the WAV format for audio compression. You can specify OGG_OPUS or MP3 instead of WAV for other formats of the same name.
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
                                          variable_value = "<text_of_phrase_variable_in_template_audio_file>"
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
                      )
                  ],
                  # Special {{ brand-voice-cc-name }} model, available on request. 
                  model = "zsl"
              )

              # Establish a connection with the server.
              cred = grpc.ssl_channel_credentials()
              channel = grpc.secure_channel('{{ api-host-sk-tts }}:443', cred)
              stub = tts_service_pb2_grpc.SynthesizerStub(channel)

              # Send data for synthesis.
              it = stub.UtteranceSynthesis(
                  request,
                  metadata=(
                      # You can use an API key for tests.
                      # ('authorization', f'Api-Key {api_key}'),
                      # For business solutions, it is better to use an IAM token.
                      ('authorization', f'Bearer {iam_token}'),
                  ),
              )

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

          {% cut "RAW format" %}

          ```python
          import io
          import grpc
          import pydub
          import argparse

          import yandex.cloud.ai.tts.v3.tts_pb2 as tts_pb2
          import yandex.cloud.ai.tts.v3.tts_service_pb2_grpc as tts_service_pb2_grpc

          def synthesize(iam_token, bytes_array) -> pydub.AudioSegment:
              template = "<template_phrase_with_markup>"
              # Template example: 'This is to remind you that your child has an appointment for {procedure} tomorrow at {time}.'
              request = tts_pb2.UtteranceSynthesisRequest(
                  output_audio_spec=tts_pb2.AudioFormatOptions(
                      raw_audio=tts_pb2.RawAudio(
                          audio_encoding=tts_pb2.RawAudio.LINEAR16_PCM,
                          sample_rate_hertz=8000
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
                                          variable_value = "<text_of_phrase_variable_in_template_audio_file>"
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
                      )
                  ],
                  # Special {{ brand-voice-cc-name }} model, available on request.
                  model = "zsl"
              )

              # Establish a connection with the server.
              cred = grpc.ssl_channel_credentials()
              channel = grpc.secure_channel('{{ api-host-sk-tts }}:443', cred)
              stub = tts_service_pb2_grpc.SynthesizerStub(channel)

              # Send data for recognition.
              it = stub.UtteranceSynthesis(
                  request,
                  metadata=(
                      # You can use an API key for tests.
                      # ('authorization', f'Api-Key {api_key}'),
                      # For business solutions, it is better to use an IAM token.
                      ('authorization', f'Bearer {iam_token}'),
                  ),
              )

              # Process the server responses and write the result to a file.
              try:
                  audio = io.BytesIO()
                  for response in it:
                      audio.write(response.audio_chunk.data)
                  audio.seek(0)
                  return pydub.AudioSegment.from_raw(
                      audio, sample_width=2, frame_rate=8000, channels=1
                  )
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

          To use the raw format and custom settings for the generated audio, in `output_audio_spec.raw_audio`, use the [RawAudio()](../../tts-v3/api-ref/grpc/Synthesizer/utteranceSynthesis.md#speechkit.tts.v3.RawAudio) parameter supported by the {{ speechkit-name }} API. The following parameters are nested in `RawAudio()`:

          * `audio_encoding`: Audio encoding type. Only the [LPCM](../../formats.md#lpcm) format is supported.
          * `sample_rate_hertz`: Sampling rate of generated audio in Hz.

              For {{ brand-voice-cc-name }}, the maximum sampling rate is 8,000 Hz. Specify this sampling rate to avoid adding unnecessary distortions when converting and compressing your audio file.

          You can set audio conversion settings in the `from_raw()` function supported by the [pydub](https://github.com/jiaaro/pydub/blob/master/API.markdown) library. Function parameters:

          * `audio`: Source audio for the template.
          * `sample_width`: Audio bit depth. The possible values are:

              * `1`: 8 bits
              * `2`: 16 bits (CD quality)
              * `4`: 32 bits

              {{ brand-voice-cc-name }} [supports](../templates.md#requirements-audio) 16-bit audio depth; therefore, put `2` for `sample_width`.

          * `frame_rate`: Sampling rate in Hz applied when converting the audio. Put `8000` so that the sampling rate of the generated audio matches the expected 8,000 Hz rate supported by {{ brand-voice-cc-name }}.
          * `channels`: Number of audio channels. The possible values are:

              * `1`: Mono
              * `2`: Stereo

              {{ brand-voice-cc-name }} [supports](../templates.md#requirements-audio) mono signal; therefore, put `1` for `channels`.

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
