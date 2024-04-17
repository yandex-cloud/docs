
* `--filter-from-organisation-id`: ID of the organization the trail being created belongs to and for whose resources audit logs will be collected. You can get the organization ID in the [{{ org-full-name }}]({{ link-org-main }}) console or using the `yc organization-manager organization list` CLI command.

   When using the `--filter-from-organisation-id` parameter, you also need to set cloud IDs in the `--filter-some-cloud-ids` parameter.

   You cannot use the `--filter-from-organisation-id` parameter together with the `--filter-all-organisation-id` parameter.

* `--filter-some-cloud-ids`: List of [IDs of the clouds](../../resource-manager/operations/cloud/get-id.md) for whose resources the trail will collect audit logs. Use this parameter only if the `--filter-from-organisation-id` parameter is set.

   The clouds specified in the parameter must belong to the organization set in the `--filter-from-organisation-id` parameter.

   If you need to collect audit logs from all clouds belonging to the organization, use the `--filter-all-organisation-id` parameter.

* `--filter-all-organisation-id`: ID of the organization the trail being created belongs to and for whose resources audit logs will be collected from all clouds.

   You can get the organization ID in the [{{ org-full-name }}]({{ link-org-main }}) console or using the `yc organization-manager organization list` CLI command.

   You cannot use the `--filter-all-organisation-id` parameter together with the `--filter-from-organisation-id` parameter.