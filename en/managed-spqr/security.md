---
title: Access management in {{ mspqr-full-name }}
description: Access management in {{ SPQR }}, a database creation and management service. This section describes the resources for which you can assign a role, the roles existing in this service, and the roles required for specific actions.
---

# Access management in {{ mspqr-name }}


In this section, you will learn about:

* [Resources you can assign a role for](#resources).
* [Roles this service has](#roles-list).
* [Roles required for specific actions](#required-roles).

{% include [about-access-management](../_includes/iam/about-access-management.md) %}

To assign a role for a resource, a user should have the `mdb.admin` role, `managed-spqr.admin` role, or one of the following roles for that resource:

{% include [roles-list](../_includes/iam/roles-list.md) %}

## Resources you can assign a role for {#resources}

{% include [basic-resources](../_includes/iam/basic-resources-for-access-control.md) %}

{% include [assign-roles-mdb](../_includes/iam/assign-roles-mdb.md) %}

## Roles this service has {#roles-list}

The chart below shows the roles existing in the service and their permission inheritance. For example, `{{ roles-editor }}` inherits all `{{ roles-viewer }}` permissions. You can find the role descriptions below the chart.

{% include [roles-managed-spqr](../_mermaid/roles/managed-spqr.md) %}

### Service roles {#service-roles}

#### managed-spqr.auditor {#managed-spqr-auditor}

{% include [managed-spqr.auditor](../_roles/managed-spqr/auditor.md) %}

#### managed-spqr.viewer {#managed-spqr-viewer}

{% include [managed-spqr.viewer](../_roles/managed-spqr/viewer.md) %}

#### managed-spqr.restorer {#managed-spqr-restorer}

{% include [managed-spqr.restorer](../_roles/managed-spqr/restorer.md) %}

#### managed-spqr.editor {#managed-spqr-editor}

{% include [managed-spqr.editor](../_roles/managed-spqr/editor.md) %}

#### managed-spqr.admin {#managed-spqr-admin}

{% include [managed-spqr.admin](../_roles/managed-spqr/admin.md) %}

#### mdb.auditor {#mdb-auditor}

{% include [mdb-auditor](../_roles/mdb/auditor.md) %}

#### mdb.viewer {#mdb-viewer}

{% include [mdb-viewer](../_roles/mdb/viewer.md) %}

#### mdb.admin {#mdb-admin}

{% include [mdb-admin](../_roles/mdb/admin.md) %}

#### mdb.restorer {#mdb-restorer}

{% include [mdb-restorer](../_roles/mdb/restorer.md) %}

#### vpc.publicAdmin {#vpc-public-admin}

{% include [vpc-publicadmin](../_roles/vpc/publicAdmin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../_includes/primitive-roles-footnote.md) %}

## Required roles {#required-roles}

To use the service, you need the [managed-spqr.editor role or higher](../iam/concepts/access-control/roles.md) for the folder to house the new cluster. The `managed-spqr.viewer` role only allows you to view the list of clusters.

To create a {{ mspqr-name }} cluster, you need the [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) role and the `managed-spqr.editor` role or higher.

You can always assign a role with more permissions. For example, you can assign the `managed-spqr.admin` role instead of `managed-spqr.editor`.

## What's next {#whats-next}

* [How to assign a role](../iam/operations/roles/grant.md).
* [How to revoke a role](../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../iam/concepts/access-control/index.md).
* [Learn more about role inheritance](../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

