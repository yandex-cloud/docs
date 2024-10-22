# Потоковое распознавание речи с микрофона с помощью API v3

Ниже рассмотрен пример потокового распознавания речи, продиктованной на микрофон. Распознавание происходит в режиме реального времени с помощью [API v3](../../stt-v3/api-ref/grpc/) {{ speechkit-name }}.

В примере заданы параметры:

* [язык](../models.md#languages) — русский;
* формат аудиопотока — [LPCM](../../formats.md#LPCM) с частотой дискретизации 8000 Гц;
* [количество аудиоканалов](../../stt-v3/api-ref/grpc/AsyncRecognizer/recognizeFile#speechkit.stt.v3.RawAudio) — 1;
* размер буфера записи — 4096;
* длительность записи голоса — 30 секунд;
* [фильтр ненормативной лексики](../../stt-v3/api-ref/grpc/AsyncRecognizer/recognizeFile#speechkit.stt.v3.TextNormalizationOptions) — включен.

Для работы с API нужны пакеты `grpcio-tools`, `PortAudio` и `PyAudio`.

Аутентификация выполняется от имени сервисного аккаунта с помощью [API-ключа](../../../iam/concepts/authorization/api-key.md). Подробнее об [аутентификации в API {{speechkit-name}}](../../concepts/auth.md).

## Подготовьте необходимые данные {#preparations}

1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) ему роль `{{ roles-speechkit-stt }}`.
1. Для сервисного аккаунта [получите](../../../iam/operations/api-key/create.md) и сохраните API-ключ.

## Создайте приложение для потокового распознавания речи {#create-an-application}

{% list tabs group=programming_language %}

- Python 3 {#python}

   1. Склонируйте репозиторий [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi):

      ```bash
      git clone https://github.com/yandex-cloud/cloudapi
      ```

   1. Установите пакет `PortAudio` для вывода аудио в режиме реального времени:

      ```bash
      sudo apt update && sudo apt install portaudio19-dev
      ```

   1. Установите менеджер пакетов [pip](https://pip.pypa.io/en/stable/), если он не установлен. Иначе переходите к следующему шагу.

      ```bash
      sudo apt install python3-pip
      ```

   1. С помощью менеджера пакетов pip установите пакеты:

      * `grpcio-tools` — для работы с API {{speechkit-name}};
      * `PyAudio` — для записи аудио.

      ```bash
      pip install grpcio-tools PyAudio
      ```

   1. Перейдите в папку с репозиторием {{ yandex-cloud }} API, создайте папку `output` и сгенерируйте в ней код интерфейса клиента:

      ```bash
      cd <путь_к_папке_cloudapi> && \
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

      В результате в папке `output` будут созданы файлы с интерфейсом клиента: `stt_pb2.py`, `stt_pb2_grpc.py`, `stt_service_pb2.py`, `stt_service_pb2_grpc.py` и файлы зависимостей.

   1. Создайте файл `test.py` в папке `output` и добавьте в него код:

      ```python
      import pyaudio
      import wave
      import argparse
      import grpc
      import yandex.cloud.ai.stt.v3.stt_pb2 as stt_pb2
      import yandex.cloud.ai.stt.v3.stt_service_pb2_grpc as stt_service_pb2_grpc

      # Настройки потокового распознавания.
      FORMAT = pyaudio.paInt16
      CHANNELS = 1
      RATE = 8000
      CHUNK = 4096
      RECORD_SECONDS = 30
      WAVE_OUTPUT_FILENAME = "audio.wav"

      audio = pyaudio.PyAudio()

      def gen():
         # Задайте настройки распознавания.
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

         # Отправьте сообщение с настройками распознавания.
         yield stt_pb2.StreamingRequest(session_options=recognize_options)

         # Начните запись голоса.
         stream = audio.open(format=FORMAT, channels=CHANNELS,
                     rate=RATE, input=True,
                     frames_per_buffer=CHUNK)
         print("recording")
         frames = []

         # Распознайте речь по порциям.
         for i in range(0, int(RATE / CHUNK * RECORD_SECONDS)):
            data = stream.read(CHUNK)
            yield stt_pb2.StreamingRequest(chunk=stt_pb2.AudioChunk(data=data))
            frames.append(data)
         print("finished")

         # Остановите запись.
         stream.stop_stream()
         stream.close()
         audio.terminate()

         # Создайте файл WAV с записанным голосом.
         waveFile = wave.open(WAVE_OUTPUT_FILENAME, 'wb')
         waveFile.setnchannels(CHANNELS)
         waveFile.setsampwidth(audio.get_sample_size(FORMAT))
         waveFile.setframerate(RATE)
         waveFile.writeframes(b''.join(frames))
         waveFile.close()

      def run(secret):
         # Установите соединение с сервером.
         cred = grpc.ssl_channel_credentials()
         channel = grpc.secure_channel('stt.{{ api-host }}:443', cred)
         stub = stt_service_pb2_grpc.RecognizerStub(channel)

         # Отправьте данные для распознавания.
         it = stub.RecognizeStreaming(gen(), metadata=(
         # Параметры для аутентификации с API-ключом от имени сервисного аккаунта
            ('authorization', f'Api-Key {secret}'),
         # Для аутентификации с IAM-токеном используйте строку ниже
         #   ('authorization', f'Bearer {secret}'),
         ))

         # Обработайте ответы сервера и выведите результат в консоль.
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

      Где:

      * `FORMAT` — формат аудиопотока.
      * `CHANNELS` — количество аудиоканалов.
      * `RATE` — частота дискретизации аудиопотока, в герцах.
      * `CHUNK` — размер буфера записи. Размер определяется количеством кадров, на которые разбивается записанная речь.
      * `RECORD_SECONDS` — длительность записи голоса, в секундах.
      * `WAVE_OUTPUT_FILENAME` — название аудиофайла с записью голоса. Файл создается в результате работы скрипта.
      * `profanity_filter` — фильтр ненормативной лексики.
      * `literature_text` — [флаг для написания распознанного текста в литературном стиле](../../stt-v3/api-ref/grpc/AsyncRecognizer/recognizeFile#speechkit.stt.v3.TextNormalizationOptions).
      * `language_code` — язык, для которого будет выполнено распознавание.

   1. Задайте API-ключ сервисного аккаунта в виде переменной окружения:

      ```bash
      export API_KEY=<API-ключ>
      ```

   1. Выполните созданный файл:

      ```python
      python3 output/test.py --secret ${API_KEY}
      ```

      В терминале запускается скрипт по распознаванию речи. В качестве входных данных он ожидает речь, продиктованную на микрофон.

   1. Говорите в микрофон.

      Записанная речь выводится в терминал. Пример:

      ```text
      type=status_code, alternatives=None
      type=status_code, alternatives=None
      type=partial, alternatives=['проверка']
      type=partial, alternatives=['проверка']
      type=status_code, alternatives=None
      type=status_code, alternatives=None
      type=partial, alternatives=['проверка распознавания']
      type=status_code, alternatives=None
      type=status_code, alternatives=None
      type=status_code, alternatives=None
      type=partial, alternatives=['проверка распознавания']
      type=partial, alternatives=['проверка распознавания голоса']
      type=status_code, alternatives=None
      type=status_code, alternatives=None
      type=partial, alternatives=['проверка распознавания голоса']
      ```

   Скрипт распознает и записывает речь в течение 30 секунд. После завершения его работы сохраняется файл `audio.wav` с записанным голосом.

{% endlist %}

## Решение проблем {#troubleshooting}

#### Скрипт запускается, но речь не распознается {#no-recognition}

Возможно несколько причин:

* Скрипт запущен в терминале, встроенном в IDE. Такой терминал может не иметь доступ к микрофону. Запустите скрипт во внешнем терминале.
* Скрипт запущен на macOS, и терминалу не выдан доступ к микрофону. Откройте системные настройки операционной системы и проверьте, есть ли у терминала нужный доступ.
* Микрофон не подключен.
