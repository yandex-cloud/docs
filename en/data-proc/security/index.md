---
title: Access management in {{ dataproc-full-name }}
description: Access management for Apache Hadoop® and Apache Spark™ cluster creation and management services. To grant a user access to {{ dataproc-name }} resources, i.e., clusters and subclusters, assign them the roles from the list below.
---

# Access management in {{ dataproc-name }}

{{ yandex-cloud }} users can only perform operations on resources according to their assigned roles. Without assigned roles, a user cannot perform most operations.

To allow a user or group, e.g., Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated user](../../iam/concepts/federations.md), [user group](../../organization/operations/manage-groups.md), [system group](../../iam/concepts/access-control/system-group.md), or [public group](../../iam/concepts/access-control/public-group.md), access to {{ dataproc-name }} resources, i.e., clusters and subclusters, assign them the roles from the list below. Currently, a role can only be assigned for a parent resource, such as a folder or cloud. Roles are inherited by nested resources.

To assign a role for a resource, a user should have either the `mdb.admin` role, or `dataproc.admin` role, or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

{% note info %}

For more information about role inheritance, see [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-full-name }} documentation.

{% endnote %}

## Assigning roles {#grant-role}

To assign a role to a user:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## What roles exist in this service {#roles-list}

The list below shows all roles used for access control in {{ dataproc-name }}.

### Service roles {#service-roles}

#### dataproc.agent {#dataproc-agent}

{% include [dataproc.agent](../../_roles/data-processing/agent.md) %}

#### dataproc.auditor {#dataproc-auditor}

{% include [dataproc.auditor](../../_roles/data-processing/auditor.md) %}

#### dataproc.viewer {#dataproc-viewer}

{% include [dataproc.viewer](../../_roles/data-processing/viewer.md) %}

#### dataproc.user {#dataproc-user}

{% include [dataproc.user](../../_roles/data-processing/user.md) %}

#### dataproc.provisioner {#dataproc-provisioner}

{% include [dataproc.provisioner](../../_roles/data-processing/provisioner.md) %}

#### dataproc.editor {#dataproc-editor}

{% include [dataproc.editor](../../_roles/data-processing/editor.md) %}

#### dataproc.admin {#dataproc-admin}

{% include [dataproc.admin](../../_roles/data-processing/admin.md) %}

#### mdb.auditor {#mdb-auditor}

{% include [mdb-auditor](../../_roles/mdb/auditor.md) %}

#### mdb.viewer {#mdb-viewer}

{% include [mdb-viewer](../../_roles/mdb/viewer.md) %}

#### mdb.admin {#mdb-admin}

{% include [mdb-admin](../../_roles/mdb/admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}