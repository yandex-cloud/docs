{% note info %}

If you select a [cloud network](../../vpc/concepts/network.md#network) from another [folder](../../resource-manager/concepts/resources-hierarchy.md#folder), [assign](../../iam/operations/sa/assign-role-for-sa.md) the resource [service account](../../iam/concepts/users/service-accounts.md) the following [roles](../../iam/concepts/access-control/roles.md) in this folder:
* [{{ roles-vpc-private-admin }}](../../vpc/security/index.md#vpc-private-admin)
* [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user)

To use a [public IP address](../../vpc/concepts/address.md#public-addresses), also [assign](../../iam/operations/sa/assign-role-for-sa.md) the [{{ roles-vpc-public-admin }}](../../vpc/security/index.md#vpc-public-admin) role.

{% endnote %}