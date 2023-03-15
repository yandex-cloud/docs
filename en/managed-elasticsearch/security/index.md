# Managing access to {{ mes-name }}


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

### {{ roles.mes.admin }} {#mes-admin}

{% include [roles-mes-admin](../../_includes/roles-mes-admin.md) %}

### {{ roles.mes.auditor }} {#mes-auditor}

{% include [roles-mes-auditor](../../_includes/roles-mes-auditor.md) %}

### {{ roles.mes.editor }} {#mes-editor}

{% include [roles-mes-editor](../../_includes/roles-mes-editor.md) %}

### {{ roles.mes.viewer }} {#mes-viewer}

{% include [roles-mes-viewer](../../_includes/roles-mes-viewer.md) %}

## Roles required {#required-roles}

To use the service, you need the `{{ roles.mes.editor }}` [role](../../iam/concepts/access-control/roles.md) or higher for the folder where a cluster is created. The `{{ roles.mes.viewer }}` role only enables you to view the cluster list.

You can always assign a role with more permissions. For instance, you can assign `{{ roles.mes.admin }}` instead of `{{ roles.mes.editor }}`.

## What's next {#whats-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

