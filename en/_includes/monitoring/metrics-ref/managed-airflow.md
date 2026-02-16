The `name` label contains the metric name.

Labels shared by all {{ maf-name }} metrics:

Label | Value
----|----
service | Service ID: `managed-airflow`
cluster_id | [Cluster](../../../managed-airflow/concepts/index.md#cluster) ID

Service metrics:

Name<br/>Type, units | Description<br/>Labels
----|----
`airflow.dag_processing.file_path_queue_size_value`<br/>`GAUGE`, count | Number of DAG files to include in the next scan
`airflow.dag_processing.file_path_queue_update_count.value`<br/>`COUNTER`, count | Number of file system scans that resulted in all existing DAGs being enqueued.
`airflow.dag_processing.import_errors.value`<br/>`GAUGE`, count | Number of DAG file parsing errors
`airflow.dag_processing.total_parse_time.value`<br/>`GAUGE`, seconds | Time taken to scan and import all DAG files to include the next scan
`airflow.dagbag_size.value`<br/>`GAUGE`, count | Number of DAG files found in the latest DAGBag scan based on scheduler configuration
`airflow.dataset.orphaned.value`<br/>`GAUGE`, count | Number of datasets labeled as orphans since they are no longer linked to DAG schedule parameters or task outputs.
`airflow.job_start.value`<br/>`COUNTER`, count | Number of runs of different types of tasks, such as `SchedulerJob`, `LocalTaskJob`, etc.
`airflow.pool.deferred_slots.default_pool.value`<br/>`GAUGE`, count | Number of deferred slots in default pools
`airflow.pool.deferred_slots.value`<br/>`GAUGE`, count | Number of deferred slots in all pools.<br/>This metric features the `pool_name` label containing the pool name.
`airflow.pool.open_slots.default_pool.value`<br/>`GAUGE`, count | Number of open slots in default pools
`airflow.pool.open_slots.value`<br/>`GAUGE`, count | Number of open slots in all pools.<br/>This metric features the `pool_name` label containing the pool name.
`airflow.pool.queued_slots.default_pool.value`<br/>`GAUGE`, count | Number of queued slots in default pools
`airflow.pool.queued_slots.value`<br/>`GAUGE`, count | Number of queued slots in all pools.<br/>This metric features the `pool_name` label containing the pool name.
`airflow.pool.running_slots.default_pool.value`<br/>`GAUGE`, count | Number of running slots in default pools
`airflow.pool.running_slots.value`<br/>`GAUGE`, count | Number of running slots in all pools.<br/>This metric features the `pool_name` label containing the pool name.
`airflow.scheduler.critical_section_duration.50_percentile`<br/>`TIMING`, milliseconds | Time spent on the critical section of the scheduler loop^1^, 50th percentile
`airflow.scheduler.critical_section_duration.95_percentile`<br/>`TIMING`, milliseconds | Time spent on the critical section of the scheduler loop^1^, 95th percentile
`airflow.scheduler.critical_section_duration.99_percentile`<br/>`TIMING`, milliseconds | Time spent on the critical section of the scheduler loop^1^, 99th percentile
`airflow.scheduler.critical_section_duration.count`<br/>`TIMING`, count | Number of time measurements for the critical section of the scheduler loop^1^
`airflow.scheduler.critical_section_duration.lower`<br/>`TIMING`, milliseconds | Minimum time spent on the critical section of the scheduler loop^1^
`airflow.scheduler.critical_section_duration.mean`<br/>`TIMING`, milliseconds | Average time spent on the critical section of the scheduler loop^1^
`airflow.scheduler.critical_section_duration.median`<br/>`TIMING`, milliseconds | Median time spent on the critical section of the scheduler loop^1^
`airflow.scheduler.critical_section_duration.stddev`<br/>`TIMING`, milliseconds | Standard deviation of the time spent on the critical section of the scheduler loop^1^
`airflow.scheduler.critical_section_duration.sum`<br/>`TIMING`, milliseconds | Total time spent on the critical section of the scheduler loop^1^
`airflow.scheduler.critical_section_duration.upper`<br/>`TIMING`, milliseconds | Maximum time spent on the critical section of the scheduler loop^1^
`airflow.scheduler.critical_section_query_duration.50_percentile`<br/>`TIMING`, milliseconds | Time spent running a query in the critical section^1^, 50th percentile
`airflow.scheduler.critical_section_query_duration.95_percentile`<br/>`TIMING`, milliseconds | Time spent running a query in the critical section^1^, 95th percentile
`airflow.scheduler.critical_section_query_duration.99_percentile`<br/>`TIMING`, milliseconds | Time spent running a query in the critical section^1^, 99th percentile
`airflow.scheduler.critical_section_query_duration.count`<br/>`TIMING`, count | Number of query run time measurements in the critical section^1^
`airflow.scheduler.critical_section_query_duration.lower`<br/>`TIMING`, milliseconds | Minimum time spent running a query in the critical section^1^
`airflow.scheduler.critical_section_query_duration.mean`<br/>`TIMING`, milliseconds | Average time spent running a query in the critical section^1^
`airflow.scheduler.critical_section_query_duration.median`<br/>`TIMING`, milliseconds | Median time spent running a query in the critical section^1^
`airflow.scheduler.critical_section_query_duration.stddev`<br/>`TIMING`, milliseconds | Standard deviation of the time spent running a query in the critical section^1^
`airflow.scheduler.critical_section_query_duration.sum`<br/>`TIMING`, milliseconds | Total time spent running a query in the critical section^1^
`airflow.scheduler.critical_section_query_duration.upper`<br/>`TIMING`, milliseconds | Maximum time spent running a query in the critical section^1^
`airflow.scheduler.heartbeat.value`<br/>`COUNTER`, count | Number of heartbeat messages from the scheduler indicating its active state
`airflow.scheduler.load_serializers.50_percentile`<br/>`TIMING`, milliseconds | Time spent serializing data in the scheduler^2^, 50th percentile
`airflow.scheduler.load_serializers.95_percentile`<br/>`TIMING`, milliseconds | Time spent serializing data in the scheduler^2^, 95th percentile
`airflow.scheduler.load_serializers.99_percentile`<br/>`TIMING`, milliseconds | Time spent serializing data in the scheduler^2^, 99th percentile
`airflow.scheduler.load_serializers.count`<br/>`TIMING`, count | Number of time measurements for data serialization in the scheduler^2^
`airflow.scheduler.load_serializers.lower`<br/>`TIMING`, milliseconds | Minimum time spent serializing data in the scheduler^2^
`airflow.scheduler.load_serializers.mean`<br/>`TIMING`, milliseconds | Average time spent serializing data in the scheduler^2^
`airflow.scheduler.load_serializers.median`<br/>`TIMING`, milliseconds | Median time spent serializing data in the scheduler^2^
`airflow.scheduler.load_serializers.stddev`<br/>`TIMING`, milliseconds | Standard deviation of the time spent serializing data in the scheduler^2^
`airflow.scheduler.load_serializers.sum`<br/>`TIMING`, milliseconds | Total time spent serializing data in the scheduler^2^
`airflow.scheduler.load_serializers.upper`<br/>`TIMING`, milliseconds | Maximum time spent serializing data in the scheduler^2^
`airflow.scheduler.orphaned_tasks.adopted.value`<br/>`COUNTER`, count | Number of tasks adopted by the scheduler that were marked as orphans.
`airflow.scheduler.orphaned_tasks.cleared.value`<br/>`COUNTER`, count | Number of tasks cleared by the scheduler that were marked as orphans.
`airflow.scheduler.scheduler_loop_duration.50_percentile`<br/>`TIMING`, milliseconds | Time spent running one scheduler loop, 50th percentile
`airflow.scheduler.scheduler_loop_duration.95_percentile`<br/>`TIMING`, milliseconds | Time spent running one scheduler loop, 95th percentile
`airflow.scheduler.scheduler_loop_duration.99_percentile`<br/>`TIMING`, milliseconds | Time spent running one scheduler loop, 99th percentile
`airflow.scheduler.scheduler_loop_duration.count`<br/>`TIMING`, count | Number of time measurements for one scheduler loop
`airflow.scheduler.scheduler_loop_duration.lower`<br/>`TIMING`, milliseconds | Minimum time spent running one scheduler loop
`airflow.scheduler.scheduler_loop_duration.mean`<br/>`TIMING`, milliseconds | Average time spent running one scheduler loop
`airflow.scheduler.scheduler_loop_duration.median`<br/>`TIMING`, milliseconds | Median time spent running one scheduler loop
`airflow.scheduler.scheduler_loop_duration.stddev`<br/>`TIMING`, milliseconds | Standard deviation of time spent running one scheduler loop
`airflow.scheduler.scheduler_loop_duration.sum`<br/>`TIMING`, milliseconds | Total time spent running one scheduler loop
`airflow.scheduler.scheduler_loop_duration.upper`<br/>`TIMING`, milliseconds | Maximum time spent running one scheduler loop
`airflow.scheduler.tasks.executable.value`<br/>`GAUGE`, count | Number of tasks that are ready to run based on pool limitations, DAG concurrency, worker status, and priority levels.
`airflow.scheduler.tasks.starving.value`<br/>`GAUGE`, count | Number of tasks that cannot be scheduled due to no free slots in the pool.
`CeleryExecutor`<br/>`GAUGE`, count | Number of [Celery](https://docs.celeryq.dev/en/main/index.html) workers at different task running stages.<br/>The `status` label value means the number of workers with the following statuses:<ul><li>`open`: Workers ready to take on tasks.</li><li>`queued`: Workers with tasks in queue but not yet running.</li><li>`running`: Workers running tasks.</li></ul>

^1^ Only a single scheduler can enter this loop at a time.
^2^ Data serialization for exchange between tasks and for web server and scheduler security.