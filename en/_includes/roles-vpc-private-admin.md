#### vpc.privateAdmin {#vpc-private-admin}

The `{{ roles-vpc-private-admin }}` role allows you to manage connectivity between VMs and managed database clusters within {{ yandex-cloud }}:
- Create, delete, and update [networks and subnets](../vpc/concepts/network.md).
- Set up [static routes](../vpc/concepts/static-routes.md) and internal addresses.

With this role, you cannot make a VM or cluster available outside of the network they belong to. Use the `{{ roles-vpc-public-admin }}` role to manage external access permissions.

{% include [roles-restriction-only-parents](iam/roles-restriction-only-parents.md) %}
