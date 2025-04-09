* `--description`: Trail description. This is an optional parameter.
* `--labels`: List of [labels](../../resource-manager/concepts/labels.md). This is an optional parameter. You can specify one or more labels separated by commas in `<key1>=<value1>,<key2>=<value2>` format.
* `--service-account-id`: Service account [ID](../../iam/operations/sa/get-id.md).
* `--destination-bucket`: [Name](../../storage/concepts/bucket.md#naming) of the {{ objstorage-full-name }} bucket you want to upload audit logs to.

    You cannot use this parameter together with `--destination-log-group-id` or `--destination-yds-stream`.
* `--destination-bucket-object-prefix`: [Prefix](../../storage/concepts/object.md#folder) that will be assigned to the objects with audit logs in the bucket. It is an optional parameter used in the [full name](../../audit-trails/concepts/format.md#log-file-name) of the audit log file.

    {% include [note-bucket-prefix](./note-bucket-prefix.md) %}

* `--destination-log-group-id`: ID of the {{ cloud-logging-full-name }} [log group](../../logging/concepts/log-group.md) the audit logs will be uploaded to.

    You cannot use this parameter together with `--destination-bucket` or `--destination-yds-stream`.
* `--destination-yds-stream`: Name of the {{ yds-full-name }} [data stream](../../data-streams/concepts/glossary.md#stream-concepts) the audit logs will be uploaded to.

    You cannot use this parameter together with `--destination-bucket` or `--destination-log-group-id`.
* `--destination-yds-database-id`: ID of the {{ ydb-short-name }} database used by {{ yds-name }}.
* `--filter-all-folder-id`: Folder [ID](../../resource-manager/operations/folder/get-id.md). The system will be logging management events for all resources in this folder.
* `--filter-all-cloud-id`: Cloud [ID](../../resource-manager/operations/cloud/get-id.md). The system will be logging management events for all resources in this cloud.
* `--filter-all-organisation-id`: Organization [ID](../../organization/operations/organization-get-id.md). The system will be logging management events for all resources in this organization.
* `--filter-some-folder-ids`: List of folder IDs. The system will be logging management events for all resources in those folders, in the cloud specified in `--filter-from-cloud-id`.

    This parameter can only be used together with `--filter-from-cloud-id`.
* `--filter-from-cloud-id`: ID of the cloud housing the folders specified in the `--filter-some-folder-ids` parameter.

    This parameter can only be used together with `--filter-some-folder-ids`.
* `--filter-some-cloud-ids`: List of cloud IDs. The system will be logging management events for all resources in those clouds, in the organization specified in `--filter-from-organisation-id`.

    This parameter can only be used together with `--filter-from-organisation-id`.
* `--filter-from-organisation-id`: ID of the organization housing the clouds specified under `--filter-some-folder-ids`.

    This parameter can only be used together with `--filter-some-cloud-ids`.