To connect to a virtual machine or {{ k8s }} node with {{ oslogin }} access enabled, assign the following roles to the user or [service account](../../iam/concepts/users/service-accounts.md):

* `compute.osLogin` or `compute.osAdminLogin` [role](../../compute/security/index.md#compute-oslogin).
* `resource-manager.auditor` [role](../../resource-manager/security/index.md#resource-manager-auditor) or higher for the folder containing the VM instance or {{ k8s }} node.
* `compute.operator` [role](../../compute/security/index.md#compute-operator) for connecting via the {{ yandex-cloud }} CLI.