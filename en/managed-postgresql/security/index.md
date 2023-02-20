---
title: "Access management in {{ mpg-full-name }}"
description: "Access management in the PostgreSQL database creation and management service. The section describes which resources you can assign roles to, which roles exist in the service, and which roles are required for particular actions."
---

# Access management in {{ mpg-name }}

{% if audience != "internal"%}

In this section, you'll learn:

* [Which resources you can assign roles to](#resources).
* [Which roles exist in the service](#roles-list).
* [Which roles are required](#required-roles) for particular actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## What resources you can assign roles to {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

To allow access to {{ mpg-name }} service resources (DB clusters and hosts, cluster backups, databases, and their users), assign the user the appropriate roles for the folder or cloud hosting the resources.

## What roles exist in the service {#roles-list}

The diagram shows which roles are available in the service and how they inherit each other's permissions. For example, the `{{ roles-editor }}` role includes all the permissions of `{{ roles-viewer }}`. A description of each role is given under the diagram.

![image](../../_assets/mdb/roles-managed-postgresql.svg)

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

### {{ roles.mpg.admin }} {#mpg-admin}

{% include [roles-mpg-admin](../../_includes/roles-mpg-admin.md) %}

### {{ roles.mpg.auditor }} {#mpg-auditor}

{% include [roles-mpg-auditor](../../_includes/roles-mpg-auditor.md) %}

### {{ roles.mpg.editor }} {#mpg-editor}

{% include [roles-mpg-editor](../../_includes/roles-mpg-editor.md) %}

### {{ roles.mpg.viewer }} {#mpg-viewer}

{% include [roles-mpg-viewer](../../_includes/roles-mpg-viewer.md) %}

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

## Identity Management (IDM) {#idm}

**IDM** is an option that is enabled when creating a cluster to use the [SOX data access mechanism](https://ru.wikipedia.org/wiki/Закон_Сарбейнза_—_Оксли). This option is required to assign _persons responsible for a cluster_ and to provide cluster access in [Identity Management](https://idm.yandex-team.ru/) (IDM). It's mandatory for clusters created in the `PRODUCTION` environment. You can't disable the option.

_Persons responsible for a cluster_ are approved by _responsible employees from MDB_. A person _responsible for a cluster_ can then approve requests for cluster roles along with the MDB team.

The following roles are granted using the **IDM** option:

* Read.
* Write.
* Responsible.

{% note warning %}

Roles in ABC (_MDB administrator_ and _MDB user_) and roles assigned using the **IDM** option (_Person responsible for a cluster_) are different roles. When assigning roles in ABC, the rights to perform actions _on a cluster_ are granted via the {% if lang == "ru" and audience != "internal" %}[API](../../glossary/rest-api.md){% else %}API{% endif %}, while with the **IDM** option enabled, this is done _inside the database_.

{% endnote %}

{% endif %}
