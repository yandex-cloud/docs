{% note info %}

This service account will be used only to create the VM and will not be linked to it. The service account must have the [compute.admin](../../compute/security/index.md#compute-admin), [vpc.admin](../../vpc/security/index.md#vpc-admin), and [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) roles. For more information, see [{#T}](../../iam/operations/sa/assign-role-for-sa.md).

{% endnote %}