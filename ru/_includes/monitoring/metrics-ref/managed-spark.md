Имя метрики пишется в метку `name`.

Общие метки для всех метрик сервиса {{ msp-name }}:

#|
|| **Метка** | **Значение** ||
|| service | Идентификатор сервиса: `managed-spark` ||
|| cluster_id | Идентификатор кластера ||
|| node_name | Идентификатор хоста ||
|| node_role | Роль хоста. Возможные значения:
* `spark_cluster.driver` — драйвер.
* `spark_cluster.executor` — исполнитель. ||
|#

## Метрики ресурсов кластера {#managed-spark-cluster-resources-metrics}

#|
|| **Имя**

**Тип, единицы измерения** | **Описание** ||
|| `node.allocatable_cpu.gauge`

`DGAUGE`, штуки | Количество CPU, доступных для контейнеров. ||
|| `node.capacity_cpu.gauge`

`DGAUGE`, штуки | Общее количество CPU в кластере. Часть CPU может быть зарезервирована под системные нужды. ||
|| `node.cpu_usage.gauge`

`DGAUGE`, число | Степень утилизации CPU на хостах. ||
|| `node.allocatable_memory.gauge`

`DGAUGE`, байты | Объем памяти хостов, доступной для контейнеров. ||
|| `node.capacity_memory.gauge`

`DGAUGE`, байты | Общий объем памяти хостов. Часть памяти может быть зарезервирована под системные нужды. ||
|| `node.memory_usage.gauge`

`DGAUGE`, байты | Используемый объем памяти хостов. ||
|| `node.fs_available_bytes.gauge`

`DGAUGE`, байты | Доступный для контейнеров объем дисков на хостах. ||
|| `node.fs_capacity_bytes.gauge`

`DGAUGE`, байты | Объем дисков хостов. Часть дискового пространства может быть зарезервирована под системные нужды. ||
|| `node.fs_used_bytes.gauge`

`DGAUGE`, байты | Объем использованного места на дисках хостов. ||
|| `node.network_rx_bytes.gauge`

`DGAUGE`, байты | Объем входящего сетевого трафика кластера. ||
|| `node.network_rx_errors.gauge`

`DGAUGE`, штуки | Количество ошибок приема сетевого трафика кластера. ||
|| `node.network_tx_bytes.gauge`

`DGAUGE`, байты | Объем исходящего сетевого трафика кластера. ||
|| `node.network_tx_errors.gauge`

`DGAUGE`, штуки | Количество ошибок при отправке сетевого трафика кластера. ||
|| `pod.running.gauge`

`DGAUGE`, штуки | Количество работающих контейнеров.

Дополнительная метка `pod_name` может принимать значение идентификатора контейнера. ||
|| `pod.succeeded.gauge`

`DGAUGE`, штуки | Количество успешно завершенных контейнеров.

Дополнительная метка `pod_name` может принимать значение идентификатора контейнера. ||
|| `pod.pending.gauge`

`DGAUGE`, штуки | Количество контейнеров, ожидающих запуска.

Дополнительная метка `pod_name` может принимать значение идентификатора контейнера. ||
|| `pod.failed.gauge`

`DGAUGE`, штуки | Количество контейнеров, запуск которых завершился ошибкой.

Дополнительная метка `pod_name` может принимать значение идентификатора контейнера. ||
|| `pod.unknown.gauge`

`DGAUGE`, штуки | Количество контейнеров в неизвестном состоянии.

Дополнительная метка `pod_name` может принимать значение идентификатора контейнера. ||
|| `pod_container.ready.gauge`

`DGAUGE`, штуки | Количество готовых к запуску контейнеров.

Дополнительная метка `pod_name` может принимать значение идентификатора контейнера. ||
|| `pod_container.started.gauge`

`DGAUGE`, штуки | Количество запущенных контейнеров.

Дополнительная метка `pod_name` может принимать значение идентификатора контейнера. ||
|| `pod_container.restart_count.gauge`

`DGAUGE`, штуки | Количество повторных запусков контейнера.

Дополнительная метка `pod_name` может принимать значение идентификатора контейнера. ||
|| `pod_container.cpu_usage.gauge`

`DGAUGE`, число | Степень утилизации CPU контейнером.

Дополнительная метка `pod_name` может принимать значение идентификатора контейнера. ||
|| `pod_container.cpu_limit.gauge`

`DGAUGE`, число | Лимит CPU контейнера.

Дополнительная метка `pod_name` может принимать значение идентификатора контейнера. ||
|| `pod_container.memory_usage.gauge`

`DGAUGE`, байты | Использование памяти контейнером.

Дополнительная метка `pod_name` может принимать значение идентификатора контейнера. ||
|| `pod_container.memory_limit.gauge`

`DGAUGE`, байты | Лимит памяти контейнера.

Дополнительная метка `pod_name` может принимать значение идентификатора контейнера. ||
|| `pod_container.logsfs_capacity_bytes.gauge`

`DGAUGE`, байты | Выделенный объем файловой системы logsfs для контейнера.

Дополнительная метка `pod_name` может принимать значение идентификатора контейнера. ||
|| `pod_container.logsfs_available_bytes.gauge`

`DGAUGE`, байты | Доступный объем файловой системы logsfs контейнера для запуска приложений.

Дополнительная метка `pod_name` может принимать значение идентификатора контейнера. ||
|| `pod_container.rootfs_capacity_bytes.gauge`

`DGAUGE`, байты | Выделенный объем файловой системы rootfs контейнера.

Дополнительная метка `pod_name` может принимать значение идентификатора контейнера. ||
|| `pod_container.rootfs_available_bytes.gauge`

`DGAUGE`, байты | Доступный объем файловой системы rootfs контейнера.

Дополнительная метка `pod_name` может принимать значение идентификатора контейнера. ||
|| `pod_container.rootfs_used_bytes.gauge`

`DGAUGE`, байты | Использованный объем файловой системы rootfs контейнера.

Дополнительная метка `pod_name` может принимать значение идентификатора контейнера. ||
|| `pod_network.rx_bytes.gauge`

`DGAUGE`, байты | Объем входящего сетевого трафика в контейнер.

Дополнительная метка `pod_name` может принимать значение идентификатора контейнера. ||
|| `pod_network.rx_errors.gauge`

`DGAUGE`, штуки | Количество ошибок приема сетевого трафика в контейнер.

Дополнительная метка `pod_name` может принимать значение идентификатора контейнера. ||
|| `pod_network.tx_bytes.gauge`

`DGAUGE`, байты | Объем исходящего сетевого трафика из контейнера.

Дополнительная метка `pod_name` может принимать значение идентификатора контейнера. ||
|| `pod_network.tx_errors.gauge`

`DGAUGE`, штуки | Количество ошибок при отправке сетевого трафика из контейнера.

Дополнительная метка `pod_name` может принимать значение идентификатора контейнера. ||
|| `pod_volume.capacity_bytes.gauge`

`DGAUGE`, байты | Общий объем подключенного диска в контейнере.

Дополнительная метка `pod_name` может принимать значение идентификатора контейнера. ||
|| `pod_volume.available_bytes.gauge`

`DGAUGE`, байты | Доступный объем подключенного диска в контейнере.

Дополнительная метка `pod_name` может принимать значение идентификатора контейнера. ||
|| `pod_volume.used_bytes.gauge`

`DGAUGE`, байты | Использованный объем подключенного диска в контейнере.

Дополнительная метка `pod_name` может принимать значение идентификатора контейнера. ||
|#

## Метрики сервиса {#managed-spark-metrics}

### Метрики драйверов {#managed-spark-drivers-metrics}

Нативные метрики {{ SPRK }} для [мониторинга драйверов](https://spark.apache.org/docs/latest/monitoring.html#component-instance--driver).

Для метрик применяются дополнительные метки:

* `pod_name` — может принимать значение идентификатора контейнера;
* `job_id` — может принимать значение идентификатора задания.

#|
|| **Имя**

**Тип** ||
|| `driver_appstatus_jobduration_number.value`

`DGAUGE` ||
|| `driver_appstatus_jobduration_value.value`

`DGAUGE` ||
|| `driver_appstatus_jobs_failedjobs_count.value`

`DGAUGE` ||
|| `driver_appstatus_jobs_succeededjobs_count.value`

`DGAUGE` ||
|| `driver_appstatus_stages_completedstages_count.value`

`DGAUGE` ||
|| `driver_appstatus_stages_failedstages_count.value`

`DGAUGE` ||
|| `driver_appstatus_stages_skippedstages_count.value`

`DGAUGE` ||
|| `driver_appstatus_tasks_blacklistedexecutors_count.value`

`DGAUGE` ||
|| `driver_appstatus_tasks_completedtasks_count.value`

`DGAUGE` ||
|| `driver_appstatus_tasks_excludedexecutors_count.value`

`DGAUGE` ||
|| `driver_appstatus_tasks_failedtasks_count.value`

`DGAUGE` ||
|| `driver_appstatus_tasks_killedtasks_count.value`

`DGAUGE` ||
|| `driver_appstatus_tasks_skippedtasks_count.value`

`DGAUGE` ||
|| `driver_appstatus_tasks_unblacklistedexecutors_count.value`

`DGAUGE` ||
|| `driver_appstatus_tasks_unexcludedexecutors_count.value`

`DGAUGE` ||
|| `driver_dagscheduler_job_activejobs_number.value`

`DGAUGE` ||
|| `driver_dagscheduler_job_activejobs_value.value`

`DGAUGE` ||
|| `driver_dagscheduler_job_alljobs_number.value``DGAUGE` ||
|| `driver_dagscheduler_job_alljobs_value.value``DGAUGE` ||
|| `driver_dagscheduler_stage_failedstages_number.value`

`DGAUGE` ||
|| `driver_dagscheduler_stage_failedstages_value.value`

`DGAUGE` ||
|| `driver_dagscheduler_stage_runningstages_number.value`

`DGAUGE` ||
|| `driver_dagscheduler_stage_runningstages_value.value`

`DGAUGE` ||
|| `driver_dagscheduler_stage_waitingstages_number.value`

`DGAUGE` ||
|| `driver_dagscheduler_stage_waitingstages_value.value`

`DGAUGE` ||
|#

### Метрики исполнителей {#managed-spark-executors-metrics}

Нативные метрики {{ SPRK }} для [мониторинга исполнителей](https://spark.apache.org/docs/latest/monitoring.html#component-instance--executor).

Для метрик применяются дополнительные метки:

* `pod_name` — может принимать значение идентификатора контейнера;
* `job_id` — может принимать значение идентификатора задания;
* `executor_id` — может принимать значение `driver`;
* `application_id` — может принимать значение идентификатора Spark-приложения;
* `application_name` — может принимать значение имени Spark-приложения.

#|
|| **Имя**

**Тип** ||
|| `executor_activetasks.value`

`DGAUGE` ||
|| `executor_completedtasks_total.value`

`DGAUGE` ||
|| `executor_failedtasks_total.value`

`DGAUGE` ||
|| `executor_directpoolmemory_bytes.value`

`DGAUGE` ||
|| `executor_diskused_bytes.value`

`DGAUGE` ||
|| `executor_jvmheapmemory_bytes.value`

`DGAUGE` ||
|| `executor_jvmoffheapmemory_bytes.value`

`DGAUGE` ||
|| `executor_majorgccount_total.value`

`DGAUGE` ||
|| `executor_majorgctime_seconds_total.value`

`DGAUGE` ||
|| `executor_mappedpoolmemory_bytes.value`

`DGAUGE` ||
|| `executor_maxmemory_bytes.value`

`DGAUGE` ||
|| `executor_maxtasks.value`

`DGAUGE` ||
|| `executor_memoryused_bytes.value`

`DGAUGE` ||
|| `executor_minorgccount_total.value`

`DGAUGE` ||
|| `executor_minorgctime_seconds_total.value`

`DGAUGE` ||
|| `executor_offheapexecutionmemory_bytes.value`

`DGAUGE` ||
|| `executor_offheapstoragememory_bytes.value`

`DGAUGE` ||
|| `executor_offheapunifiedmemory_bytes.value`

`DGAUGE` ||
|| `executor_onheapexecutionmemory_bytes.value`

`DGAUGE` ||
|| `executor_onheapstoragememory_bytes.value`

`DGAUGE` ||
|| `executor_onheapunifiedmemory_bytes.value`

`DGAUGE` ||
|| `executor_processtreejvmrssmemory_bytes.value`

`DGAUGE` ||
|| `executor_processtreejvmvmemory_bytes.value`

`DGAUGE` ||
|| `executor_processtreeotherrssmemory_bytes.value`

`DGAUGE` ||
|| `executor_processtreeothervmemory_bytes.value`

`DGAUGE` ||
|| `executor_processtreepythonrssmemory_bytes.value`

`DGAUGE` ||
|| `executor_processtreepythonvmemory_bytes.value`

`DGAUGE` ||
|| `executor_rddblocks.value`

`DGAUGE` ||
|| `executor_totalcores.value`

`DGAUGE` ||
|| `executor_totalduration_seconds_total.value`

`DGAUGE` ||
|| `executor_totalgctime_seconds_total.value`

`DGAUGE` ||
|| `executor_totalinputbytes_bytes_total.value`

`DGAUGE` ||
|| `executor_totaloffheapstoragememory_bytes.value`

`DGAUGE` ||
|| `executor_totalonheapstoragememory_bytes.value`

`DGAUGE` ||
|| `executor_totalshuffleread_bytes_total.value`

`DGAUGE` ||
|| `executor_totalshufflewrite_bytes_total.value`

`DGAUGE` ||
|| `executor_totaltasks_total.value`

`DGAUGE` ||
|| `executor_usedoffheapstoragememory_bytes.value`

`DGAUGE` ||
|| `executor_usedonheapstoragememory_bytes.value`

`DGAUGE` ||
|#
