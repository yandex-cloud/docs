# Потоковое распознавание речи с автоматическим определением языка

Пример показывает, как с помощью [API v3](../../stt-v3/api-ref/grpc/) {{ speechkit-short-name }} в режиме реального времени распознать речь в формате LPCM с автоматическим определением языка (языков).

В примере заданы следующие параметры:

* [язык распознавания](../models#languages) — `auto` (автоматическое определение языка);
* формат аудиопотока — [LPCM](../../formats.md#LPCM) с частотой дискретизации 8000 Гц;
* [количество аудиоканалов](../../stt-v3/api-ref/grpc/stt_service#RawAudio) — 1 (значение по умолчанию);
* остальные параметры оставлены по умолчанию.

## Автоматическое определение языка {#language-labels}

{% include [stt-language-labels](../../../_includes/speechkit/stt-language-labels.md) %}

## Подготовьте необходимые данные {#preparations}

1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) ему роль `{{ roles-speechkit-stt }}`.
1. Для сервисного аккаунта [получите](../../../iam/operations/iam-token/create-for-sa#via-cli) и сохраните IAM-токен. 
1. Скачайте [пример](https://{{ s3-storage-host }}/speechkit/speech.pcm) аудиофайла для распознавания или [сгенерируйте](../../tts/api/tts-examples-v3.md) свой.

## Создайте приложение для потокового распознавания речи {#recognition}

Чтобы реализовать пример из этого раздела:

1. Склонируйте репозиторий [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi):

    ```bash
    git clone https://github.com/yandex-cloud/cloudapi
    ```

1. Создайте клиентское приложение:

    {% list tabs %}

    - Python 3

        1. Установите пакет `grpcio-tools` с помощью менеджера пакетов [pip](https://pip.pypa.io/en/stable/):

            ```bash
            pip install grpcio-tools
            ```

        1. Перейдите в папку со склонированным репозиторием {{ yandex-cloud }} API, создайте папку `output` и сгенерируйте в ней код интерфейса клиента:

            ```bash
            cd <путь_к_папке_cloudapi>
            mkdir output
            python -m grpc_tools.protoc -I . -I third_party/googleapis \
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
                        # Задайте автоматическое распознавание языков.
                        language_restriction=stt_pb2.LanguageRestrictionOptions(
                            restriction_type=stt_pb2.LanguageRestrictionOptions.WHITELIST,
                            language_code=['auto']
                        ),
                        # Выберите модели распознавание — потоковое распознавание.
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

            def run(iam_token, audio_file_name):
                # Установите соединение с сервером.
                cred = grpc.ssl_channel_credentials()
                channel = grpc.secure_channel('{{ api-host-sk-stt }}:443', cred)
                stub = stt_service_pb2_grpc.RecognizerStub(channel)

                # Отправьте данные для распознавания.
                it = stub.RecognizeStreaming(gen(audio_file_name), metadata=(
                    ('authorization', f'Bearer {iam_token}'),
                ))

                # Обработайте ответы сервера и выведите результат в консоль.
                try:
                    for r in it:
                        event_type, alternatives = r.WhichOneof('Event'), None
                        if event_type == 'partial' and len(r.partial.alternatives) > 0:
                            alternatives = [a.text for a in r.partial.alternatives]
                        if event_type == 'final':
                            alternatives = [a.text for a in r.final.alternatives]
                            # Получение языковых меток:
                            langs = [a.languages for a in r.final.alternatives]
                        if event_type == 'final_refinement':
                            alternatives = [a.text for a in r.final_refinement.normalized_text.alternatives]
                        print(f'type={event_type}, alternatives={alternatives}')
                        # Вывод в консоль языковых меток для финальных версий:
                        if event_type == 'final':
                            print(f'Language labels:')
                            for lang in langs:
                                for line in lang:
                                    words=f'{line}'.splitlines()
                                    for word in words:
                                        print(f'  {word}', end="")
                                    print()
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

            Где:

            * `audio_encoding` — [формат](../../formats.md) аудиопотока.
            * `sample_rate_hertz` — частота дискретизации аудиопотока.
            * `audio_channel_count` — количество аудиоканалов.
            * `language_code` — [язык](../index.md#langs), для которого будет выполнено распознавание.

    {% endlist %}

1. Задайте [IAM-токен](../../../iam/concepts/authorization/iam-token.md) сервисного аккаунта:

    ```bash
    export IAM_TOKEN=<IAM-токен_сервисного_аккаунта>
    ```

1. Выполните созданный файл:

    ```bash
    python3 output/test.py --token ${IAM_TOKEN} --path <путь_к_файлу_speech.pcm>
    ```

    Где `--path` — путь к аудиофайлу, который необходимо распознать.

    Результат:

    ```bash
    type=status_code, alternatives=None
    type=partial, alternatives=None
    type=partial, alternatives=['привет']
    type=final, alternatives=['привет мир']
    Language guess:
        language_code: "ru-RU"  probability: 1
    type=final_refinement, alternatives=['привет мир']
    type=eou_update, alternatives=None
    type=partial, alternatives=None
    type=status_code, alternatives=None
    ```

#### См. также {#see-also}

* [Справочник API v3](../../stt-v3/api-ref/grpc/)
* [{#T}](../../concepts/auth.md)