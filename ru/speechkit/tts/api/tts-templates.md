# Синтез речи по шаблонам с помощью API v3

Синтез по шаблонам в {{ brand-voice-premium }} и {{ brand-voice-core }} доступен только для голосов [{{ brand-voice-name }}](../brand-voice/index.md).


{% note warning %}

Сервисы {{ brand-voice-premium }} и {{ brand-voice-core }} предоставляются по запросу. Для доступа к технологии [заполните форму](#contact-form).

{% endnote %}


Чтобы синтезировать фразу по шаблону:

1. [{#T}](#prepare-template).
1. [{#T}](#send-to-api).

## Перед началом работы {#before-you-begin}

{% include [template-synthesis-before-you-begin](../../../_includes/speechkit/api-v3-template-synthesis-before.md) %}

## Подготовьте шаблон аудиозаписи {#prepare-template}

Шаблон состоит из аудиозаписи шаблонной фразы и размеченного текста фразы.

Ограничения на параметры шаблона:

* Длительность фразы для синтеза — не более {{ tts-v3-time }} (ограничение API) вместе с переменной частью. Оптимальная для восприятия длительность фразы — не более 16 секунд, как в разговорной речи.
* Длина шаблона — не более {{ tts-v3-count }} нормализованного текста.

{% note warning %}

Отправляйте в API синтеза шаблоны с переменными частями. Неизменяемые фразы отправлять не нужно.

Примеры неизменяемых фраз:
>Здравствуйте, с вами говорят из клиники "МедСити".
>
>Добрый день, это компания по вывозу строительного мусора "Вывозов".
>

{% endnote %}

{% include [prepare-template-synthesis](../../../_includes/speechkit/prepare-template-synthesis.md) %}

## Отправьте данные в API v3 {#send-to-api}

Создайте и запустите клиентское приложение для отправки данных:

{% list tabs %}

- Python 3

    1. Склонируйте репозиторий [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi):

       ```bash
       git clone https://github.com/yandex-cloud/cloudapi
       ```
       
    1. Установите зависимости с помощью [менеджера пакетов pip](https://pip.pypa.io/en/stable/):

        ```bash
        pip install grpcio-tools && \
        pip install pydub
        ```

        Пакет `grpcio-tools` нужен для генерации кода интерфейса клиента API v3 синтеза.

        Пакет `pydub` нужен для обработки полученных аудиофайлов.

    1. [Скачайте утилиту FFmpeg](https://www.ffmpeg.org/download.html) для корректной работы пакета `pydub`.
    1. Добавьте путь к папке, в которой находится исполняемый файл FFmpeg, в переменную `PATH`:

        ```bash
        export PATH=$PATH:<путь_к_папке_с_исполняемым_файлом_FFmpeg>
        ```

    1. Перейдите в папку с клонированным репозиторием {{ yandex-cloud }} API, создайте папку `output` и сгенерируйте в ней код интерфейса клиента:

        ```bash
        cd <путь_к_папке_cloudapi> && \
        mkdir output && \
        python -m grpc_tools.protoc -I . -I third_party/googleapis \
          --python_out=output \
          --grpc_python_out=output \
          google/api/http.proto \
          google/api/annotations.proto \
          yandex/cloud/api/operation.proto \
          google/rpc/status.proto \
          yandex/cloud/ai/tts/v3/tts_service.proto \
          yandex/cloud/ai/tts/v3/tts.proto
        ```

        В папке `output` будут созданы файлы с интерфейсом клиента: `tts_pb2.py`, `tts_pb2_grpc.py`, `tts_service_pb2.py`, `tts_service_pb2_grpc.py` и файлы зависимостей.

    1. В корне папки `output` создайте файл `test.py` и добавьте в него код для синтеза API v3 по шаблонам.

          {% cut "test.py" %}

          ```python
          import io
          import pydub
          import argparse

          import yandex.cloud.ai.tts.v3.tts_pb2 as tts_pb2
          import yandex.cloud.ai.tts.v3.tts_service_pb2_grpc as tts_service_pb2_grpc

          def synthesize(iam_token, bytes_array) -> pydub.AudioSegment:
              template = "<шаблонная_фраза_с_разметкой>"
              # Пример шаблона: 'Напоминаем, что завтра в {time}, ваш ребенок записан на процедуру {procedure}.'
              request = tts_pb2.UtteranceSynthesisRequest(
                  output_audio_spec=tts_pb2.AudioFormatOptions(
                      container_audio=tts_pb2.ContainerAudio(
                          container_audio_type=tts_pb2.ContainerAudio.WAV
                      )
                  ),
                  loudness_normalization_type=tts_pb2.UtteranceSynthesisRequest.LUFS,
                  text_template = tts_pb2.TextTemplate(
                      text_template = template,
                      variables = [
                          # Задайте список переменных шаблона.
                          # Количество элементов tts_pb2.TextVariable() в списке определяется количеством переменных в шаблоне.
                          tts_pb2.TextVariable(
                              variable_name = "<имя_переменной_в_template>",
                              # Пример: '{time}'
                              variable_value = "<текст_для_синтеза>"
                              # Пример: 'восемь часов тридцать минут'
                          )
                      ]
                  ),
                  hints = [
                      tts_pb2.Hints(
                          audio_template = tts_pb2.AudioTemplate(
                              audio = tts_pb2.AudioContent(
                                  # Загрузите исходное аудио для шаблона.
                                  content = bytes_array,
                                  audio_spec = tts_pb2.AudioFormatOptions(
                                      container_audio = tts_pb2.ContainerAudio(
                                          container_audio_type = tts_pb2.ContainerAudio.WAV
                                      )
                                  )
                              ),
                              text_template = tts_pb2.TextTemplate(
                                  text_template = template,
                                  variables = [
                                      # Задайте список переменных шаблона.
                                      # Количество элементов tts_pb2.TextVariable() в списке определяется количеством переменных в шаблоне.
                                      tts_pb2.TextVariable(
                                          variable_name = "<имя_переменной_в_template>",
                                          variable_value = "<текст_переменной_части_фразы_в_звуковом_файле_шаблона>"
                                      )
                                  ]
                              ),
                              variables = [
                                  # Задайте список аудиопараметров переменных шаблона.
                                  # Количество элементов tts_pb2.AudioVariable() в списке определяется количеством переменных в шаблоне.
                                  tts_pb2.AudioVariable(
                                      variable_name = "<имя_переменной_в_template>",
                                      # Длина переменной части фразы в аудио шаблона (в миллисекундах).
                                      variable_length_ms = <длина_переменной>,
                                      # Начало переменной части фразы в аудио шаблона (в миллисекундах).
                                      variable_start_ms = <время_начала_переменной>
                                  )
                              ]
                          )
                     ),
                     tts_pb2.Hints(
                         voice = "<идентификатор_вашего_голоса>"
                     )
                  ],
              )

              # Установите соединение с сервером.
              cred = grpc.ssl_channel_credentials()
              channel = grpc.secure_channel('{{ api-host-sk-tts }}:443', cred)
              stub = tts_service_pb2_grpc.SynthesizerStub(channel)

              # Отправьте данные для синтеза.
              it = stub.UtteranceSynthesis(request, metadata=(
                  ("authorization", f"Bearer {iam_token}"),
              ))

              # Обработайте ответы сервера и запишите результат в файл.
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
              parser.add_argument('--input', required=True, help='Template WAV file')
              parser.add_argument('--output', required=True, help='Output WAV file with synthesized speech')
              args = parser.parse_args()

              with open(args.input, 'rb') as file:
                  speech = file.read()
    
              audio = synthesize(args.token, speech)
              with open(args.output, 'wb') as fp:
                  audio.export(fp, format='wav')
          ```

          {% endcut %}

    1. Выполните файл `test.py`:

        ```bash
        export IAM_TOKEN=<IAM-токен_сервисного_аккаунта> && \
        python output/test.py \
          --token ${IAM_TOKEN} \
          --input sample.wav \
          --output speech.wav
        ```

        Где:

        * `IAM_TOKEN` — [IAM-токен сервисного аккаунта](../../../iam/concepts/authorization/iam-token.md).
        * `--input` — имя аудиофайла с шаблоном фразы.
        * `--output` — имя аудиофайла с синтезированной фразой.

{% endlist %}

В папке `cloudapi` будет создан файл `speech.wav` с синтезированной по шаблону фразой.

#### См. также {#see-also}

* [{#T}](tts-examples-v3.md)
* [{#T}](../brand-voice/index.md)
* [{#T}](../templates.md)
