---
title: Создать голосового агента через {{ realtime-api }}
description: Следуя этой инструкции, вы сможете с помощью {{ realtime-api }} создать в {{ foundation-models-full-name }} голосового агента для взаимодействия в режиме реального времени через транспорт на базе WebSocket.
---

# Создать голосового агента через {{ realtime-api }} на базе WebSocket

[_{{ realtime-api }}_](../../concepts/agents/realtime.md#realtime-api) — это событийно-ориентированный интерфейс {{ foundation-models-name }}, предназначенный для голосового взаимодействия сервера с клиентом в режиме реального времени через транспорт на базе [WebSocket](https://ru.wikipedia.org/wiki/WebSocket).

С помощью {{ realtime-api }} вы можете создать [голосового агента](../../concepts/agents/realtime.md), который в режиме реального времени будет анализировать аудиопоток с микрофона, передавать голосовые запросы на обработку в [модель](../../concepts/agents/realtime.md#model) `{{ realtime-model }}`, получать ответ модели и воспроизводить его через динамики.

В процессе обработки запросов пользователя модель может вызывать различные [инструменты](../../concepts/assistant/tools/index.md). Ответ на запрос возвращается одновременно в виде синтезированной речи и в текстовом формате.

## Схема взаимодействия пользователя с агентом {#dialog-steps}

В приведенном ниже примере взаимодействие пользователя с агентом организовано по следующей схеме:

1. Пользователь произносит запрос, при этом микрофон записывает поток, а функция `uplink()` отправляет агенту фрагменты аудио.
1. Сервер (модель `{{ realtime-model }}`) выявляет эпизоды тишины ([VAD](https://ru.wikipedia.org/wiki/Voice_Activity_Detection)) и возвращает распознанный текст в событии `conversation.item.input_audio_transcription.completed`. Агент логирует полученный текст.
1. Модель генерирует ответ (`response.created`) и начинает возвращать текстовые дельты (`response.output_text.delta`) и аудиодельты (`response.output_audio.delta`).
1. Функция `downlink()` выводит текст с ответом на экран и воспроизводит аудио через `AudioOut`.

    При этом, если пользователь начинает произносить новый запрос, воспроизведение ответа прерывается и начинается новая итерация обработки нового пользовательского запроса.

## Перед началом работы {#before-begin}

Чтобы воспользоваться примером:

{% list tabs group=programming_language %}

- Python {#python}

  1. {% include [before-begin-realtime-step0](../../../_includes/ai-studio/before-begin-realtime-step0.md) %}
  1. {% include [before-begin-realtime-step1](../../../_includes/ai-studio/before-begin-realtime-step1.md) %}
  1. {% include [sdk-before-begin-step3](../../../_includes/ai-studio/sdk-before-begin-step3.md) %}
  1. {% include [sdk-before-begin-step4](../../../_includes/ai-studio/sdk-before-begin-step4.md) %}
  1. {% include [sdk-before-begin-step5](../../../_includes/ai-studio/sdk-before-begin-step5.md) %}
  1. С помощью менеджера пакетов [pip](https://pip.pypa.io/en/stable/) установите необходимые библиотеки:

      ```bash
      pip install numpy sounddevice aiohttp
      ```

      Дополнительная информация об устанавливаемых библиотеках:

      * `aiohttp` — асинхронные клиенты HTTP и WebSocket. Необходима версия библиотеки `3.9.0` или выше.
      * `numpy` — работа с аудиомассивами и преобразованиями. Необходима версия библиотеки `1.26.0` или выше.
      * `sounddevice` — запись и воспроизведение звука через PortAudio. Необходима версия библиотеки `0.4.6` или выше.

{% endlist %}

## Создайте голосового агента {#create-agent}

Чтобы создать голосового агента на базе WebSocket:

{% list tabs group=programming_language %}

- Python {#python}

  1. Создайте файл `voice-agent.py` и добавьте в него следующий код:

      {% include [va-via-websocket-code](../../../_includes/ai-studio/agents/va-via-websocket-code.md) %}

      Где:

      * Конфигурация:

          * `YANDEX_CLOUD_API_KEY` — [API-ключ](../../../iam/concepts/authorization/api-key.md) [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md), от имени которого вызываются методы {{ realtime-api }}. 
          * `YANDEX_CLOUD_FOLDER_ID` — идентификатор [каталога](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вызывается {{ realtime-api }}.
          * `VECTOR_STORE_ID` — идентификатор [поискового индекса](../../concepts/assistant/search-index.md) для встроенного поиска по файлам базы знаний.
          * `WS_URL` — WebSocket-эндпоинт {{ realtime-api }}.
          * `IN_RATE` и `OUT_RATE` — частоты дискретизации аудио на входе и выходе.
          * `VOICE` — [голос](../../../speechkit/tts/voices.md#premium), которым озвучивается ответ агента.  
      * Вспомогательные функции:
      
          * `float_to_pcm16()` — преобразует аудиоданные из `float32` (с микрофона) в `PCM16`.
          * `b64_encode()` и `b64_decode()` — кодирование в формат [Base64](https://ru.wikipedia.org/wiki/Base64) и декодирование фрагментов аудио для передачи по WebSocket.
          * `log()` — безопасный вывод логов (не блокирует поток).
          * `fake_weather()` — демонстрационная функция, имитирующая погодный API. Возвращает ответ, содержащий информацию о погоде и совет, в формате [JSON](https://ru.wikipedia.org/wiki/JSON).
      * Классы:
      
          * Класс `AudioOut` управляет воспроизведением звука. Создает поток `sounddevice.RawOutputStream` и буфер, в который добавляются PCM-блоки, полученные от сервера. Если очередь пуста, воспроизводится тишина.
          * Класс `MicStreamer` управляет захватом аудио с микрофона в отдельном потоке и отправкой фрагментов аудио в асинхронную очередь (`asyncio.Queue`). Из этой очереди данные затем передаются на сервер в функции `uplink()`.
      * Асинхронные функции:
      
          * `uplink()` — непрерывно получает фрагменты аудио из очереди и отправляет их на сервер в формате:

              ```
              {"type": "input_audio_buffer.append", "audio": "<base64>"}
              ```
          * `downlink()` — обрабатывает входящие сообщения от {{ realtime-api }}:

              * `conversation.item.input_audio_transcription.completed` — распознанный текст запроса пользователя;
              * `response.output_text.delta` — фрагмент ответа агента в текстовом виде;
              * `response.output_audio.delta` — фрагмент ответа агента в аудиоформате (синтезированная речь);
              * `response.output_item.done` — результаты завершенного [вызова функции](../../concepts/generation/function-call.md) (в примере — функции `get_weather`);
              * `error` — сообщения об ошибках;
              * `input_audio_buffer.speech_started` — начало нового запроса пользователя (прекращает воспроизведение текущего ответа агента).
              
          * Основной поток `main()`:

              * Подключается к {{ realtime-api }}.
              * Настраивает сессию: задает модель, параметры аудио и список инструментов.
              * Запускает две фоновые задачи (асинхронные функции `uplink` и `downlink`).
              * Обрабатывает события **Ctrl + C** (корректное завершение соединения).

  1. Выполните созданный файл:

      ```bash
      python3 voice-agent.py
      ```

      В результате выполнения кода агент будет ожидать голосовых запросов и отвечать на них, выводя ответы на экран в текстовом формате и одновременно воспроизводя их в динамиках компьютера.

      Чтобы прервать выполнение кода, используйте комбинацию клавиш **Ctrl + C**.

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/agents/realtime.md)