---
title: Access management in {{ mkf-full-name }}
description: Access management in Apache Kafka, a database creation and management service. This section describes the resources for which you can assign a role, the roles existing in this service, and the roles required for specific actions.
---

# Access management in {{ mkf-name }}


In this section, you will learn about:

* [Resources you can assign a role for](#resources).
* [Roles this service has](#roles-list).
* [Roles required](#required-roles) for specific actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

To assign a role for a resource, you need the `mdb.admin` role, the `managed-kafka.admin` role, or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## Resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

To allow access to {{ mkf-name }} resources (clusters, hosts, cluster backups, partitions, topics, and users), assign the user the appropriate roles for the folder, cloud, or organization containing these resources.

You can assign a role for a separate cluster from the [management console]({{ link-console-main }}) or via the [API](../api-ref/authentication.md).

## Roles this service has {#roles-list}

The chart below shows the roles existing in the service and their permission inheritance. For example, `{{ roles-editor }}` inherits all `{{ roles-viewer }}` permissions. You can find the role descriptions below the chart.

{% include [roles-managed-kafka](../../_mermaid/roles/managed-kafka.md) %}

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

## Required roles {#required-roles}

To use {{ maf-name }}, you need the [{{ roles.mkf.editor }} role or higher](../../iam/concepts/access-control/roles.md) for the folder that will contain the new cluster. The `{{ roles.mkf.viewer }}` role only allows you to view the list of clusters.

To create a {{ mkf-name }} cluster, you need the [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) role and the `{{ roles.mkf.editor }}` role or higher.

You can always assign a role with more permissions. For example, you can assign the `{{ roles.mkf.admin }}` role instead of `{{ roles.mkf.editor }}`.

## What's next {#whats-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about role inheritance](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

