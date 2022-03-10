# Примеры использования API потокового распознавания

Чтобы попробовать примеры в этом разделе:

1. Склонируйте репозиторий [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi):
    ```
    git clone https://github.com/yandex-cloud/cloudapi
    ```
1. [Узнайте идентификатор каталога](../../../resource-manager/operations/folder/get-id.md), к которому у вашего аккаунта есть доступ.
1. Для аутентификации в примерах используется [IAM-токен](../../../iam/concepts/authorization/iam-token) ([о других способах аутентификации](../../concepts/auth.md)). Получите IAM-токен:
   * [Инструкция](../../../iam/operations/iam-token/create.md) для аккаунта на Яндексе.
   * [Инструкция](../../../iam/operations/iam-token/create-for-sa.md) для сервисного аккаунта.
1. Скачайте [пример](https://storage.yandexcloud.net/speechkit/speech.pcm) аудиофайла для распознавания. Аудиофайл имеет формат [LPCM](https://en.wikipedia.org/wiki/Pulse-code_modulation) с частотой дискретизации 8000.

После этого приступите к созданию клиентского приложения.

{% list tabs %}

- Python 3

   1. Установите пакет `grpcio-tools` с помощью менеджера пакетов [pip](https://pip.pypa.io/en/stable/):

       ```bash
       pip install grpcio-tools
       ```

   1. Перейдите в директорию с репозиторием [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi), создайте директорию `output` и сгенерируйте в ней код интерфейса клиента:

       ```bash
       cd cloudapi
       mkdir output
       python -m grpc_tools.protoc -I . -I third_party/googleapis --python_out=output --grpc_python_out=output google/api/http.proto google/api/annotations.proto yandex/cloud/api/operation.proto google/rpc/status.proto yandex/cloud/operation/operation.proto yandex/cloud/ai/stt/v2/stt_service.proto
       ```

      В результате в директории `output` будут созданы файлы с интерфейсом клиента: `stt_service_pb2.py`, `stt_service_pb2_grpc.py` и файлы зависимостей.

   1. Создайте файл в корне директории `output`, например `test.py`, и добавьте в него следующий код:

       ```python
       #coding=utf8
       import argparse
 
       import grpc
 
       import yandex.cloud.ai.stt.v2.stt_service_pb2 as stt_service_pb2
       import yandex.cloud.ai.stt.v2.stt_service_pb2_grpc as stt_service_pb2_grpc
 
 
       CHUNK_SIZE = 4000
 
       def gen(folder_id, audio_file_name):
           # Задать настройки распознавания.
           specification = stt_service_pb2.RecognitionSpec(
               language_code='ru-RU',
               profanity_filter=True,
               model='general',
               partial_results=True,
               audio_encoding='LINEAR16_PCM',
               sample_rate_hertz=8000
           )
           streaming_config = stt_service_pb2.RecognitionConfig(specification=specification, folder_id=folder_id)
 
           # Отправить сообщение с настройками распознавания.
           yield stt_service_pb2.StreamingRecognitionRequest(config=streaming_config)
 
           # Прочитать аудиофайл и отправить его содержимое порциями.
           with open(audio_file_name, 'rb') as f:
               data = f.read(CHUNK_SIZE)
               while data != b'':
                   yield stt_service_pb2.StreamingRecognitionRequest(audio_content=data)
                   data = f.read(CHUNK_SIZE)
 
       def run(folder_id, iam_token, audio_file_name):
           # Установить соединение с сервером.
           cred = grpc.ssl_channel_credentials()
           channel = grpc.secure_channel('stt.api.cloud.yandex.net:443', cred)
           stub = stt_service_pb2_grpc.SttServiceStub(channel)
 
           # Отправить данные для распознавания.
           it = stub.StreamingRecognize(gen(folder_id, audio_file_name), metadata=(('authorization', 'Bearer %s' % iam_token),))
 
           # Обработать ответы сервера и вывести результат в консоль.
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
   1. Выполните созданный файл, передав в аргументах IAM-токен, идентификатор каталога и путь к аудиофайлу, который необходимо распознать:

       ```bash
       export FOLDER_ID=b1gvmob95yysaplct532
       export IAM_TOKEN=CggaATEVAgA...
       python test.py --token ${IAM_TOKEN} --folder_id ${FOLDER_ID} --path speech.pcm
      
       Start chunk:
       alternative: привет
       Is final: False
 
       Start chunk:
       alternative: привет мир
       Is final: True
       ```
   
- Node.js

   1. Перейдите в директорию с репозиторием [{{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi), создайте директорию `src` и сгенерируйте в ней файл зависимостей `package.json`:

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
   1. Скачайте [публичный сертификат](https://github.com/grpc/grpc/blob/master/etc/roots.pem) gRPC из официального репозитория и сохраните его в корне директории `src`.
   1. Создайте файл в корне директории `src`, например `index.js`, и добавьте в него следующий код:

       ```js
       const fs = require('fs');
       const grpc = require('grpc');
       const protoLoader = require('@grpc/proto-loader');
       const CHUNK_SIZE = 4000;
 
       // Получаем ID каталога и IAM-токен из переменных окружения.
       const folderId = process.env.FOLDER_ID;
       const iamToken = process.env.IAM_TOKEN;
 
       // Читаем файл, указанный в аргументах.
       const audio = fs.readFileSync(process.argv[2]);
 
       // Задать настройки распознавания.
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
 
       // Частота отправки аудио в миллисекундах.
       // Для формата LPCM частоту можно рассчитать по формуле: CHUNK_SIZE * 1000 / ( 2 * sampleRateHertz);
       const FREQUENCY = 250;
 
       const serviceMetadata = new grpc.Metadata();
       serviceMetadata.add('authorization', `Bearer ${iamToken}`);
 
       const packageDefinition = protoLoader.loadSync('../yandex/cloud/ai/stt/v2/stt_service.proto', {
           includeDirs: ['node_modules/google-proto-files', '..']
       });
       const packageObject = grpc.loadPackageDefinition(packageDefinition);
 
       // Установить соединение с сервером.
       const serviceConstructor = packageObject.yandex.cloud.ai.stt.v2.SttService;
       const grpcCredentials = grpc.credentials.createSsl(fs.readFileSync('./roots.pem'));
       const service = new serviceConstructor('stt.api.cloud.yandex.net:443', grpcCredentials);
       const call = service['StreamingRecognize'](serviceMetadata);
 
       // Отправить сообщение с настройками распознавания.
       call.write(request);
 
       // Прочитать аудиофайл и отправить его содержимое порциями.
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
 
       // Обработать ответы сервера и вывести результат в консоль.
       call.on('data', (response) => {
           console.log('Start chunk: ');
           response.chunks[0].alternatives.forEach((alternative) => {
               console.log('alternative: ', alternative.text)
           });
           console.log('Is final: ', Boolean(response.chunks[0].final));
           console.log('');
       });
 
       call.on('error', (response) => {
           // Обрабатываем ошибки
           console.log(response);
       });
       ```
   1. Задайте переменные `FOLDER_ID` и `IAM_TOKEN`, которые используются в скрипте, и выполните созданный файл. В аргументах укажите путь к аудиофайлу:

       ```bash
       export FOLDER_ID=b1gvmob95yysaplct532
       export IAM_TOKEN=CggaATEVAgA...
       node index.js speech.pcm
 
       Start chunk:
       alternative:  привет мир
       Is final:  true
       ```

{% endlist %}