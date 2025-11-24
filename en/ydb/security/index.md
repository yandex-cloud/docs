---
title: Access management in {{ ydb-full-name }}
description: Access management in {{ ydb-full-name }}, a database creation and management service. To allow access to {{ ydb-short-name }} resources (databases and their users), assign to the user the relevant roles from the list.
sourcePath: overlay/security/start_auth.md
---

# Access management in {{ ydb-name }}

{{ yandex-cloud }} users can only perform operations on resources in accordance with the roles assigned to them. Without assigned roles, a user cannot perform most operations.

To allow access to {{ ydb-short-name }} resources (databases and their users), assign relevant roles from the list below to a Yandex account, [service account](../../iam/concepts/users/service-accounts.md), [federated](../../iam/concepts/users/accounts.md#saml-federation) or [local](../../iam/concepts/users/accounts.md#local) users, [user group](../../organization/operations/manage-groups.md), [system group](../../iam/concepts/access-control/system-group.md), or [public group](../../iam/concepts/access-control/public-group.md). A role can be assigned for a parent resource (folder or cloud) whose roles are inherited by nested resources.

You can also grant a role to access a specific database. This will allow a user without any roles in the directory hosting the database to access the database according to the role assigned.

To assign a role for a resource, a user should have the `ydb.admin` role or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

{% note info %}

For more information about role inheritance, see [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-full-name }} guide.

{% endnote %}

## Assigning roles {#grant-roles}

To assign a role to a user:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

You can also assign roles for individual resources within the service:

{% list tabs group=instructions %}

- Management console {#console}

  Use the [management console]({{ link-console-main }}) to assign roles for the [YDB DBMS](../concepts/index.md#ydb).

- CLI {#cli}

  You can use the [{{ yandex-cloud }} CLI](../../cli/cli-ref/ydb/cli-ref/index.md) to assign roles for the following resources:

  * [YDB DBMS](../concepts/index.md#ydb)
  * YDB DBMS backup

- {{ TF }} {#tf}

  Use the [{{ TF }}]({{ tf-provider-resources-link }}/ydb_database_iam_binding) to assign roles for the [YDB DBMS](../concepts/index.md#ydb).

- API {#api}

  Use the [{{ yandex-cloud }}](../api-ref/authentication.md) API to assign roles for the following resources:

  * [YDB DBMS](../concepts/index.md#ydb)
  * YDB DBMS backup

{% endlist %}

## Roles this service has {#roles-list}

The list below shows all roles used for access control in {{ ydb-name }}.

### Service roles {#service-roles}

#### ydb.auditor {#ydb-auditor}

{% include [ydb.auditor](../../_roles/ydb/auditor.md) %}

#### ydb.viewer {#ydb-viewer}

{% include [ydb.viewer](../../_roles/ydb/viewer.md) %}

#### ydb.editor {#ydb-editor}

{% include [ydb.editor](../../_roles/ydb/editor.md) %}

#### ydb.admin {#ydb-admin}

{% include [ydb.admin](../../_roles/ydb/admin.md) %}

#### ydb.kafkaApi.client {#ydb-kafkaapi-client}

{% include [ydb.kafkaApi.client](../../_roles/ydb/kafkaApi/client.md) %}


### Primitive roles {#primitive-roles}

#### {{ roles-auditor }} {#auditor}

{% include [roles-auditor](../../_roles/primitive-roles/auditor.md) %}

#### {{ roles-viewer }} {#viewer}

{% include [roles-viewer](../../_roles/primitive-roles/viewer.md) %}

#### {{ roles-editor }} {#editor}

{% include [roles-editor](../../_roles/primitive-roles/editor.md) %}

#### {{ roles-admin }} {#admin}

{% include [roles-admin](../../_roles/primitive-roles/admin.md) %}
