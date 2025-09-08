---
title: Access management in {{ mkf-full-name }}
description: Access management in the Apache Kafka database creation and management service. This section describes the resources for which you can assign a role, the roles existing in the service, and the roles required to perform a particular action.
---

# Access management in {{ mkf-name }}


In this section, you will learn:

* [Which resources you can assign a role for](#resources).
* [Which roles exist in the service](#roles-list).
* [Which roles are required](#required-roles) for particular actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Roles for a resource can be assigned by users who have the `mdb.admin`, `managed-kafka.admin`, or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## Which resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

To allow access to {{ mkf-name }} resources (clusters, hosts, cluster backups, partitions, topics, and users), assign the user the appropriate roles for the folder, cloud, or organization containing these resources.

## Which roles exist in the service {#roles-list}

The chart below shows which roles are available in the service and how they inherit each other's permissions. For example, the `{{ roles-editor }}` role includes all the permissions of `{{ roles-viewer }}`. You can find the description of each role under the chart.

![image](../../_assets/mdb/roles-managed-kafka.svg)

### Service roles {#service-roles}

#### managed-kafka.auditor {#managed-kafka-auditor}

{% include [managed-kafka.auditor](../../_roles/managed-kafka/auditor.md) %}

#### managed-kafka.viewer {#managed-kafka-viewer}

{% include [managed-kafka.viewer](../../_roles/managed-kafka/viewer.md) %}

#### managed-kafka.editor {#managed-kafka-editor}

{% include [managed-kafka.editor](../../_roles/managed-kafka/editor.md) %}

#### managed-kafka.admin {#managed-kafka-admin}

{% include [managed-kafka.admin](../../_roles/managed-kafka/admin.md) %}

#### managed-kafka.interfaceUser {#managed-kafka-interface-user}

{% include [managed-kafka.interfaceUser](../../_roles/managed-kafka/interfaceUser.md) %}

#### mdb.auditor {#mdb-auditor}

{% include [mdb-auditor](../../_roles/mdb/auditor.md) %}

#### mdb.viewer {#mdb-viewer}

{% include [mdb-viewer](../../_roles/mdb/viewer.md) %}

#### mdb.admin {#mdb-admin}

{% include [mdb-admin](../../_roles/mdb/admin.md) %}

#### vpc.publicAdmin {#vpc-public-admin}

{% include [vpc-publicadmin](../../_roles/vpc/publicAdmin.md) %}


### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## Roles required {#required-roles}

To use the service, you need the [{{ roles.mkf.editor }} role](../../iam/concepts/access-control/roles.md) or higher for the folder to house the new cluster. The `{{ roles.mkf.viewer }}` role enables you only to view the list of clusters.

To create a {{ mkf-name }} cluster, you need the [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) role and the `{{ roles.mkf.editor }}` role or higher.

You can always assign a role with more permissions. For instance, you can assign `{{ roles.mkf.admin }}` instead of `{{ roles.mkf.editor }}`.

## What's next {#whats-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

