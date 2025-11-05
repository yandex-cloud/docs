{% note info %}

To configure [user group](../../organization/concepts/user-pools.md) mapping on the {{ yandex-cloud }} side, [assign](../../iam/operations/roles/grant.md#resource) the user one of the following [roles](../../iam/concepts/access-control/roles.md):

* [`organization-manager.federations.editor`](../../organization/security/index.md#organization-manager-federations-editor)
* [`organization-manager.federations.admin`](../../organization/security/index.md#organization-manager-federations-admin)
* [`organization-manager.editor`](../../organization/security/index.md#organization-manager-editor)
* [`organization-manager.admin`](../../organization/security/index.md#organization-manager-admin)

The role must be assigned for the groups you intend to map.

{% endnote %}