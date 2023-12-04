# Microphone speech streaming recognition using API v3

Below, we provide an example of streaming recognition of microphone-recorded speech. Speech is recognized in real time using {{ speechkit-name }} [API v3](../../stt-v3/api-ref/grpc/).

This example uses the following parameters:

* [Language](../models.md#languages): Russian.
* Format of the audio stream: [LPCM](../../formats.md#LPCM) with a sampling rate of 8000 Hz.
* [Number of audio channels](../../stt-v3/api-ref/grpc/stt_service#RawAudio): 1.
* Recording buffer size: 4096.
* Audio recording duration: 30 seconds.
* [Profanity filter](../../stt-v3/api-ref/grpc/stt_service#TextNormalizationOptions): Enabled.

To use the API, you need the `grpcio-tools`, `PortAudio`, and `PyAudio` packages.

Authentication is performed under a service account using an [API key](../../../iam/concepts/authorization/api-key.md). Learn more about [authentication in the {{speechkit-name}} API](../../concepts/auth.md).

## Prepare the necessary data {#preparations}

1. [Create](../../../iam/operations/sa/create.md) a service account and [assign](../../../iam/operations/sa/assign-role-for-sa.md) it the `{{ roles-speechkit-stt }}` role.
1. [Get](../../../iam/operations/api-key/create.md) an API key for the service account and save it.

## Create an application for streaming speech recognition {#create-an-application}

{% list tabs %}

- Python 3

   1. Clone the [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi) repository:

      ```bash
      git clone https://github.com/yandex-cloud/cloudapi
      ```

   1. Install the `PortAudio` package to output audio in real time:

      ```bash
      sudo apt update && sudo apt install portaudio19-dev
      ```

   1. Install the required packages using the [PIP](https://pip.pypa.io/en/stable/) package manager:

      * `grpcio-tools` for working with the {{speechkit-name}} API.
      * `PyAudio` for audio recording.

      ```bash
      pip install grpcio-tools PyAudio
      ```

   1. Go to the directory hosting the {{ yandex-cloud }} API repository, create an `output` directory, and generate the client interface code there:

      ```bash
      cd <path to cloudapi directory> && \
      mkdir output && \
      python -m grpc_tools.protoc -I . -I third_party/googleapis \
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

   1. Create a `test.py` file in the `output` directory and add the following code to it:

      ```python
      import pyaudio
      import wave
      import argparse
      import grpc
      import yandex.cloud.ai.stt.v3.stt_pb2 as stt_pb2
      import yandex.cloud.ai.stt.v3.stt_service_pb2_grpc as stt_service_pb2_grpc

      # Streaming recognition settings.
      FORMAT = pyaudio.paInt16
      CHANNELS = 1
      RATE = 8000
      CHUNK = 4096
      RECORD_SECONDS = 30
      WAVE_OUTPUT_FILENAME = "audio.wav"

      audio = pyaudio.PyAudio()

      def gen():
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

         # Start audio recording.
         stream = audio.open(format=FORMAT, channels=CHANNELS,
                     rate=RATE, input=True,
                     frames_per_buffer=CHUNK)
         print("recording")
         frames = []

         # Recognize speech in chunks.
         for i in range(0, int(RATE / CHUNK * RECORD_SECONDS)):
            data = stream.read(CHUNK)
            yield stt_pb2.StreamingRequest(chunk=stt_pb2.AudioChunk(data=data))
            frames.append(data)
         print("finished")

         # Stop audio recording.
         stream.stop_stream()
         stream.close()
         audio.terminate()

         # Create a WAV file with the recorded audio.
         waveFile = wave.open(WAVE_OUTPUT_FILENAME, 'wb')
         waveFile.setnchannels(CHANNELS)
         waveFile.setsampwidth(audio.get_sample_size(FORMAT))
         waveFile.setframerate(RATE)
         waveFile.writeframes(b''.join(frames))
         waveFile.close()

      def run(secret):
         # Establish a connection to the server.
         cred = grpc.ssl_channel_credentials()
         channel = grpc.secure_channel('stt.api.cloud.yandex.net:443', cred)
         stub = stt_service_pb2_grpc.RecognizerStub(channel)

         # Send data for recognition.
         it = stub.RecognizeStreaming(gen(), metadata=(
         # Parameters for authorization as a service account with an API key
            ('authorization', f'Api-Key {secret}'),
         # For authorization with an IAM token, use the string below
         #   ('authorization', f'Bearer {secret}'),
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
         parser.add_argument('--secret', required=True, help='API key or IAM token')
         args = parser.parse_args()
         run(args.secret)
      ```

      Where:

      * `FORMAT`: Format of the audio stream.
      * `CHANNELS`: Number of audio channels.
      * `RATE`: Audio stream sampling rate in Hz.
      * `CHUNK`: Recording buffer size. The size is determined based on the number of frames the recorded speech is split into.
      * `RECORD_SECONDS`: Audio recording duration in seconds.
      * `WAVE_OUTPUT_FILENAME`: Name of the audio file with the recorded speech. The file is created by a script.
      * `profanity_filter`: Profanity filter.
      * `literature_text`: [Flag to generate the recognized text in a literary style](../../stt-v3/api-ref/grpc/stt_service#TextNormalizationOptions).
      * `language_code`: Recognition language.

   1. Set the service account's API key as an environment variable:

      ```bash
      export API_KEY=<API key>
      ```

   1. Run the created file:

      ```python
      python3 output/test.py --secret ${API_KEY}
      ```

      This runs a speech recognition script in the terminal. It expects microphone-recorded speech as an input.

   1. Speak using a microphone.

      The recorded speech is output to the terminal. For example:

      ```text
      type=status_code, alternatives=None
      type=status_code, alternatives=None
      type=partial, alternatives=['check']
      type=partial, alternatives=['check']
      type=status_code, alternatives=None
      type=status_code, alternatives=None
      type=partial, alternatives=['recognition check']
      type=status_code, alternatives=None
      type=status_code, alternatives=None
      type=status_code, alternatives=None
      type=partial, alternatives=['recognition check']
      type=partial, alternatives=['speech recognition check']
      type=status_code, alternatives=None
      type=status_code, alternatives=None
      type=partial, alternatives=['speech recognition check']
      ```

   The script recognizes speech and records it during 30 seconds. Once the script is executed, its results are saved to an `audio.wav` file with the recorded speech.

{% endlist %}

## Troubleshooting {#troubleshooting}

#### The script is run with no speech recognized {#no-recognition}

Possible causes:

* The script is run in the terminal embedded in an IDE. This terminal might have no microphone access. Run the script in an external terminal.
* The script is run on macOS and the terminal is not allowed to access the microphone. Open the system settings of the OS and make sure the terminal has the appropriate access permission.
* The microphone is not enabled.
