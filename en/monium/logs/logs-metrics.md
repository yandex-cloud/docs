# Log metrics

{{ monium-logs-name }} publishes a set of standard metrics for each project, regardless of the log delivery method.

Using these metrics, you can estimate log volume by service and cluster, delivery lag, and the number of `ERROR` log entries for the entire project and per service.

The metrics are aggregated into a service dashboard named **Logs overview**:
* Dashboard is created automatically in a project once logs start being written to the system.
* Dashboard is available at level of the folder storing the logs.
* Metrics do not have the `host` or `user_cluster` labels.
* `user_service` label indicates the log group the metrics are calculated for.

## Viewing the dashboard with log metrics {view-logs-dashboard}

{% list tabs group=instructions %}

- {{ monium-name }} UI {#console}

  1. On the [{{ monium-name }}]({{ link-monium }}) home page, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}** on the left.
  1. Navigate to the **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}** tab.
  1. Find and select **Logs overview** from the list.

{% endlist %}

## Description of dashboard charts {#dashboards}

* **Top services by logs**: Services by the number of sent logs. Use it to identify services generating the largest number of entries.
* **Top services by traffic**: Services by traffic amount in bytes. It shows which services are creating the largest load in terms of data size.
* **Top services by bytes per log record**: Services by average log entry size. It helps you identify services with excessively large entries.
* **Invalidated logs**: Logs that failed validation as non-compliant with format requirements.
* **Failed quota checks**: Requests rejected due to exceeding project quotas.
* **Failed authentications**: Failed authorization attempts.
* **Attributes kind: Rows with dropped labels**: Rows with attributes prefixed with `labels.` that are discarded or moved to metadata.
* **Severity**: Log distribution by severity levels:
  * **Count info logs for services**: Number of INFO-level logs produced by each service.
  * **Count warn logs for services**: Number of warnings per service.
  * **Count error logs for services**: Number of errors per service.
* **Latencies: Average latencies of write logs from service**: Time between sending the log by the application and writing it to the system.

## Description of metrics {#metrics}

### ingest_processed_logs {#ingest-processed-logs}

Number of authorized and validated logs per second. If the number of logs exceeds the quota, some logs remain unprocessed.

Labels:
* `user_cluster`: Cluster the logs came from (use `total` to view the total across all clusters).
* `user_service`: Service the logs came from (use `total` to view the total across all services).
* `host`: Host the logs came from (use `cluster` to calculate the total across all data centers or select a specific data center).

### ingest_processed_bytes {#ingest-processed-bytes}

Authorized and validated bytes per second. If the data amount exceeds the quota, some logs remain unprocessed.

Labels:
* `user_cluster`: Cluster the logs came from (use `total` to view the total across all clusters).
* `user_service`: Service the logs came from (use `total` to view the total across all services).
* `host`: Host the logs came from (use `cluster` to calculate the total across all data centers or select a specific data center).

### logsvalidator_invalidated_logs {#logsvalidator}

Number of non-validated logs per second.

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

Number of logs by severity level. This metric uses the time value from the log entry, not the time of the system write.

Labels:
* `user_cluster`: Cluster the logs came from (use `total` to view the total across all clusters).
* `user_service`: Service the logs came from (use `total` to view the total across all services).
* `host`: Host the logs came from (use `cluster` to calculate the total across all data centers or select a specific data center).
* `severity`: Log `level` (`Error`, `Warn`, or `Info`).

### receiver_auth_processed_logs {#receiver-auth-processed-logs}

Number of logs per second prior to authorization, validation, and quota checks.

Labels:
* `user_cluster`: Cluster the logs came from (use `total` to view the total across all clusters).
* `user_service`: Service the logs came from (use `total` to view the total across all services).
* `host`: Host the logs came from (use `cluster` to calculate the total across all data centers or select a specific data center).

### receiver_auth_processed_logs_bytes {#receiver-auth-processed-logs-bytes}

Bytes per second prior to authorization, validation, and quota checks.

Labels:
* `user_cluster`: Cluster the logs came from (use `total` to view the total across all clusters).
* `user_service`: Service the logs came from (use `total` to view the total across all services).
* `host`: Host the logs came from (use `cluster` to calculate the total across all data centers or select a specific data center).

### receiver_auth_authorizations {#receiver-auth-authorizations}

Number of failed authorization attempts per second.

Labels:
* `user_cluster`: Cluster the logs came from (use `total` to view the total across all clusters).
* `user_service`: Service the logs came from (use `total` to view the total across all services).
* `host`: Host the logs came from (use `cluster` to calculate the total across all data centers or select a specific data center).
* `user_auth_result`: Authorization result (currently, `failure` only).
* `user_auth_kind`: Authorization type.

### lag_from_app_sec {#lag-from-app-sec}

Time from when the application sends the log until it is written to the system.

Labels:
* `user_cluster`: Cluster the logs came from (use `total` to view the total across all clusters).
* `user_service`: Service the logs came from (use `total` to view the total across all services).
* `host`: Host the logs came from (use `cluster` to calculate the total across all data centers or select a specific data center).
* `bin`: Buckets in seconds (1, 30, 50, 60, 90, 120, 300, 900, or _inf_).

### lag_from_agent_sec {#lag-from-agent-sec}

Time from when the agent sends the log until it is written to the system.

Labels:
* `user_cluster`: Cluster the logs came from (use `total` to view the total across all clusters).
* `user_service`: Service the logs came from (use `total` to view the total across all services).
* `host`: Host the logs came from (use `cluster` to calculate the total across all data centers or select a specific data center).
* `bin`: Buckets in seconds (1, 5, 60, 90, 300, inf).

### project_logs_quota {#project-logs-quota}

Project quota on log lines.

Labels:
* `host`: Set to `quota`.

### project_bytes_logs_quota {#project-bytes-logs-quota}

Project quota on log size in bytes per second.

Labels:
* `host`: Set to `quota`.

### ingest_dropped_labels_count {#ingest-dropped-labels-count}

Number of lines per second where the attribute prefixed with `labels.` is written to metadata or discarded.

Labels:
* `user_cluster`: Cluster the logs came from (use `total` to view the total across all clusters).
* `user_service`: Service the logs came from (use `total` to view the total across all services).
* `host`: Host the logs came from (use `cluster` to calculate the total across all data centers or select a specific data center).