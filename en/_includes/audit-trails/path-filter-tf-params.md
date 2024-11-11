
* `some_filter`: Structure describing the resources whose audit logs will be collected. Based on the audit log collection scope, it allows configuring event processing in specific organization clouds or cloud folders associated with the trail.

    * `resource_id`: ID of the parent resource the new trail belongs to and for whose resources audit logs will be collected. Based on the audit log collection scope, specify the organization [ID](../../organization/operations/organization-get-id.md) or the [ID](../../resource-manager/operations/cloud/get-id.md) of the cloud associated with the trail in this parameter.
    * `resource_type`: Type of the {{ yandex-cloud }} parent resource to create a trail in. Based on the audit log collection scope, specify `organization-manager.organization` or `resource-manager.cloud` in this parameter.
    * `any_filters`: Structure describing one child resource audit logs will be collected in. To specify multiple child resources, set the `any_filters` parameter as many times as needed. Based on the audit log collection scope, in this parameter, specify information on the clouds or folders whose events the trail will process:

        * `resource_id`: Child resource ID. Based on the audit log collection scope, specify the ID of the [cloud](../../resource-manager/operations/cloud/get-id.md) or [folder](../../resource-manager/operations/folder/get-id.md) whose audit logs the trail will collect.
        * `resource_type`: Child resource type. Based on the audit log collection scope, specify `resource-manager.cloud` or `resource-manager.folder` in this parameter.

    To set the current folder as the audit log collection scope, use the `any_filter` parameter instead of `some_filter`.

    You cannot use `some_filter` together with `any_filter`.

* `any_filter`: Structure describing the resources whose audit logs will be collected. Based on the audit log collection scope, it allows configuring event processing in all clouds of the organization associated with the trail, in all folders of the cloud associated with the trail, or in the current folder where you want to create the trail. You cannot use `any_filter` together with `some_filter`.
    * `resource_id`: ID of the resource the new trail belongs to and for whose resources audit logs will be collected. Based on the audit log collection scope, specify the [organization](../../organization/operations/organization-get-id.md), [cloud](../../resource-manager/operations/cloud/get-id.md), or [folder](../../resource-manager/operations/folder/get-id.md) ID in this parameter.
    * `resource_type`: {{ yandex-cloud }} resource type. Based on the audit log collection scope, specify `organization-manager.organization`, `resource-manager.cloud`, or `resource-manager.folder`.

