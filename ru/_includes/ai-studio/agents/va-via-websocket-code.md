{% cut "Код голосового агента" %}

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

# ==== Конфигурация ====
YANDEX_CLOUD_API_KEY = "<API-ключ_сервисного_аккаунта>"
YANDEX_CLOUD_FOLDER_ID = "<идентификатор_каталога>"

# Конфигурация инструментов
VECTOR_STORE_ID = "<идентификатор_поискового_индекса>"

# Проверяем, что заданы ключ и ID каталога
assert (
    YANDEX_CLOUD_FOLDER_ID and YANDEX_CLOUD_API_KEY
), "YANDEX_CLOUD_FOLDER_ID и YANDEX_CLOUD_API_KEY обязательны"

# Настройки API
WS_URL = (
    f"wss://rest-assistant.{{ api-host }}/v1/realtime/openai"
    f"?model=gpt://{YANDEX_CLOUD_FOLDER_ID}/{{ realtime-model }}"
)
HEADERS = {"Authorization": f"api-key {YANDEX_CLOUD_API_KEY}"}

# Конфигурация аудио для сервера
IN_RATE = 24000
OUT_RATE = 44100
CHANNELS = 1
VOICE = "dasha"

# Конфигурация аудио для локального устройства
FRAME_MS = 20
IN_SAMPLES = int(IN_RATE * FRAME_MS / 1000)
OUT_BLOCK = int(OUT_RATE * 0.02)


# ======== Вспомогательные функции ========


# Преобразует аудио из формата float32 в формат PCM16
def float_to_pcm16(data: np.ndarray) -> bytes:
    data = np.clip(data, -1.0, 1.0)
    return (data * 32767).astype(np.int16).tobytes()


# Декодирует строку base64 в байты
def b64_decode(s: str) -> bytes:
    return base64.b64decode(s)


# Кодирует байты в строку base64
def b64_encode(b: bytes) -> str:
    return base64.b64encode(b).decode("ascii")


# Потокобезопасный вывод логов
def log(*args):
    print(*args)
    sys.stdout.flush()


# Генерирует фиктивные погодные данные в виде JSON
def fake_weather(city: str) -> str:
    rng = random.Random(hash(city) & 0xFFFFFFFF)

    weather_data = {
        "city": city,
        "temperature_c": rng.randint(-10, 35),
        "condition": rng.choice(["ясно", "облачно", "дождь", "снег", "гроза", "туман"]),
        "wind_m_s": round(rng.uniform(0.5, 10.0), 1),
        "advice": rng.choice(
            [
                "Возьми легкую куртку.",
                "Зонт пригодится.",
                "Пей воду и избегай солнца.",
                "На дорогах скользко — будь аккуратнее.",
                "Ветрено, капюшон не помешает.",
            ]
        ),
    }

    return json.dumps(weather_data, ensure_ascii=False)


# ======== Класс для вывода аудио ========
class AudioOut:

    # Управляет выходным аудиопотоком с буферизацией.
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

    # Обратный вызов для аудиопотока
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

    # Добавляет аудиоданные в очередь вывода
    def write(self, pcm16_bytes: bytes):
        if self.closed or not pcm16_bytes:
            return

        try:
            self.queue.put_nowait(pcm16_bytes)
        except Exception:
            self.clear()

    # Очищает буфер аудио
    def clear(self):
        try:
            with self.queue.mutex:
                self.queue.queue.clear()
        except Exception:
            pass

    # Закрывает аудиопоток
    def close(self):
        if self.closed:
            return

        self.closed = True
        try:
            self.stream.stop()
            self.stream.close()
        except Exception:
            pass


# ======== Класс для записи с микрофона ========
class MicStreamer:
    # Передает аудио с микрофона в асинхронную очередь
    def __init__(self, output_queue: asyncio.Queue, can_stream_event: asyncio.Event):
        self.output_queue = output_queue
        self.running = False
        self.loop: Optional[asyncio.AbstractEventLoop] = None
        self.can_stream_event = can_stream_event

    # Запускает поток записи микрофона в отдельном треде
    def start(self):
        self.loop = asyncio.get_running_loop()
        self.running = True
        threading.Thread(target=self._streaming_loop, daemon=True).start()

    # Основной цикл записи аудио с микрофона
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

    # Останавливает запись с микрофона
    def stop(self):
        self.running = False


# ======== Основное приложение ========


# Главный цикл приложения
async def main():
    session = aiohttp.ClientSession()
    ws = await session.ws_connect(WS_URL, headers=HEADERS, heartbeat=20.0)
    log("Подключено к Realtime API.")

    # Настройка сессии
    await ws.send_json(
        {
            "type": "session.update",
            "session": {
                "instructions": (
                    "Ты вежливый русскоязычный ассистент. Отвечай кратко. "
                    "Если просят рассказать новости —  используй функцию web_search."
                    "Если спрашивают о погоде — вызывай функцию get_weather."
                    "При вопросе про {голосовой профилировщик} - обращайся к функции file_search"
                ),
                # Конфигурация формата ответа: в ответе может быть и текст, и звук
                "output_modalities": ["text", "audio"],
                "audio": {
                    "input": {
                        # Формат входящего аудио
                        "format": {
                            "type": "audio/pcm",
                            "rate": IN_RATE,
                            "channels": CHANNELS,
                        },
                        # Конфигурация серверного VAD
                        "turn_detection": {
                            "type": "server_vad",  # включаем серверный VAD
                            "threshold": 0.5,  # чувствительность
                            "silence_duration_ms": 400,  # длительность тишины для завершения речи
                        },
                    },
                    # Формат исходящего аудио
                    "output": {
                        "format": {"type": "audio/pcm", "rate": OUT_RATE},
                        "voice": VOICE,
                    },
                },
                # "tool_choice": {"type": "auto"}
                # Инструменты для использования в агенте
                "tools": [
                    # Функция модели для демонстрации работы с вызовом функций
                    {
                        "type": "function",
                        "name": "get_weather",
                        "description": "Получить краткую сводку погоды по городу.",
                        "parameters": {
                            "type": "object",
                            "properties": {"city": {"type": "string"}},
                            "required": ["city"],
                            "additionalProperties": False,
                        },
                    },
                    # Инструмент поиска в интернете.
                    {
                        "type": "function",
                        "name": "web_search",
                        "description": "Поиск в интернете",
                        "parameters": "{}",
                    },
                    # Инструмент поиска по файлам.
                    {
                        "type": "function",
                        "name": "file_search",  # обязательное имя функции
                        "description": VECTOR_STORE_ID,  # id индекса
                        "parameters": "{}",
                    },
                ],
            },
        }
    )

    # Инициализация компонентов аудио
    mic_queue: asyncio.Queue[bytes] = asyncio.Queue(maxsize=50)
    can_stream_input = asyncio.Event()
    can_stream_input.set()

    mic = MicStreamer(mic_queue, can_stream_input)
    mic.start()

    audio_out = AudioOut()
    session_id = None

    # Управление "эпохами" озвучки
    play_epoch = 0
    current_response_epoch = None

    # Отправка аудио с микрофона на сервер
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

    # Прием и обработка сообщений от сервера
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

            # Распознанный текст пользователя
            if msg_type == "conversation.item.input_audio_transcription.completed":
                transcript = message.get("transcript", "")
                if transcript:
                    log(f"on_message: {msg_type} [user (transcript): {transcript}]")
                continue

            # Текст, который сервер отправляет на озвучку
            if msg_type == "response.output_text.delta":
                delta = message.get("delta", "")
                if delta:
                    log(f"on_message: {msg_type} [agent (text): {delta}]")
                continue

            # Логирование идентификатора сессии
            if msg_type == "session.created":
                session_id = (message.get("session") or {}).get("id")
                log(f"on_message: {msg_type} [session.id = {session_id}]")
                continue

            # Прерывание текущего ответа агента, если пользователь начал говорить
            if msg_type == "input_audio_buffer.speech_started":
                play_epoch += 1
                current_response_epoch = None
                audio_out.clear()
                continue

            # Начало нового ответа агента
            if msg_type == "response.created":
                current_response_epoch = play_epoch
                continue

            # Поступление аудиоданных от агента
            if msg_type == "response.output_audio.delta":
                if current_response_epoch == play_epoch:
                    audio_out.write(b64_decode(message["delta"]))
                continue

            # Завершение вызова функции
            if msg_type == "response.output_item.done":
                item = message.get("item") or {}

                if item.get("type") == "function_call":
                    call_id = item.get("call_id")
                    args_text = item.get("arguments") or "{}"

                    try:
                        args = json.loads(args_text)
                    except Exception:
                        args = {}

                    city = (args.get("city") or "Москва").strip()
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

                    # Запрос нового ответа агента
                    log("отправляем response.create после функции")
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

            # Обработка ошибок
            if msg_type == "error":
                log("ОШИБКА СЕРВЕРА:", json.dumps(message, ensure_ascii=False))
                continue

        log("WS соединение закрыто")

    log("Говорите (server VAD). Нажмите Ctrl+C для выхода.")

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
        log("\nВыход.")


if __name__ == "__main__":
    asyncio.run(main())
```

{% endcut %}