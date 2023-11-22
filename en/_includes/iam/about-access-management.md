## About access management {#about-access-control}

In {{ yandex-cloud }}, all transactions are checked in [{{ iam-full-name }}](../../iam/). If a subject does not have the required permission, the service returns an error.


To grant permission for a resource, [assign roles](../../iam/operations/roles/grant.md) for this resource to the subject that will perform operations. Roles can be assigned to a Yandex account, a [service account](../../iam/concepts/users/service-accounts.md), [federated users](../../iam/concepts/federations.md), a [user group](../../organization/operations/manage-groups.md), or a [system group](../../iam/concepts/access-control/system-group.md). For more information, see [{#T}](../../iam/concepts/access-control/index.md).


Only users with the `admin` or `resource-manager.clouds.owner` role for a resource can assign roles for this resource.