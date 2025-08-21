---
title: Access management in {{ mch-full-name }}
description: Access management in {{ CH }}, a database creation and management service. This section describes the resources for which you can assign a role, the roles existing in the service, and the roles required for specific actions.
---

# Access management in {{ mch-name }}


In this section, you will learn:

* [What resources you can assign a role for](#resources).
* [What roles this service has](#roles-list).
* [What roles are required](#required-roles) for specific actions.

{% include [about-access-management](../_includes/iam/about-access-management.md) %}

To assign a role for a resource, a user should have the `mdb.admin` role, `managed-clickhouse.admin` role, or one of the following roles for that resource:

{% include [roles-list](../_includes/iam/roles-list.md) %}

## Resources you can assign a role for {#resources}

{% include [basic-resources](../_includes/iam/basic-resources-for-access-control.md) %}

{% include [assign-roles-mdb](../_includes/iam/assign-roles-mdb.md) %}

## What roles exist in this service {#roles-list}

The chart below shows the roles existing in the service and their permission inheritance. For example, `{{ roles-editor }}` inherits all the `{{ roles-viewer }}` permissions. You can find the role descriptions below the chart.

![image](../_assets/mdb/roles-managed-clickhouse.svg)

### Service roles {#service-roles}

#### managed-clickhouse.auditor {#managed-clickhouse-auditor}

{% include [managed-clickhouse.auditor](../_roles/managed-clickhouse/auditor.md) %}

#### managed-clickhouse.viewer {#managed-clickhouse-viewer}

{% include [managed-clickhouse.viewer](../_roles/managed-clickhouse/viewer.md) %}

#### managed-clickhouse.editor {#managed-clickhouse-editor}

{% include [managed-clickhouse.editor](../_roles/managed-clickhouse/editor.md) %}

#### managed-clickhouse.admin {#managed-clickhouse-admin}

{% include [managed-clickhouse.admin](../_roles/managed-clickhouse/admin.md) %}

#### mdb.auditor {#mdb-auditor}

{% include [mdb-auditor](../_roles/mdb/auditor.md) %}

#### mdb.viewer {#mdb-viewer}

{% include [mdb-viewer](../_roles/mdb/viewer.md) %}

#### mdb.admin {#mdb-admin}

{% include [mdb-admin](../_roles/mdb/admin.md) %}

#### vpc.publicAdmin {#vpc-public-admin}

{% include [vpc-publicadmin](../_roles/vpc/publicAdmin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../_includes/primitive-roles-footnote.md) %}

## What roles are required {#required-roles}

To use the service, you need the [{{ roles.mch.editor }} role or higher](../iam/concepts/access-control/roles.md) for the folder to house the new cluster. The `{{ roles.mch.viewer }}` role allows you only to view the list of clusters.

To create a {{ mch-name }} cluster, you need the [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) role and the `{{ roles.mch.editor }}` role or higher.

You can always assign a role with more permissions. For example, you can assign the `{{ roles.mch.admin }}` role instead of `{{ roles.mch.editor }}`.

## What's next {#whats-next}

* [How to assign a role](../iam/operations/roles/grant.md).
* [How to revoke a role](../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../iam/concepts/access-control/index.md).
* [Learn more about role inheritance](../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).


{% include [clickhouse-disclaimer](../_includes/clickhouse-disclaimer.md) %}
