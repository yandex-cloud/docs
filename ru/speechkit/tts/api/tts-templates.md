# Синтезировать речь по шаблону с помощью API v3

Синтез по шаблонам доступен только для голосов [{{ brand-voice-name }}](../brand-voice/index.md). Чтобы использовать синтез по шаблонам, [заполните форму](#contact-form).

Чтобы синтезировать фразу по шаблону:

1. [Подготовьте шаблон аудиозаписи](#prepare-template).
1. [Отправьте данные в API v3](#send-to-api).

## Перед началом работы {#before-you-begin}

1. Клонируйте [репозиторий {{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi):

    ```bash
    git clone https://github.com/yandex-cloud/cloudapi
    ```

1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт для работы с API {{ speechkit-short-name }}.
1. [Назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роль `{{ roles-speechkit-tts }}` или выше на каталог, в котором он был создан.
1. [Получите](../../../iam/operations/iam-token/create-for-sa.md) IAM-токен для сервисного аккаунта.

## Подготовьте шаблон аудиозаписи {#prepare-template}

{% note warning %}

Шаблон состоит из аудиозаписи шаблонной фразы и размеченного текста фразы. В API сервиса отправляйте для синтеза только шаблоны с переменными частями. Неизменяемые фразы отправлять не нужно.

{% endnote %}

Примеры неизменяемых фраз:
>Здравствуйте, с вами говорят из клиники "МедСити".
>
>Это компания по вывозу строительного мусора "Вывозов".
>

Чтобы подготовить шаблон:

* Запишите аудио шаблонной фразы.
* Разметьте текст шаблонной фразы согласно [требованиям](../templates.md#requirements) и оберните переменные части в скобки `{}`.

  Примеры разметки:
  >Вы записаны к врачу {Ивановой} на {двадцатое марта} в {двенадцать часов}.
  >
  >Напоминаем, что {завтра} в {четырнадцать часов} к вам приедет машина с контейнером для вывоза мусора.
  >

* Определите для каждой переменной части значение времени ее начала и ее длительность в аудиозаписи (в миллисекундах).

{% note info %}

Длительность фразы для синтеза не должна превышать {{ tts-v3-time }} (ограничение API) вместе с переменной частью. Оптимальное восприятие фразы достигается при длительности не более 16 секунд — как в разговорной речи.

Длина шаблона не должна превышать 250 символов нормализованного текста.

{% endnote %}

## Отправьте данные в API {#send-to-api}

Создайте клиентское приложение для отправки данных:

{% list tabs %}

- Python 3

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

    1. В корне папки `output` создайте файл (например, `test.py`) и добавьте в него код:

          ```python
          import io
          import grpc
          import pydub
          import argparse

          import yandex.cloud.ai.tts.v3.tts_pb2 as tts_pb2
          import yandex.cloud.ai.tts.v3.tts_service_pb2_grpc as tts_service_pb2_grpc

          def synthesize(iam_token, bytes_array) -> pydub.AudioSegment:
              template = "<шаблонная_фраза_с_разметкой>"
              # Пример: 'Напоминаю, что завтра в {time}, ваш ребенок записан на процедуру {procedure}.'
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
                                      # Количество элементов tts_pb2.TextVariable() списка определяется количеством переменных в шаблоне.
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
                                  # Исходное аудио для шаблона
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
                                      # Количество переменных tts_pb2.TextVariable() списка определяется количеством переменных в шаблоне.
                                      tts_pb2.TextVariable(
                                          variable_name = "<имя_переменной_в_template>",
                                          variable_value = "<текст_переменной_части_фразы_в_звуковом_файле_шаблона>"
                                      )
                                  ]
                              ),
                              variables = [
                                  # Количество переменных tts_pb2.AudioVariable() в списке определяется шаблоном.
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
                     # Не передавайте этот параметр, если вы используете {{ brand-voice-cc-name }}
                     tts_pb2.Hints(
                        voice = "<идентификатор_вашего_голоса>"
                     )

                  ],
                  model = "zsl"
              )
    
              # Установить соединение с сервером.
              cred = grpc.ssl_channel_credentials()
              channel = grpc.secure_channel('{{ api-host-sk-tts }}:443', cred)
              stub = tts_service_pb2_grpc.SynthesizerStub(channel)

              # Отправить данные для синтеза.
              it = stub.UtteranceSynthesis(request, metadata=(
                  ("authorization", f"Bearer {iam_token}")
              ))

              # Обработать ответы сервера и записать результат в файл.
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
              parser.add_argument('--output', required=True, help='Output WAV file with synthesis voice')
              args = parser.parse_args()

              with open(args.input, 'rb') as file:
                  speech = file.read()
    
              audio = synthesize(args.token, speech)
              with open(args.output, 'wb') as fp:
                  audio.export(fp, format='wav')
          ```

    1. Выполните созданный файл (в этом примере — `test.py`):

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
