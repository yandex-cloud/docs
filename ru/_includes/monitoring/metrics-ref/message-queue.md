Имя метрики пишется в метку `name`.

Все метрики сервиса {{ message-queue-name }} имеют общую метку `service=message-queue`.

## Метрики HTTP API {#mq-http-metrics}

| Имя метрики<br>Тип, единицы измерения | Описание<br>Метки |
| --- | --- |
| `api.http.errors_count_per_second`<br>`DGAUGE`, ошибки/с | Количество ошибок выполнения запросов в секунду.<br>Метка — `method`, метод {{ message-queue-full-name }} API, к которому выполняются запросы. |
| `api.http.request_duration_milliseconds`<br>`DGAUGE`, миллисекунды | Продолжительность выполнения запросов.<br>Метка — `method`, метод {{ message-queue-full-name }} API, к которому выполняются запросы. |
| `api.http.requests_count_per_second`<br>`DGAUGE`, запросы/с | Количество обработанных запросов в секунду.<br>Метка — `method`, метод {{ message-queue-full-name }} API, к которому выполняются запросы. |

## Метрики сервиса {#mq-metrics}

| Имя метрики<br>Тип, единицы измерения | Описание<br>Метки |
| --- | --- |
| `queue.messages.client_processing_duration_milliseconds`<br>`DGAUGE`, миллисекунды | Время обработки сообщений получателем. |
| `queue.messages.deduplicated_count_per_second`<br>`DGAUGE`, сообщения/с | Частота дедупликации сообщений показывает, сколько сообщений за это время было обработано определенное количество раз. Например, сколько сообщений было обработано один раз, сколько — дважды и так далее. Эта метрика позволяет определить избыточную обработку повторяющихся сообщений. |
| `queue.messages.deleted_count_per_second`<br>`DGAUGE`, сообщения/с | Частота удаления сообщений из очереди. |
| `queue.messages.empty_receive_attempts_count_per_second`<br>`DGAUGE`, попытки/с | Количество зафиксированных попыток получения пустого сообщения в секунду. |
| `queue.messages.inflight_count`<br>`DGAUGE`, штуки | Количество сообщений, которые приняты получателями, но не удалены из очереди (у которых не истек [таймаут видимости](../../../message-queue/concepts/visibility-timeout.md)). |
| `queue.messages.oldest_age_milliseconds`<br>`DGAUGE`, миллисекунды | Время хранения наиболее раннего сообщения в очереди.<br>Название метрики устарело, а его составная часть `milliseconds` не отражает текущих единиц измерения. Сейчас метрика исчисляется в `s` (seconds) – секунды. |
| `queue.messages.purged_count_per_second`<br>`DGAUGE`, сообщения/с | Частота удаления сообщений с помощью метода очистки очереди [PurgeQueue](../../../message-queue/api-ref/queue/PurgeQueue). |
| `queue.messages.receive_attempts_count_rate`<br>`DGAUGE`, штуки | Количество попыток получения сообщений из очереди. |
| `queue.messages.received_bytes_per_second`<br>`DGAUGE`, байты/с | Общий размер сообщений, принятых из очереди в секунду. |
| `queue.messages.received_count_per_second`<br>`DGAUGE`, сообщения/с | Количество сообщений, принятых из очереди в секунду. |
| `queue.messages.request_timeouts_count_per_second`<br>`DGAUGE`, ошибки/с | Количество ошибок выполнения запросов `ReceiveMessage`. |
| `queue.messages.reside_duration_milliseconds`<br>`DGAUGE`, миллисекунды | Время обработки сообщений в очереди. |
| `queue.messages.sent_bytes_per_second`<br>`DGAUGE`, байты/с | Общий размер сообщений, отправленных в очередь в секунду. |
| `queue.messages.sent_count_per_second`<br>`DGAUGE`, сообщения/с | Количество сообщений, отправленных в очередь в секунду. |
| `queue.messages.stored_count`<br>`DGAUGE`, штуки | Количество сообщений в очереди в текущий момент. |
