# Примеры использования API v3 потокового распознавания

Чтобы реализовать пример из этого раздела:

1. Склонируйте репозиторий [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi):

    ```
    git clone https://github.com/yandex-cloud/cloudapi
    ```

1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт для работы с API {{ speechkit-short-name }}.
1. [Назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роль `{{ roles-editor }}` или выше на каталог, в котором он был создан.
1. [Получите](../../../iam/operations/iam-token/create-for-sa.md) IAM-токен для сервисного аккаунта.
1. Скачайте [пример](https://{{ s3-storage-host }}/speechkit/speech.pcm) аудиофайла для распознавания. Аудиофайл имеет формат [LPCM](https://ru.wikipedia.org/wiki/Импульсно-кодовая_модуляция) с частотой дискретизации 8000.
1. Создайте клиентское приложение:

    {% list tabs %}

    - Python 3

      1. Установите пакет `grpcio-tools` с помощью менеджера пакетов [pip](https://pip.pypa.io/en/stable/):

          ```bash
          pip install grpcio-tools
          ```

      1. Перейдите в директорию со склонированным репозиторием {{ yandex-cloud }} API, создайте директорию `output` и сгенерируйте в ней код интерфейса клиента:

          ```bash
          cd <путь_к_директории_cloudapi>
          mkdir output
          python -m grpc_tools.protoc -I . -I third_party/googleapis --python_out=output --grpc_python_out=output google/api/http.proto google/api/annotations.proto yandex/cloud/api/operation.proto google/rpc/status.proto yandex/cloud/operation/operation.proto yandex/cloud/ai/stt/v3/stt_service.proto yandex/cloud/ai/stt/v3/stt.proto
          ```

          В результате в директории `output` будут созданы файлы с интерфейсом клиента: `stt_pb2.py`, `stt_pb2_grpc.py`, `stt_service_pb2.py`, `stt_service_pb2_grpc.py` и файлы зависимостей.

      1. Создайте файл в корне директории `output`, например `test.py`, и добавьте в него следующий код:

          ```python
          #coding=utf8
          import argparse

          import grpc

          import yandex.cloud.ai.stt.v3.stt_pb2 as stt_pb2
          import yandex.cloud.ai.stt.v3.stt_service_pb2_grpc as stt_service_pb2_grpc


          CHUNK_SIZE = 4000

          def gen(audio_file_name):
              # Задать настройки распознавания.
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

              # Отправить сообщение с настройками распознавания.
              yield stt_pb2.StreamingRequest(session_options=recognize_options)

              # Прочитать аудиофайл и отправить его содержимое порциями.
              with open(audio_file_name, 'rb') as f:
                  data = f.read(CHUNK_SIZE)
                  while data != b'':
                      yield stt_pb2.StreamingRequest(chunk=stt_pb2.AudioChunk(data=data))
                      data = f.read(CHUNK_SIZE)

          def run(iam_token, audio_file_name):
              # Установить соединение с сервером.
              cred = grpc.ssl_channel_credentials()
              channel = grpc.secure_channel('stt.{{ api-host }}:443', cred)
              stub = stt_service_pb2_grpc.RecognizerStub(channel)

              # Отправить данные для распознавания.
              it = stub.RecognizeStreaming(gen(audio_file_name), metadata=(
                  ('authorization', f'Bearer {iam_token}'),
                  ('x-node-alias', 'speechkit.stt.rc')
              ))

              # Обработать ответы сервера и вывести результат в консоль.
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
              parser.add_argument('--token', required=True, help='IAM token')
              parser.add_argument('--path', required=True, help='audio file path')
              args = parser.parse_args()
              run(args.token, args.path)

          ```
   
      1. Задайте IAM-токен сервисного аккаунта и выполните созданный файл. В параметре `path` укажите путь к аудиофайлу, который необходимо распознать:

          ```bash
          export IAM_TOKEN=<IAM-токен_сервисного_аккаунта>
          python output/test.py --token ${IAM_TOKEN} --path <путь_к_файлу_speech.pcm>
          ```

          Результат:

          ```bash
          type=status_code, alternatives=None
          type=partial, alternatives=None
          type=partial, alternatives=['привет ми']
          type=final, alternatives=['привет мир']
          type=final_refinement, alternatives=['Привет мир']
          type=eou_update, alternatives=None
          type=partial, alternatives=None
          type=status_code, alternatives=None
          ```
   
    {% endlist %}