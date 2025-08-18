## Audit log format {#log-name}

Depending on the [destination object](../../audit-trails/concepts/trail.md#target) (a bucket or log group), the message used by {{ at-name }} to transmit audit logs has a different structure and content:
* If the destination object is a bucket, the message is a file containing an array of [JSON objects](#scheme) of the audit log.
* If the destination object is a log group, the message includes a single JSON object of the audit log.

### Audit log file in a bucket {#log-file-name}

Below is the template for the full name of an audit log file in a bucket:

`<object_prefix>/<trail_ID>/<year>/<month>/<file_name>.json`

### Log group entry {#logging-group-name}

Log group entries have the following values:
* **Time**: `event_time` value.
* **JSON**: JSON object of the event.
* **Level**: Calculated depending on the `event_status` value:
  * `ERROR`: For the `ERROR` value.
  * `WARN`: For the `CANCELLED` value.
  * `INFO`: In all other cases.
* **{{ ui-key.yacloud.logging.column_header-message }}**: Contains the values of the `event_status`, `event_type`, `subject_name`, `cloud_name`, and `resource_name` fields.

{% include [logging-dublicate-events](../../_includes/audit-trails/logging-dublicate-events.md) %}