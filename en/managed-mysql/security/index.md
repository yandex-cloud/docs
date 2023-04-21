---
title: "Access management in {{ mmy-full-name }}"
description: "Access management in the {{ MY }} database creation and management service. This section describes which resources you can assign roles to, which roles exist in the service, and which roles are required for particular actions."
---

# Access management in {{ mmy-name }}


In this section, you will learn:

* [Which resources you can assign roles to](#resources).
* [Which roles exist in the service](#roles-list).
* [Which roles are required](#required-roles) for particular actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Which resources you can assign roles to {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

To allow access to {{ mmy-name }} service resources (DB clusters and hosts, cluster backups, databases, and their users), assign the user the appropriate roles for the folder or cloud hosting the resources.

## Which roles exist in the service {#roles-list}

The chart below shows which roles are available in the service and how they inherit each other's permissions. For example, the `{{ roles-editor }}` role includes all the permissions of `{{ roles-viewer }}`. You can find the description of each role under the chart.

![image](../../_assets/mdb/roles-managed-mysql.svg)

{% include [mmy-auditor](../../_includes/iam/roles/mmy-auditor.md) %}

{% include [mmy-viewer](../../_includes/iam/roles/mmy-viewer.md) %}

{% include [mmy-editor](../../_includes/iam/roles/mmy-editor.md) %}

{% include [mmy-admin](../../_includes/iam/roles/mmy-admin.md) %}

{% include [mdb.auditor](../../_includes/iam/roles/mdb.auditor.md) %}

{% include [mdb.viewer](../../_includes/iam/roles/mdb.viewer.md) %}

{% include [mdb.admin](../../_includes/iam/roles/mdb.admin.md) %}

{% include [roles-vpc-public-admin](../../_includes/roles-vpc-public-admin.md) %}

### {{ roles-viewer }} {#viewer}

{% include [roles-viewer](../../_includes/roles-viewer.md) %}

### {{ roles-editor }} {#editor}

{% include [roles-editor](../../_includes/roles-editor.md) %}

### {{ roles-admin }} {#admin}

{% include [roles-admin](../../_includes/roles-admin.md) %}

### {{ roles-cloud-member }} {#member}

{% include [roles-cloud-member](../../_includes/roles-cloud-member.md) %}

### {{ roles-cloud-owner }} {#owner}

{% include [roles-cloud-owner](../../_includes/roles-cloud-owner.md) %}

## Roles required {#required-roles}

To use the service, you need the `{{ roles.mmy.editor }}` [role](../../iam/concepts/access-control/roles.md) or higher for the folder where a cluster is created. The `{{ roles.mmy.viewer }}` role only enables you to view the cluster list.

You can always assign a role with more permissions. For instance, you can assign `{{ roles.mmy.admin }}` instead of `{{ roles.mmy.editor }}`.

## What's next {#whats-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

