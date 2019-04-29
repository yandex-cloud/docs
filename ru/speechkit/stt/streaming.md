# Потоковое распознавание речи

Потоковый режим позволит вам одновременно отправлять аудио на распознавание и получать результаты распознавания, пока речь продолжается.

В отличие от других [способов распознавания](index.md#stt-ways), вы сможете получать промежуточные результаты распознавания, пока человек продолжает говорить фразу. После паузы сервис вернет финальные результаты и начнет распознавание новой фразы.

> Например, как только пользователь начинает говорить с [Яндекс.Станцией](https://station.yandex.ru/), она начинает передавать его речь на сервер для распознавания. Сервер обрабатывает данные и возвращает промежуточные и финальные результаты распознавания каждой фразы. Промежуточные результаты используются, чтобы показать пользователю ход распознавания, а после финальных результатов Яндекс.Станция выполняет действие, например включает фильм.

Чтобы использовать сервис, создайте приложение, которое будет осуществлять потоковое распознавания речи: отправлять аудиофрагменты и обрабатывать ответ с результатами распознавания.

## Использование сервиса

### Перед началом

1. Получите идентификатор каталога, к которому у вас есть доступ, например из URL страницы каталога в консоли управления:
    ```
    https://console.cloud.yandex.ru/folders/b5gfc3ntettogerelqed7p
    ```
    `b5gfc3ntettogerelqed7p` — это идентификатор каталога.
1. Склонируйте репозиторий [Yandex.Cloud API](https://github.com/yandex-cloud/cloudapi):
    ```
    git clone https://github.com/yandex-cloud/cloudapi
    ```
    Файл [stt_service.proto](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/ai/stt/v2/stt_service.proto) из этого репозитория будет использоваться для создания кода интерфейса клиента.

### Создание клиентского приложения

Для распознавания речи приложение сначала должно отправить [сообщение с настройками распознавания](#specification-msg), а потом отправлять [сообщения с аудиофрагментами](#audio-msg).

Параллельно с тем как отправляются аудиофрагменты, в ответ сервис будет возвращать [фрагменты распознанного текста](#response), которые необходимо обрабатывать, например выводить их в консоль.

Чтобы приложение смогло обращаться к сервису, необходимо сгенерировать код интерфейса клиента для используемого языка программирования. Сгенерируйте этот код из скачанного файла [stt_service.proto](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/ai/stt/v2/stt_service.proto).

Ниже представлены [примеры](#examples) клиентских приложений. Помимо этого, в [документации gRPC](https://grpc.io/docs/tutorials/) вы можете найти подробные инструкции по генерации интерфейсов и реализации клиентских приложений для различных языков программирования.

### Авторизация в сервисе

Для авторизации приложение должно отправлять в каждом сообщении [IAM-токен](../../iam/concepts/authorization/iam-token.md). Учтите, что срок действия IAM-токена ограничен.

Узнайте, как получить IAM-токен для вашего аккаунта в соответствующей инструкции:

* [Инструкция](../../iam/operations/iam-token/create.md) для аккаунта на Яндексе.
* [Инструкция](../../iam/operations/iam-token/create-for-sa.md) для [сервисного аккаунта](../../iam/concepts/users/service-accounts.md).

### Результат распознавания

В процессе распознавания речь делится на фразы. Фраза — это фрагмент речи из одного и более слов, после которого был период тишины. Фраза может состоять из предложений, если между ними не было паузы.

Результат распознавания — это варианты распознавания одной фразы. В ответе сервиса может содержаться несколько фраз.

_Финальные результаты_ распознавания формируются, когда система распознавания обнаруживает конец фразы. При этом вы можете отправить несколько сообщений с аудиофрагментом и это будет одной фразой.

_Промежуточные результаты_ распознавания формируются в процессе распознавания фразы. Получение промежуточных результатов позволит быстрее реагировать на распознаваемую речь, не дожидаясь окончания фразы для получения финального результата.

Вы можете указать, чтобы сервис возвращал промежуточные результаты распознавания. Для этого в [сообщении с настройками распознавания](#specification-msg) укажите `config.specification.partial_results=true`. В ответе для промежуточных результатов `final=false`, а для финальных `final=true`.

### Ограничения сессии распознавания речи

После получения сообщения с настройками распознавания сервис начнет сессию распознавания. Для каждой сессии действуют следующие ограничения:

* Время между отправкой сообщений в сервис не должно превышать 5 секунд.
* Максимальная длительность переданного аудио за всю сессию — [!KEYREF stt-streaming-audioLength].
* Максимальный размер переданных аудиоданных — [!KEYREF stt-streaming-fileSize].


Если в течение 5 секунд в сервис не отправлялись сообщения или достигнут лимит по длительности или размеру данных, сессия обрывается. Чтобы продолжить распознавание речи, надо заново установить соединение и отправить новое сообщение с настройками распознавания.

## API сервиса

Сервис располагается по адресу: `stt.api.cloud.yandex.net:443`

### Сообщение с настройками распознавания {#specification-msg}

Параметр | Описание
----- | -----
config | **object**<br>Поле с настройками распознавания и идентификатором каталога.
config<br>.specification | **object**<br>Настройки распознавания.
config<br>.specification<br>.languageCode | **string**<br>Язык, для которого будет выполнено распознавание.<br/>Допустимые значения:<ul><li>`ru-RU` (по умолчанию) — русский язык,</li><li>`en-US` — английский язык.</li><li>`tr-TR` — турецкий язык.</li></ul>
config<br>.specification<br>.model | **string**<br>Языковая модель, которую следует использовать при распознавании.<br/>Чем точнее выбрана модель, тем лучше результат распознавания. В одном запросе можно указать только одну модель.<br/>[Допустимые значения](models.md) зависят от выбранного языка. Значение параметра по умолчанию: `general`.
config<br>.specification<br>.profanityFilter | **boolean**<br>Фильтр ненормативной лексики.<br/>Допустимые значения:<ul><li>`true` — исключать ненормативную лексику из результатов распознавания.</li><li>`false` (по умолчанию) — не исключать ненормативную лексику.</li></ul>
config<br>.specification<br>.partialResults | **boolean**<br>Фильтр промежуточных результатов.<br/>Допустимые значения:<ul><li>`true` — возвращать промежуточные результаты (часть распознанного высказывания). Для промежуточных результатов `final` равно `false`.</li><li>`false` (по умолчанию) — возвращать только финальные результаты (распознанное высказывание целиком).
config<br>.specification<br>.audioEncoding | **string**<br>[Формат](formats.md) передаваемого аудио.<br/>Допустимые значения:<ul><li>`LINEAR16_PCM` — [LPCM без WAV-заголовка](formats.md#lpcm).</li><li>`OGG_OPUS` (по умолчанию) — формат [OggOpus](formats.md#oggopus).</li></ul>
config<br>.specification<br>.sampleRateHertz | **integer** (int64)<br>Частота дискретизации передаваемого аудио.<br/>Этот параметр обязателен, если значение `format` равно `LINEAR16_PCM`. Допустимые значения:<ul><li>`48000` (по умолчанию) — частота дискретизации 48 кГц;</li><li>`16000` — частота дискретизации 16 кГц;</li><li>`8000` — частота дискретизации 8 кГц.</li></ul>
folderId | **string**<br><p>Идентификатор каталога, к которой у вас есть доступ. Требуется для авторизации с пользовательским аккаунтом (см. ресурс <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a> ). Не используйте это поле, если вы делаете запрос от имени сервисного аккаунта.</p> <p>Максимальная длина строки в символах — 50.</p>

### Сообщение с аудиофрагментом {#audio-msg}

Параметр | Описание
----- | -----
`audio_content` | Фрагмент аудио в виде массива байт. Аудио должно быть в формате, указанном в [сообщении с настройками распознавания](#specification-msg).


### Структура ответа {#response}

При успешном распознавании фрагмента речи придет сообщение, содержащее список результатов распознавания `chunks[]`. Каждый результат содержит поля:

* `alternatives[]` - список вариантов распознанного текста. Каждый вариант содержит поля:
    * `text` - распознанный текст.
    * `confidence` - достоверность определения. Сейчас сервис всегда возвращает значение `1`, которое эквивалентно 100%.
* `final` - равно `true`, если результат окончательный, и `false`, если промежуточный.

### Коды ошибок, возвращаемые сервером {#error_codes}

Соответствия gRPC-статусов с HTTP-кодами описаны в [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto).

Список возможных gRPC-ошибок, возвращаемых сервисом:

Код | Статус | Описание
----- | ----- | -----
3 | `INVALID_ARGUMENT` | Клиент некорректно указал параметры запроса. Детальная информация представлена в поле `details`.
16 | `UNAUTHENTICATED` | Для выполнения операции необходима авторизация. Проверьте IAM-токен и идентификатор каталога, которые вы передали
13 | `INTERNAL` | Внутренняя ошибка сервера. Ошибка означает, что операция не может быть выполнена из-за технического состояния сервера. Например, из-за нехватки вычислительных ресурсов.

## Примеры {#examples}

Для того чтобы попробовать примеры в этом разделе:

1. Скачайте protobuf-файл с описанием сервиса [stt_service.proto](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/ai/stt/v2/stt_service.proto) в ту же директорию.
1. Узнайте идентификатор каталога, к которому у вашего аккаунта есть доступ.
1. Получите IAM-токен:
    * [Инструкция](../../iam/operations/iam-token/create.md) для аккаунта на Яндексе.
    * [Инструкция](../../iam/operations/iam-token/create-for-sa.md) для сервисного аккаунта.
1. Выберите аудиофайл для распознавания. В примерах используется файл `speech.pcm` в формате [LPCM](https://en.wikipedia.org/wiki/Pulse-code_modulation) с частотой дискретизации 8000.
    > [!NOTE]
    >
    > Нет аудиофайла для распознавания? Скачайте готовый [пример](https://storage.yandexcloud.net/speechkit/speech.pcm).

После этого приступите к созданию клиентского приложения.

---

**[!TAB Python]**

1. Установите пакет grpcio-tools с помощью менеджера пакетов [pip](https://pip.pypa.io/en/stable/):

    ```bash
    pip install grpcio-tools
    ```

1. Перейдите в директорию с репозиторием [Yandex.Cloud API](https://github.com/yandex-cloud/cloudapi) и сгенерируйте код интерфейса клиента:

    ```bash
    cd cloudapi
    python -m grpc_tools.protoc -I . -I third_party/googleapis --python_out=. --grpc_python_out=. yandex/cloud/ai/stt/v2/stt_service.proto
    ```

    В результате в этой директории будут созданы файлы с интерфейсом клиента: `stt_service_pb2.py` и `stt_service_pb2_grpc.py`.

1. Создайте файл, например `test.py`, и добавьте в него следующий код:

    ```Python
    import argparse

    import grpc

    import stt_service_pb2
    import stt_service_pb2_grpc


    CHUNK_SIZE = 16000

    def gen(folder_id, audio_file_name):
        # Задаем настройки распознавания.
        specification = stt_service_pb2.RecognitionSpec(
            language_code='ru-RU',
            profanity_filter=True,
            model='general',
            partial_results=True,
            audio_encoding='LINEAR16_PCM',
            sample_rate_hertz=8000
        )
        streaming_config = stt_service_pb2.RecognitionConfig(specification=specification, folder_id=folder_id)

        # Отправляем сообщение с настройками распознавания.
        yield stt_service_pb2.StreamingRecognitionRequest(config=streaming_config)

        # Читаем аудиофайл и отправляем его содержимое порциями.
        with open(audio_file_name, 'rb') as f:
            data = f.read(CHUNK_SIZE)
            while data != b'':
                yield stt_service_pb2.StreamingRecognitionRequest(audio_content=data)
                data = f.read(CHUNK_SIZE)


    def run(folder_id, iam_token, audio_file_name):
        # Устанавливаем соединение с сервером.
        cred = grpc.ssl_channel_credentials()
        channel = grpc.secure_channel('stt.api.cloud.yandex.net:443', cred)
        stub = stt_service_pb2_grpc.SttServiceStub(channel)

        # Отправляем данные для распознавания.
        it = stub.StreamingRecognize(gen(folder_id, audio_file_name), metadata=(('authorization', 'Bearer %s' % iam_token),))

        # Обрабатываем ответы сервера и выводим результат в консоль.
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
    ('Is final: ', False)

    Start chunk:
    alternative: привет мир
    ('Is final: ', True)
    ```

---
