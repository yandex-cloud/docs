---
title: "Managing access to {{ mes-name }}"
description: "In this section, you will learn about the resources for which you can assign a role, the roles existing in the service, and the roles required to perform a particular action."
---

# Managing access to {{ mes-name }}

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}


In this section, you will learn:

* [Which resources you can assign a role for](#resources).
* [Which roles exist in the service](#roles-list).
* [Which roles are required](#required-roles) for particular actions.


To use the service, log in to the management console with a [Yandex account](../../iam/concepts/users/accounts.md#passport) or [federated account](../../iam/concepts/users/accounts.md#saml-federation).


{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

{% include [roles-assign](../../_includes/iam/roles-assign.md) %}

## Which resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

To allow access to {{ mes-name }} service resources (clusters and hosts, cluster backups, and accounts), assign the user the appropriate roles for a folder or cloud hosting the resources.

## Which roles exist in the service {#roles-list}

The chart below shows which roles are available in the service and how they inherit each other's permissions. For example, the `{{ roles-editor }}` role includes all the permissions of `{{ roles-viewer }}`. You can find the description of each role under the chart.

![image](../../_assets/mdb/roles-managed-elasticsearch.svg)

### Service roles {#service-roles}

#### managed-elasticsearch.viewer {#managed-elasticsearch-viewer}

{% include [managed-elasticsearch.viewer](../../_roles/managed-elasticsearch/viewer.md) %}

#### managed-elasticsearch.editor {#managed-elasticsearch-editor}

{% include [managed-elasticsearch.editor](../../_roles/managed-elasticsearch/editor.md) %}

#### managed-elasticsearch.admin {#managed-elasticsearch-admin}

{% include [managed-elasticsearch.admin](../../_roles/managed-elasticsearch/admin.md) %}

#### mdb.auditor {#mdb-auditor}

{% include [mdb-auditor](../../_roles/mdb/auditor.md) %}

#### mdb.viewer {#mdb-viewer}

{% include [mdb-viewer](../../_roles/mdb/viewer.md) %}

#### mdb.admin {#mdb-admin}

{% include [mdb-admin](../../_roles/mdb/admin.md) %}

#### vpc.publicAdmin {#vpc-public-admin}

{% include [vpc-publicadmin](../../_roles/vpc/publicAdmin.md) %}


### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

## Roles required {#required-roles}

To use the service, you need the `{{ roles.mes.editor }}` [role](../../iam/concepts/access-control/roles.md) or higher for the folder where the cluster is created. With the`{{ roles.mes.viewer }}` role, you can only view the list of clusters.

You can always assign a role with more permissions. For instance, you can assign `{{ roles.mes.admin }}` instead of `{{ roles.mes.editor }}`.

## What's next {#whats-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

