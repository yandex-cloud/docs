# Streaming synthesis

{{ speechkit-full-name }} allows you to send texts for [streaming synthesis](../index.md#streaming) one by one within a single session using the [API v3](../../tts-v3/api-ref/grpc/).

The example uses the following synthesis parameters:

* Synthesized audio file [format](../../formats.md): LPCM with a sample rate of 22,050 Hz, [WAV](https://{{ lang }}.wikipedia.org/wiki/WAV) container (default).
* [Volume normalization](../index.md#volume): LUFS (default).

To convert and record the result, you will need the `grpcio-tools` and `pathlib` packages.

Authentication is performed under a service account using an [API key](../../../iam/concepts/authorization/api-key.md) or [IAM token](../../../iam/concepts/authorization/iam-token.md). To learn more about {{ speechkit-name }} API authentication, see [{#T}](../../concepts/auth.md).

To synthesize multiple texts one by one:

1. [Create](../../../iam/operations/sa/create.md) a service account to work with the {{ speechkit-name }} API.
1. [Assign](../../../iam/operations/sa/assign-role-for-sa.md) the service account the `{{ roles-speechkit-tts }}` role or higher for the folder where it was created.
1. Clone the [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi) repository:

    ```bash
    git clone https://github.com/yandex-cloud/cloudapi
    ```

1. Install the `grpcio-tools` and `pathlib` packages using the [pip](https://pip.pypa.io/en/stable/) package manager:

    ```bash
    pip install grpcio-tools && \
    pip install pathlib
    ```

    You need the `grpcio-tools` package to generate the interface code for the API v3 synthesis client and the `pathlib` package to process the audio files you get.

1. In the directory hosting the cloned API repository, create a directory named `output`, and generate the client interface code there:

    ```bash
    cd <path_to_cloudapi_directory>
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

    This will create the `tts_pb2.py`, `tts_pb2_grpc.py`, `tts_service_pb2.py`, and `tts_service_pb2_grpc.py` client interface files, as well as dependency files, in the `output` directory.

1. Create a file (e.g., `test.py`) in the root of the `output` directory, and add the following code to it:

    ```python
    import pathlib
    import grpc
    import yandex.cloud.ai.tts.v3.tts_pb2 as tts_pb2
    import yandex.cloud.ai.tts.v3.tts_service_pb2_grpc as tts_service_pb2_grpc
    
    # Parameters for authentication with the API key
    YANDEX_API_KEY = "<API_key>"
    # Parameters for authentication with an IAM token
    # YANDEX_IAM_TOKEN = "<IAM_token>"
    
    def stream_synthesis():
        cred = grpc.ssl_channel_credentials()
    
        auth_meta = (
            ('authorization',
            f'Api-key {YANDEX_API_KEY}'),
            # or
            # ('authorization',
            # f'Bearer {YANDEX_IAM_TOKEN}'),
        )
        with grpc.secure_channel('tts.api.cloud.yandex.net:443', cred) as channel:
            stub = tts_service_pb2_grpc.SynthesizerStub(channel)
    
            # Synthesis settings
            synthesis_options = tts_pb2.SynthesisOptions(
                voice="masha",
                role="good",
                output_audio_spec=tts_pb2.AudioFormatOptions(
                    # Output audio settings. Specify using the RawAudio or ContainerAudiio objects.
                    
                    # raw_audio=tts_pb2.RawAudio(
                    #     audio_encoding=tts_pb2.RawAudio.LINEAR16_PCM,
                    #     sample_rate_hertz=16000
                    # )
                    container_audio=tts_pb2.ContainerAudio(
                        container_audio_type=tts_pb2.ContainerAudio.ContainerAudioType.WAV
                    )
                )
            )
    
            # Request generator
            def request_generator():
                # Providing settings in the first message
                yield tts_pb2.StreamSynthesisRequest(options=synthesis_options)
    
                # Sending texts for synthesis one by one
                # Each phrase you send must end with a space 
                # so they do not turn into a single word during synthesis.
                # Short text
                yield tts_pb2.StreamSynthesisRequest(synthesis_input=tts_pb2.SynthesisInput(text="Hello! "))
                # Very long text to synthesize in chunks
                yield tts_pb2.StreamSynthesisRequest(synthesis_input=tts_pb2.SynthesisInput(
                    text=(
                        "I’m Masha. I work at Classy Service Ltd. "
                        "I can help you select your order and arrange a delivery. "
                        "I will also find the right person to assist you. I can help with the blank canvas syndrome. I can tell a joke or recite a poem. I also know the weather forecast for tomorrow."
                    )
                ))
                # Short text
                yield tts_pb2.StreamSynthesisRequest(synthesis_input=tts_pb2.SynthesisInput(text="What would you like to ask?"))
    
            # In finished applications, you will instantly play the audio you get.
            # For example purposes, let’s create a single file from all audio recordings.
            audio_chunks = []
            for response in stub.StreamSynthesis(request_generator(), metadata=auth_meta):
                if response.audio_chunk.data:
                    print(f"Audio obtained: {len(response.audio_chunk.data)} b")
                    audio_chunks.append(response.audio_chunk.data)
                if response.text_chunk.text:
                    print("Text to turn into speech:", response.text_chunk.text)
                print(f"Start: {response.start_ms} ms, length: {response.length_ms} ms")
    
            synthesized_audio = b"".join(audio_chunks)
            pathlib.Path("result.wav").write_bytes(synthesized_audio)
            
    
    if __name__ == '__main__':
        stream_synthesis()
    ```

    Where:

    * `<API_key>`: [API key](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) with the `yc.ai.speechkitTts.execute` scope.
    
      If you are using an [IAM token](../../../iam/operations/iam-token/create-for-sa.md) for authentication, modify the Python script.

1. Run the Python script you created:

    ```bash
    python test.py
    ```

    As a result, a file named `result.wav` with synthesized speech will be created in the `cloudapi` directory.