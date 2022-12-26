---
title: Access management in Yandex Data Proc
description: "Access management in the Apache Hadoop and Apache Spark cluster creation and management service. To allow access to the Data Proc service resources (clusters or subclusters), assign the user the required roles from the list below."
---

# Access management in {{ dataproc-name }}

{{ yandex-cloud }} users can only perform operations on resources that are allowed by the roles assigned to them. If a user doesn't have any roles assigned, almost all operations are forbidden.

To allow access to {{ dataproc-name }} service resources (clusters and subclusters), assign the user the required roles from the list below. Currently, a role can only be assigned to a parent resource (folder or cloud). Roles are inherited by nested resources.

{% note info %}

For more information about role inheritance, see [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-full-name }} documentation.

{% endnote %}

## Assigning roles {#grant-role}

To assign a user a role:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Roles {#roles}

The list below shows all roles that are considered when verifying access rights in the {{ dataproc-name }} service.

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

{% include [mdb.dataproc.agent](../../_includes/roles-dataproc-agent.md) %}

{% include [data-proc-roles](../../_includes/data-proc/data-proc-roles.md) %}

### {{ roles-viewer }} {#viewer}

A user with the role `{{ roles-viewer }}` can connect to hosts in a
{{ dataproc-name }} cluster if their {% if lang == "ru" and audience != "internal" %}[SSH keys](../../glossary/ssh-keygen.md){% else %}SSH keys{% endif %} are linked to this cluster.

### {{ roles-mdb-admin }} {#mdb-admin}

A user with the role `{{ roles-mdb-admin }}` can manage {{ dataproc-name }} clusters, for example, create a cluster or create or delete a subcluster in a cluster.

The `{{ roles-mdb-admin }}` role also includes all permissions of the `{{ roles-viewer }}` role.

### {{ roles-editor }} {#editor}

Users with the `{{ roles-editor }}` role can manage any resource, including creating clusters and creating and deleting their subclusters.

The `{{ roles-editor }}` role also includes all permissions of the `{{ roles-viewer }}` role.

### {{ roles-admin }} {#admin}

Users with the `{{ roles-admin }}` role can manage resource access rights, including allowing other users to create {{ dataproc-name }} clusters and to view information about user rights.

The `{{ roles-admin }}` role also includes all permissions of the `{{ roles-editor }}` role.
