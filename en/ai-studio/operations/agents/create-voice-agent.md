---
title: Creating a voice agent in {{ foundation-models-full-name }}
description: Follow this guide to create a voice agent using the {{ realtime-api }} in {{ foundation-models-full-name }}.
---

# Creating a voice agent

In {{ foundation-models-full-name }}, you can create a [voice agent](../../concepts/agents/realtime.md) that can communicate with the user in voice and text formats and maintain a dialogue closely resembling natural human interaction.

## Getting started {#before-begin}

To use an example:

1. Get an [API key](../../../iam/concepts/authorization/api-key.md) for the [service account](../../../iam/concepts/users/service-accounts.md) you are going to use to interact with the [{{ realtime-api }}](../../concepts/agents/realtime.md#realtime-api). For more information, see [{#T}](../get-api-key.md).
1. {% include [sdk-before-begin-step3](../../../_includes/ai-studio/sdk-before-begin-step3.md) %}
1. {% include [sdk-before-begin-step4](../../../_includes/ai-studio/sdk-before-begin-step4.md) %}
1. {% include [sdk-before-begin-step5](../../../_includes/ai-studio/sdk-before-begin-step5.md) %}

## Create a voice agent {#create-agent}

The provided example illustrates the process of client-server interaction through the {{ realtime-api }}. To create a voice agent:

1. Create a file named `voice-agent.py` and paste the following code into it:

    ```python
    import asyncio
    import json
    import base64
    import websockets
    import wave
    import subprocess

    API_KEY = "<API_key>"
    FOLDER = "<folder_ID>"
    INPUT_FILE = "<path_to_input_audio_file>"
    CONVERTED_FILE = "./converted.wav"
    OUTPUT_FILE = "./output.wav"
    CHUNK_SIZE = 15000  # Fragment size, in bytes (~100 ms at 24 kHz mono PCM16)

    REALTIME_URL = f"wss://rest-assistant.api.cloud.yandex.net/v1/realtime/openai?model=gpt://{FOLDER}/speech-realtime-250923"


    def make_silence_chunk(samples: int):
        """Generates a silence fragment of a specified duration (samples) in PCM16 format."""
        return (b"\x00\x00" * samples)


    async def main():
        # 1️⃣ Converting the input file to a format the {{ realtime-api }} can understand:
        # mono, 24kHz, 16-bit PCM. Without this, the model will not accept the audio.
        print("🎧 Converting the input file...")
        subprocess.run([
            "ffmpeg", "-y", "-i", INPUT_FILE,
            "-ac", "1", "-ar", "24000", "-sample_fmt", "s16",
            CONVERTED_FILE
        ], check=True)
        print(f"✅ Converted {INPUT_FILE} -> {CONVERTED_FILE}")

        # 2️⃣ Establishing a WebSocket connection with the {{ realtime-api }}.
        async with websockets.connect(
                REALTIME_URL,
                additional_headers=[("Authorization", f"api-key {API_KEY}")]
        ) as ws:
            print("✅ Connected to {{ realtime-api }}")

            # 3️⃣ Waiting for the first "session.created" event with the session settings.
            created = json.loads(await ws.recv())
            print("✅ Session created:", created)

            # 4️⃣ Updating the session: Enabling server_vad, selecting a voice and output format.
            await ws.send(json.dumps({
                "type": "session.update",
                "session": {
                    "type": "realtime",
                    "output_modalities": ["text", "audio"],  # 👈 now we want both text and sound
                    "audio": {
                        "input": {
                            # Input audio format
                            "format": {"type": "audio/pcm", "rate": 24000},
                            # Server-side VAD configuration
                            "turn_detection": {
                                "type": "server_vad",  # enabling sever VAD
                                "threshold": 0.5,  # sensitivity
                                "silence_duration_ms": 200,  # silence considered to be the end of speech
                                "create_response": False,  # creating the response manually
                                "interrupt_response": False
                            }
                        },
                        "output": {
                            "format": {"type": "audio/pcm", "rate": 44100},
                            "voice": "marina"
                        }
                    },
                    "instructions": """
                If asked about airplane and booking, pretend you have understood and done everything.  
    In your response, strictly follow these rules:
    You are assisting the user in the voice channel. 
    If the user mentions order number, seats, address, or other important info, make sure you go through it verbally in your response for the user to understand that their inputs were heard correctly.
    Keep your responses concise; in general, shape them to be easy to listen to.
                """
                }
            }))

            # 5️⃣ Reading the WAV file we prepared and sending it in chunks.
            with wave.open(CONVERTED_FILE, "rb") as wf:
                assert wf.getframerate() == 24000, "Expected 24 kHz"
                audio_bytes = wf.readframes(wf.getnframes())
                samples_per_chunk = CHUNK_SIZE // 2  # as 2 bytes = 1 sample
                print(f"📊 Sending {len(audio_bytes)} bytes ({wf.getnframes()} frames)")

            # Sending the audio data in fragments
            for i in range(0, len(audio_bytes), CHUNK_SIZE):
                await ws.send(json.dumps({
                    "type": "input_audio_buffer.append",
                    "audio": base64.b64encode(audio_bytes[i:i + CHUNK_SIZE]).decode("ascii")
                }))

            # Sending ~500 ms of silence at the end to guarantee VAD detects the end of speech
            silence_chunk = make_silence_chunk(samples_per_chunk)
            for _ in range(5):  # 5 * 100мс = 500мс
                await ws.send(json.dumps({
                    "type": "input_audio_buffer.append",
                    "audio": base64.b64encode(silence_chunk).decode("ascii")
                }))

            # Telling the server that the audio stream has ended.
            await ws.send(json.dumps({"type": "input_audio_buffer.commit"}))
            print("🎙 Audio fully sent — waiting VAD to be completed...")

            committed = False  # we will be tracking to see if buffer has been committed
            full_text, audio_chunks = [], []

            try:
                while True:
                    msg = await ws.recv()
                    data = json.loads(msg)
                    print("📥 Event:", data)

                    if data.get("type") == "input_audio_buffer.committed" and not committed:
                        committed = True
                        print("✅ Audio buffer committed — creating a response...")
                        await ws.send(json.dumps({
                            "type": "response.create",
                            "response": {
                                "instructions": "Give a brief answer to the question from the audio."
                            }
                        }))

                    # Collecting audio deltas if the model sends text
                    if data.get("type") == "response.output_audio.delta":
                        audio_chunks.append(base64.b64decode(data["delta"]))

                    # Collecting text deltas if the model sends text
                    if data.get("type") == "response.output_text.delta":
                        full_text.append(data["delta"])

                    # When the response is fully ready → outputting the text and saving the audio
                    if data.get("type") == "response.done":
                        print("✅ Response completed")
                        if full_text:
                            print("📝 Final text:", "".join(full_text))
                        if audio_chunks:
                            with wave.open(OUTPUT_FILE, "wb") as wf:
                                wf.setnchannels(1)
                                wf.setsampwidth(2)
                                wf.setframerate(44100)
                                wf.writeframes(b"".join(audio_chunks))
                            print(f"🔊 Audio saved to {OUTPUT_FILE}")
                        break

            except websockets.ConnectionClosed:
                print("🔌 Connection closed by server")


    if __name__ == "__main__":
        asyncio.run(main())
    ```

    Where:

    * `API_KEY`: [API key](../../../iam/concepts/authorization/api-key.md) of the [service account](../../../iam/concepts/users/service-accounts.md) used to call {{ realtime-api }} methods. 
    * `FOLDER`: ID of the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the {{ realtime-api }} is called in.
    * `INPUT_FILE`: Path to the file containing the input audio message. In this example, you can use any audio file as the input audio message, even one [generated](../../../speechkit/operations/tts-playground.md) using {{ speechkit-name }} Playground.
    * `CONVERTED_FILE`: Path to the temporary audio file the input audio message will be saved into when converting it to the required format (mono, 24 kHz, 16-bit PCM).
    * `OUTPUT_FILE`: Path to the generated audio file containing the model's response.
1. Run the file you created:

    ```bash
    python3 voice-agent.py
    ```

    As a result of executing the code, the model's response in text format will be displayed on the screen. The audio format response will be saved to a file the path to which is set in the `OUTPUT_FILE` variable.

#### See also {#see-also}

* [{#T}](../../concepts/agents/realtime.md)