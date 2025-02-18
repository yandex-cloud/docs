# Microphone speech streaming recognition using the API v3

Below, we provide an example of streaming recognition of microphone-recorded speech. Speech is recognized in real time using the {{ speechkit-name }} [API v3](../../stt-v3/api-ref/grpc/).

This example uses the following parameters:

* [Language](../models.md#languages): Russian.
* Format of the audio stream: [LPCM](../../formats.md#LPCM) with a sampling rate of 8000 Hz.
* [Number of audio channels](../../stt-v3/api-ref/grpc/AsyncRecognizer/recognizeFile#speechkit.stt.v3.RawAudio): 1.
* Recording buffer size: 4096.
* Voice recording duration: 30 seconds.
* [Profanity filter](../../stt-v3/api-ref/grpc/AsyncRecognizer/recognizeFile#speechkit.stt.v3.TextNormalizationOptions): Enabled.

To work with the API, you need the `grpcio-tools`, `PortAudio`, and `PyAudio` packages.

Authentication is performed under a service account using an [API key](../../../iam/concepts/authorization/api-key.md). Learn more about [authentication in the {{speechkit-name}} API](../../concepts/auth.md).

## Prepare the required data {#preparations}

1. [Create](../../../iam/operations/sa/create.md) a service account and [assign](../../../iam/operations/sa/assign-role-for-sa.md) the `{{ roles-speechkit-stt }}` role to it.
1. [Get](../../../iam/operations/api-key/create.md) an API key for the service account and save it.

## Create an application for streaming speech recognition {#create-an-application}

{% list tabs group=programming_language %}

- Python 3 {#python}

   1. Clone the [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi) repository:

      ```bash
      git clone https://github.com/yandex-cloud/cloudapi
      ```

   1. Install the `PortAudio` package to output audio in real time:

      ```bash
      sudo apt update && sudo apt install portaudio19-dev
      ```

   1. Install the [pip](https://pip.pypa.io/en/stable/) package manager if not installed yet. Otherwise, proceed to the next step.

      ```bash
      sudo apt install python3-pip
      ```

   1. Use the pip package manager to install the following packages:

      * `grpcio-tools` to work with the {{speechkit-name}} API.
      * `PyAudio` to record audio.

      ```bash
      pip install grpcio-tools PyAudio
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
           yandex/cloud/operation/operation.proto \
           yandex/cloud/validation.proto \
           yandex/cloud/ai/stt/v3/stt_service.proto \
           yandex/cloud/ai/stt/v3/stt.proto
      ```

      This will create the `stt_pb2.py`, `stt_pb2_grpc.py`, `stt_service_pb2.py`, and `stt_service_pb2_grpc.py` client interface files, as well as dependency files, in the `output` folder.

   1. Create a file named `test.py` in the `output` folder and add the following code to it:

      ```python
      import pyaudio
      import wave
      import argparse
      import grpc
      import yandex.cloud.ai.stt.v3.stt_pb2 as stt_pb2
      import yandex.cloud.ai.stt.v3.stt_service_pb2_grpc as stt_service_pb2_grpc

      # Stream recognition settings.
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

         # Start voice recording.
         stream = audio.open(format=FORMAT, channels=CHANNELS,
                     rate=RATE, input=True,
                     frames_per_buffer=CHUNK)
         print("recording")
         frames = []

         # Recognize speech in fragments.
         for i in range(0, int(RATE / CHUNK * RECORD_SECONDS)):
            data = stream.read(CHUNK)
            yield stt_pb2.StreamingRequest(chunk=stt_pb2.AudioChunk(data=data))
            frames.append(data)
         print("finished")

         # Stop recording.
         stream.stop_stream()
         stream.close()
         audio.terminate()

         # Create a WAV file with recorded voice.
         waveFile = wave.open(WAVE_OUTPUT_FILENAME, 'wb')
         waveFile.setnchannels(CHANNELS)
         waveFile.setsampwidth(audio.get_sample_size(FORMAT))
         waveFile.setframerate(RATE)
         waveFile.writeframes(b''.join(frames))
         waveFile.close()

      def run(secret):
         # Establish a connection with the server.
         cred = grpc.ssl_channel_credentials()
         channel = grpc.secure_channel('{{ api-host-sk-stt }}:443', cred)
         stub = stt_service_pb2_grpc.RecognizerStub(channel)

         # Send data for recognition.
         it = stub.RecognizeStreaming(gen(), metadata=(
         # Parameters for authentication with an API key as a service account.
            ('authorization', f'Api-Key {secret}'),
         # To authenticate with an IAM token, use the string below:
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

      * `FORMAT`: Audio stream format.
      * `CHANNELS`: Number of audio channels.
      * `RATE`: Audio stream sampling rate in Hz.
      * `CHUNK`: Recording buffer size. The size is determined based on the number of frames the recorded speech is split into.
      * `RECORD_SECONDS`: Voice recording duration in seconds.
      * `WAVE_OUTPUT_FILENAME`: Name of the voice audio file. The file is created by a script.
      * `profanity_filter`: Profanity filter.
      * `literature_text`: [Flag to present the recognized text in a literary style](../../stt-v3/api-ref/grpc/AsyncRecognizer/recognizeFile#speechkit.stt.v3.TextNormalizationOptions).
      * `language_code`: Recognition language.

   1. Set the service account's API key as an environment variable:

      ```bash
      export API_KEY=<API_key>
      ```

   1. Run the created file:

      ```python
      python3 output/test.py --secret ${API_KEY}
      ```

      This runs a speech recognition script in the terminal. It expects microphone-recorded speech as an input.

   1. Speak using a microphone.

      The recorded speech is output to the terminal. Example:

      ```text
      type=status_code, alternatives=None
      type=status_code, alternatives=None
      type=partial, alternatives=['test']
      type=partial, alternatives=['test']
      type=status_code, alternatives=None
      type=status_code, alternatives=None
      type=partial, alternatives=['recognition test']
      type=status_code, alternatives=None
      type=status_code, alternatives=None
      type=status_code, alternatives=None
      type=partial, alternatives=['recognition test']
      type=partial, alternatives=['voice recognition test']
      type=status_code, alternatives=None
      type=status_code, alternatives=None
      type=partial, alternatives=['voice recognition test']
      ```

   The script recognizes speech and records it during 30 seconds. Once the script is executed, its results are saved to an `audio.wav` file with recorded voice.

{% endlist %}

## Troubleshooting {#troubleshooting}

#### The script is run with no speech recognized {#no-recognition}

Possible causes:

* The script is run in the terminal embedded in an IDE. This terminal might have no microphone access. Run the script in an external terminal.
* The script is run on macOS and the terminal is not allowed to access the microphone. Open the system settings of the OS and make sure the terminal has the appropriate access permission.
* The microphone is not enabled.
