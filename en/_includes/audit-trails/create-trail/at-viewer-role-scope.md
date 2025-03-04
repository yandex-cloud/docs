* `audit-trails.viewer` for one of the resources that defines the [required log collection scope](../../../audit-trails/concepts/trail.md#collecting-area):

    * [Organization](../../../organization/operations/add-role.md): To collect logs in selected clouds of the organization.
    * [Cloud](../../../resource-manager/operations/cloud/set-access-bindings.md#access-to-sa): To collect logs in selected folders of the cloud.
    * [Folder](../../../resource-manager/operations/folder/set-access-bindings.md#access-to-sa): To collect logs in this folder.

    Child resources inherit access permissions from their parent resources. For example, if a service account [gets a role for a cloud](../../../resource-manager/operations/cloud/set-access-bindings.md), then the trail that uses this account will be able to collect logs for resources across all folders of this cloud. However, the trail will not be able to collect logs in other clouds owned by the organization: [a role for the organization](../../../organization/operations/add-role.md) is required for that.
