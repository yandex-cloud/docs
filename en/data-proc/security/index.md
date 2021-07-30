---
title: Access management in Yandex Data Proc
description: "Access management in the Apache Hadoop and Apache Spark cluster creation and management service. To allow access to the Data Proc service resources (clusters or subclusters), assign the user the required roles from the list below."

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# Access management in {{ dataproc-name }}

Yandex.Cloud users can only perform operations on resources that are permitted under the roles assigned to them. If a user doesn't have any roles assigned, almost all operations are forbidden.

To allow access to {{ dataproc-name }} service resources (clusters and subclusters), assign the user the required roles from the list below. For now, a role can only be assigned for a parent resource (folder or cloud), and roles are inherited by nested resources.

{% note info %}

For more information about role inheritance, see [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-full-name }} documentation.

{% endnote %}

## Assigning roles {#grant-role}

To assign a user a role:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Roles {#roles}

The list below shows all the roles used when verifying access rights in
{{ dataproc-name }}.

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

{% include [mdb.dataproc.agent](../../_includes/roles-dataproc-agent.md) %}

### {{ roles-viewer }} {#viewer}

Users with the `{{ roles-viewer }}` role can connect to hosts in the {{ dataproc-name }} cluster if its SSH keys are linked to this cluster.

### {{ roles-editor }} {#editor}

Users with the `{{ roles-editor }}` role can manage any resource, including creating clusters and creating and deleting their subclusters.

The `{{ roles-editor }}` role also includes all `{{ roles-viewer }}` role permissions.

### {{ roles-admin }} {#admin}

Users with the `{{ roles-admin }}` role can manage resource access rights, including allowing other users to create {{ dataproc-name }} clusters and to view information about user rights.

The `{{ roles-admin }}` role also includes all `{{ roles-editor }}` role permissions.