
* `destination.data_stream`: Structure describing the target {{ yds-full-name }} [data stream](../../logging/operations/get-group.md).

   * `database_id`: ID of the {{ ydb-short-name }} database used by the {{ yds-name }} data stream. You can get the database ID in the [management console]({{ link-console-main }}) or using the `yc ydb database list` CLI command.
   * `stream_name`: {{ yds-name }} data stream name.
