Имя метрики пишется в метку `name`.

Общие метки для всех метрик сервиса {{ maf-name }}:

Метка | Значение
----|----
service | Идентификатор сервиса: `managed-airflow`
cluster_id | Идентификатор [кластера](../../../managed-airflow/concepts/index.md#cluster)

Метрики сервиса:

Имя<br/>Тип, единицы измерения | Описание<br/>Метки
----|----
`airflow.dag_processing.file_path_queue_size_value`<br/>`GAUGE,` штуки | Количество файлов DAG, которые будут учтены при следующем сканировании.
`airflow.dag_processing.file_path_queue_update_count.value`<br/>`COUNTER,` штуки | Количество раз, когда файловая система была сканирована и все существующие DAG были добавлены в очередь.
`airflow.dag_processing.import_errors.value`<br/>`GAUGE,` штуки | Количество ошибок при попытке разобрать файлы DAG.
`airflow.dag_processing.total_parse_time.value`<br/>`GAUGE,` секунды | Время, потребовавшееся на сканирование и импорт всех файлов DAG, которые будут учтены при следующем сканировании.
`airflow.dagbag_size.value`<br/>`GAUGE,` штуки | Количество файлов DAG, найденных при последнем сканировании DAGBag по конфигурации планировщика.
`airflow.dataset.orphaned.value`<br/>`GAUGE,` штуки | Количество датасетов, которые были помечены как сироты, потому что они больше не связываются с параметрами расписания DAG или выходными данными задач.
`airflow.job_start.value`<br/>`COUNTER`, штуки | Количество запусков различных типов заданий, таких как `SchedulerJob`, `LocalTaskJob` и др.
`airflow.pool.deferred_slots.default_pool.value`<br/>`GAUGE,` штуки | Количество отложенных слотов в пулах по умолчанию.
`airflow.pool.deferred_slots.value`<br/>`GAUGE,` штуки | Количество отложенных слотов во всех пулах.<br/> Метка `pool_name` — имя пула.
`airflow.pool.open_slots.default_pool.value`<br/>`GAUGE,` штуки | Количество открытых слотов в пулах по умолчанию.
`airflow.pool.open_slots.value`<br/>`GAUGE,` штуки | Количество открытых слотов во всех пулах.<br/> Метка `pool_name` — имя пула.
`airflow.pool.queued_slots.default_pool.value`<br/>`GAUGE,` штуки | Количество очередных слотов в пулах по умолчанию.
`airflow.pool.queued_slots.value`<br/>`GAUGE,` штуки | Количество очередных слотов во всех пулах.<br/> Метка `pool_name` — имя пула.
`airflow.pool.running_slots.default_pool.value`<br/>`GAUGE,` штуки | Количество работающих слотов в пулах по умолчанию.
`airflow.pool.running_slots.value`<br/>`GAUGE,` штуки | Количество работающих слотов во всех пулах.<br/> Метка `pool_name` — имя пула.
`airflow.scheduler.critical_section_duration.50_percentile`<br/>`TIMING,` миллисекунды | Время, затраченное на критическую секцию цикла планировщика^1^. 0.5 процентиль.
`airflow.scheduler.critical_section_duration.95_percentile`<br/>`TIMING,` миллисекунды | Время, затраченное на критическую секцию цикла планировщика^1^. 0.95 процентиль.
`airflow.scheduler.critical_section_duration.99_percentile`<br/>`TIMING,` миллисекунды | Время, затраченное на критическую секцию цикла планировщика^1^. 0.99 процентиль.
`airflow.scheduler.critical_section_duration.count`<br/>`TIMING,` штуки | Количество измерений времени, затраченного на критическую секцию цикла планировщика^1^.
`airflow.scheduler.critical_section_duration.lower`<br/>`TIMING,` миллисекунды | Минимальное время, затраченное на критическую секцию цикла планировщика^1^.
`airflow.scheduler.critical_section_duration.mean`<br/>`TIMING,` миллисекунды | Среднее время, затраченное на критическую секцию цикла планировщика^1^.
`airflow.scheduler.critical_section_duration.median`<br/>`TIMING,` миллисекунды | Медианное время, затраченное на критическую секцию цикла планировщика^1^.
`airflow.scheduler.critical_section_duration.stddev`<br/>`TIMING,` миллисекунды | Стандартное отклонение времени, затраченного на критическую секцию цикла планировщика^1^.
`airflow.scheduler.critical_section_duration.sum`<br/>`TIMING,` миллисекунды | Суммарное время, затраченное на критическую секцию цикла планировщика^1^.
`airflow.scheduler.critical_section_duration.upper`<br/>`TIMING,` миллисекунды | Максимальное время, затраченное на критическую секцию цикла планировщика^1^.
`airflow.scheduler.critical_section_query_duration.50_percentile`<br/>`TIMING,` миллисекунды | Время, затраченное на выполнение запроса в критической секции^1^. 0.5 процентиль.
`airflow.scheduler.critical_section_query_duration.95_percentile`<br/>`TIMING,` миллисекунды | Время, затраченное на выполнение запроса в критической секции^1^. 0.95 процентиль.
`airflow.scheduler.critical_section_query_duration.99_percentile`<br/>`TIMING,` миллисекунды | Время, затраченное на выполнение запроса в критической секции^1^. 0.99 процентиль.
`airflow.scheduler.critical_section_query_duration.count`<br/>`TIMING,` штуки | Количество измерений времени, затраченного на выполнение запроса в критической секции^1^.
`airflow.scheduler.critical_section_query_duration.lower`<br/>`TIMING,` миллисекунды | Минимальное время, затраченное на выполнение запроса в критической секции^1^.
`airflow.scheduler.critical_section_query_duration.mean`<br/>`TIMING,` миллисекунды | Среднее время, затраченное на выполнение запроса в критической секции^1^.
`airflow.scheduler.critical_section_query_duration.median`<br/>`TIMING,` миллисекунды | Медианное время, затраченное на выполнение запроса в критической секции^1^.
`airflow.scheduler.critical_section_query_duration.stddev`<br/>`TIMING,` миллисекунды | Стандартное отклонение времени, затраченного на выполнение запроса в критической секции^1^.
`airflow.scheduler.critical_section_query_duration.sum`<br/>`TIMING,` миллисекунды | Суммарное время, затраченное на выполнение запроса в критической секции^1^.
`airflow.scheduler.critical_section_query_duration.upper`<br/>`TIMING,` миллисекунды | Максимальное время, затраченное на выполнение запроса в критической секции^1^.
`airflow.scheduler.heartbeat.value`<br/>`COUNTER,` штуки | Количество heartbeat-сообщений планировщика, указывающих на его активность.
`airflow.scheduler.load_serializers.50_percentile`<br/>`TIMING,` миллисекунды | Время, затраченное на сериализацию данных в планировщике^2^. 0.5 процентиль.
`airflow.scheduler.load_serializers.95_percentile`<br/>`TIMING,` миллисекунды | Время, затраченное на сериализацию данных в планировщике^2^. 0.95 процентиль.
`airflow.scheduler.load_serializers.99_percentile`<br/>`TIMING,` миллисекунды | Время, затраченное на сериализацию данных в планировщике^2^. 0.99 процентиль.
`airflow.scheduler.load_serializers.count`<br/>`TIMING,` штуки | Количество измерений времени, затраченного на сериализацию данных в планировщике^2^.
`airflow.scheduler.load_serializers.lower`<br/>`TIMING,` миллисекунды | Минимальное время, затраченное на сериализацию данных в планировщике^2^.
`airflow.scheduler.load_serializers.mean`<br/>`TIMING,` миллисекунды | Среднее время, затраченное на сериализацию данных в планировщике^2^.
`airflow.scheduler.load_serializers.median`<br/>`TIMING,` миллисекунды | Медианное время, затраченное на сериализацию данных в планировщике^2^.
`airflow.scheduler.load_serializers.stddev`<br/>`TIMING,` миллисекунды | Стандартное отклонение времени, затраченного на сериализацию данных в планировщике^2^.
`airflow.scheduler.load_serializers.sum`<br/>`TIMING,` миллисекунды | Суммарное время, затраченное на сериализацию данных в планировщике^2^.
`airflow.scheduler.load_serializers.upper`<br/>`TIMING,` миллисекунды | Максимальное время, затраченное на сериализацию данных в планировщике^2^.
`airflow.scheduler.orphaned_tasks.adopted.value`<br/>`COUNTER,` штуки | Количество усыновленных планировщиком задач, которые были помечены как сироты.
`airflow.scheduler.orphaned_tasks.cleared.value`<br/>`COUNTER,` штуки | Количество очищенных планировщиком задач, которые были помечены как сироты.
`airflow.scheduler.scheduler_loop_duration.50_percentile`<br/>`TIMING,` миллисекунды | Время, затраченное на выполнение одного цикла планировщика. 0.5 процентиль.
`airflow.scheduler.scheduler_loop_duration.95_percentile`<br/>`TIMING,` миллисекунды | Время, затраченное на выполнение одного цикла планировщика. 0.95 процентиль.
`airflow.scheduler.scheduler_loop_duration.99_percentile`<br/>`TIMING,` миллисекунды | Время, затраченное на выполнение одного цикла планировщика. 0.99 процентиль.
`airflow.scheduler.scheduler_loop_duration.count`<br/>`TIMING,` штуки | Количество измерений времени, затраченного на выполнение одного цикла планировщика.
`airflow.scheduler.scheduler_loop_duration.lower`<br/>`TIMING,` миллисекунды | Минимальное время, затраченное на выполнение одного цикла планировщика.
`airflow.scheduler.scheduler_loop_duration.mean`<br/>`TIMING,` миллисекунды | Среднее время, затраченное на выполнение одного цикла планировщика.
`airflow.scheduler.scheduler_loop_duration.median`<br/>`TIMING,` миллисекунды | Медианное время, затраченное на выполнение одного цикла планировщика.
`airflow.scheduler.scheduler_loop_duration.stddev`<br/>`TIMING,` миллисекунды | Стандартное отклонение времени, затраченного на выполнение одного цикла планировщика.
`airflow.scheduler.scheduler_loop_duration.sum`<br/>`TIMING,` миллисекунды | Суммарное время, затраченное на выполнение одного цикла планировщика.
`airflow.scheduler.scheduler_loop_duration.upper`<br/>`TIMING,` миллисекунды | Максимальное время, затраченное на выполнение одного цикла планировщика.
`airflow.scheduler.tasks.executable.value`<br/>`GAUGE,` штуки | Количество задач, готовых к выполнению в соответствии с ограничениями пула, конкурентности DAG, состояния исполнителя и приоритетов.
`airflow.scheduler.tasks.starving.value`<br/>`GAUGE,` штуки | Количество задач, которые не могут быть запланированы из-за отсутствия свободного слота в пуле.
`CeleryExecutor`<br/>`GAUGE,` штуки | Количество воркеров [Celery](https://docs.celeryq.dev/en/main/index.html) на разных стадиях выполнения задач.<br/>Значение метки `status` означает количество воркеров, которые:<ul><li>`open` — готовы к получению задачи.</li><li>`queued` — получили задачи, но еще не начали выполнение.</li><li>`running` — выполняют задачи.</li></ul>

^1^ Только один планировщик может одновременно войти в этот цикл.
^2^ Процесс сериализации данных для обмена между задачами и для безопасности веб-сервера и планировщика.