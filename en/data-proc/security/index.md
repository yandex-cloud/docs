---
title: "Access management in {{ dataproc-full-name }}"
description: "Access management in the service for creation and management of Apache Hadoop® and Apache Spark™ clusters. To allow access to {{ dataproc-name }} resources (clusters and subclusters), assign the user the required roles from the list below."
---

# Access management in {{ dataproc-name }}

{{ yandex-cloud }} users can only perform operations on resources that are allowed by the roles assigned to them. If a user does not have any roles assigned, almost all operations are forbidden.

To enable access to {{ dataproc-name }} resources (clusters and subclusters), assign the required roles from the list below to a Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated users](../../iam/concepts/federations.md), [user group](../../organization/operations/manage-groups.md), [system group](../../iam/concepts/access-control/system-group.md), or [public group](../../iam/concepts/access-control/public-group.md). Currently, a role can only be assigned for a parent resource (folder or cloud). Roles are inherited by nested resources.

Roles for a resource can be assigned by users who have the `mdb.admin`, `dataproc.admin`, or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

{% note info %}

For more information about role inheritance, see [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-full-name }} documentation.

{% endnote %}

## Assigning roles {#grant-role}

To assign a user a role:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Which roles exist in the service {#roles-list}

The list below shows all roles considered when verifying access permissions in {{ dataproc-name }}.

### Service roles {#service-roles}

#### dataproc.agent {#dataproc-agent}

{% include [dataproc.agent](../../_roles/dataproc/agent.md) %}

#### dataproc.auditor {#dataproc-auditor}

{% include [dataproc.auditor](../../_roles/dataproc/auditor.md) %}

#### dataproc.viewer {#dataproc-viewer}

{% include [dataproc.viewer](../../_roles/dataproc/viewer.md) %}

#### dataproc.user {#dataproc-user}

{% include [dataproc.user](../../_roles/dataproc/user.md) %}

#### dataproc.provisioner {#dataproc-provisioner}

{% include [dataproc.provisioner](../../_roles/dataproc/provisioner.md) %}

#### dataproc.editor {#dataproc-editor}

{% include [dataproc.editor](../../_roles/dataproc/editor.md) %}

#### dataproc.admin {#dataproc-admin}

{% include [dataproc.admin](../../_roles/dataproc/admin.md) %}

#### managed-metastore.auditor {#managed-metastore-auditor}

{% include [managed-metastore.auditor](../../_roles/managed-metastore/auditor.md) %}

#### managed-metastore.viewer {#managed-metastore-viewer}

{% include [managed-metastore.viewer](../../_roles/managed-metastore/viewer.md) %}

#### managed-metastore.editor {#managed-metastore-editor}

{% include [managed-metastore.editor](../../_roles/managed-metastore/editor.md) %}

#### managed-metastore.admin {#managed-metastore-admin}

{% include [managed-metastore.admin](../../_roles/managed-metastore/admin.md) %}

#### managed-metastore.integrationProvider {#managed-metastore-integrationProvider}

{% include [managed-metastore.integrationProvider](../../_roles/managed-metastore/integrationProvider.md) %}

#### mdb.auditor {#mdb-auditor}

{% include [mdb-auditor](../../_roles/mdb/auditor.md) %}

#### mdb.viewer {#mdb-viewer}

{% include [mdb-viewer](../../_roles/mdb/viewer.md) %}

#### mdb.admin {#mdb-admin}

{% include [mdb-admin](../../_roles/mdb/admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}