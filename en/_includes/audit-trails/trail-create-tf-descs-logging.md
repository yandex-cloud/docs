{% note warning %}

You can only specify one destination from the following: `storage_destination`, `logging_destination`, or `data_stream_destination`.

{% endnote %}

* `logging_destination`: Upload logs to a {{ cloud-logging-name }} group.
    * `log_group_id`: [ID of the log group](../../logging/operations/get-group.md) for the trail to save audit logs to.
* `storage_destination`: Uploading logs to the {{ objstorage-name }} bucket:
    * `log_group_id`: Name of the bucket for the trail to save audit logs to.
    * `object_prefix`: [Prefix](../../storage/concepts/object.md#folder) that will be assigned to the objects with audit logs in the bucket. It is an optional parameter used in the [full name](../../audit-trails/concepts/format.md#log-file-name) of the audit log file.

        {% include [note-bucket-prefix](note-bucket-prefix.md) %}

* `data_stream_destination`: Upload logs to a {{ yds-name }} data stream:
    * `stream_name`: Name of the data stream for the trail to save audit logs to.
    * `database_id`: ID of the {{ ydb-short-name }} database used by {{ yds-name }}.
