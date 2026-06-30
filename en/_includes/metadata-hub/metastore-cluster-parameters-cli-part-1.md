* `--description`: Cluster description.
* `--labels`: List of [labels](../../resource-manager/concepts/labels.md). Provide labels in `<key>=<value>` format.
* `--service-account-id`: [Service account](../../iam/concepts/users/service-accounts.md) ID.
* `--version`: {{ metastore-name }} version.

  {% include [metastore-version](metastore-version-cluster-create.md) %}

* `--warehouse-bucket`: Name of the {{ objstorage-name }} bucket to store the {{ metastore-name }} (warehouse) data.
* `--warehouse-path`: Path within the bucket to prefix the {{ metastore-name }} data. This is an optional setting.
