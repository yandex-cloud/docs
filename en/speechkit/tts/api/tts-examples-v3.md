# Example uses for the synthesis API v3

This example uses the {{ speechkit-short-name }} [API v3](../../new-v3/api-ref/grpc/) for synthesis and recording of the following text to an audio file:

> I'm Yandex Speech+Kit. I can turn any text into speech. Now y+ou can, too!

The example uses the default settings: data in the audio file is saved in [LPCM]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Импульсно-кодовая_модуляция){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Pulse-code_modulation){% endif %} format with a sampling rate of 22050 Hz and depth of 16 bit. Data is then packaged into a [WAV]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/WAV){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/WAV){% endif %} container.

To implement an example:

1. Clone the [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi) repository:

   ```bash
   git clone https://github.com/yandex-cloud/cloudapi
   ```

1. [Create](../../../iam/operations/sa/create.md) a service account to work with the {{ speechkit-short-name }} API.
1. [Assign](../../../iam/operations/sa/assign-role-for-sa.md) the service account the `{{ roles-editor }}` role or a higher role for the folder where it was created.
1. [Get](../../../iam/operations/iam-token/create-for-sa.md) an IAM token for the service account.
1. Create a client application:

   {% list tabs %}

   - Python 3

      1. Install the `grpcio-tools` and `pydub` packages using the [pip](https://pip.pypa.io/en/stable/) package manager:

         ```bash
         pip install grpcio-tools
         pip install pydub
         ```

         The `grpcio-tools` package is needed to generate client interface code for the synthesis API v3.

         The `pydub` package is needed to process the received audio files.

      1. [Download](https://www.ffmpeg.org/download.html) the FFmpeg utility for correct operation of the `pydub` package. Add the path to the directory with the executable file to the `PATH` variable. To do this, run the command:

         ```bash
         export PATH=$PATH:<path_to_directory_with_executable_FFmpeg_file>
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
           yandex/cloud/ai/tts/v3/tts_service.proto \
           yandex/cloud/ai/tts/v3/tts.proto
         ```

         As a result, the `tts_pb2.py`, `tts_pb2_grpc.py`, `tts_service_pb2.py`, `tts_service_pb2_grpc.py` client interface files as well as dependency files will be created in the `output` directory.

      1. Create a file (for example, `test.py`) in the root of the `output` directory and add the following code to it:

         ```python
         import io
         import grpc
         import pydub
         import argparse

         import yandex.cloud.ai.tts.v3.tts_pb2 as tts_pb2
         import yandex.cloud.ai.tts.v3.tts_service_pb2_grpc as tts_service_pb2_grpc


         def synthesize(iam_token, text) -> pydub.AudioSegment:
             request = tts_pb2.UtteranceSynthesisRequest(
                 text=text,
                 output_audio_spec=tts_pb2.AudioFormatOptions(
                     container_audio=tts_pb2.ContainerAudio(
                         container_audio_type=tts_pb2.ContainerAudio.WAV
                     )
                 ),
                 loudness_normalization_type=tts_pb2.UtteranceSynthesisRequest.LUFS
             )

             # Establish a connection with the server.
             cred = grpc.ssl_channel_credentials()
             channel = grpc.secure_channel('tts.{{ api-host }}:443', cred)
             stub = tts_service_pb2_grpc.SynthesizerStub(channel)

             # Send data for synthesis.
             it = stub.UtteranceSynthesis(request, metadata=(
                 ('authorization', f'Bearer {iam_token}'),
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
             parser.add_argument('--token', required=True, help='IAM token')
             parser.add_argument('--text', required=True, help='Text for synthesis')
             parser.add_argument('--output', required=True, help='Output file')
             args = parser.parse_args()

             audio = synthesize(args.token, args.text)
             with open(args.output, 'wb') as fp:
                 audio.export(fp, format='wav')
         ```

      1. Set the IAM token of the service account, text for synthesis, name of the audio file, and execute the created file:

         ```bash
         export IAM_TOKEN=<service_account_IAM token>
         export TEXT='I'm Yandex Speech+Kit. I can turn any text into speech. Now y+ou can, too!'
         python output/test.py --token ${IAM_TOKEN} --output speech.wav --text ${TEXT}
         ```

         As a result, the `speech.wav` file with synthesized speech will be created in the `cloudapi` directory.

   {% endlist %}