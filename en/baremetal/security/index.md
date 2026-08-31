# Access management in {{ baremetal-full-name }}

{% include [operate-via-roles-paragraph](../../_includes/iam/operate-via-roles-paragraph.md) %}

To grant access to {{ baremetal-name }} resources, assign the relevant roles from the list below to a Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated](../../iam/concepts/users/accounts.md#saml-federation) or [local](../../iam/concepts/users/accounts.md#local) users, [user group](../../organization/operations/manage-groups.md), [system group](../../iam/concepts/access-control/system-group.md), or [public group](../../iam/concepts/access-control/public-group.md). Currently, a role can only be assigned for a parent resource, i.e., folder or cloud, whose roles are inherited by nested resources.

For more information about role inheritance, see [Inheritance of access permissions](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-name }} documentation.

## Roles this service has {#roles-list}

In {{ baremetal-name }}, you can manage access using both service and primitive roles.

{% include [baremetal](../../_mermaid/roles/baremetal.md) %}

### Service roles {#service-roles}

#### baremetal.auditor {#baremetal-auditor}

{% include [baremetal-auditor](../../_roles/baremetal/auditor.md) %}

#### baremetal.viewer {#baremetal-viewer}

{% include [baremetal-viewer](../../_roles/baremetal/viewer.md) %}

#### baremetal.operator {#baremetal-operator}

{% include [baremetal-operator](../../_roles/baremetal/operator.md) %}

#### baremetal.editor {#baremetal-editor}

{% include [baremetal-editor](../../_roles/baremetal/editor.md) %}

{% note info %}

The `baremetal.editor` role includes the [backup.user](../../backup/security/index.md#backup-user) permissions that enable connecting servers to [{{ backup-full-name }}](../../backup/index.yaml) as well as linking and unlinking them from [backup policies](../../backup/concepts/policy.md).

{% include [denyActivation-iam-policy-pre-notice](../../_includes/backup/denyActivation-iam-policy-pre-notice.md) %}

{% endnote %}

#### baremetal.admin {#baremetal-admin}

{% include [baremetal-admin](../../_roles/baremetal/admin.md) %}

{% note info %}

The `baremetal.admin` role includes the [backup.user](../../backup/security/index.md#backup-user) permissions that enable connecting servers to [{{ backup-full-name }}](../../backup/index.yaml) as well as linking and unlinking them from [backup policies](../../backup/concepts/policy.md).

{% include [denyActivation-iam-policy-pre-notice](../../_includes/backup/denyActivation-iam-policy-pre-notice.md) %}

{% endnote %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## Useful links {#see-also}

[Hierarchy of {{ yandex-cloud }} resources](../../resource-manager/concepts/resources-hierarchy.md)
