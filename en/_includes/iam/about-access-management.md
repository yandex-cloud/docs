## About access management {#about-access-control}

In {{ yandex-cloud }}, all transactions are checked in [{{ iam-full-name }}](../../iam/). If a subject does not have the required permission, the service returns an error.


To grant permissions for a resource, [assign roles](../../iam/operations/roles/grant.md) for this resource to the subject that will perform the operations. You can assign roles to a Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated users](../../iam/concepts/federations.md), [user group](../../organization/operations/manage-groups.md), [system group](../../iam/concepts/access-control/system-group.md), or [public group](../../iam/concepts/access-control/public-group.md). For more information, see [{#T}](../../iam/concepts/access-control/index.md).
