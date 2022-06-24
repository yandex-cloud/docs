# Примеры использования API v3 синтеза

В этом примере используется {{ speechkit-short-name }} [API v3](../../new-v3/api-ref/grpc/) для синтеза и записи в аудиофайл следующего текста:

>Я Яндекс Спичк+ит. Я могу превратить любой текст в речь. Теперь и в+ы — можете!

В примере используются настройки по умолчанию: данные в аудиофайле сохраняются в формате [LPCM]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Импульсно-кодовая_модуляция){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Pulse-code_modulation){% endif %} с частотой дискретизации 22 050 Гц и разрядностью 16 бит. Затем данные упаковываются в контейнер [WAV]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/WAV){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/WAV){% endif %}.

Чтобы реализовать пример:

1. Склонируйте репозиторий [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi):

    ```bash
    git clone https://github.com/yandex-cloud/cloudapi
    ```

1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт для работы с API {{ speechkit-short-name }}.
1. [Назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роль `{{ roles-editor }}` или выше на каталог, в котором он был создан.
1. [Получите](../../../iam/operations/iam-token/create-for-sa.md) IAM-токен для сервисного аккаунта.
1. Создайте клиентское приложение:

    {% list tabs %}

    - Python 3

      1. Установите пакеты `grpcio-tools` и `pydub` с помощью менеджера пакетов [pip](https://pip.pypa.io/en/stable/):

          ```bash
          pip install grpcio-tools
          pip install pydub
          ```

          Пакет `grpcio-tools` нужен для генерации кода интерфейса клиента API v3 синтеза.

          Пакет `pydub` нужен для обработки полученных аудиофайлов.

      1. [Скачайте](https://www.ffmpeg.org/download.html) утилиту FFmpeg для корректной работы пакета `pydub`. Добавьте путь к директории, в которой находится исполняемый файл, в переменную `PATH`. Для этого выполните команду:

          ```bash
          export PATH=$PATH:<путь_к_папке_с_исполняемым_файлом_FFmpeg>
          ```

      1. Перейдите в директорию со склонированным репозиторием {{ yandex-cloud }} API, создайте директорию `output` и сгенерируйте в ней код интерфейса клиента:

          ```bash
          cd <путь_к_директории_cloudapi>
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

          В результате в директории `output` будут созданы файлы с интерфейсом клиента: `tts_pb2.py`, `tts_pb2_grpc.py`, `tts_service_pb2.py`, `tts_service_pb2_grpc.py` и файлы зависимостей.

      1. Создайте файл в корне директории `output`, например `test.py`, и добавьте в него следующий код:

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
    
              # Установить соединение с сервером.
              cred = grpc.ssl_channel_credentials()
              channel = grpc.secure_channel('tts.{{ api-host }}:443', cred)
              stub = tts_service_pb2_grpc.SynthesizerStub(channel)

              # Отправить данные для синтеза.
              it = stub.UtteranceSynthesis(request, metadata=(
                  ('authorization', f'Bearer {iam_token}'),
              ))

              # Собрать аудиозапись по чанкам.
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
   
      1. Задайте IAM-токен сервисного аккаунта, текст для синтеза, имя аудиофайла и выполните созданный файл:

          ```bash
          export IAM_TOKEN=<IAM-токен_сервисного_аккаунта>
          export TEXT='Я Яндекс Спичк+ит. Я могу превратить любой текст в речь. Теперь и в+ы — можете!'
          python output/test.py --token ${IAM_TOKEN} --output speech.wav --text ${TEXT}
          ```

          В результате в директории `cloudapi` будет создан файл `speech.wav` с синтезированной речью.
   
    {% endlist %}