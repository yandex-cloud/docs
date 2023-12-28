---
title: "Access management in {{ dataproc-full-name }}"
description: "Access management in the service for creation and management of Apache Hadoop® and Apache Spark™ clusters. To allow access to {{ dataproc-name }} resources (clusters and subclusters), assign the user the required roles from the list below."
---

# Access management in {{ dataproc-name }}

{{ yandex-cloud }} users can only perform operations on resources that are allowed by the roles assigned to them. If a user does not have any roles assigned, almost all operations are forbidden.

To allow access to {{ dataproc-name }} resources (clusters or subclusters), assign the Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated users](../../iam/concepts/federations.md), [user group](../../organization/operations/manage-groups.md), or [system group](../../iam/concepts/access-control/system-group.md) the required roles from the list below. Currently, a role can only be assigned to a parent resource (folder or cloud). Roles are inherited by nested resources.

Only users with the `admin`, `resource-manager.clouds.owner`, or `organization-manager.organizations.owner` role for a resource can assign roles for this resource.

{% note info %}

For more information about role inheritance, see [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-full-name }} documentation.

{% endnote %}

## Assigning roles {#grant-role}

To assign a user a role:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Which roles exist in the service {#roles-list}

The list below shows all roles that are considered when verifying access rights in the {{ dataproc-name }} service.

### Service roles {#service-roles}

{% include [mdb.dataproc.agent](../../_includes/iam/roles/dataproc-agent.md) %}

{% include [data-proc-roles](../../_includes/iam/roles/data-proc-roles.md) %}

{% include [managed-metastore-roles](../../_includes/iam/roles/managed-metastore-roles.md) %}

{% include [mdb.auditor](../../_includes/iam/roles/mdb.auditor.md) %}

{% include [mdb.viewer](../../_includes/iam/roles/mdb.viewer.md) %}

{% include [mdb.admin](../../_includes/iam/roles/mdb.admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}
