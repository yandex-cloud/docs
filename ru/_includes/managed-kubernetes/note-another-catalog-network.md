{% note info %}

При выборе [облачной сети](../../vpc/concepts/network.md#network) из другого [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder), [назначьте](../../iam/operations/sa/assign-role-for-sa.md) [сервисному аккаунту](../../iam/concepts/users/service-accounts.md) для ресурсов следующие [роли](../../iam/concepts/access-control/roles.md) в этом каталоге:
* [{{ roles-vpc-private-admin }}](../../iam/concepts/access-control/roles.md#vpc-private-admin)
* [{{ roles-vpc-user }}](../../iam/concepts/access-control/roles.md#vpc-user)

Для использования [публичного IP-адреса](../../vpc/concepts/address.md#public-addresses) дополнительно [назначьте](../../iam/operations/sa/assign-role-for-sa.md) роль [{{ roles-vpc-public-admin }}](../../iam/concepts/access-control/roles.md#vpc-public-admin).

{% endnote %}