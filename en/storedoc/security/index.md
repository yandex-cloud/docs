---
title: Access management in {{ mmg-full-name }}
description: Access management in the {{ SD }} database creation and management service. This section describes the resources you can assign a role for, the roles this service has, and the roles required for specific actions.
---

# Access management in {{ mmg-name }}


In this section, you will learn about the following:

* [Resources you can assign a role for](#resources).
* [Roles this service has](#roles-list).
* [Roles required for specific actions](#required-roles).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

To assign a role for a resource, you need the `mdb.admin` role, `managed-mongodb.admin` role, or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## Resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

{% include [assign-roles-mdb](../../_includes/iam/assign-roles-mdb.md) %}

You can also assign a role for an individual cluster in the [management console]({{ link-console-main }}), via the [CLI](../../cli), or [API](../api-ref/authentication.md).

## Roles this service has {#roles-list}

The diagram below shows available service roles and their permission inheritance hierarchy. For example, `{{ roles-editor }}` inherits all `{{ roles-viewer }}` permissions. You can find role descriptions below the diagram.

{% include [roles-managed-storedoc](../../_mermaid/roles/managed-storedoc.md) %}

### Service roles {#service-roles}

#### managed-mongodb.auditor {#managed-mongodb-auditor}

{% include [managed-mongodb.auditor](../../_roles/managed-mongodb/auditor.md) %}

#### managed-mongodb.viewer {#managed-mongodb-viewer}

{% include [managed-mongodb.viewer](../../_roles/managed-mongodb/viewer.md) %}

#### managed-mongodb.restorer {#managed-mongodb-restorer}

{% include [managed-mongodb.restorer](../../_roles/managed-mongodb/restorer.md) %}

#### managed-mongodb.user {#managed-mongodb-user}

{% include [managed-mongodb.user](../../_roles/managed-mongodb/user.md) %}

#### managed-mongodb.switcher {#managed-mongodb-switcher}

{% include [managed-mongodb.switcher](../../_roles/managed-mongodb/switcher.md) %}

#### managed-mongodb.editor {#managed-mongodb-editor}

{% include [managed-mongodb.editor](../../_roles/managed-mongodb/editor.md) %}

#### managed-mongodb.admin {#managed-mongodb-admin}

{% include [managed-mongodb.admin](../../_roles/managed-mongodb/admin.md) %}

#### managed-mongodb.maintenanceTask.viewer {#managed-mongodb-maintenanceTask-viewer}

{% include [managed-mongodb.maintenanceTask.viewer](../../_roles/managed-mongodb/maintenanceTask/viewer.md) %}

#### managed-mongodb.maintenanceTask.editor {#managed-mongodb-maintenanceTask-editor}

{% include [managed-mongodb.maintenanceTask.editor](../../_roles/managed-mongodb/maintenanceTask/editor.md) %}

#### mdb.auditor {#mdb-auditor}

{% include [mdb-auditor](../../_roles/mdb/auditor.md) %}

#### mdb.viewer {#mdb-viewer}

{% include [mdb-viewer](../../_roles/mdb/viewer.md) %}

#### mdb.admin {#mdb-admin}

{% include [mdb-admin](../../_roles/mdb/admin.md) %}

#### mdb.restorer {#mdb-restorer}

{% include [mdb-restorer](../../_roles/mdb/restorer.md) %}

#### mdb.switcher {#mdb-switcher}

{% include [mdb.switcher](../../_roles/mdb/switcher.md) %}

#### mdb.maintenanceTask.viewer {#mdb-maintenanceTask-viewer}

{% include [mdb.maintenanceTask.viewer](../../_roles/mdb/maintenanceTask/viewer.md) %}

#### mdb.maintenanceTask.editor {#mdb-maintenanceTask-editor}

{% include [mdb.maintenanceTask.editor](../../_roles/mdb/maintenanceTask/editor.md) %}

#### vpc.publicAdmin {#vpc-public-admin}

{% include [vpc-publicadmin](../../_roles/vpc/publicAdmin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## Required roles {#required-roles}

To use the service, you need the [{{ roles.mmg.editor }} role or higher](../../iam/concepts/access-control/roles.md) on the folder containing your new cluster. The `{{ roles.mmg.viewer }}` role only allows you to view the cluster list.

To create a {{ mmg-name }} cluster, you need the [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) role and the `{{ roles.mmg.editor }}` role or higher.

You can also assign a role with broader permissions, e.g., `{{ roles.mmg.admin }}` instead of `{{ roles.mmg.editor }}`.

## What's next {#whats-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about role inheritance](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

