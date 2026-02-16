---
title: Потоковое распознавание аудиофайла с помощью API v3 в {{ speechkit-full-name }}
description: Следуя данной инструкции, вы сможете использовать потоковое распознавание аудиофайла с помощью API v3.
---

# Потоковое распознавание аудиофайла с помощью API v3

Ниже рассмотрен пример потокового распознавания речи из аудиофайла с помощью [API v3](../../stt-v3/api-ref/grpc/index.md) {{ speechkit-name }}. В примере заданы параметры:

* [язык](../models.md#languages) — русский;
* формат аудиопотока — [LPCM](../../formats.md#LPCM) с частотой дискретизации 8000 Гц;
* [количество аудиоканалов](../../stt-v3/api-ref/grpc/AsyncRecognizer/recognizeFile#speechkit.stt.v3.RawAudio) — 1 (значение по умолчанию);
* включен [фильтр ненормативной лексики](../../stt-v3/api-ref/grpc/AsyncRecognizer/recognizeFile#speechkit.stt.v3.TextNormalizationOptions);
* остальные параметры оставлены по умолчанию.

Аутентификация происходит от имени сервисного аккаунта с помощью [API-ключа](../../../iam/concepts/authorization/api-key.md) или [IAM-токена](../../../iam/concepts/authorization/iam-token.md). Подробнее об [аутентификации в API {{ speechkit-name }}](../../concepts/auth.md).

Чтобы реализовать пример из этого раздела:

1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт для работы с API {{ speechkit-short-name }}.
1. [Назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роль `{{ roles-speechkit-stt }}` или выше на каталог, в котором он был создан.
1. Настройте окружение и создайте клиентское приложение:

    {% list tabs group=programming_language %}

    - Python 3 {#python}

      1. Получите [API-ключ](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) или [IAM-токен](../../../iam/operations/iam-token/create-for-sa.md) для сервисного аккаунта.
      1. Скачайте [пример](https://{{ s3-storage-host }}/speechkit/speech.pcm) аудиофайла для распознавания или используйте свой аудиофайл.
      1. Склонируйте репозиторий [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi):

         ```bash
         git clone https://github.com/yandex-cloud/cloudapi
         ```
      1. Установите пакет `grpcio-tools` с помощью менеджера пакетов [pip](https://pip.pypa.io/en/stable/):

         ```bash
         pip install grpcio-tools
         ```
      1. Перейдите в папку со склонированным репозиторием {{ yandex-cloud }} API, создайте папку `output` и сгенерируйте в ней код интерфейса клиента:

         ```bash
         cd <путь_к_папке_cloudapi>
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
             yandex/cloud/ai/stt/v3/stt_service.proto \
             yandex/cloud/ai/stt/v3/stt.proto
         ```

         В результате в папке `output` будут созданы файлы с интерфейсом клиента: `stt_pb2.py`, `stt_pb2_grpc.py`, `stt_service_pb2.py`, `stt_service_pb2_grpc.py` и файлы зависимостей.
      1. Создайте файл в корне папки `output`, например `test.py`, и добавьте в него следующий код:

         ```python
         #coding=utf8
         import argparse

         import grpc

         import yandex.cloud.ai.stt.v3.stt_pb2 as stt_pb2
         import yandex.cloud.ai.stt.v3.stt_service_pb2_grpc as stt_service_pb2_grpc

         CHUNK_SIZE = 4000

         def gen(audio_file_name):
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

             # Прочитайте аудиофайл и отправьте его содержимое порциями.
             with open(audio_file_name, 'rb') as f:
                 data = f.read(CHUNK_SIZE)
                 while data != b'':
                     yield stt_pb2.StreamingRequest(chunk=stt_pb2.AudioChunk(data=data))
                     data = f.read(CHUNK_SIZE)

         # Вместо iam_token передавайте api_key при авторизации с API-ключом
         # от имени сервисного аккаунта.
         # def run(api_key, audio_file_name):
         def run(iam_token, audio_file_name):
             # Установите соединение с сервером.
             cred = grpc.ssl_channel_credentials()
             channel = grpc.secure_channel('{{ api-host-sk-stt }}:443', cred)
             stub = stt_service_pb2_grpc.RecognizerStub(channel)

             # Отправьте данные для распознавания.
             it = stub.RecognizeStreaming(gen(audio_file_name), metadata=(
             # Параметры для авторизации с IAM-токеном
                 ('authorization', f'Bearer {iam_token}'),
             # Параметры для авторизации с API-ключом от имени сервисного аккаунта
             #   ('authorization', f'Api-Key {api_key}'),
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
             parser.add_argument('--token', required=True, help='IAM token or API key')
             parser.add_argument('--path', required=True, help='audio file path')
             args = parser.parse_args()
             run(args.token, args.path)
         ```

         Где:

         * `audio_encoding` — [формат](../../formats.md) аудиопотока.
         * `sample_rate_hertz` — частота дискретизации аудиопотока.
         * `audio_channel_count` — количество аудиоканалов.
         * `profanity_filter` — [фильтр ненормативной лексики](../../stt-v3/api-ref/grpc/AsyncRecognizer/recognizeFile#speechkit.stt.v3.TextNormalizationOptions).
         * `literature_text` — [флаг для написания распознанного текста в литературном стиле](../../stt-v3/api-ref/grpc/AsyncRecognizer/recognizeFile#speechkit.stt.v3.TextNormalizationOptions).
         * `language_code` — [язык](../index.md#langs), для которого будет выполнено распознавание.
      1. Сохраните полученный ранее [IAM-токен](../../../iam/concepts/authorization/iam-token.md) сервисного аккаунта в переменную окружения `IAM_TOKEN`:

         ```bash
         export IAM_TOKEN=<IAM-токен_сервисного_аккаунта>
         ```

         Чтобы аутентифицироваться в API {{ speechkit-name }} с помощью API-ключа, сохраните API-ключ в переменную окружения `API_KEY` и измените файл `test.py` в соответствии с комментариями в коде.
      1. Выполните созданный файл:

         ```bash
         python3 output/test.py --token ${IAM_TOKEN} --path <путь_к_файлу_speech.pcm>
         ```

         Где `--path` — путь к аудиофайлу, который необходимо распознать.

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

    - Java {#java}

      1. [Создайте](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) API-ключ сервисного аккаунта.
      1. Установите зависимости:

          ```bash
          sudo apt update && sudo apt install --yes openjdk-21-jre-headless maven
          ```

          Для корректной сборки проекта требуется Java версии `17` и выше.
      1. Склонируйте [репозиторий](https://github.com/yandex-cloud-examples/yc-speechkit-stt-java) с конфигурацией для приложения на Java:

          ```bash
          git clone https://github.com/yandex-cloud-examples/yc-speechkit-stt-java
          ```
      1. Перейдите в папку репозитория:

          ```bash
          cd yc-speechkit-stt-java
          ```
      1. Скомпилируйте проект в этой папке:

          ```bash
          mvn clean install
          ```
      1. Перейдите в созданную папку `target`:

          ```bash
          cd target
          ```
      1. Сохраните [API-ключ](../../../iam/concepts/authorization/api-key.md) сервисного аккаунта в переменную окружения `API_KEY`:

          ```bash
          export API_KEY=<API-ключ>
          ```
      1. Скачайте [пример](https://{{ s3-storage-host }}/doc-files/speech.wav) аудиофайла в [формате WAV](https://ru.wikipedia.org/wiki/WAV):

          ```bash
          wget https://{{ s3-storage-host }}/doc-files/speech.wav
          ```
      1. Запустите программу Java для распознавания речи:

          ```bash
          java -cp speechkit_examples-1.0-SNAPSHOT.jar yandex.cloud.speechkit.examples.SttV3Client speech.wav
          ```

          Результат:

          ```text
          sending  initial request
          Done sending
          Stt stream completed
          Recognized text is я яндекс спичкит я могу превратить любой текст в речь теперь и вы можете
          ```

    {% endlist %}

#### См. также {#see-also}

* [{#T}](microphone-streaming.md)
* [Подробнее про API v3](../../stt-v3/api-ref/grpc/index.md)
* [{#T}](../../concepts/auth.md)
