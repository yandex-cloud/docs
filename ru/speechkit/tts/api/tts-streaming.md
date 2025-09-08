# Потоковый синтез

{{ speechkit-full-name }} позволяет поочередно отправлять тексты для [потокового синтеза](../index.md#streaming) в рамках одной сессии с помощью [API v3](../../tts-v3/api-ref/grpc/).

В примере заданы следующие параметры синтеза:

* [формат](../../formats.md) синтезированного аудиофайла — LPCM с частотой дискретизации 22 050 Гц, контейнер [WAV](https://{{ lang }}.wikipedia.org/wiki/WAV) (значение по умолчанию);
* [нормализация громкости](../index.md#volume) — LUFS (значение по умолчанию).

Преобразование и запись результата выполняются с помощью пакетов `grpcio-tools` и `pathlib`.

Аутентификация происходит от имени сервисного аккаунта с помощью [API-ключа](../../../iam/concepts/authorization/api-key.md) или [IAM-токена](../../../iam/concepts/authorization/iam-token.md). Подробнее об аутентификации в API {{ speechkit-name }} см. [{#T}](../../concepts/auth.md).

Чтобы поочередно синтезировать несколько текстов:

1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт для работы с API {{ speechkit-name }}.
1. [Назначьте](../../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роль `{{ roles-speechkit-tts }}` или выше на каталог, в котором он был создан.
1. Склонируйте репозиторий [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi):

    ```bash
    git clone https://github.com/yandex-cloud/cloudapi
    ```

1. Установите пакеты `grpcio-tools` и `pathlib` с помощью менеджера пакетов [pip](https://pip.pypa.io/en/stable/):

    ```bash
    pip install grpcio-tools && \
    pip install pathlib
    ```

    Пакет `grpcio-tools` нужен для генерации кода интерфейса клиента API v3 синтеза, пакет `pathlib` — для обработки полученных аудиофайлов.

1. В папке со склонированным репозиторием создайте папку `output` и сгенерируйте в ней код интерфейса клиента:

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
      yandex/cloud/ai/tts/v3/tts_service.proto \
      yandex/cloud/ai/tts/v3/tts.proto
    ```

    В результате в папке `output` будут созданы файлы с интерфейсом клиента: `tts_pb2.py`, `tts_pb2_grpc.py`, `tts_service_pb2.py`, `tts_service_pb2_grpc.py` и файлы зависимостей.

1. Создайте файл в корне папки `output`, например `test.py`, и добавьте в него следующий код:

    ```python
    import pathlib
    import grpc
    import yandex.cloud.ai.tts.v3.tts_pb2 as tts_pb2
    import yandex.cloud.ai.tts.v3.tts_service_pb2_grpc as tts_service_pb2_grpc
    
    # Параметры для аутентификации с API-ключом
    YANDEX_API_KEY = "<API-ключ>"
    # Параметры для аутентификации с IAM-токеном
    # YANDEX_IAM_TOKEN = "<IAM-токен>"
    
    def stream_synthesis():
        cred = grpc.ssl_channel_credentials()
    
        auth_meta = (
            ('authorization',
            f'Api-key {YANDEX_API_KEY}'),
            # или
            # ('authorization',
            # f'Bearer {YANDEX_IAM_TOKEN}'),
        )
        with grpc.secure_channel('tts.api.cloud.yandex.net:443', cred) as channel:
            stub = tts_service_pb2_grpc.SynthesizerStub(channel)
    
            # Настройки синтеза
            synthesis_options = tts_pb2.SynthesisOptions(
                voice="masha",
                role="good",
                output_audio_spec=tts_pb2.AudioFormatOptions(
                    # Настройки выходного аудио. Задайте через объекты RawAudio или ContainerAudio
                    
                    # raw_audio=tts_pb2.RawAudio(
                    #     audio_encoding=tts_pb2.RawAudio.LINEAR16_PCM,
                    #     sample_rate_hertz=16000
                    # )
                    container_audio=tts_pb2.ContainerAudio(
                        container_audio_type=tts_pb2.ContainerAudio.ContainerAudioType.WAV
                    )
                )
            )
    
            # Генератор запросов
            def request_generator():
                # Первым сообщение передаем настройки
                yield tts_pb2.StreamSynthesisRequest(options=synthesis_options)
    
                # Последовательная отправка текстов для синтеза
                # Каждая отправленная фраза обязательно должна заканчиваться пробелом, 
                # чтобы сервис не склеивал их при синтезе в одно слово.
                # Короткий текст
                yield tts_pb2.StreamSynthesisRequest(synthesis_input=tts_pb2.SynthesisInput(text="Привет! "))
                # Очень длинный текст, который будет синтезироваться по частям
                yield tts_pb2.StreamSynthesisRequest(synthesis_input=tts_pb2.SynthesisInput(
                    text=(
                        "Меня зовут Маша. Я представляю компанию Классный сервис. "
                        "Могу помочь с подбором заказа и оформлением доставки. "
                        "Также подберу подходящего специалиста. Могу помочь с проблемой чистого листа. Могу рассказать анекдот,  стихотворение. Также знаю прогноз погоды на завтра."
                    )
                ))
                # Короткий текст
                yield tts_pb2.StreamSynthesisRequest(synthesis_input=tts_pb2.SynthesisInput(text="Какой у вас вопрос?"))
    
            # В готовых приложениях вы будете проигрывать полученные аудио сразу.
            # Для демонстрации соберем все аудио в единый файл.
            audio_chunks = []
            for response in stub.StreamSynthesis(request_generator(), metadata=auth_meta):
                if response.audio_chunk.data:
                    print(f"Получено аудио: {len(response.audio_chunk.data)} б")
                    audio_chunks.append(response.audio_chunk.data)
                if response.text_chunk.text:
                    print("Озвучиваемый текст:", response.text_chunk.text)
                print(f"Начало: {response.start_ms} мс, длина: {response.length_ms} мс")
    
            synthesized_audio = b"".join(audio_chunks)
            pathlib.Path("result.wav").write_bytes(synthesized_audio)
            
    
    if __name__ == '__main__':
        stream_synthesis()
    ```

    Где:

    * `<API-ключ>` — [API-ключ](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) с областью действия `yc.ai.speechkitTts.execute`.
    
      Если для аутентификации вы используйте [IAM-токен](../../../iam/operations/iam-token/create-for-sa.md), измените код Python-скрипта.

1. Выполните созданный Python-скрипт:

    ```bash
    python test.py
    ```

    В результате в папке `cloudapi` будет создан файл `result.wav` с синтезированной речью.