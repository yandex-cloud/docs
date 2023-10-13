#### vpc.user {#vpc-user}

The `{{ roles-vpc-user }}` role allows you to connect to {{ vpc-short-name }} network resources and use them. It includes all permissions of the `{{ roles-vpc-viewer }}` role and a permission to:
- Use [networks and subnets](../vpc/concepts/network.md).
- Use [static routes](../vpc/concepts/static-routes.md).
- Assign static [addresses](../vpc/concepts/address.md) to VMs.
- Assign [security groups](../vpc/concepts/security-groups.md) to VM network interfaces.

{% include [roles-restriction-only-parents](iam/roles-restriction-only-parents.md) %}