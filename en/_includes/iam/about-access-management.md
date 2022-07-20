## About access management {#about-access-control}

All transactions in {{ yandex-cloud }} are checked by the [{{ iam-name }}](../../iam/) service. If a subject doesn't have the required permission, the service returns an error.

To grant permission to a resource, [assign roles](../../iam/operations/roles/grant.md) for this resource to the subject that will perform operations. Roles can be assigned to a {% if product == "yandex-cloud" %}Yandex{% endif %}{% if product == "cloud-il" %}Google{% endif %} account, [service account](../../iam/concepts/users/service-accounts.md) or [system group](../../iam/concepts/access-control/system-group.md). For more information, see [{#T}](../../iam/concepts/access-control/index.md).

Only users with the `admin` or `resource-manager.clouds.owner` role for a resource can assign roles for this resource.