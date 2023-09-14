# Managing access to {{ mes-name }}

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}


In this section, you will learn:

* [Which resources you can assign roles to](#resources).
* [Which roles exist in the service](#roles-list).
* [Which roles are required](#required-roles) for particular actions.


To use the service, log in to the management console with a [Yandex account](../../iam/concepts/index.md#passport) or [federated account](../../iam/concepts/index.md#saml-federation).


{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Which resources you can assign roles to {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

To allow access to {{ mes-name }} service resources (clusters and hosts, cluster backups, and accounts), assign the user the appropriate roles for a folder or cloud hosting the resources.

## Which roles exist in the service {#roles-list}

The chart below shows which roles are available in the service and how they inherit each other's permissions. For example, the `{{ roles-editor }}` role includes all the permissions of `{{ roles-viewer }}`. You can find the description of each role under the chart.

![image](../../_assets/mdb/roles-managed-elasticsearch.svg)

### Service roles {#service-roles}

{% include [mes-auditor](../../_includes/iam/roles/mes-auditor.md) %}

{% include [mes-viewer](../../_includes/iam/roles/mes-viewer.md) %}

{% include [mes-editor](../../_includes/iam/roles/mes-editor.md) %}

{% include [mes-admin](../../_includes/iam/roles/mes-admin.md) %}

{% include [mdb.auditor](../../_includes/iam/roles/mdb.auditor.md) %}

{% include [mdb.viewer](../../_includes/iam/roles/mdb.viewer.md) %}

{% include [mdb.admin](../../_includes/iam/roles/mdb.admin.md) %}

{% include [roles-vpc-public-admin](../../_includes/roles-vpc-public-admin.md) %}

#### {{ roles-cloud-member }} {#member}

{% include [roles-cloud-member](../../_includes/roles-cloud-member.md) %}

#### {{ roles-cloud-owner }} {#owner}

{% include [roles-cloud-owner](../../_includes/roles-cloud-owner.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

## Roles required {#required-roles}

To use the service, you need the `{{ roles.mes.editor }}` [role](../../iam/concepts/access-control/roles.md) or higher for the folder where a cluster is created. The `{{ roles.mes.viewer }}` role only enables you to view the cluster list.

You can always assign a role with more permissions. For instance, you can assign `{{ roles.mes.admin }}` instead of `{{ roles.mes.editor }}`.

## What's next {#whats-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

