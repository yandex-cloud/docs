---
title: "Access to {{ mms-name }}"
description: "To allow access to {{ mms-name }} service resources (DB clusters and hosts, cluster backups, databases, and their users), assign to the user the relevant roles for the folder or cloud hosting the resources."
keywords:
  - access
  - configuring access
  - "{{ MS }} access"
  - ms sql server
  - "{{ MS }}"
---

# Access management in {{ mms-name }}

{% if audience != "internal"%}

In this section, you will learn:
* [Which resources you can assign roles to](#resources).
* [Which roles exist in the service](#roles-list).
* [Which roles are required](#required-roles) for particular actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Which resources you can assign roles to {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

To allow access to {{ mms-name }} service resources (DB clusters and hosts, cluster backups, databases, and their users), assign the user the appropriate roles for the folder or cloud hosting the resources.

## Which roles exist in the service {#roles-list}

The chart below shows which roles are available in the service and how they inherit each other's permissions. For example, the `{{ roles-editor }}` role includes all the permissions of `{{ roles-viewer }}`. You can find the description of each role under the chart.

![image](../../_assets/mdb/roles-managed-sqlserver.svg)

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

### {{ roles.mms.admin }} {#mms-admin}

{% include [roles-mms-admin](../../_includes/roles-mms-admin.md) %}

### {{ roles.mms.auditor }} {#mms-auditor}

{% include [roles-mms-auditor](../../_includes/roles-mms-auditor.md) %}

### {{ roles.mms.editor }} {#mms-editor}

{% include [roles-mms-editor](../../_includes/roles-mms-editor.md) %}

### {{ roles.mms.viewer }} {#mms-viewer}

{% include [roles-mms-viewer](../../_includes/roles-mms-viewer.md) %}

## Roles required {#required-roles}

To use the service, you need the `{{ roles.mms.editor }}` [role](../../iam/concepts/access-control/roles.md) or higher to the folder where a cluster is created. The `{{ roles.mms.viewer }}` role only enables you to view the cluster list.

You can always assign a role with more permissions. For instance, you can assign `{{ roles.mms.admin }}` instead of `{{ roles.mms.editor }}`.

## What's next {#whats-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

{% else %}

{% include [abc-roles](../../_includes/mdb/internal/abc-roles.md) %}

{% endif %}
