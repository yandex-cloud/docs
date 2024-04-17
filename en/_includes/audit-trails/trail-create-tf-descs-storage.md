
* `storage_destination`: Structure describing the target bucket.
   * `bucket_name`: [Name of the bucket](../../storage/concepts/bucket.md#naming) to upload audit logs to.
      To get a list of buckets in the default folder, run the `yc storage bucket list` CLI command.

   * `object_prefix`: [Prefix](../../storage/concepts/object.md#folder) to assign to the objects with audit logs in the bucket. It is an optional parameter used in the [full name](../../audit-trails/concepts/format.md#log-file-name) of the audit log file.

      {% include [note-bucket-prefix](./note-bucket-prefix.md) %}

