{% list tabs %}

- Connecting via the YC CLI

  To connect to a virtual machine or {{ k8s }} node with OS Login access enabled via the [YC CLI](../../cli/quickstart.md), the user or [service account](../../iam/concepts/users/service-accounts.md) under which you will run the YC CLI command needs the `compute.osLogin` or `compute.osAdminLogin` role, as well as the `compute.operator` role.

- Connecting via a standard SSH client

  To connect to a virtual machine or {{ k8s }} node with OS Login access enabled via a standard SSH client, the user or [service account](../../iam/concepts/users/service-accounts.md) used for connection needs the `compute.osLogin` or `compute.osAdminLogin` role.

{% endlist %}