
* `--filter-from-cloud-id`: [ID of the cloud](../../resource-manager/operations/cloud/get-id.md) the trail being created belongs to and for whose resources audit logs will be collected.

   When using the `--filter-from-cloud-id` parameter, you also need to set folder IDs in the `--filter-some-folder-ids` parameter.

   You cannot use the `--filter-from-cloud-id` parameter together with the `--filter-all-cloud-id` parameter.

* `--filter-some-folder-ids`: List of [IDs of the folders](../../resource-manager/operations/folder/get-id.md) for whose resources the trail will collect audit logs. Use this parameter only if the `---filter-from-cloud-id` parameter is set.

   The folders specified in the parameter must belong to the cloud set in the `--filter-from-cloud-id` parameter.

   If you need to collect audit logs from all folders belonging to the cloud, use the `--filter-all-cloud-id` parameter.

* `--filter-all-cloud-id`: [ID of the cloud](../../resource-manager/operations/cloud/get-id.md) the trail being created belongs to and for whose resources audit logs will be collected from all folders.

   You cannot use the `--filter-all-cloud-id` parameter together with the `--filter-from-cloud-id` parameter.