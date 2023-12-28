# Пример использования API v2 потокового распознавания

Пример показывает, как с помощью {{ speechkit-short-name }} [API v2](streaming-api.md) в режиме реального времени распознать речь в формате LPCM.

В примере заданы следующие параметры:

* [язык](../index.md#langs) — русский;
* формат аудиопотока — [LPCM](../../formats.md#LPCM) с частотой дискретизации 8000 Гц;
* [фильтр ненормативной лексики](streaming-api.md#specification-msg) — True;
* [фильтр промежуточных результатов](streaming-api.md#specification-msg) — True;
* остальные параметры оставлены по умолчанию.

Для работы с API нужны пакеты `grpcio-tools` для Python и `grpc` для Node.js.

Аутентификация происходит от имени аккаунта на Яндексе или федеративного аккаунта с помощью [IAM-токена](../../../iam/concepts/authorization/iam-token.md). Если вы используете сервисный аккаунт, передавать в запросе идентификатор каталога не нужно. Подробнее об [аутентификации в API {{ speechkit-name }}](../../concepts/auth.md).

Чтобы реализовать примеры в этом разделе:

1. Склонируйте репозиторий [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi):

    ```bash
    git clone https://github.com/yandex-cloud/cloudapi
    ```

1. Скачайте [пример](https://{{ s3-storage-host }}/speechkit/speech.pcm) аудиофайла для распознавания.

1. Создайте клиентское приложение:

   {% list tabs group=programming_language %}

   - Python 3 {#python}

     1. Установите пакет `grpcio-tools` с помощью менеджера пакетов [pip](https://pip.pypa.io/en/stable/):

        ```bash
        pip install grpcio-tools
        ```

     1. Перейдите в папку с репозиторием [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi/), создайте папку `output` и сгенерируйте в ней код интерфейса клиента:

        ```bash
        cd cloudapi
        mkdir output
        python -m grpc_tools.protoc -I . -I third_party/googleapis \
          --python_out=output \
          --grpc_python_out=output \
            google/api/http.proto \
            google/api/annotations.proto \
            yandex/cloud/api/operation.proto \
            google/rpc/status.proto \
            yandex/cloud/operation/operation.proto \
            yandex/cloud/ai/stt/v2/stt_service.proto
        ```

        В результате в папке `output` будут созданы файлы с интерфейсом клиента: `stt_service_pb2.py`, `stt_service_pb2_grpc.py` и файлы зависимостей.

     1. Создайте файл в корне папки `output`, например `test.py`, и добавьте в него следующий код:

        ```python
        #coding=utf8
        import argparse

        import grpc

        import yandex.cloud.ai.stt.v2.stt_service_pb2 as stt_service_pb2
        import yandex.cloud.ai.stt.v2.stt_service_pb2_grpc as stt_service_pb2_grpc

        CHUNK_SIZE = 4000

        def gen(folder_id, audio_file_name):
            # Задайте настройки распознавания.
            specification = stt_service_pb2.RecognitionSpec(
                language_code='ru-RU',
                profanity_filter=True,
                model='general',
                partial_results=True,
                audio_encoding='LINEAR16_PCM',
                sample_rate_hertz=8000
            )
            streaming_config = stt_service_pb2.RecognitionConfig(specification=specification, folder_id=folder_id)

            # Отправьте сообщение с настройками распознавания.
            yield stt_service_pb2.StreamingRecognitionRequest(config=streaming_config)

            # Прочитайте аудиофайл и отправьте его содержимое порциями.
            with open(audio_file_name, 'rb') as f:
                data = f.read(CHUNK_SIZE)
                while data != b'':
                    yield stt_service_pb2.StreamingRecognitionRequest(audio_content=data)
                    data = f.read(CHUNK_SIZE)

        def run(folder_id, iam_token, audio_file_name):
            # Установите соединение с сервером.
            cred = grpc.ssl_channel_credentials()
            channel = grpc.secure_channel('stt.{{ api-host }}:443', cred)
            stub = stt_service_pb2_grpc.SttServiceStub(channel)

            # Отправьте данные для распознавания.
            it = stub.StreamingRecognize(gen(folder_id, audio_file_name), metadata=(
                ('authorization', 'Bearer %s' % iam_token),
                ('Transfer-encoding', 'chunked'),
            ))

            # Обработайте ответы сервера и выведите результат в консоль.
            try:
                for r in it:
                    try:
                        print('Start chunk: ')
                        for alternative in r.chunks[0].alternatives:
                            print('alternative: ', alternative.text)
                        print('Is final: ', r.chunks[0].final)
                        print('')
                    except LookupError:
                        print('Not available chunks')
            except grpc._channel._Rendezvous as err:
                print('Error code %s, message: %s' % (err._state.code, err._state.details))

        if __name__ == '__main__':
            parser = argparse.ArgumentParser()
            parser.add_argument('--token', required=True, help='IAM token')
            parser.add_argument('--folder_id', required=True, help='folder ID')
            parser.add_argument('--path', required=True, help='audio file path')
            args = parser.parse_args()

            run(args.folder_id, args.token, args.path)
        ```

        Где:

        * `language_code` — [язык](../index.md#langs), для которого будет выполнено распознавание.
        * `profanity_filter` — [фильтр ненормативной лексики](streaming-api.md#specification-msg).
        * `model` — [языковая модель](../models.md).
        * `partial_results` — [фильтр промежуточных результатов распознавания](streaming-api.md#specification-msg).
        * `audio_encoding` — [формат](../../formats.md) аудиопотока.
        * `sample_rate_hertz` — частота дискретизации аудиопотока.

     1. Задайте [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md):

        ```bash
        export FOLDER_ID=<идентификатор_каталога>
        ```

     1. Задайте [IAM-токен](../../../iam/concepts/authorization/iam-token.md):

        ```bash
        export IAM_TOKEN=<IAM-токен>
        ```

     1. Выполните созданный файл:

        ```bash
        python test.py --token ${IAM_TOKEN} --folder_id ${FOLDER_ID} --path speech.pcm
        ```

        Где `--path` — путь к аудиофайлу, который необходимо распознать.

        Результат:

        ```bash
        Start chunk:
        alternative: привет
        Is final: False

        Start chunk:
        alternative: привет мир
        Is final: True
        ```

   - Node.js {#node}

     1. Перейдите в папку с репозиторием [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi), создайте папку `src` и сгенерируйте в ней файл зависимостей `package.json`:

        ```bash
        cd cloudapi
        mkdir src
        cd src
        npm init
        ```

     1. Установите необходимые пакеты с помощью npm:

        ```bash
        npm install grpc @grpc/proto-loader google-proto-files --save
        ```

     1. Скачайте [публичный сертификат](https://github.com/grpc/grpc/blob/master/etc/roots.pem) gRPC из официального репозитория и сохраните его в корне папки `src`.
     1. Создайте файл в корне папки `src`, например `index.js`, и добавьте в него следующий код:

        ```js
        const fs = require('fs');
        const grpc = require('grpc');
        const protoLoader = require('@grpc/proto-loader');
        const CHUNK_SIZE = 4000;

        // Получите ID каталога и IAM-токен из переменных окружения.
        const folderId = process.env.FOLDER_ID;
        const iamToken = process.env.IAM_TOKEN;

        // Прочитайте файл, указанный в аргументах.
        const audio = fs.readFileSync(process.argv[2]);

        // Задайте настройки распознавания.
        const request = {
            config: {
                specification: {
                    languageCode: 'ru-RU',
                    profanityFilter: true,
                    model: 'general',
                    partialResults: true,
                    audioEncoding: 'LINEAR16_PCM',
                    sampleRateHertz: '8000'
                },
                folderId: folderId
            }
        };

        // Задайте частоту отправки аудио в миллисекундах.
        // Для формата LPCM частоту можно рассчитать по формуле: CHUNK_SIZE * 1000 / ( 2 * sampleRateHertz);
        const FREQUENCY = 250;

        const serviceMetadata = new grpc.Metadata();
        serviceMetadata.add('authorization', `Bearer ${iamToken}`);
        serviceMetadata.add('Transfer-encoding', `chunked`);

        const packageDefinition = protoLoader.loadSync('../yandex/cloud/ai/stt/v2/stt_service.proto', {
            includeDirs: ['node_modules/google-proto-files', '..']
        });
        const packageObject = grpc.loadPackageDefinition(packageDefinition);

        // Установите соединение с сервером.
        const serviceConstructor = packageObject.yandex.cloud.ai.stt.v2.SttService;
        const grpcCredentials = grpc.credentials.createSsl(fs.readFileSync('./roots.pem'));
        const service = new serviceConstructor('stt.{{ api-host }}:443', grpcCredentials);
        const call = service['StreamingRecognize'](serviceMetadata);

        // Отправьте сообщение с настройками распознавания.
        call.write(request);

        // Прочитайте аудиофайл и отправьте его содержимое порциями.
        let i = 1;
        const interval = setInterval(() => {
            if (i * CHUNK_SIZE <= audio.length) {
                const chunk = new Uint16Array(audio.slice((i - 1) * CHUNK_SIZE, i * CHUNK_SIZE));
                const chunkBuffer = Buffer.from(chunk);
                call.write({audioContent: chunkBuffer});
                i++;
            } else {
                call.end();
                clearInterval(interval);
            }
        }, FREQUENCY);

        // Обработайте ответы сервера и выведите результат в консоль.
        call.on('data', (response) => {
            console.log('Start chunk: ');
            response.chunks[0].alternatives.forEach((alternative) => {
                console.log('alternative: ', alternative.text)
            });
            console.log('Is final: ', Boolean(response.chunks[0].final));
            console.log('');
        });

        call.on('error', (response) => {
            // Выведите ошибки в консоль.
            console.log(response);
        });
        ```

        Где:

        * `languageCode` — [язык](../index.md#langs), для которого будет выполнено распознавание.
        * `pprofanityFilter` — [фильтр ненормативной лексики](streaming-api.md#specification-msg).
        * `model` — [языковая модель](../models.md).
        * `partialResults` — [фильтр промежуточных результатов распознавания](streaming-api.md#specification-msg).
        * `audioEncoding` — [формат](../../formats.md) аудиопотока.
        * `sampleRateHertz` — частота дискретизации аудиопотока.

     1. Задайте [идентификатор каталога](../../../resource-manager/operations/folder/get-id.md):

        ```bash
        export FOLDER_ID=<идентификатор_каталога>
        ```

     1. Задайте [IAM-токен](../../../iam/concepts/authorization/iam-token.md):

        ```bash
        export IAM_TOKEN=<IAM-токен>
        ```

     1. Выполните созданный файл:

        ```bash
        node index.js speech.pcm
        ```

        Где `speech.pcm` — имя аудиофайла для распознавания.

        Результат:

        ```bash
        Start chunk:
        alternative: привет мир
        Is final: true
        ```

   {% endlist %}

#### См. также {#see-also}

* [{#T}](streaming-api.md)
* [{#T}](../../concepts/auth.md)