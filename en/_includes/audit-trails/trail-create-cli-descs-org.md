
* `--filter-from-organisation-id`: [ID](../../organization/operations/organization-get-id.md) of the organization the new trail belongs to and for whose resources audit logs will be collected.

    When using the `--filter-from-organisation-id` parameter, you also need to set cloud IDs in the `--filter-some-cloud-ids` parameter.

    You cannot use `--filter-from-organisation-id` together with `--filter-all-organisation-id`.

* `--filter-some-cloud-ids`: List of [IDs of the clouds](../../resource-manager/operations/cloud/get-id.md) for whose resources the trail will collect audit logs. Use this parameter only if the `--filter-from-organisation-id` parameter is set.

    The clouds specified in the parameter must belong to the organization named in the `--filter-from-organisation-id` parameter.

    If you need to collect audit logs in all clouds belonging to an organization, use the `--filter-all-organisation-id` parameter.

* `--filter-all-organisation-id`: ID of the organization the new trail belongs to and for whose resources audit logs will be collected from all clouds.

    You cannot use `--filter-all-organisation-id` together with `--filter-from-organisation-id`.