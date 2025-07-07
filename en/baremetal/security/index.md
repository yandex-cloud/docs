# Access management in {{ baremetal-full-name }}

{{ yandex-cloud }} users can only perform operations on resources in accordance with the roles assigned to them. As long as a user has no roles assigned, all operations are forbidden.

To allow a user or group, e.g., Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated user](../../iam/concepts/federations.md), [user group](../../organization/operations/manage-groups.md), [system group](../../iam/concepts/access-control/system-group.md), or [public group](../../iam/concepts/access-control/public-group.md), access to {{ baremetal-name }} resources, assign them the roles from the list below. Currently, a role can only be assigned for a parent resource (folder or cloud). Roles are inherited by nested resources.

{% note info %}

For more information about role inheritance, see [Inheritance of access permissions](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-name }} documentation.

{% endnote %}

## What roles exist in this service {#roles-list}

In {{ baremetal-name }}, you can manage access using both service and primitive roles.

### Service roles {#service-roles}

#### baremetal.auditor {#baremetal-auditor}

{% include [baremetal-auditor](../../_roles/baremetal/auditor.md) %}

#### baremetal.viewer {#baremetal-viewer}

{% include [baremetal-viewer](../../_roles/baremetal/viewer.md) %}

#### baremetal.operator {#baremetal-operator}

{% include [baremetal-operator](../../_roles/baremetal/operator.md) %}

#### baremetal.editor {#baremetal-editor}

{% include [baremetal-editor](../../_roles/baremetal/editor.md) %}

#### baremetal.admin {#baremetal-admin}

{% include [baremetal-admin](../../_roles/baremetal/admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## See also {#see-also}

[Hierarchy of {{ yandex-cloud }} resources](../../resource-manager/concepts/resources-hierarchy.md)
