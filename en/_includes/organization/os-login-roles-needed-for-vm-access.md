{% list tabs %}

- Connecting via the YC CLI

  To connect to a VM or {{ k8s }} node with enabled {{ oslogin }} access via the [YC CLI](../../cli/quickstart.md), assign the `compute.osLogin` or `compute.osAdminLogin` role as well as the `compute.operator` role to the user or [service account](../../iam/concepts/users/service-accounts.md) running the YC CLI command.

- Connecting via a standard SSH client

  To connect to a virtual machine or {{ k8s }} node with {{ oslogin }} access enabled via a standard SSH client, assign the `compute.osLogin` or `compute.osAdminLogin` role to the connecting user or [service account](../../iam/concepts/users/service-accounts.md).

{% endlist %}