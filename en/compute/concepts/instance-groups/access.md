# Access

By default, all operations in {{ ig-name }} are performed under a [service account](../../../iam/concepts/users/service-accounts.md).

Service accounts are special accounts that can be used by services and applications to work with other {{ yandex-cloud }} APIs on your behalf. For more information about service accounts and access management in {{ yandex-cloud }}, see the [{{ iam-full-name }} documentation](../../../iam/).

{{ ig-name }} use [authorized keys](../../../iam/concepts/authorization/key.md) of the service account to authorize in the APIs and perform operations on resources within the roles granted to this service account. For example, {{ ig-name }} can use a service account to create, update, and delete VM instances.

An instance group may only have one service account created in the same folder as the group.

To enable a service account to create, modify, run, restart, stop, or delete VM instances in a group, you need to [assign](../../../iam/operations/sa/assign-role-for-sa.md) this service account the [compute.editor](../../security/index.md#compute-editor) role for the folder where you want to place your instance group.

If you want to integrate an instance group with a [{{ network-load-balancer-full-name }}](../../../network-load-balancer/), you also need to assign the [load-balancer.editor](../../../network-load-balancer/security/index.md#load-balancer-editor) role to the service account.

To integrate an instance group with an L7 load balancer from [{{ alb-full-name }}](../../../application-load-balancer/), assign the [alb.editor](../../../application-load-balancer/security/index.md#alb-editor) role to the service account.

For more information, see [{#T}](balancers.md).

{% note info %}

{% include [sa-dependence](../../../_includes/instance-groups/sa-dependence.md) %}

{% endnote %}

## Use cases {#examples}

* [{#T}](../../tutorials/vm-autoscale/index.md)

#### See also {#see-also}

- [{#T}](../../quickstart/ig.md)
- [{#T}](../../../iam/operations/sa/create.md)
- [{#T}](../../operations/instance-groups/create-with-balancer.md)
- [{#T}](../../operations/instance-groups/create-with-load-balancer.md)