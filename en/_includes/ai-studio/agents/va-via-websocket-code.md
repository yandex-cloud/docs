{% cut "Voice agent code" %}

```python
import json
import base64
import asyncio
import threading
import time
import random
import sys
from typing import Optional

import numpy as np
import sounddevice as sd
import aiohttp

# ==== Configuration ====
YANDEX_CLOUD_API_KEY = "<service_account_API_key>"
YANDEX_CLOUD_FOLDER_ID = "<folder_ID>"

# Configuring tools
VECTOR_STORE_ID = "<search_index_ID>"

# Checking for key and folder ID
assert (
    YANDEX_CLOUD_FOLDER_ID and YANDEX_CLOUD_API_KEY
), "YANDEX_CLOUD_FOLDER_ID and YANDEX_CLOUD_API_KEY are required"

# API settings
WS_URL = (
    f"wss://rest-assistant.{{ api-host }}/v1/realtime/openai"
    f"?model=gpt://{YANDEX_CLOUD_FOLDER_ID}/{{ realtime-model }}"
)
HEADERS = {"Authorization": f"api-key {YANDEX_CLOUD_API_KEY}"}

# Configuring audio for a server
IN_RATE = 24000
OUT_RATE = 44100
CHANNELS = 1
VOICE = "dasha"

# Configuring audio for a local device
FRAME_MS = 20
IN_SAMPLES = int(IN_RATE * FRAME_MS / 1000)
OUT_BLOCK = int(OUT_RATE * 0.02)


# ======== Auxiliary functions ========


# Converts audio from `float32` to `PCM16`
def float_to_pcm16(data: np.ndarray) -> bytes:
    data = np.clip(data, -1.0, 1.0)
    return (data * 32767).astype(np.int16).tobytes()


# Decodes a base64 string into bytes
def b64_decode(s: str) -> bytes:
    return base64.b64decode(s)


# Encodes bytes into a base64 string
def b64_encode(b: bytes) -> str:
    return base64.b64encode(b).decode("ascii")


# Thread-safe log output
def log(*args):
    print(*args)
    sys.stdout.flush()


# Generates fake weather data JSONs
def fake_weather(city: str) -> str:
    rng = random.Random(hash(city) & 0xFFFFFFFF)

    weather_data = {
        "city": city,
        "temperature_c": rng.randint(-10, 35),
        "condition": rng.choice(["clear", "cloudy", "rain", "snow", "thunderstorm", "fog"]),
        "wind_m_s": round(rng.uniform(0.5, 10.0), 1),
        "advice": rng.choice(
            [
                "Take along a light jacket.",
                "An umbrella will come in handy.",
                "Drink water and avoid the sun.",
                "The roads are slippery, so be careful.",
                "It's windy, a hood will be a good idea.",
            ]
        ),
    }

    return json.dumps(weather_data, ensure_ascii=False)


# ======== Audio output class ========
class AudioOut:

    # Manages the output audio stream, buffered
    def __init__(self, rate: int = OUT_RATE):
        import queue

        self.queue = queue.Queue(maxsize=100)
        self.closed = False
        self.stream = sd.RawOutputStream(
            samplerate=rate,
            channels=1,
            dtype="int16",
            blocksize=OUT_BLOCK,
            latency="low",
            callback=self._audio_callback,
        )
        self.stream.start()

    # Audio stream callback
    def _audio_callback(self, outdata, frames, time_info, status):
        try:
            chunk = self.queue.get_nowait()
        except Exception:
            outdata[:] = b"\x00" * (frames * 2)
            return

        need = frames * 2

        if len(chunk) >= need:
            outdata[:] = chunk[:need]
            rest = chunk[need:]
            if rest:
                try:
                    self.queue.queue.appendleft(rest)
                except Exception:
                    pass
        else:
            outdata[: len(chunk)] = chunk
            outdata[len(chunk) :] = b"\x00" * (need - len(chunk))

    # Adds audio data to the output queue
    def write(self, pcm16_bytes: bytes):
        if self.closed or not pcm16_bytes:
            return

        try:
            self.queue.put_nowait(pcm16_bytes)
        except Exception:
            self.clear()

    # Clears the audio buffer
    def clear(self):
        try:
            with self.queue.mutex:
                self.queue.queue.clear()
        except Exception:
            pass

    # Closes the audio stream
    def close(self):
        if self.closed:
            return

        self.closed = True
        try:
            self.stream.stop()
            self.stream.close()
        except Exception:
            pass


# ======== Microphone recording class ========
class MicStreamer:
    # Sends audio from a microphone to an async queue
    def __init__(self, output_queue: asyncio.Queue, can_stream_event: asyncio.Event):
        self.output_queue = output_queue
        self.running = False
        self.loop: Optional[asyncio.AbstractEventLoop] = None
        self.can_stream_event = can_stream_event

    # Starts a microphone recording stream in a separate thread
    def start(self):
        self.loop = asyncio.get_running_loop()
        self.running = True
        threading.Thread(target=self._streaming_loop, daemon=True).start()

    # Main loop for recording audio from a microphone
    def _streaming_loop(self):
        try:
            with sd.InputStream(
                samplerate=IN_RATE,
                channels=1,
                dtype="float32",
                blocksize=IN_SAMPLES,
                latency="low",
            ) as stream:
                while self.running:
                    if not self.can_stream_event.is_set():
                        time.sleep(0.01)
                        continue

                    data, _ = stream.read(IN_SAMPLES)
                    pcm = float_to_pcm16(data.reshape(-1))

                    if self.loop and not self.loop.is_closed():
                        future = asyncio.run_coroutine_threadsafe(
                            self.output_queue.put(pcm), self.loop
                        )
                        try:
                            future.result(timeout=0.2)
                        except Exception:
                            pass
        except Exception as e:
            log("[MIC ERROR]", e)

    # Stops microphone recording
    def stop(self):
        self.running = False


# ======== Main app ========


# Main loop of the app
async def main():
    session = aiohttp.ClientSession()
    ws = await session.ws_connect(WS_URL, headers=HEADERS, heartbeat=20.0)
    log("Connected to Realtime API.")

    # Configuring the session
    await ws.send_json(
        {
            "type": "session.update",
            "session": {
                "instructions": (
                    "You are a polite English-speaking assistant. Answer briefly."
                    "If asked to tell the news, use the web_search function."
                    "If asked about the weather, call the get_weather function."
                    "If asked about {voice profiler}, use the file_search function"
                ),
                # Response format configuration: response can contain both text and audio
                "output_modalities": ["text", "audio"],
                "audio": {
                    "input": {
                        # Input audio format
                        "format": {
                            "type": "audio/pcm",
                            "rate": IN_RATE,
                            "channels": CHANNELS,
                        },
                        # Server VAD configuration
                        "turn_detection": {
                            "type": "server_vad",  # enabling sever VAD
                            "threshold": 0.5,  # sensitivity
                            "silence_duration_ms": 400,  # duration of silence to complete a speech fragment
                        },
                    },
                    # Output audio format
                    "output": {
                        "format": {"type": "audio/pcm", "rate": OUT_RATE},
                        "voice": VOICE,
                    },
                },
                # "tool_choice": {"type": "auto"}
                # Tools for the agent
                "tools": [
                    # Model function to demo function calls
                    {
                        "type": "function",
                        "name": "get_weather",
                        "description": "Get a brief weather report for the city.",
                        "parameters": {
                            "type": "object",
                            "properties": {"city": {"type": "string"}},
                            "required": ["city"],
                            "additionalProperties": False,
                        },
                    },
                    # Internet search tool
                    {
                        "type": "function",
                        "name": "web_search",
                        "description": "Web search",
                        "parameters": "{}",
                    },
                    # File system search tool
                    {
                        "type": "function",
                        "name": "file_search",  # required function name
                        "description": VECTOR_STORE_ID,  # index ID
                        "parameters": "{}",
                    },
                ],
            },
        }
    )

    # Initializing audio components
    mic_queue: asyncio.Queue[bytes] = asyncio.Queue(maxsize=50)
    can_stream_input = asyncio.Event()
    can_stream_input.set()

    mic = MicStreamer(mic_queue, can_stream_input)
    mic.start()

    audio_out = AudioOut()
    session_id = None

    # Managing text-to-speech conversion "epochs"
    play_epoch = 0
    current_response_epoch = None

    # Sending audio from microphone to the server
    async def uplink():
        try:
            while True:
                await can_stream_input.wait()
                pcm = await mic_queue.get()
                await ws.send_json(
                    {"type": "input_audio_buffer.append", "audio": b64_encode(pcm)}
                )
        except asyncio.CancelledError:
            pass

    # Receiving and processing messages from the server
    async def downlink():
        nonlocal session_id, play_epoch, current_response_epoch

        async for msg in ws:
            if msg.type != aiohttp.WSMsgType.TEXT:
                continue

            message = json.loads(msg.data)
            msg_type = message.get("type")

            if msg_type not in {
                "input_audio_buffer.commit",
                "response.output_text.delta",
                "conversation.item.input_audio_transcription.completed",
                "session.created",
            }:
                log(f"on_message: {msg_type}")

            # User's recognized text
            if msg_type == "conversation.item.input_audio_transcription.completed":
                transcript = message.get("transcript", "")
                if transcript:
                    log(f"on_message: {msg_type} [user (transcript): {transcript}]")
                continue

            # Text the server sends for text-to-speech conversion
            if msg_type == "response.output_text.delta":
                delta = message.get("delta", "")
                if delta:
                    log(f"on_message: {msg_type} [agent (text): {delta}]")
                continue

            # Logging the session ID
            if msg_type == "session.created":
                session_id = (message.get("session") or {}).get("id")
                log(f"on_message: {msg_type} [session.id = {session_id}]")
                continue

            # Interrupting the agent's current response if the user starts speaking
            if msg_type == "input_audio_buffer.speech_started":
                play_epoch += 1
                current_response_epoch = None
                audio_out.clear()
                continue

            # Start of the agent's new response
            if msg_type == "response.created":
                current_response_epoch = play_epoch
                continue

            # Arrival of audio data from the agent
            if msg_type == "response.output_audio.delta":
                if current_response_epoch == play_epoch:
                    audio_out.write(b64_decode(message["delta"]))
                continue

            # Ending a function call
            if msg_type == "response.output_item.done":
                item = message.get("item") or {}

                if item.get("type") == "function_call":
                    call_id = item.get("call_id")
                    args_text = item.get("arguments") or "{}"

                    try:
                        args = json.loads(args_text)
                    except Exception:
                        args = {}

                    city = (args.get("city") or "Moscow").strip()
                    weather_json = fake_weather(city)

                    payload_item = {
                        "type": "conversation.item.create",
                        "item": {
                            "type": "function_call_output",
                            "call_id": call_id,
                            "output": weather_json,
                        },
                    }

                    log(
                        "[conversation.item.create(function_call_output):",
                        json.dumps(payload_item, ensure_ascii=False),
                    )
                    await ws.send_json(payload_item)

                    # Request for a new agent response
                    log("Sending response.create after function")
                    await ws.send_json(
                        {
                            "type": "response.create",
                            "response": {
                                "modalities": ["audio", "text"],
                                "conversation": "default",
                            },
                        }
                    )
                continue

            # Handling errors
            if msg_type == "error":
                log("SERVER ERROR:", json.dumps(message, ensure_ascii=False))
                continue

        log("WS connection closed")

    log("Speak (server VAD). Press Ctrl+C to exit.")

    uplink_task = asyncio.create_task(uplink())
    downlink_task = asyncio.create_task(downlink())

    try:
        while True:
            await asyncio.sleep(3600)
    except KeyboardInterrupt:
        pass
    finally:
        uplink_task.cancel()
        downlink_task.cancel()
        mic.stop()
        audio_out.close()
        await ws.close()
        await session.close()
        log("\nExit.")


if __name__ == "__main__":
    asyncio.run(main())
```

{% endcut %}