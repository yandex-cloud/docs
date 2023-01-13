---
title: "Access to {{ mgp-name }}"
description: "To allow access to {{ mgp-name }} service resources (DB clusters and hosts, cluster backups, databases, and their users), assign the user the appropriate roles for the folder or cloud hosting the resources."
keywords:
  - access
  - configuring access
  - access to {{ GP }}
  - green plum
  - {{ GP }}
---

# Access management in {{ mgp-name }}

{% if audience != "internal"%}

In this section, you'll learn:

* [Which resources you can assign roles to](#resources).
* [Which roles exist in the service](#roles-list).
* [Which roles are required](#required-roles) for particular actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}


## What resources you can assign roles to {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

To allow access to {{ mgp-name }} service resources (DB clusters and hosts, cluster backups, databases, and their users), assign the user the appropriate roles for the folder or cloud hosting the resources.

## What roles exist in the service {#roles-list}

The diagram shows which roles are available in the service and how they inherit each other's permissions. For example, the `{{ roles-editor }}` role includes all the permissions of `{{ roles-viewer }}`. A description of each role is given under the diagram.

![image](../../_assets/mdb/service-roles-hierarchy.svg)

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

### {{ roles.mgp.admin }} {#mgp-admin}

{% include [roles-mgp-admin](../../_includes/roles-mgp-admin.md) %}

### {{ roles.mgp.auditor }} {#mgp-auditor}

{% include [roles-mgp-auditor](../../_includes/roles-mgp-auditor.md) %}

### {{ roles.mgp.editor }} {#mgp-editor}

{% include [roles-mgp-editor](../../_includes/roles-mgp-editor.md) %}

### {{ roles.mgp.viewer }} {#mgp-viewer}

{% include [roles-mgp-viewer](../../_includes/roles-mgp-viewer.md) %}

## Roles required {#required-roles}

To use the service, you need the `editor` [role](../../iam/concepts/access-control/roles.md) or higher to the folder where a cluster is created. The `viewer` role only enables you to view the cluster list.

You can always assign a role with more permissions. For example, assign the `admin` role instead of `editor`.

## What's next {#whats-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [More information on inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

{% else %}

{% include [abc-roles](../../_includes/mdb/internal/abc-roles.md) %}

{% endif %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
