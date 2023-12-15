#### vpc.viewer {#vpc-viewer}

The `{{ roles-vpc-viewer }}` role lets you view resource model objects:
- [Networks and subnets](../vpc/concepts/network.md)
- [Static route](../vpc/concepts/static-routes.md) tables
- [Addresses](../vpc/concepts/address.md)
- [Security groups](../vpc/concepts/security-groups.md)

{% include [roles-restriction-only-parents](iam/roles-restriction-only-parents.md) %}

It includes the permissions of the `vpc.auditor` role.