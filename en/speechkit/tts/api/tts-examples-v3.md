# Speech synthesis in the API v3

With the {{ speechkit-short-name }} [API v3](../../tts-v3/api-ref/grpc/), you can synthesize speech from text in [TTS markup](../markup/tts-markup.md) to a [WAV](https://en.wikipedia.org/wiki/WAV) file.

The example uses the following synthesis parameters:

* Synthesized audio file [format](../../formats.md): LPCM with a sample rate of 22050 Hz, [WAV](https://en.wikipedia.org/wiki/WAV) container (default).
* [Volume normalization](../index.md#volume): LUFS (default).

To convert and record the result, you will need the `grpcio-tools` and `pydub` packages and the [FFmpeg](https://ffmpeg.org/) utility.

Authentication is performed under a service account using an [API key](../../../iam/concepts/authorization/api-key.md) or [IAM token](../../../iam/concepts/authorization/iam-token.md). To learn more about {{ speechkit-name }} API authentication, see [{#T}](../../concepts/auth.md).

To implement an example:

1. [Create](../../../iam/operations/sa/create.md) a service account to work with the {{ speechkit-short-name }} API.
1. [Assign](../../../iam/operations/sa/assign-role-for-sa.md) the service account the `{{ roles-speechkit-tts }}` role or higher for the folder where it was created.
1. Get an [API key](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) or [IAM token](../../../iam/operations/iam-token/create-for-sa.md) for your service account.
1. Create a client application:

    {% list tabs group=programming_language %}

    - Python 3 {#python}

      1. Clone the [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi) repository:

          ```bash
          git clone https://github.com/yandex-cloud/cloudapi
          ```

      1. Install the `grpcio-tools` and `pydub` packages using the [pip](https://pip.pypa.io/en/stable/) package manager:

          ```bash
          pip install grpcio-tools && \
          pip install pydub
          ```

          You need the `grpcio-tools` package to generate the interface code for the API v3 synthesis client. You need the `pydub` package to process the resulting audio files.

      1. [Download](https://www.ffmpeg.org/download.html) FFmpeg for correct operation of the `pydub` package. Add the path to the folder with the executable to the `PATH` variable. To do this, run the following command:

          ```bash
          export PATH=$PATH:<path_to_folder_with_FFmpeg_executable>
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
            yandex/cloud/ai/tts/v3/tts_service.proto \
            yandex/cloud/ai/tts/v3/tts.proto
          ```

          This will create the `tts_pb2.py`, `tts_pb2_grpc.py`, `tts_service_pb2.py`, and `tts_service_pb2_grpc.py` client interface files, as well as dependency files, in the `output` folder.

      1. Create a file (e.g., `test.py`) in the `output` folder root and add the following code to it:

          ```python
          import io
          import grpc
          import pydub
          import argparse

          import yandex.cloud.ai.tts.v3.tts_pb2 as tts_pb2
          import yandex.cloud.ai.tts.v3.tts_service_pb2_grpc as tts_service_pb2_grpc

          # Specify the synthesis settings.
          # When authorizing with an API key, provide api_key instead of iam_token.
          #def synthesize(api_key, text) -> pydub.AudioSegment:
          def synthesize(iam_token, text) -> pydub.AudioSegment:
              request = tts_pb2.UtteranceSynthesisRequest(
                  text=text,
                  output_audio_spec=tts_pb2.AudioFormatOptions(
                      container_audio=tts_pb2.ContainerAudio(
                          container_audio_type=tts_pb2.ContainerAudio.WAV
                      )
                  ),
                  # Synthesis parameters
                  hints=[
                    tts_pb2.Hints(voice= 'alexander'), # (Optional) Specify the voice. The default value is `marina`
                    tts_pb2.Hints(role = 'good'), # (Optional) Specify the role only if applicable for this voice
                    tts_pb2.Hints(speed=1.1), # (Optional) Specify synthesis speed
                  ],

                  loudness_normalization_type=tts_pb2.UtteranceSynthesisRequest.LUFS
              )

              # Establish a connection with the server.
              cred = grpc.ssl_channel_credentials()
              channel = grpc.secure_channel('{{ api-host-sk-tts }}:443', cred)
              stub = tts_service_pb2_grpc.SynthesizerStub(channel)

              # Send data for synthesis.
              it = stub.UtteranceSynthesis(request, metadata=(

              # Parameters for authentication with an IAM token
                  ('authorization', f'Bearer {iam_token}'),
              # Parameters for authentication with an API key as a service account
              #   ('authorization', f'Api-Key {api_key}'),
              ))

              # Create an audio file out of chunks.
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
              parser.add_argument('--token', required=True, help='IAM token or API key')
              parser.add_argument('--text', required=True, help='Text for synthesis')
              parser.add_argument('--output', required=True, help='Output file')
              args = parser.parse_args()

              audio = synthesize(args.token, args.text)
              with open(args.output, 'wb') as fp:
                  audio.export(fp, format='wav')
          ```

      1. Execute the file from the previous step:

          ```bash
          export IAM_TOKEN=<service_account_IAM_token>
          export TEXT='I'm Yandex Speech+Kit. I can turn any text into speech. Now y+ou can, too!'
          python3 output/test.py \
            --token ${IAM_TOKEN} \
            --output speech.wav \
            --text ${TEXT}
          ```

          Where:

          * `IAM_TOKEN`: [Service account IAM token](../../../iam/concepts/authorization/iam-token.md). If you use an API key for authentication under a service account, change the Python script and the program call.
          * `TEXT`: Text for synthesis in [TTS markup](../markup/tts-markup.md).
          * `--output`: Name of the file for the audio.

          As a result, a file named `speech.wav` with synthesized speech will be created in the `cloudapi` folder.

    - Java {#java}

      1. Install the dependencies:

          ```bash
          sudo apt update && sudo apt install --yes default-jdk maven
          ```

      1. Clone the [repository](https://github.com/yandex-cloud-examples/yc-speechkit-tts-java) with a Java application configuration:

          ```bash
          git clone https://github.com/yandex-cloud-examples/yc-speechkit-tts-java
          ```

      1. Go to the repository directory:

          ```bash
          cd yc-speechkit-tts-java
          ```

      1. Compile a project in this directory:

          ```bash
          mvn clean install
          ```

      1. Go to the `target` directory you created:

          ```bash
          cd target
          ```

      1. Specify the service account's [API key](../../../iam/concepts/authorization/api-key.md) and text to synthesize:

          ```bash
          export API_KEY=<API_key> && \
          export TEXT='I'm Yandex Speech+Kit. I can turn any text into speech. Now y+ou can, too!'
          ```

      1. Run the Java script for speech synthesis:

          ```bash
          java -cp speechkit_examples-1.0-SNAPSHOT.jar yandex.cloud.speechkit.examples.TtsV3Client ${TEXT}
          ```

          As a result, the `result.wav` audio file should appear in the `target` directory. It contains speech recorded from the `TEXT` environment variable.

    {% endlist %}

#### See also {#see-also}

* [Learn more about the API v3](../../tts-v3/api-ref/grpc/)
* [{#T}](../../concepts/auth.md)
* [{#T}](../../sdk/python/synthesis.md)

