Имя метрики пишется в метку `name`.

Все метрики сервиса {{ data-transfer-name }} имеют общие метки:

Метка | Значение
--- | ---
service | Идентификатор сервиса: `data-transfer`.
job_index | Индекс воркера для отличия воркеров, используемых при [параллельном копировании](../../../data-transfer/concepts/sharded.md) данных.
src_id | Идентификатор [источника](../../../data-transfer/transfer-matrix.md).
target_type | Тип [приемника](../../../data-transfer/transfer-matrix.md), например `mongo`.
resource_id | Идентификатор [трансфера](../../../data-transfer/concepts/index.md#transfer) {{ data-transfer-name }}.
dst_id | Идентификатор приемника.
source_type | Тип источника, например `mongo`.
operation_type (кроме метрик `replication.*`) | Тип операции, например `Activate`.

## Метрики CPU {#data-transfer-cpu-metrics}

Загрузка процессорных ядер.

Общие метки для всех метрик CPU:

Метка | Значение
--- | ---
component | Компонент системы, например `psutil`.

Имя</br>Тип, единицы измерения | Описание
----- | -----
`cpu.counts`</br>`COUNTER`, штуки | Количество CPU, выделенных на перенос данных в воркере.
`proc.cpu`</br>`DGAUGE`, % | Загрузка процессорных ядер.
`proc.descriptors`</br>`DGAUGE`, штуки | Количество открытых файловых дескрипторов.
`proc.ram`</br>`DGAUGE`, байты | Использование оперативной памяти.

## Метрики RAM {#data-transfer-ram-metrics}

Общие метки для всех метрик RAM:

Метка | Значение
--- | ---
component | Компонент системы, например `psutil`.

Имя</br>Тип, единицы измерения | Описание
----- | -----
`mem.available`</br>`COUNTER`, байты | Использование оперативной памяти, тип потребления `available`.
`mem.percentage`</br>`DGAUGE`, % | Процент использования оперативной памяти.
`mem.used`</br>`COUNTER`, байты | Использование оперативной памяти, тип потребления `used`.

## Метрики сервиса {#data-transfer-metrics}

Имя</br>Тип, единицы измерения | Описание</br>Метки
----- | -----
`fallbacks.source.deepness`</br>`DGAUGE`, штуки | Текущее количество элементов в fallback-очереди на стороне источника.
`fallbacks.source.errors`</br>`COUNTER`, штуки | Количество ошибок, возникших на стороне источника в процессе fallback.
`fallbacks.source.items`</br>`COUNTER`, штуки | Общее количество элементов, добавленных в fallback-очередь на стороне источника.
`fallbacks.target.deepness`</br>`DGAUGE`, штуки | Текущее количество элементов в fallback-очереди на стороне приемника.
`fallbacks.target.errors`</br>`COUNTER`, штуки | Количество ошибок, возникших на стороне приемника в процессе fallback.
`fallbacks.target.items`</br>`COUNTER`, штуки | Общее количество элементов, добавленных в fallback-очередь на стороне приемника.
`logger.bytes_written`</br>`COUNTER`, байты | Общий объем записанных логов.
`logger.field_truncated_size_hist`</br>`IGAUGE`, байты | Гистограмма усеченных полей в логах.</br>Метка `bin` — бакеты гистограммы.
`logger.leaked_count`</br>`COUNTER`, штуки | Количество утечек в логах.
`logger.leaked_size`</br>`COUNTER`, байты | Объем утечек в логах.
`logger.leaked_size_hist`</br>`IGAUGE`, байты | Гистограмма утечек в логах.</br>Метка `bin` — бакеты гистограммы.
`logger.success_size_hist`</br>`IGAUGE`, байты | Гистограмма записанных логов.</br>Метка `bin` — бакеты гистограммы.
`middleware.error_tracker.failures`</br>`COUNTER`, штуки | Количество ошибок в трекере ошибок.</br>Метка `component` — компонент системы, например `middleware_filter`.
`middleware.error_tracker.success`</br>`COUNTER`, штуки | Количество успешных операций в трекере ошибок.</br>Метка `component` — компонент системы, например `middleware_filter`.
`middleware.filter.dropped`</br>`COUNTER`, штуки | Количество отброшенных элементов.</br>Метка `component` — компонент системы, например `middleware_filter`.
`publisher.consumer.active`</br>`DGAUGE`, штуки | Количество активных консьюмеров (потоков обработки данных).
`publisher.consumer.compress_ratio`</br>`DGAUGE`, % | Коэффициент сжатия данных во время передачи данных.
`publisher.consumer.ddl_error`</br>`COUNTER`, штуки | Количество ошибок, связанных с операциями DDL (Data Definition Language).
`publisher.consumer.error`</br>`COUNTER`, штуки | Общее количество ошибок, возникающих у консьюмеров.
`publisher.consumer.extracted_bytes`</br>`DGAUGE`, байты | Объем данных, извлеченный из источника.
`publisher.consumer.fatal`</br>`COUNTER`, штуки | Количество фатальных ошибок, требующих вмешательства оператора.
`publisher.consumer.log_usage_bytes`</br>`DGAUGE`, байты | Объем буфера или журнала опережающей записи (там, где он поддерживается) в источнике.
`publisher.consumer.read_bytes`</br>`DGAUGE`, байты | Объем прочитанных данных.
`publisher.data.bytes`</br>`COUNTER`, байты | Объем считанных из источника данных.
`publisher.data.changeitems`</br>`COUNTER`, штуки | Число событий на источнике, сгенерированных для переноса (события помимо переносимых данных могут содержать технические операции).
`publisher.data.parsed_rows`</br>`COUNTER`, штуки | Количество строк, успешно обработанных после их парсинга.
`publisher.data.transactions`</br>`COUNTER`, штуки | Количество транзакций данных, обработанных в процессе передачи.
`publisher.data.unparsed_rows`</br>`COUNTER`, штуки | Количество строк данных, которые не удалось успешно распарсить.
`publisher.time.delay_ms`</br>`DGAUGE`, миллисекунды | Задержка в процессе передачи данных.
`publisher.time.parse_ms`</br>`DGAUGE`, миллисекунды | Время, затраченное на парсинг данных.
`publisher.time.push_ms`</br>`DGAUGE`, миллисекунды | Время, затраченное на отправку данных в приемник.
`publisher.time.transform_ms`</br>`DGAUGE`, миллисекунды | Время, затраченное на трансформацию данных.
`replication.running`</br>`DGAUGE`, 0/1 | Текущее состояние репликации.</br>Принимает значения:<ul><li>`1` — запущена;</li><li>`0` — остановлена.</li></ul>
`replication.start.unix`</br>`DGAUGE`, число | Метка времени начала репликации в формате Unix epoch.
`runtime.alloc`</br>`COUNTER`, байты | Общий объем выделенной, но еще не освобожденной памяти.</br>Метка `component` — компонент системы, например `psutil`.
`runtime.heapIdle`</br>`COUNTER`, байты | Объем памяти, который был выделен под динамическую память, но в данный момент не используется.</br>Метка `component` — компонент системы, например `psutil`.
`runtime.heapInuse`</br>`COUNTER`, байты | Объем памяти, активно используемой под динамическую память.</br>Метка `component` — компонент системы, например `psutil`.
`runtime.numGC`</br>`COUNTER`, штуки | Количество циклов сборки мусора (GC), выполненных с начала времени измерения.</br>Метка `component` — компонент системы, например `psutil`.
`runtime.sys`</br>`COUNTER`, байты | Общий объем используемой системной памяти.</br>Метка `component` — компонент системы, например `psutil`.
`runtime.totalAlloc`</br>`COUNTER`, байты | Общий объем памяти, выделенной за все время работы.</br>Метка `component` — компонент системы, например `psutil`.
`sinker.pusher.data.changeitems`</br>`COUNTER`, штуки | Число событий, записанных в приемник (события помимо переносимых данных могут содержать технические операции).
`sinker.pusher.data.row_events_pushed`</br>`COUNTER`, штуки | Число строк, отправленных в приемник.
`sinker.pusher.time.batch_push_distribution_sec`</br>`IGAUGE`, секунды | Полное время записи в приемник батча данных с учетом предварительной обработки.</br>Метка `bin` — бакеты гистограммы.
`sinker.pusher.time.row_lag_sec`</br>`IGAUGE`, секунды | Разница между временем появления записей на приемнике и источнике.</br>Метка `bin` — бакеты гистограммы.
`sinker.pusher.time.row_max_lag_sec`</br>`DGAUGE`, секунды | Максимальное отставание данных.
`sinker.pusher.time.row_max_read_lag_sec`</br>`DGAUGE`, секунды | Максимальное отставание данных от момента их появления на источнике до момента их чтения.
`sinker.table.deleted_rows`</br>`COUNTER`, штуки | Количество удаленных строк в таблице.</br>Метка `table` — таблица БД или коллекция.
`sinker.table.rows`</br>`COUNTER`, штуки | 50 таблиц с максимальным количеством записанных в приемник строк.</br>Метка `table` — таблица БД или коллекция.
`sinker.table.updated_rows`</br>`COUNTER`, штуки | Количество обновленных строк в таблице.</br>Метка `table` — таблица БД или коллекция.
`sinker.table.upserted_rows`</br>`COUNTER`, штуки | Количество строк, вставленных или обновленных (`upsert`) в таблице.</br>Метка `table` — таблица БД или коллекция.
`sinker.time.bulkPrepare`</br>`DGAUGE`, секунды | Время подготовки батча данных для записи.
`sinker.time.bulkWrite`</br>`DGAUGE`, секунды | Время записи батча данных.
`sinker.time.push`</br>`DGAUGE`, секунды | Общее время операции записи данных.
`sinker.transactions.inflight`</br>`COUNTER`, штуки | Количество активных транзакций.
`sinker.transactions.total`</br>`COUNTER`, штуки | Общее количество выполненных транзакций.
`storage.diff_perc`</br>`DGAUGE`, % | Разница в процентах между количеством записей на источнике и приемнике.</br>Метка `table` — таблица БД или коллекция.
`storage.source_rows`</br>`DGAUGE`, штуки | Количество строк на источнике данных.</br>Метка `table` — таблица БД или коллекция.
`storage.target_rows`</br>`DGAUGE`, штуки |  Количество строк на приемнике данных.</br>Метка `table` — таблица БД или коллекция.
`task.snapshot.remainder.table`</br>`DGAUGE`, штуки | Количество строк, ожидающих переноса.</br>Метка `table` — таблица БД или коллекция.
`task.snapshot.reminder.total`</br>`DGAUGE`, штуки | Общее количество оставшихся строк для переноса.</br>Метка `table` — таблица БД или коллекция.
`task.status`</br>`DGAUGE`, 0/1 | Статус выполняющейся операции.</br>Принимает значения:<ul><li>`1` — задача активна;</li><li>`0` — задача неактивна.</li></ul>