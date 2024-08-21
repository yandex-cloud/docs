The metric name is written to the `name` label.

Common labels for all {{ maf-name }} metrics:

| Label | Value |
----|----
| service | Service ID: `managed-airflow` |
| cluster_id | [Cluster](../../../managed-airflow/concepts/index.md#cluster) ID |

Service metrics:

| Name<br/>Type, units | Description<br/>Labels |
----|----
| `airflow.dag_processing.file_path_queue_size_value`<br/>`GAUGE,` number | Number of DAG files that will be considered in the next scan. |
| `airflow.dag_processing.file_path_queue_update_count.value`<br/>`COUNTER,` number | Number of times the file system was scanned and all existing DAGs were added to the queue. |
| `airflow.dag_processing.import_errors.value`<br/>`GAUGE,` number | Number of errors when trying to parse DAG files. |
| `airflow.dag_processing.total_parse_time.value`<br/>`GAUGE,` seconds | The time it took to scan and import all DAG files that will be included in the next scan. |
| `airflow.dagbag_size.value`<br/>`GAUGE,` number | Number of DAG files found in the last DAGBag scan by scheduler configuration. |
| `airflow.dataset.orphaned.value`<br/>`GAUGE,` number | Number of datasets that were marked as orphans because they no longer link to DAG schedule parameters or task outputs. |
| `airflow.job_start.value`<br/>`COUNTER`, number | Number of runs of different types of tasks such as `SchedulerJob`, `LocalTaskJob`, etc. |
| `airflow.pool.deferred_slots.default_pool.value`<br/>`GAUGE,` number | Number of deferred slots in default pools. |
| `airflow.pool.deferred_slots.value`<br/>`GAUGE,` number | Number of deferred slots in all pools.<br/> `pool_name` label: Pool name. |
| `airflow.pool.open_slots.default_pool.value`<br/>`GAUGE,` number | Number of open slots in default pools. |
| `airflow.pool.open_slots.value`<br/>`GAUGE,` number | Number of open slots in all pools.<br/> `pool_name` label: Pool name. |
| `airflow.pool.queued_slots.default_pool.value`<br/>`GAUGE,` number | Number of queued slots in default pools. |
| `airflow.pool.queued_slots.value`<br/>`GAUGE,` number | Number of queued slots in all pools.<br/> `pool_name` label: Pool name. |
| `airflow.pool.running_slots.default_pool.value`<br/>`GAUGE,` number | Number of running slots in default pools. |
| `airflow.pool.running_slots.value`<br/>`GAUGE,` number | Number of running slots in all pools.<br/> `pool_name` label: Pool name. |
| `airflow.scheduler.critical_section_duration.50_percentile`<br/>`TIMING,` milliseconds | Time spent on the critical section of the scheduler loop^1^. 0.5 percentile. |
| `airflow.scheduler.critical_section_duration.95_percentile`<br/>`TIMING,` milliseconds | Time spent on the critical section of the scheduler loop^1^. 0.95 percentile. |
| `airflow.scheduler.critical_section_duration.99_percentile`<br/>`TIMING,` milliseconds | Time spent on the critical section of the scheduler loop^1^. 0.99 percentile. |
| `airflow.scheduler.critical_section_duration.count`<br/>`TIMING,` number | Number of measurements of time spent on the critical section of the scheduler loop^1^. |
| `airflow.scheduler.critical_section_duration.lower`<br/>`TIMING,` milliseconds | Minimum time spent on the critical section of the scheduler loop^1^. |
| `airflow.scheduler.critical_section_duration.mean`<br/>`TIMING,` milliseconds | Average time spent on the critical section of the scheduler loop^1^. |
| `airflow.scheduler.critical_section_duration.median`<br/>`TIMING,` milliseconds | Median time spent on the critical section of the scheduler loop^1^. |
| `airflow.scheduler.critical_section_duration.stddev`<br/>`TIMING,` milliseconds | Standard deviation of time spent on the critical section of the scheduler loop^1^. |
| `airflow.scheduler.critical_section_duration.sum`<br/>`TIMING,` milliseconds | Total time spent on the critical section of the scheduler loop^1^. |
| `airflow.scheduler.critical_section_duration.upper`<br/>`TIMING,` milliseconds | Maximum time spent on the critical section of the scheduler loop^1^. |
| `airflow.scheduler.critical_section_query_duration.50_percentile`<br/>`TIMING,` milliseconds | Time spent to execute a query in the critical section^1^. 0.5 percentile. |
| `airflow.scheduler.critical_section_query_duration.95_percentile`<br/>`TIMING,` milliseconds | Time spent to execute a query in the critical section^1^. 0.95 percentile. |
| `airflow.scheduler.critical_section_query_duration.99_percentile`<br/>`TIMING,` milliseconds | Time spent to execute a query in the critical section^1^. 0.99 percentile. |
| `airflow.scheduler.critical_section_query_duration.count`<br/>`TIMING,` number | Number of measurements of the time spent to execute a query in the critical section^1^. |
| `airflow.scheduler.critical_section_query_duration.lower`<br/>`TIMING,` milliseconds | Minimum time spent to execute a query in the critical section^1^. |
| `airflow.scheduler.critical_section_query_duration.mean`<br/>`TIMING,` milliseconds | Average time spent to execute a query in the critical section^1^. |
| `airflow.scheduler.critical_section_query_duration.median`<br/>`TIMING,` milliseconds | Median time spent to execute a query in the critical section^1^. |
| `airflow.scheduler.critical_section_query_duration.stddev`<br/>`TIMING,` milliseconds | Standard deviation of the time spent to execute a query in the critical section^1^. |
| `airflow.scheduler.critical_section_query_duration.sum`<br/>`TIMING,` milliseconds | Total time spent to execute a query in the critical section^1^. |
| `airflow.scheduler.critical_section_query_duration.upper`<br/>`TIMING,` milliseconds | Maximum time spent to execute a query in the critical section^1^. |
| `airflow.scheduler.heartbeat.value`<br/>`COUNTER,` number | Number of heartbeat messages from the scheduler indicating its activity. |
| `airflow.scheduler.load_serializers.50_percentile`<br/>`TIMING,` milliseconds | Time spent serializing data in the scheduler^2^. 0.5 percentile. |
| `airflow.scheduler.load_serializers.95_percentile`<br/>`TIMING,` milliseconds | Time spent serializing data in the scheduler^2^. 0.95 percentile. |
| `airflow.scheduler.load_serializers.99_percentile`<br/>`TIMING,` milliseconds | Time spent serializing data in the scheduler^2^. 0.99 percentile. |
| `airflow.scheduler.load_serializers.count`<br/>`TIMING,` number | Number of measurements of time spent serializing data in the scheduler^2^. |
| `airflow.scheduler.load_serializers.lower`<br/>`TIMING,` milliseconds | Minimum time spent serializing data in the scheduler^2^. |
| `airflow.scheduler.load_serializers.mean`<br/>`TIMING,` milliseconds | Average time spent serializing data in the scheduler^2^. |
| `airflow.scheduler.load_serializers.median`<br/>`TIMING,` milliseconds | Median time spent serializing data in the scheduler^2^. |
| `airflow.scheduler.load_serializers.stddev`<br/>`TIMING,` milliseconds | Standard deviation of time spent serializing data in the scheduler^2^. |
| `airflow.scheduler.load_serializers.sum`<br/>`TIMING,` milliseconds | Total time spent serializing data in the scheduler^2^. |
| `airflow.scheduler.load_serializers.upper`<br/>`TIMING,` milliseconds | Maximum time spent serializing data in the scheduler^2^. |
| `airflow.scheduler.orphaned_tasks.adopted.value`<br/>`COUNTER,` number | Number of tasks adopted by the scheduler that were marked as orphans. |
| `airflow.scheduler.orphaned_tasks.cleared.value`<br/>`COUNTER,` number | Number of tasks cleared by the scheduler that were marked as orphans. |
| `airflow.scheduler.scheduler_loop_duration.50_percentile`<br/>`TIMING,` milliseconds | Time spent to execute one scheduler loop. 0.5 percentile. |
| `airflow.scheduler.scheduler_loop_duration.95_percentile`<br/>`TIMING,` milliseconds | Time spent to execute one scheduler loop. 0.95 percentile. |
| `airflow.scheduler.scheduler_loop_duration.99_percentile`<br/>`TIMING,` milliseconds | Time spent to execute one scheduler loop. 0.99 percentile. |
| `airflow.scheduler.scheduler_loop_duration.count`<br/>`TIMING,` number | Number of measurements of time spent to execute one scheduler loop. |
| `airflow.scheduler.scheduler_loop_duration.lower`<br/>`TIMING,` milliseconds | Minimum time spent to execute one scheduler loop. |
| `airflow.scheduler.scheduler_loop_duration.mean`<br/>`TIMING,` milliseconds | Average time spent to execute one scheduler loop. |
| `airflow.scheduler.scheduler_loop_duration.median`<br/>`TIMING,` milliseconds | Median time spent to execute one scheduler loop. |
| `airflow.scheduler.scheduler_loop_duration.stddev`<br/>`TIMING,` milliseconds | Standard deviation of time spent to execute one scheduler loop. |
| `airflow.scheduler.scheduler_loop_duration.sum`<br/>`TIMING,` milliseconds | Total time spent to execute one scheduler loop. |
| `airflow.scheduler.scheduler_loop_duration.upper`<br/>`TIMING,` milliseconds | Total time spent to execute one scheduler loop. |
| `airflow.scheduler.tasks.executable.value`<br/>`GAUGE,` number | Number of tasks ready to run according to pool limitations, DAG competitiveness, executor state, and priorities. |
| `airflow.scheduler.tasks.starving.value`<br/>`GAUGE,` number | Number of tasks that cannot be scheduled because there is no free slot in the pool. |
| `CeleryExecutor`<br/>`GAUGE,` number | Number of [Celery](https://docs.celeryq.dev/en/main/index.html) workers at different stages of task execution.<br/>The `status` label value means the number of workers that:<ul><li>`open`: Are ready to receive a task.</li><li>`queued`: Have received tasks but have not yet started executing them.</li><li>`running`: Are executing tasks.</li></ul> |

^1^ Only one scheduler can enter this loop at a time.
^2^ Data serialization process for exchange between tasks and for web server and scheduler security.