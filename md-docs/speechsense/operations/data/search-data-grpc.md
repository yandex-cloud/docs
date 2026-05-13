# Поиск данных через gRPC API

## Перед началом работы {#before-you-begin}

Для работы с API Yandex Cloud потребуется Git, Python 3.6 или старше и пакет `grpcio-tools`. [Узнайте, как установить Python](https://www.python.org/downloads/).

Чтобы искать данные с помощью gRPC API Yandex Cloud:

1. В консоли управления [создайте сервисный аккаунт](../../../iam/operations/sa/create.md).
1. [Добавьте сервисный аккаунт в пространство](../space/add-user-to-space.md) с ролью `Data editor`. Это позволит сервисному аккаунту загружать данные в SpeechSense.
1. Чтобы аутентифицироваться в API Yandex Cloud, создайте для сервисного аккаунта [API-ключ](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) с заданной [областью действия](../../../iam/concepts/authorization/api-key.md#scoped-api-keys) `yc.speech-sense.use` или [IAM-токен](../../../iam/operations/iam-token/create-for-sa.md).
1. Склонируйте [репозиторий API Yandex Cloud](https://github.com/yandex-cloud/cloudapi):
   
   ```bash
   git clone https://github.com/yandex-cloud/cloudapi
   ```
1. Установите пакет `grpcio-tools` с помощью менеджера пакетов [pip](https://pip.pypa.io/en/stable/):
   
   ```python
   pip install grpcio-tools
   ```
1. [Загрузите аудиозаписи](upload-data.md) или [чаты](upload-chat-text.md) в SpeechSense.

## Найти данные {#grpc-api-search}

1. Перейдите в папку с репозиторием API Yandex Cloud, создайте папку `search_data`, сгенерируйте в ней код интерфейса клиента и перейдите в папку `search_data`:

    {% list tabs group=programming_language %}

    - Bash {#bash}

        ```bash
        cd <путь_к_папке_cloudapi> && \
        mkdir search_data && \
        python3 -m grpc_tools.protoc -I . -I third_party/googleapis \
            --python_out=./search_data/ \
            --grpc_python_out=./search_data/ \
            google/api/http.proto \
            google/api/annotations.proto \
            yandex/cloud/api/operation.proto \
            google/rpc/status.proto \
            yandex/cloud/operation/operation.proto \
            yandex/cloud/validation.proto \
            yandex/cloud/speechsense/v1/*.proto \
            yandex/cloud/speechsense/v1/*/*.proto
        cd search_data
        ```

    {% endlist %}

1. В папке `search_data` создайте Python-скрипт `search_data.py`, который выполняет поиск диалогов в SpeechSense.

    {% cut "Пример скрипта search_data.py с фильтрацией и полнотекстовым поиском" %}

    ```python
    import argparse
    import re
    from datetime import datetime
    from typing import NamedTuple

    import grpc
    from google.protobuf.field_mask_pb2 import FieldMask
    from google.protobuf.json_format import MessageToJson

    from yandex.cloud.speechsense.v1 import search_pb2
    from yandex.cloud.speechsense.v1 import talk_service_pb2
    from yandex.cloud.speechsense.v1 import talk_service_pb2_grpc

    class IntRangeFilter(NamedTuple):
        key: str
        lower_bound: int
        lb_inclusive: bool
        upper_bound: int
        ub_inclusive: bool

    def parse_int_range(s: str) -> IntRangeFilter:
        pattern = r'(-?\d+)(<=|<)(\w+)(<=|<)(-?\d+)'

        match = re.match(pattern, s)

        if not match:
            raise ValueError(f"Could not parse int range from: '{s}'")

        lower_bound = int(match.group(1))
        lower_bound_inclusive = match.group(2) == "<="
        key = match.group(3)
        upper_bound_inclusive = match.group(4) == "<="
        upper_bound = int(match.group(5))

        return IntRangeFilter(
            key=key,
            lower_bound=lower_bound,
            lb_inclusive=lower_bound_inclusive,
            upper_bound=upper_bound,
            ub_inclusive=upper_bound_inclusive
        )

    def build_search_request(
            organization_id: str,
            space_id: str,
            connection_id: str,
            project_id: str,
            query=None,
            from_date=None,
            to_date=None,
            match_filter=None,
            classifier_filter=None,
            page_size=100,
            page_token='') -> talk_service_pb2.SearchTalkRequest:
        request = talk_service_pb2.SearchTalkRequest(
            organization_id=organization_id,
            space_id=space_id,
            connection_id=connection_id,
            project_id=project_id,
            page_size=page_size,
            page_token=page_token
        )

        # Добавление запроса полнотекстового поиска
        if query:
            request.query.text = query

        # Добавление фильтра по дате
        if from_date:
            date_filter = search_pb2.DateRangeFilter()
            date_filter.from_value.FromDatetime(datetime.fromisoformat(from_date))
            request.filters.append(search_pb2.Filter(key="userMeta.date", date_range=date_filter))

        if to_date:
            date_filter = search_pb2.DateRangeFilter()
            date_filter.to_value.FromDatetime(datetime.fromisoformat(to_date))
            request.filters.append(search_pb2.Filter(key="userMeta.date", date_range=date_filter))

        # Добавление match-фильтра
        if match_filter:
            key, value = match_filter.split(':')  # kлюч/значение
            any_match_filter = search_pb2.AnyMatchFilter()
            any_match_filter.values.append(value)
            request.filters.append(search_pb2.Filter(key=key, any_match=any_match_filter))

        # Добавление фильтра классификатора
        if classifier_filter:
            filter_values = parse_int_range(classifier_filter)
            int_range_filter = search_pb2.IntRangeFilter()
            int_range_filter.from_value.value=filter_values.lower_bound
            int_range_filter.to_value.value=filter_values.upper_bound
            int_range_filter.bounds_inclusive.from_inclusive=filter_values.lb_inclusive
            int_range_filter.bounds_inclusive.to_inclusive=filter_values.ub_inclusive
            request.filters.append(
                    search_pb2.Filter(key='talk.classifiers.' + filter_values.key + '.count', int_range=int_range_filter))

        return request

    # Для аутентификации с IAM-токеном замените параметр api_key на iam_token
    def print_talks(
            api_key: str,
            organization_id: str,
            space_id: str,
            connection_id: str,
            project_id: str,
            query=None,
            from_date=None,
            to_date=None,
            match_filter=None,
            classifier_filter=None
    ):
        credentials = grpc.ssl_channel_credentials()
        channel = grpc.secure_channel('api.speechsense.yandexcloud.net:443', credentials)
        talk_service_stub = talk_service_pb2_grpc.TalkServiceStub(channel)

        page_token = ''

        while True:
            search_request = build_search_request(
                organization_id=organization_id,
                space_id=space_id,
                connection_id=connection_id,
                project_id=project_id,
                query=query,
                from_date=from_date,
                to_date=to_date,
                match_filter=match_filter,
                classifier_filter=classifier_filter,
                page_token=page_token)

            # Поиск ID подходящих диалогов
            search_response = talk_service_stub.Search(search_request, metadata=(
                ('authorization', f'Api-Key {api_key}'),
                # Для аутентификации с IAM-токеном передавайте заголовок
                # ('authorization', f'Bearer {iam_token}'),
            ))
            page_token = search_response.next_page_token
            # print(f'found falks {search_response.talks_count}')

            # По умолчанию будут возвращены только базовые поля диалога.
            # Для включения результатов анализа необходимо дополнительно передать их в запрос
            fields_to_include = FieldMask(
                paths=['transcription', 'speech_statistics', 'silence_statistics', 'interrupts_statistics',
                       'conversation_statistics', 'points', 'text_classifiers'])

            # Запрос полных данных диалогов по ID
            get_request = talk_service_pb2.GetTalkRequest(
                organization_id=organization_id,
                space_id=space_id,
                connection_id=connection_id,
                project_id=project_id,
                talk_ids=search_response.talk_ids,
                results_mask=fields_to_include
            )

            get_response = talk_service_stub.Get(get_request, metadata=(
                ('authorization', f'Api-Key {api_key}'),
                # Для аутентификации с IAM-токеном передавайте заголовок
                # ('authorization', f'Bearer {iam_token}'),
            ))

            # Печать диалогов
            for talk in get_response.talk:
                print(MessageToJson(talk, ensure_ascii=False))

            # Если токен пустой, мы долистали до последней страницы результата
            if not page_token:
                break

    if __name__ == '__main__':
        parser = argparse.ArgumentParser()
        parser.add_argument('--key', required=True, help='API key or IAM token', type=str)
        parser.add_argument('--organization-id', required=True, help='Organization ID', type=str)
        parser.add_argument('--space-id', required=True, help='Space ID', type=str)
        parser.add_argument('--connection-id', required=True, help='Connection ID', type=str)
        parser.add_argument('--project-id', required=True, help='Project ID', type=str)
        parser.add_argument('--query', required=False, help='Full-text search query', type=str)
        parser.add_argument('--match-filter', required=False, help='Simple match filter in format key:value', type=str)
        parser.add_argument('--classifier-filter', required=False,
                            help='range for classifier X in format fromValue</<=X</<=toValue', type=str)
        parser.add_argument('--before', required=False, help='Search for talks before timestamp', type=str)
        parser.add_argument('--after', required=False, help='Search for talks after timestamp', type=str)

        args = parser.parse_args()

        print_talks(args.key, args.organization_id, args.space_id, args.connection_id, args.project_id, query=args.query,
                    from_date=args.after, to_date=args.before, match_filter=args.match_filter,
                    classifier_filter=args.classifier_filter)
    ```

    {% endcut %}

1. Задайте API-ключ сервисного аккаунта:
   
   ```bash
   export API_KEY=<API-ключ_сервисного_аккаунта>
   ```
   
   Если вы используете IAM-токен, передайте его вместо API-ключа:
   
   ```bash
   export IAM_TOKEN=<IAM-токен_сервисного_аккаунта>
   ```

1. Запустите скрипт `search_data.py` с нужными параметрами:

    ```bash
    python3 search_data.py \
       --organization-id <идентификатор_организации> \
       --space-id <идентификатор_пространства> \
       --connection-id <идентификатор_подключения> \
       --project-id <идентификатор_проекта> \
       --key ${API_KEY}
    ```

    Где:

    * `--organization-id` — идентификатор организации, в которой выполняется запрос. Чтобы получить идентификатор, перейдите в сервис [Cloud Center](https://center.yandex.cloud) и нажмите кнопку ![icon](../../../_assets/console-icons/copy.svg) под названием организации, в разделе ![icon](../../../_assets/console-icons/briefcase.svg).
    * `--space-id` — идентификатор пространства, в котором выполняется запрос. Чтобы получить идентификатор, перейдите в сервис [SpeechSense](https://speechsense.yandex.cloud/), откройте страницу нужного пространства и нажмите кнопку **ID**.
    * `--connection-id` — идентификатор подключения, в котором выполняется запрос. Чтобы получить идентификатор, перейдите в сервис [SpeechSense](https://speechsense.yandex.cloud/), откройте страницу нужного пространства, на вкладке **Подключение** откройте страницу нужного подключения и нажмите кнопку **ID**.
    * `--project-id` — идентификатор проекта, в котором выполняется запрос. Чтобы получить идентификатор, перейдите в сервис [SpeechSense](https://speechsense.yandex.cloud/), откройте страницу нужного пространства, на вкладке **Проекты** откройте страницу нужного проекта и нажмите кнопку **ID**.
    * `--key` — API-ключ для аутентификации. Если вы используете IAM-токен, укажите переменную окружения `IAM_TOKEN` вместо `API_KEY`.

    В результате работы скрипта на экран будут выведены данные в JSON-формате.

## Параметры запросов {#query-parameters}

### Search-запрос {#search-query}

* `Query` — это полнотекстовый поиск, который позволяет искать по текстовой расшифровке аудиозаписи и текстовым сообщениям чата.
* `Filter` — позволяет искать по метаданным пользователя, классификаторам, резюме диалога, статистикам.

  В `Filter`, передайте характеристику диалога, по которой производится фильтрация, в поле `key`:

  * `userMeta.<имя_поля>` — фильтрация по метаданным пользователя. Здесь `<имя_поля>` — это поле метаданных пользователя, которое было указано при загрузке диалога. Пример: `userMeta.date`. Тип фильтра должен соответствовать тому типу поля метаданных, который вы указали при создании подключения.
  * `talk.classifiers.<имя_классификатора>.count` — фильтрация по классификаторам.
  * `talk.summarization.points.<идентификатор_вопроса>` — фильтрация по резюме диалога. Идентификаторы вопросов из резюме диалога вы можете посмотреть в ответе get-запроса.
  * Поиск по статистикам:

    * Для аудио:
    
        * `talk.statistics.duration_seconds` — длительность диалога, в секундах.
        * `talk.statistics.simultaneous_silence.duration_seconds` — длительность одновременной тишины, в секундах.
        * `talk.statistics.simultaneous_silence.ratio` — доля одновременной тишины.
        * `talk.statistics.simultaneous_silence.max_duration_seconds` — максимальная длительность одновременной тишины, в секундах.
        * `talk.statistics.silence.duration_seconds` — длительность тишины клиента или оператора, в секундах.
        * `talk.statistics.silence.ratio` — доля тишины клиента или оператора.
        * `talk.statistics.simultaneous_speech.duration_seconds` — длительность одновременной речи, в секундах.
        * `talk.statistics.simultaneous_speech.ratio` — доля одновременной речи.
        * `talk.statistics.simultaneous_speech.max_duration_seconds` — максимальная длительность одновременной речи, в секундах.
        * `talk.statistics.speech.duration_seconds` — длительность речи клиента или оператора, в секундах.
        * `talk.statistics.speech.ratio` — доля речи клиента или оператора.
        * `talk.statistics.interrupts.count` — количество прерываний собеседника.
        * `talk.statistics.phrases.count` — количество фраз в диалоге.
        * `talk.statistics.words.count` — количество слов в диалоге.
        * `talk.statistics.letters.count` — количество символов в диалоге.
        * `talk.statistics.words.count_per_second` — количество слов в секунду.
        * `talk.statistics.letters.count_per_second` — количество символов в секунду.
        * `talk.statistics.interrupts.duration_seconds` — длительность прерываний одним из участников речи другого участника, в секундах.
    
    * Для чатов:
    
        * `talk.statistics.duration_seconds` — длительность диалога, в секундах.
        * `talk.statistics.reactions.count` — количество реакций оператора на сообщения клиента.
        * `talk.statistics.reactions.first_duration_seconds` — длительность первой реакции оператора на сообщение клиента, в секундах.
        * `talk.statistics.reactions.min_duration_seconds` — минимальная длительность реакции, в секундах.
        * `talk.statistics.reactions.max_duration_seconds` — максимальная длительность реакции, в секундах.
        * `talk.statistics.phrases.count` — количество фраз в диалоге.
        * `talk.statistics.words.count` — количество слов в диалоге.
        * `talk.statistics.letters.count` — количество символов в диалоге.

В `Filter` и `Query` можно передать канал в параметре `channel_number`. Для полнотекстового поиска это означает, что поиск ведется только по текстовой расшифровке аудиозаписи для указанного канала. Для фильтров это означает, что фильтрация происходит по метаданным,  срабатываниям классификатора или статистикам, относящимся к данному каналу.

В подключениях для чатов нумерация каналов следующая:

* `0` — канал оператора;
* `1` — канал клиента;
* `2` — канал бота.

В подключениях для аудио нумерация каналов предустановлена.

Другие виды фильтров в search-запросе:

* `AnyMatchFilter` — определяет, встречается ли значение из фильтра в метаданных, классификаторах, статистиках, резюме диалога. Например, фильтр с параметрами `key = userMeta.ticket_id` и `values = [123, 345]` вернет диалоги, у которых в поле метаданных `ticket_id` передано значение `123` или `345`.
* `IntRangeFilter` — проверяет, что заданное целочисленное значение попадает в диапазон, указанный в фильтре. Подходит для фильтрации по классификаторам, полям метаданных целочисленного типа и статистикам со значениями целочисленного типа.
* `DoubleRangeFilter` — проверяет, что заданное число с плавающей точкой попадает в диапазон, указанный в фильтре. Подходит для фильтрации по классификаторам, полям метаданных и статистикам со значениями с плавающей точкой.
* `BooleanFilter` — проверяет, что значение по ключу типа `boolean` имеет подходящее значение (`True` или `False`). Подходит для поиска по резюме диалога и полям метаданных типа `boolean`.

Подробнее о параметрах search-запроса см. в [справочнике API](../../api-ref/grpc/Talk/search.md).

### Get-запрос {#get-query}

В get-запросе важным параметром является маска результатов — поле `fields_to_include`. Если параметр `fields_to_include` не передан, вернется только базовая информация о диалоге: идентификаторы проекта, подключения и пространства, когда и кем создан и изменен, а также метаданные, добавленные при загрузке диалога.

Чтобы выгрузить дополнительную информацию, передайте в маске нужные ключи:

* `transcription` — текстовая расшифровка аудиозаписи или текстовые сообщения из чата.
* `speech_statistics` — статистика речи.
* `silence_statistics` — статистика пауз в диалоге.
* `interrupts_statistics` — статистика прерываний собеседника.
* `conversation_statistics` — статистика диалога.
* `points` — резюме диалога.
* `text_classifiers` — статистика по классификаторам (тегам).

Подробнее о параметрах get-запроса см. в [справочнике API](../../api-ref/grpc/Talk/get.md).