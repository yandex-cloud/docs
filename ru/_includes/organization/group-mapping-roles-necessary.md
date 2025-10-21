{% note info %}

Чтобы настроить сопоставление [групп пользователей](../../organization/concepts/user-pools.md) на стороне {{ yandex-cloud }}, [назначьте](../../iam/operations/roles/grant.md#resource) пользователю одну из следующих [ролей](../../iam/concepts/access-control/roles.md):

* [`organization-manager.federations.editor`](../../organization/security/index.md#organization-manager-federations-editor);
* [`organization-manager.federations.admin`](../../organization/security/index.md#organization-manager-federations-admin);
* [`organization-manager.editor`](../../organization/security/index.md#organization-manager-editor);
* [`organization-manager.admin`](../../organization/security/index.md#organization-manager-admin);

Роль должна быть назначена на те группы, для которых настраивается сопоставление.

{% endnote %}