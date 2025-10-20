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
CHUNK_SIZE = 15000  # Chunk size, in bytes (~100 ms at 24 kHz mono PCM16)

REALTIME_URL = f"wss://rest-assistant.api.cloud.yandex.net/v1/realtime/openai?model=gpt://{FOLDER}/speech-realtime-250923"

def make_silence_chunk(samples: int):
    """Generates a silence chunk of a specified duration (samples) in PCM16 format."""
    return b"\x00\x00" * samples


async def main():
    # 1️⃣ Converting the input file to a format compatible with the Realtime API:
    # mono, 24kHz, 16-bit PCM. Without this, the model will not accept the audio.
    print("🎧 Converting the input file...")
    subprocess.run([
        "ffmpeg", "-y", "-i", INPUT_FILE,
        "-ac", "1", "-ar", "24000", "-sample_fmt", "s16",
        CONVERTED_FILE
    ], check=True)
    print(f"✅ Converted {INPUT_FILE} -> {CONVERTED_FILE}")

    # 2️⃣ Establishing a WebSocket connection with the Realtime API.
    async with websockets.connect(
            REALTIME_URL,
            additional_headers=[("Authorization", f"api-key {API_KEY}")]
    ) as ws:
        print("✅ Connected to Realtime API")

        # 3️⃣ Waiting for the first "session.created" event with the session settings.
        created = json.loads(await ws.recv())
        print("✅ Session created:", created)

        # 4️⃣ Updating the session: enabling server_vad, selecting a voice and output format.
        await ws.send(json.dumps({
            "type": "session.update",
            "session": {
                "type": "realtime",
                "output_modalities": ["text", "audio"],  # we want both text and sound
                "audio": {
                    "input": {
                        # Input audio format
                        "format": {"type": "audio/pcm", "rate": 24000},
                        # Server-side VAD configuration
                        "turn_detection": {
                            "type": "server_vad",  # enabling sever VAD
                            "threshold": 0.5,  # sensitivity
                            "silence_duration_ms": 400,  # silence considered to be the end of speech
                        }
                    },
                    "output": {
                        "format": {"type": "audio/pcm", "rate": 44100},
                        "voice": "marina"
                    }
                },
                "instructions": """
            If asked about changing seats in an airplane, pretend you have understood and done everything. 
In your response, strictly follow these rules:
You are assisting the user in the voice channel. 
If the user mentions order number, seats, address, or other important info, make sure you go through it verbally in your response for the user to understand that their inputs were heard correctly.
Keep your responses concise; basically, make sure they are easy to listen to.
            """
            }
        }))

        # 5️⃣ Reading the WAV file we prepared and sending it in chunks.
        with wave.open(CONVERTED_FILE, "rb") as wf:
            assert wf.getframerate() == 24000, "Expected 24 kHz"
            audio_bytes = wf.readframes(wf.getnframes())
            samples_per_chunk = CHUNK_SIZE // 2  # as 2 bytes = 1 sample
            print(f"📊 Sending {len(audio_bytes)} bytes ({wf.getnframes()} frames)")

        # Sending the audio data in chunks
        for i in range(0, len(audio_bytes), CHUNK_SIZE):
            await ws.send(json.dumps({
                "type": "input_audio_buffer.append",
                "audio": base64.b64encode(audio_bytes[i:i + CHUNK_SIZE]).decode("ascii")
            }))

        # Sending ~500 ms of silence at the end for VAD to reliably detect the end of speech
        silence_chunk = make_silence_chunk(samples_per_chunk)
        for _ in range(5):  # 5 * 100мс = 500мс
            await ws.send(json.dumps({
                "type": "input_audio_buffer.append",
                "audio": base64.b64encode(silence_chunk).decode("ascii")
            }))

        committed = False  # we will be monitoring the buffer to make sure it is committed
        full_text, audio_chunks = [], []

        try:
            while True:
                msg = await ws.recv()
                data = json.loads(msg)
                print("📥 Event:", data)

                if data.get("type") == "input_audio_buffer.committed" and not committed:
                    committed = True
                    print("✅ Audio buffer committed — creating response...")
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

                # When the response is fully ready → printing the text and saving the audio
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