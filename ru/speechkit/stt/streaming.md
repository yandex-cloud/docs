# Потоковый режим для распознавания коротких аудио

Потоковый режим позволяет вам одновременно отправлять аудио на распознавание и получать результаты распознавания в рамках одного соединения.

В отличие от других [способов распознавания](./index.md#stt-ways), вы сможете получать промежуточные результаты распознавания, пока фраза еще незакончена. После паузы сервис вернет финальные результаты и начнет распознавание новой фразы.

> Например, как только пользователь начинает говорить с [Яндекс.Станцией](https://station.yandex.ru/), она начинает передавать его речь на сервер для распознавания. Сервер обрабатывает данные и возвращает промежуточные и финальные результаты распознавания каждой фразы. Промежуточные результаты используются, чтобы показать пользователю ход распознавания, а после финальных результатов Яндекс.Станция выполняет действие, например включает фильм.

Чтобы использовать сервис, создайте приложение, которое будет осуществлять потоковое распознавания речи: отправлять аудиофрагменты и обрабатывать ответ с результатами распознавания.

{% note warning %}

Потоковый режим предназначен для распознавания аудио в режиме реального времени. Если вам надо отправить уже записанное аудио, воспользуйтесь [другими способами](./index.md#stt-ways).

{% endnote %}

## Использование сервиса {#service-use}

### Создание клиентского приложения {#create-client-app}

Для распознавания речи приложение сначала должно отправить [сообщение с настройками распознавания](#specification-msg), а потом отправлять [сообщения с аудиофрагментами](#audio-msg).

Параллельно с тем как отправляются аудиофрагменты, в ответ сервис будет возвращать [фрагменты распознанного текста](#response), которые необходимо обрабатывать, например выводить их в консоль.

Чтобы приложение смогло обращаться к сервису, необходимо сгенерировать код интерфейса клиента для используемого языка программирования. Сгенерируйте этот код из файла [stt_service.proto](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/ai/stt/v2/stt_service.proto) из репозитория [Yandex.Cloud API](https://github.com/yandex-cloud/cloudapi).

Ниже представлены [примеры](#examples) клиентских приложений. Помимо этого, в [документации gRPC](https://grpc.io/docs/tutorials/) вы можете найти подробные инструкции по генерации интерфейсов и реализации клиентских приложений для различных языков программирования.

### Авторизация в сервисе {#auth}

В каждом запросе приложение должно передавать [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), на который у вас есть роль `editor` или выше. Подробнее в разделе [Управление доступом](../security/index.md).

Также приложение должно аутентифицироваться при каждом запросе, например при помощи IAM-токена. [Подробнее об аутентификации в сервисе](../concepts/auth.md).

### Результат распознавания {#results}

В каждом [сообщении с результатами распознавания](#response) сервер возвращает один или несколько фрагментов речи, которые он успел распознать за этот промежуток (`chunks`). Для каждого фрагмента речи указывается список вариантов распознанного текста (`alternatives`).

В процессе распознавания речь делится на фразы, а конец фразы помечается флагом `endOfUtterance`. По умолчанию сервер возвращает ответ только после распознавания всей фразы. С помощью флага `partialResults` вы можете указать, чтобы сервер возвращал и промежуточные результаты распознавания. Получение промежуточных результатов позволит быстрее реагировать на распознаваемую речь, не дожидаясь окончания фразы.

### Ограничения сессии распознавания речи {#session-restrictions}

После получения сообщения с настройками распознавания сервис начнет сессию распознавания. Для каждой сессии действуют следующие ограничения:

* Нельзя отправлять аудиофрагменты слишком часто или редко. Время между отправкой сообщений в сервис должно примерно совпадать с длительностью отправляемых аудиофрагментов, но не должно превышать 5 секунд.

    Например, каждые 400 мс отправляйте на распознавание 400 мс аудио.
* Максимальная длительность переданного аудио за всю сессию — {{ stt-streaming-audioLength }}.
* Максимальный размер переданных аудиоданных — {{ stt-streaming-fileSize }}.

Если в течение 5 секунд в сервис не отправлялись сообщения или достигнут лимит по длительности или размеру данных, сессия обрывается. Чтобы продолжить распознавание речи, надо заново установить соединение и отправить новое сообщение с настройками распознавания.

## API сервиса {#streaming-api}

Сервис располагается по адресу: `stt.api.cloud.yandex.net:443`

### Сообщение с настройками распознавания {#specification-msg}

Параметр | Описание
----- | -----
config | **object**<br>Поле с настройками распознавания и идентификатором каталога.
config<br>.specification | **object**<br>Настройки распознавания.
config<br>.specification<br>.languageCode | **string**<br>Язык, для которого будет выполнено распознавание.<br/>Допустимые значения:<ul><li>`ru-ru` (case-insensitive, по умолчанию) — русский язык.</li><li>`en-us` (case-insensitive) — английский язык.</li><li>`tr-tr` (case-insensitive) — турецкий язык.</li></ul>
config<br>.specification<br>.model | **string**<br>Языковая модель, которую следует использовать при распознавании.<br/>Чем точнее выбрана модель, тем лучше результат распознавания. В одном запросе можно указать только одну модель.<br/>[Допустимые значения](models.md) зависят от выбранного языка. Значение параметра по умолчанию: `general`.
config<br>.specification<br>.profanityFilter | **boolean**<br>Фильтр ненормативной лексики.<br/>Допустимые значения:<ul><li>`true` — исключать ненормативную лексику из результатов распознавания.</li><li>`false` (по умолчанию) — не исключать ненормативную лексику.</li></ul>
config<br>.specification<br>.partialResults | **boolean**<br>Фильтр промежуточных результатов.<br/>Допустимые значения:<ul><li>`true` — возвращать промежуточные результаты (часть распознанного высказывания). Для промежуточных результатов `final` равно `false`.</li><li>`false` (по умолчанию) — возвращать только финальные результаты (распознанное высказывание целиком).
config<br>.specification<br>.singleUtterance | **boolean**<br>Флаг, отключающий распознавание после первой фразы.<br/>Допустимые значения:<ul><li>`true` — распознать только первую фразу, прекратить распознавание и ожидать разрыва соединения пользователем.</li><li>`false` (по умолчанию) — продолжать распознавание до окончания сессии.</li></ul>
config<br>.specification<br>.audioEncoding | **string**<br>[Формат](formats.md) передаваемого аудио.<br/>Допустимые значения:<ul><li>`LINEAR16_PCM` — [LPCM без WAV-заголовка](formats.md#lpcm).</li><li>`OGG_OPUS` (по умолчанию) — формат [OggOpus](formats.md#oggopus).</li></ul>
config<br>.specification<br>.sampleRateHertz | **integer** (int64)<br>Частота дискретизации передаваемого аудио.<br/>Этот параметр обязателен, если значение `format` равно `LINEAR16_PCM`. Допустимые значения:<ul><li>`48000` (по умолчанию) — частота дискретизации 48 кГц;</li><li>`16000` — частота дискретизации 16 кГц;</li><li>`8000` — частота дискретизации 8 кГц.</li></ul>
config.<br>specification.<br>rawResults | **boolean** <br>Флаг, указывающий, как писать числа. `true` — писать прописью, `false` (по умолчанию) — писать цифрами.
folderId | **string**<br><p>Идентификатор каталога, к которому у вас есть доступ. Требуется для авторизации с пользовательским аккаунтом (см. ресурс <a href="../../iam/api-ref/UserAccount/index#representation">UserAccount</a> ). Не используйте это поле, если вы делаете запрос от имени сервисного аккаунта.</p> <p>Максимальная длина строки в символах — 50.</p>

### Экспериментальные дополнительные настройки распознавания {#additional-settings}

Для моделей потокового распознавания с версии _Марк Аврелий_ и выше поддерживаются новые настройки распознавания. Они передаются через метаданные к gRPC-процедуре.

Параметр | Описание
----- | -----
`x-sensitivity-reduction-flag` | **boolean**<br>Флаг, уменьшающий чувствительность распознавания фонового шума.<br>Допустимые значения:<ul><li>`true` — чувствительность будет уменьшена.</li><li>`false` (по умолчанию) — чувствительность не будет уменьшена.
`x-normalize-partials` | **boolean**<br>Флаг, позволяющий получать промежуточные результаты распознавания (части распознанного высказывания) в нормализованном виде: числа передаются цифрами, включен фильтр ненормативной лексики и т. д.<br>Допустимые значения:<ul><li>`true` — возвращать нормализованный результат.</li><li>`false` (по умолчанию) — возвращать ненормализованный результат.

### Сообщение с аудиофрагментом {#audio-msg}

Параметр | Описание
----- | -----
`audio_content` | Фрагмент аудио в виде массива байт. Аудио должно быть в формате, указанном в [сообщении с настройками распознавания](#specification-msg).


### Сообщение с результатами распознавания {#response}

При успешном распознавании фрагмента речи придет сообщение, содержащее список результатов распознавания `chunks[]`. Каждый результат содержит поля:

* `alternatives[]` - список вариантов распознанного текста. Каждый вариант содержит поля:
    * `text` - распознанный текст.
    * `confidence` - это поле сейчас не поддерживается, не используйте его.
* `final` - флаг, указывающий что этот результат распознавания финальный и больше меняться не будет. Если значение `false`, то результат распознавания промежуточный и может измениться при распознавании следующих фрагментов речи.
* `endOfUtterance` — флаг, указывающий что этот результат содержит конец фразы. Если значение `true`, то со следующего полученного результата начнется новая фраза.

   {% note info %}

   Если в настройках вы указали `singleUtterance=true`, то будет распознана только одна фраза за всю сессию. После сообщения, в котором `endOfUtterance` имеет значение `true`, сервер не будет распознавать следующие фразы и будет ждать, когда вы разорвете соединение.

   {% endnote %}

### Коды ошибок, возвращаемые сервером {#error_codes}

Соответствия gRPC-статусов с HTTP-кодами описаны в [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto).

Список возможных gRPC-ошибок, возвращаемых сервисом:

Код | Статус | Описание
----- | ----- | -----
3 | `INVALID_ARGUMENT` | Клиент некорректно указал параметры запроса. Детальная информация представлена в поле `details`.
9 | `RESOURCE_EXHAUSTED` | Клиент превысил одну из квот.
16 | `UNAUTHENTICATED` | Для выполнения операции необходима авторизация. Проверьте IAM-токен и идентификатор каталога, которые вы передали.
13 | `INTERNAL` | Внутренняя ошибка сервера. Ошибка означает, что операция не может быть выполнена из-за технического состояния сервера. Например, из-за нехватки вычислительных ресурсов.

## Примеры {#examples}

Для того чтобы попробовать примеры в этом разделе:

1. Склонируйте репозиторий [Yandex.Cloud API](https://github.com/yandex-cloud/cloudapi):
    ```
    git clone https://github.com/yandex-cloud/cloudapi
    ```
1. [Узнайте идентификатор каталога](../../resource-manager/operations/folder/get-id.md), к которому у вашего аккаунта есть доступ.
1. Для аутентификации в примерах используется [IAM-токен](../../iam/concepts/authorization/iam-token) ([о других способах аутентификации](../concepts/auth.md)). Получите IAM-токен:
    * [Инструкция](../../iam/operations/iam-token/create.md) для аккаунта на Яндексе.
    * [Инструкция](../../iam/operations/iam-token/create-for-sa.md) для сервисного аккаунта.
1. Скачайте [пример](https://storage.yandexcloud.net/speechkit/speech.pcm) аудиофайла для распознавания. Аудиофайл имеет формат [LPCM](https://en.wikipedia.org/wiki/Pulse-code_modulation) с частотой дискретизации 8000.

После этого приступите к созданию клиентского приложения.

{% list tabs %}

- Python 3

  1. Установите пакет grpcio-tools с помощью менеджера пакетов [pip](https://pip.pypa.io/en/stable/):

      ```bash
      $ pip install grpcio-tools
      ```

  1. Перейдите в директорию с репозиторием [Yandex.Cloud API](https://github.com/yandex-cloud/cloudapi), создайте директорию `output` и сгенерируйте в ней код интерфейса клиента:

      ```bash
      $ cd cloudapi
      $ mkdir output
      $ python -m grpc_tools.protoc -I . -I third_party/googleapis --python_out=output --grpc_python_out=output google/api/http.proto google/api/annotations.proto yandex/cloud/api/operation.proto google/rpc/status.proto yandex/cloud/operation/operation.proto yandex/cloud/ai/stt/v2/stt_service.proto
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
      $ export FOLDER_ID=b1gvmob95yysaplct532
      $ export IAM_TOKEN=CggaATEVAgA...
      $ python test.py --token ${IAM_TOKEN} --folder_id ${FOLDER_ID} --path speech.pcm
      Start chunk:
      alternative: привет
      Is final: False

      Start chunk:
      alternative: привет мир
      Is final: True
      ```


- Node.js

  1. Перейдите в директорию с репозиторием [Yandex.Cloud API](https://github.com/yandex-cloud/cloudapi), создайте директорию `src` и сгенерируйте в ней файл зависимостей `package.json`:

      ```bash
      $ cd cloudapi
      $ mkdir src
      $ cd src
      $ npm init
      ```
  1. Установите необходимые пакеты с помощью npm:

      ```bash
      $ npm install grpc @grpc/proto-loader google-proto-files --save
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
      $ export FOLDER_ID=b1gvmob95yysaplct532
      $ export IAM_TOKEN=CggaATEVAgA...
      $  node index.js speech.pcm

      Start chunk:
      alternative:  привет мир
      Is final:  true
      ```

{% endlist %}