# Log metrics

To ensure log delivery is controllable and measurable, {{ monium-name }}. Logs publishes a set of standard metrics for each project. These metrics are available in all projects receiving logs, regardless of the delivery method.

Using these metrics, you can estimate the volume of incoming logs (by service and cluster), delivery lag, and the number of `ERROR` log entries (both across the entire project and per service).

The metrics are aggregated into a service dashboard named **Logs overview**:
* Dashboard is created automatically in a project once logs start being written to the system.
* Dashboard is available at level of the folder storing the logs.
* Metrics do not have the `host` or `user_cluster` labels.
* `user_service` label indicates the log group the metrics are calculated for.

To open the service log dashboard:

1. Go to [{{ monium-name }}]({{ link-monium }}) → **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}**.
1. Select the **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}** tab.
1. Find and select **Logs overview** from the list.

## Dashboard description {#dashboards}

* **Top services by logs**: Top services by the number of sent logs. Use this dashboard to identify services generating the largest number of entries.
* **Top services by traffic**: Top services by traffic amount in bytes. This dashboard shows which services contribute most to system load based on data size.
* **Top services by bytes per log record**: Top services by average log entry size in bytes. This dashboard helps you identify services with excessively large entries.
* **Invalidated logs**: Number of logs that failed validation. The dashboard displays entries rejected due to invalid format or contents.
* **Failed quota checks**: Number of requests rejected due to exceeding quotas. This dashboard highlights instances of exceeding the project's log or byte limits.
* **Failed authentications**: Number of unsuccessful authorization attempts. This dashboard displays all unauthenticated requests.
* **Attributes kind: Rows with dropped labels**: Number of rows where labels were dropped or moved to metadata. The dashboard shows entries with `labels.`-prefixed attributes that cannot be stored as labels.
* **Severity**: Log distribution by severity levels:
  * **Count info logs for services**: Number of INFO-level logs produced by each service.
  * **Count warn logs for services**: Number of warnings per service.
  * **Count error logs for services**: Number of errors per service.
* **Latencies: Average latencies of write logs from service**: Average service log writing delay. The dashboard shows the time between log generation by the application and system write.

## Metric descriptions {#metrics}

### ingest_processed_logs {#ingest-processed-logs}

Metric tracking logs per second successfully authorized, validated, and about to be written to the database (logs may also remain unprocessed if the user-sent volume exceeds the log quota).

Labels:
* `user_cluster`: Cluster the logs came from (use `total` to view the total across all clusters).
* `user_service`: Service the logs came from (use `total` to view the total across all services).
* `host`: Host the logs came from (use `cluster` to calculate the total across all data centers or select a specific data center).

### ingest_processed_bytes {#ingest-processed-bytes}

Metric tracking bytes in logs per second successfully authorized, validated, and about to be written to the database (logs may also remain unprocessed if the user-sent bytes exceed the byte quota).

Labels:
* `user_cluster`: Cluster the logs came from (use `total` to view the total across all clusters).
* `user_service`: Service the logs came from (use `total` to view the total across all services).
* `host`: Host the logs came from (use `cluster` to calculate the total across all data centers or select a specific data center).

### logsvalidator_invalidated_logs {#logsvalidator}

Metric tracking logs per second that failed validation.

Labels:
* `user_cluster`: Cluster the logs came from (use `total` to view the total across all clusters).
* `user_service`: Service the logs came from (use `total` to view the total across all services).
* `host`: Host the logs came from (use `cluster` to calculate the total across all data centers or select a specific data center).
* `reason`: Reason why the log failed [validation](write/converting-data.md).

#### Validation errors {#logsvalidator-transcript}

* `res.attrs.project`: Project not specified.
* `res.attrs.service`: Service not specified.
* `res.attrs.invalid`: Resource-level attributes failed [validation](write/converting-data.md).
* `scope.name`: Scope name is 0 or more than 200 characters long or contains non-unicode characters.
* `scope.attrs.invalid`: Attributes failed [validation](write/converting-data.md).
* `log.attrs.invalid`: Log line attributes failed [validation](write/converting-data.md).
* `log.body.not.string`: Body type is not text.
* `severity.not.match.text`: `severity` does not match the severity text name (`severityText`).
* `severity.0.text.not.empty`: `severity = 0` with `severityText` specified.
* `severity.not.in.range`: Log `severity` is less than 1 (`Trace`) or greater than 24 (`FATAL 4`).
* `ts.invalid`: Log `timestamp` is more than 5 minutes ahead of the current time.
* `observed.ts.invalid`: Log `observed timestamp` is more than 5 minutes ahead of current time.
* `log.component.both.levels`: Component specified at both scope and log levels.

### severity_logs_user_ts {#severity-logs-user-ts}

Metric tracking log volume broken down by log severity (`Level`). This metric’s timestamp derives from the log line’s timestamp and not the data write or send times.

Labels:
* `user_cluster`: Cluster the logs came from (use `total` to view the total across all clusters).
* `user_service`: Service the logs came from (use `total` to view the total across all services).
* `host`: Host the logs came from (use `cluster` to calculate the total across all data centers or select a specific data center).
* `severity`: Log `level` (`Error`, `Warn`, or `Info`).

### receiver_auth_processed_logs {#receiver-auth-processed-logs}

This metric tracks user-sent logs per second prior to all system checks (authorization, validation, or quota checks).

Labels:
* `user_cluster`: Cluster the logs came from (use `total` to view the total across all clusters).
* `user_service`: Service the logs came from (use `total` to view the total across all services).
* `host`: Host the logs came from (use `cluster` to calculate the total across all data centers or select a specific data center).

### receiver_auth_processed_logs_bytes {#receiver-auth-processed-logs-bytes}

Metric for the number of user-sent logs in bytes per second before authorization, validation, and quota limit checks if exceeded.

Labels:
* `user_cluster`: Cluster the logs came from (use `total` to view the total across all clusters).
* `user_service`: Service the logs came from (use `total` to view the total across all services).
* `host`: Host the logs came from (use `cluster` to calculate the total across all data centers or select a specific data center).

### receiver_auth_authorizations {#receiver-auth-authorizations}

Metric tracking failed user authorization requests per second.

Labels:
* `user_cluster`: Cluster the logs came from (use `total` to view the total across all clusters).
* `user_service`: Service the logs came from (use `total` to view the total across all services).
* `host`: Host the logs came from (use `cluster` to calculate the total across all data centers or select a specific data center).
* `user_auth_result`: Authorization result (currently, `failure` only).
* `user_auth_kind`: Authorization type.

### lag_from_app_sec {#lag-from-app-sec}

Histogram tracking time between sending logs by the application and writing them.

Labels:
* `user_cluster`: Cluster the logs came from (use `total` to view the total across all clusters).
* `user_service`: Service the logs came from (use `total` to view the total across all services).
* `host`: Host the logs came from (use `cluster` to calculate the total across all data centers or select a specific data center).
* `bin`: Buckets in seconds (1, 30, 50, 60, 90, 120, 300, 900, or _inf_).

### lag_from_agent_sec {#lag-from-agent-sec}

Histogram tracking time between sending logs by the agent and writing them.

Labels:
* `user_cluster`: Cluster the logs came from (use `total` to view the total across all clusters).
* `user_service`: Service the logs came from (use `total` to view the total across all services).
* `host`: Host the logs came from (use `cluster` to calculate the total across all data centers or select a specific data center).
* `bin`: Buckets in seconds (1, 5, 60, 90, 300, inf).

### project_logs_quota {#project-logs-quota}

Metric tracking your project’s log line quota.

Labels:
* `host`: Set to `quota`.

### project_bytes_logs_quota {#project-bytes-logs-quota}

Metric tracking your project’s byte-per-second quota.

Labels:
* `host`: Set to `quota`.

### ingest_dropped_labels_count {#ingest-dropped-labels-count}

Metric tracking log lines per second in which the attribute prefixed with `labels.` was either written to metadata or discarded.

Labels:
* `user_cluster`: Cluster the logs came from (use `total` to view the total across all clusters).
* `user_service`: Service the logs came from (use `total` to view the total across all services).
* `host`: Host the logs came from (use `cluster` to calculate the total across all data centers or select a specific data center).