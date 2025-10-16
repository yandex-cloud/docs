---
title: Access to {{ mgp-name }}
description: To allow access to {{ mgp-name }} resources (DB clusters and hosts, cluster backups, databases and their users), assign the user the appropriate roles for the folder, cloud, or organization containing these resources.
keywords:
  - access
  - access
  - configuring access
  - '{{ GP }} access'
  - green plum
  - '{{ GP }}'
---

# Access management in {{ mgp-name }}


In this section, you will learn:

* [What resources you can assign a role for](#resources).
* [What roles this service has](#roles-list).
* [What roles are required](#required-roles) for specific actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

To assign a role for a resource, a user should have the `mdb.admin` role, `managed-greenplum.admin` role, or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## Resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

{% include [assign-roles-mdb](../../_includes/iam/assign-roles-mdb.md) %}

## Which roles exist in the service {#roles-list}

The chart below shows which roles are available in the service and how they inherit each other's permissions. For example, the `{{ roles-editor }}` role includes all the permissions of `{{ roles-viewer }}`. You can find the description of each role under the chart.

![image](../../_assets/mdb/roles-managed-greenplum.svg)

### Service roles {#service-roles}

#### managed-greenplum.auditor {#managed-greenplum-auditor}

{% include [managed-greenplum.auditor](../../_roles/managed-greenplum/auditor.md) %}

#### managed-greenplum.viewer {#managed-greenplum-viewer}

{% include [managed-greenplum.viewer](../../_roles/managed-greenplum/viewer.md) %}

#### managed-greenplum.restorer {#managed-greenplum-restorer}

{% include [managed-greenplum.restorer](../../_roles/managed-greenplum/restorer.md) %}

#### managed-greenplum.editor {#managed-greenplum-editor}

{% include [managed-greenplum.editor](../../_roles/managed-greenplum/editor.md) %}

#### managed-greenplum.admin {#managed-greenplum-admin}

{% include [managed-greenplum.admin](../../_roles/managed-greenplum/admin.md) %}

#### mdb.auditor {#mdb-auditor}

{% include [mdb-auditor](../../_roles/mdb/auditor.md) %}

#### mdb.viewer {#mdb-viewer}

{% include [mdb-viewer](../../_roles/mdb/viewer.md) %}

#### mdb.admin {#mdb-admin}

{% include [mdb-admin](../../_roles/mdb/admin.md) %}

#### mdb.restorer {#mdb-restorer}

{% include [mdb-restorer](../../_roles/mdb/restorer.md) %}

When you create a {{ mgp-name }} cluster, an admin user with the `mdb_admin` role is created automatically. This role replaces the superuser when working with the database and is not analogous to the `{{ roles-mdb-admin }}` role in {{ yandex-cloud }}. For more information, see [{#T}](../concepts/cluster-users.md).

#### vpc.publicAdmin {#vpc-public-admin}

{% include [vpc-publicadmin](../../_roles/vpc/publicAdmin.md) %}


### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## What roles are required {#required-roles}

To use {{ maf-name }}, you need the [{{ roles.mgp.editor }} role or higher](../../iam/concepts/access-control/roles.md) for the folder to house the new cluster. The `{{ roles.mgp.viewer }}` role only allows you to view the list of clusters.

To create a {{ mgp-name }} cluster, you need the [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) role and the `{{ roles.mgp.editor }}` role or higher.

You can always assign a role with more permissions. For example, you can assign the `{{ roles.mgp.admin }}` role instead of `{{ roles.mgp.editor }}`.

## What's next {#whats-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about role inheritance](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).


{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
