---
title: "Access management in {{ mmg-full-name }}"
description: "Access management in the MongoDB database creation and management service. This section describes the resources for which you can assign a role, the roles existing in the service, and the roles required to perform a particular action."
---

# Access management in {{ mmg-name }}


In this section, you will learn:

* [Which resources you can assign a role for](#resources).
* [Which roles exist in the service](#roles-list).
* [Which roles are required](#required-roles) for particular actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Which resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

To allow access to {{ mmg-name }} service resources (DB clusters and hosts, cluster backups, databases, and their users), assign the user the appropriate roles for the folder or cloud hosting the resources.

## Which roles exist in the service {#roles-list}

The chart below shows which roles are available in the service and how they inherit each other's permissions. For example, the `{{ roles-editor }}` role includes all the permissions of `{{ roles-viewer }}`. You can find the description of each role under the chart.

![image](../../_assets/mdb/roles-managed-mongodb.svg)

### Service roles {#service-roles}

{% include [mmg-auditor](../../_includes/iam/roles/mmg-auditor.md) %}

{% include [mmg-viewer](../../_includes/iam/roles/mmg-viewer.md) %}

{% include [mmg-editor](../../_includes/iam/roles/mmg-editor.md) %}

{% include [mmg-admin](../../_includes/iam/roles/mmg-admin.md) %}

{% include [mdb.auditor](../../_includes/iam/roles/mdb.auditor.md) %}

{% include [mdb.viewer](../../_includes/iam/roles/mdb.viewer.md) %}

{% include [mdb.admin](../../_includes/iam/roles/mdb.admin.md) %}

{% include [roles-vpc-public-admin](../../_includes/roles-vpc-public-admin.md) %}


### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

## Roles required {#required-roles}

To use the service, you need the `{{ roles.mmg.editor }}` [role](../../iam/concepts/access-control/roles.md) or higher for the folder where a cluster is created. The `{{ roles.mmg.viewer }}` role only enables you to view the cluster list.

You can always assign a role with more permissions. For instance, you can assign `{{ roles.mmg.admin }}` instead of `{{ roles.mmg.editor }}`.

## What's next {#whats-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

