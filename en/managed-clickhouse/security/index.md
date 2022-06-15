---
title: Access management in {{ mch-full-name }}
description: "Access management in the service for creating and managing {{ CH }} databases. The section describes which resources can be assigned a role, which roles act in the service, which roles are required for this or that action."
---

# Access management in {{ mch-name }}

{% if audience != "internal"%}

In this section, you'll learn:

* [Which resources you can assign roles to](#resources).
* [Which roles exist in the service](#roles-list).
* [Which roles are required](#required-roles) for particular actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## What resources you can assign roles to {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

To allow access to {{ mch-name }} service resources (DB clusters and hosts, cluster backups, databases, and their users), assign the user the appropriate roles for the folder or cloud hosting the resources.

## What roles exist in the service {#roles-list}

{% include [roles-mdb](../../_includes/roles-mdb.md) %}

## What roles do I need {#required-roles}

The table below lists the roles needed to perform a given action. You can always assign a role granting more permissions than the role specified. For instance, assign `{{ roles-editor }}` instead of `{{ roles-viewer }}`.

| Action | Methods | Required roles |
----- | ----- | -----
| **View data** | |
| View information about the cluster and related resources | `get`, `list` | `{{ roles-viewer }}` for the folder hosting the cluster |
| **Manage resources** | |
| Create clusters and backups in the folder | `create` | `{{ roles-mdb-admin }}` or `{{ roles-editor }}` for the folder |
| Creating clusters with hosts that have public access enabled | `create` | Or `{{ roles-vpc-public-admin }}` along with `{{ roles-mdb-admin }}`, or `{{ roles-editor }}` for the folder |
| Change and delete clusters and related resources | `update`, `delete` | `{{ roles-mdb-admin }}` or `{{ roles-editor }}` for the folder hosting the cluster |
| **Manage resource access** | |
| [Add](../operations/cluster-users.md#adduser), [edit](../operations/cluster-users.md#updateuser), [remove](../operations/cluster-users.md#removeuser) cluster users | `create`, `update`, `delete` | `{{ roles-editor }}` for the folder hosting the cluster |
| [Grant a role](../../iam/operations/roles/grant.md), [revoke a role](../../iam/operations/roles/revoke.md), and view the roles assigned for a folder or cloud. | `setAccessBindings`, `updateAccessBindings`, `listAccessBindings` | `{{ roles-admin }}` for this folder or cloud |

## What's next {#whats-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [More information on inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

{% else %}

{% include [abc-roles](../../_includes/mdb/internal/abc-roles.md) %}

{% endif %}
