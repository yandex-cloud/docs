---
title: "Managing access in Yandex Managed Service for PostgreSQL"
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

{% include [roles-mdb](../../_includes/roles-mdb.md) %}

## What roles do I need {#required-roles}

The table below lists the roles needed to perform a given action. You can always assign a role granting more permissions than the role specified. For example, you can assign `editor` instead of `viewer`.

| Action | Methods | Required roles |
----- | ----- | -----
| **View data** | |
| View information about the cluster and related resources | `get`, `list` | `viewer` for the folder hosting the cluster |
| View information on the cluster's managed databases and their runtime logs | `get`, `list` | `{{ roles-mdb-viewer }}` for the folder hosting the cluster |
| View information regarding the cluster's managed databases (without access to data or runtime logs) | `get`, `list` | `{{ roles-mdb-auditor }}` for the folder hosting the cluster |
| **Manage resources** | |
| Create clusters and backups in a folder | `create` | `mdb.admin` or `editor` for the folder |
| Creating clusters with hosts that have public access enabled | `create` | Or `vpc.publicAdmin` together with `mdb.admin`, or `editor` for the folder |
| Change and delete clusters and related resources | `update`, `delete` | `mdb.admin` or `editor` for the folder hosting the cluster |
| **Manage resource access** | |
| [Add](../operations/cluster-users.md#adduser), [edit](../operations/cluster-users.md#updateuser), [remove](../operations/cluster-users.md#removeuser) cluster users | `create`, `update`, `delete` | `editor` for the folder hosting the cluster |
| [Manage access to databases](../operations/grant.md) in a cluster | `grantPermission`, `revokePermission` | `editor` for the folder hosting the cluster |
| [Grant a role](../../iam/operations/roles/grant.md), [revoke a role](../../iam/operations/roles/revoke.md), and view the roles assigned for a folder or cloud. | `setAccessBindings`, `updateAccessBindings`, `listAccessBindings` | `admin` for this folder or cloud |

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

Roles in ABC (_MDB administrator_ and _MDB user_) and roles assigned using the **IDM** option (_Person responsible for a cluster_) are different roles. When assigning roles in ABC, the rights to perform actions _on a cluster_ are granted via the API, while with the **IDM** option enabled, this is done _inside the database_.

{% endnote %}

{% endif %}
