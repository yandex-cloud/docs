{% note warning %}

Only one destination must be specified: `storage_destination`, `logging_destination`, or `data_stream_destination`.

{% endnote %}

* `logging_destination`: Uploading logs to a {{ cloud-logging-full-name }} [group](../../logging/concepts/log-group.md).

    * `log_group_id`: [ID of the log group](../../logging/operations/get-group.md) for the trail to save audit logs to.
* `storage_destination`: Uploading logs to a {{ objstorage-full-name }} [bucket](../../storage/concepts/bucket.md):

    * `log_group_id`: Name of the bucket for the trail to save audit logs to.
    * `object_prefix`: [Prefix](../../storage/concepts/object.md#folder) that will be assigned to the objects with audit logs in the bucket. It is an optional parameter used in the [full name](../../audit-trails/concepts/format.md#log-file-name) of the audit log file.

        {% include [note-bucket-prefix](note-bucket-prefix.md) %}

* `data_stream_destination`: Uploading logs to a [data stream](../../data-streams/concepts/glossary.md#stream-concepts) in {{ yds-full-name }}:

    * `stream_name`: Name of the data stream for the trail to save audit logs to.
    * `database_id`: ID of the {{ ydb-full-name }} database used by {{ yds-name }}.