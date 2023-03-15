---
title: "Access management in {{ mrd-full-name }}"
description: "Access management in the Redis database creation and management service. This section describes which resources you can assign roles to, which roles exist in the service, and which roles are required for particular actions."
---

# Access management in {{ mrd-name }}


In this section, you will learn:

* [Which resources you can assign roles to](#resources).
* [Which roles exist in the service](#roles-list).
* [Which roles are required](#required-roles) for particular actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Which resources you can assign roles to {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

To allow access to {{ mrd-name }} service resources (DB clusters and hosts, cluster backups, databases, and their users), assign the user the appropriate roles for the folder or cloud hosting the resources.

## Which roles exist in the service {#roles-list}

The chart below shows which roles are available in the service and how they inherit each other's permissions. For example, the `{{ roles-editor }}` role includes all the permissions of `{{ roles-viewer }}`. You can find the description of each role under the chart.

![image](../../_assets/mdb/roles-managed-redis.svg)

### {{ roles-mdb-admin }} {#mdb-admin}

{% include [roles-mdb-admin](../../_includes/roles-mdb-admin.md) %}

### {{ roles-mdb-viewer }} {#mdb-viewer}

{% include [roles-mdb-viewer](../../_includes/roles-mdb-viewer.md) %}

### {{ roles-mdb-auditor }} {#mdb-auditor}

{% include [roles-mdb-auditor](../../_includes/roles-mdb-auditor.md) %}

### {{ roles-cloud-member }} {#resmgr-clouds-member}

{% include [roles-cloud-member](../../_includes/roles-cloud-member.md) %}

### {{ roles-cloud-owner }} {#resmgr-clouds-owner}

{% include [roles-cloud-owner](../../_includes/roles-cloud-owner.md) %}

{% include [roles-vpc-public-admin](../../_includes/roles-vpc-public-admin.md) %}

### {{ roles-viewer }} {#viewer}

{% include [roles-viewer](../../_includes/roles-viewer.md) %}

### {{ roles-editor }} {#editor}

{% include [roles-editor](../../_includes/roles-editor.md) %}

### {{ roles-admin }} {#admin}

{% include [roles-admin](../../_includes/roles-admin.md) %}

### {{ roles.mrd.admin }} {#mrd-admin}

{% include [roles-mrd-admin](../../_includes/roles-mrd-admin.md) %}

### {{ roles.mrd.auditor }} {#mrd-auditor}

{% include [roles-mrd-auditor](../../_includes/roles-mrd-auditor.md) %}

### {{ roles.mrd.editor }} {#mrd-editor}

{% include [roles-mrd-editor](../../_includes/roles-mrd-editor.md) %}

### {{ roles.mrd.viewer }} {#mrd-viewer}

{% include [roles-mrd-viewer](../../_includes/roles-mrd-viewer.md) %}

## Roles required {#required-roles}

To use the service, you need the `{{ roles.mrd.editor }}` [role](../../iam/concepts/access-control/roles.md) or higher to the folder where a cluster is created. The `{{ roles.mrd.viewer }}` role only enables you to view the cluster list.

You can always assign a role with more permissions. For instance, you can assign `{{ roles.mrd.admin }}` instead of `{{ roles.mrd.editor }}`.

## What's next {#whats-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

