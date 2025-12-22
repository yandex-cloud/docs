---
title: Access management in {{ mmy-full-name }}
description: Access management in {{ MY }}, a solution for creating and managing databases. This section describes the resources for which you can assign a role, the roles existing in this service, and the roles required for specific actions.
---

# Access management in {{ mmy-name }}


In this section, you will learn about:

* [Resources you can assign a role for](#resources).
* [Roles this service has](#roles-list).
* [Roles required for specific actions](#required-roles).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

To assign a role for a resource, you need the `mdb.admin` role, the `managed-mysql.admin` role, or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## Resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

{% include [assign-roles-mdb](../../_includes/iam/assign-roles-mdb.md) %}

You can assign a role for a separate cluster from the [management console]({{ link-console-main }}) or via the [API](../api-ref/authentication.md).

## Roles this service has {#roles-list}

The chart below shows the roles existing in the service and their permission inheritance. For example, `{{ roles-editor }}` inherits all `{{ roles-viewer }}` permissions. You can find the role descriptions below the chart.

{% include [roles-managed-mysql](../../_mermaid/roles/managed-mysql.md) %}

### Service roles {#service-roles}

#### managed-mysql.auditor {#managed-mysql-auditor}

{% include [managed-mysql.auditor](../../_roles/managed-mysql/auditor.md) %}

#### managed-mysql.viewer {#managed-mysql-viewer}

{% include [managed-mysql.viewer](../../_roles/managed-mysql/viewer.md) %}

#### managed-mysql.restorer {#managed-mysql-restorer}

{% include [managed-mysql.restorer](../../_roles/managed-mysql/restorer.md) %}

#### managed-mysql.editor {#managed-mysql-editor}

{% include [managed-mysql.editor](../../_roles/managed-mysql/editor.md) %}

#### managed-mysql.admin {#managed-mysql-admin}

{% include [managed-mysql.admin](../../_roles/managed-mysql/admin.md) %}

#### mdb.auditor {#mdb-auditor}

{% include [mdb-auditor](../../_roles/mdb/auditor.md) %}

#### mdb.viewer {#mdb-viewer}

{% include [mdb-viewer](../../_roles/mdb/viewer.md) %}

#### mdb.admin {#mdb-admin}

{% include [mdb-admin](../../_roles/mdb/admin.md) %}

#### mdb.restorer {#mdb-restorer}

{% include [mdb-restorer](../../_roles/mdb/restorer.md) %}

#### vpc.publicAdmin {#vpc-public-admin}

{% include [vpc-publicadmin](../../_roles/vpc/publicAdmin.md) %}


### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## Required roles {#required-roles}

To use {{ maf-name }}, you need the [{{ roles.mmy.editor }} role or higher](../../iam/concepts/access-control/roles.md) for the folder that will contain the new cluster. The `{{ roles.mmy.viewer }}` role only allows you to view the list of clusters.

To create a {{ mmy-name }} cluster, you need the [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) role and the `{{ roles.mmy.editor }}` role or higher.

You can always assign a role with more permissions. For example, you can assign the `{{ roles.mmy.admin }}` role instead of `{{ roles.mmy.editor }}`.

## What's next {#whats-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about role inheritance](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

