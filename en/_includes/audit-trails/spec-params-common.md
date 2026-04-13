* `destination`: Settings of the selected destination the audit logs will be uploaded to.

    {% note warning %}

    Destination settings are mutually exclusive. Using some settings makes it impossible to use others.

    {% endnote %}

    * `object_storage`: Uploading logs to a {{ objstorage-full-name }} [bucket](../../storage/concepts/bucket.md#naming):

        * `bucket_id`: [Bucket](../../storage/concepts/bucket.md#naming) name.

            You can request the name of the bucket with the list of buckets in the folder (the default folder is used):

            ```bash
            yc storage bucket list
            ```
        * `object_prefix`: [Prefix](../../storage/concepts/object.md#folder) that will be assigned to the objects with audit logs in the bucket. It is an optional parameter used in the [full name](../../audit-trails/concepts/format.md#log-file-name) of the audit log file.

            {% include [note-bucket-prefix](../../_includes/audit-trails/note-bucket-prefix.md) %}

    * `cloud_logging`: Uploading logs to a {{ cloud-logging-full-name }} [group](../../logging/concepts/log-group.md).

        Specify the log group ID in the `log_group_id` parameter. You can request the ID with the [list of log groups in the folder](../../logging/operations/list.md).
    * `data_stream`: Uploading logs to a [data stream](../../data-streams/concepts/glossary.md#stream-concepts) in {{ yds-full-name }}:

        * `stream_name`: Stream name. You can request the name with the [list of data streams in the folder](../../data-streams/operations/manage-streams.md#list-data-streams).
        * `database_id`: ID of the {{ ydb-short-name }} database used by {{ yds-name }}. You can request the ID with the [list of {{ ydb-short-name }} databases in the folder](../../ydb/operations/manage-databases.md#list-db).
* `service_account_id`: Service account [ID](../../iam/operations/sa/get-id.md).