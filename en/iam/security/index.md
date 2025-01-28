---
title: Access management in {{ iam-full-name }} ({{ iam-short-name }})
description: Access management in {{ iam-full-name }} ({{ iam-short-name }}), an identity and access management service. This section describes the resources for which you can assign a role, the roles existing in the service, and the roles required to perform a particular action.
---

# Access management in {{ iam-name }}

In this section, you will learn:
* [Which resources you can assign a role for](#resources).
* [Which roles exist in the service](#roles-list).
* [Which roles are required](#choosing-roles) for particular actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Roles for a resource can be assigned by users who have the `iam.admin` role or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## Which resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

You can assign a role for a [service account](../concepts/users/service-accounts.md) in the [management console]({{ link-console-main }}) or using the {{ yandex-cloud }} [CLI](../../cli/cli-ref/iam/cli-ref/service-account/add-access-binding.md), [API](../api-ref/authentication.md), or [{{ TF }}]({{ tf-provider-resources-link }}/iam_service_account_iam_binding).

## Which roles exist in the service {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](../../_assets/iam/security/service-roles-hierarchy.svg)

### Service roles {#service-roles}

#### iam.serviceAccounts.user {#iam-serviceAccounts-user}

{% include [iam.serviceAccounts.user](../../_roles/iam/serviceAccounts/user.md) %}

#### iam.serviceAccounts.admin {#iam-serviceAccounts-admin}

{% include [iam.serviceAccounts.admin](../../_roles/iam/serviceAccounts/admin.md) %}

For some services, e.g., [{{ ig-name }}](../../compute/concepts/instance-groups/index.md) or [{{ managed-k8s-name }}]({{ link-cloud-services }}/managed-kubernetes), you need a service account to perform operations. If you specified a service account in the request, {{ iam-short-name }} will check whether you have permissions to use this account.

#### iam.serviceAccounts.accessKeyAdmin {#iam-serviceAccounts-accessKeyAdmin}

{% include [iam.serviceAccounts.accessKeyAdmin](../../_roles/iam/serviceAccounts/accessKeyAdmin.md) %}

#### iam.serviceAccounts.apiKeyAdmin {#iam-serviceAccounts-apiKeyAdmin}

{% include [iam.serviceAccounts.apiKeyAdmin](../../_roles/iam/serviceAccounts/apiKeyAdmin.md) %}

#### iam.serviceAccounts.authorizedKeyAdmin {#iam-serviceAccounts-authorizedKeyAdmin}

{% include [iam.serviceAccounts.authorizedKeyAdmin](../../_roles/iam/serviceAccounts/authorizedKeyAdmin.md) %}

#### iam.serviceAccounts.keyAdmin {#iam-serviceAccounts-keyAdmin}

{% include [iam.serviceAccounts.keyAdmin](../../_roles/iam/serviceAccounts/keyAdmin.md) %}

#### iam.serviceAccounts.tokenCreator {#iam-serviceAccounts-tokenCreator}

{% include [iam.serviceAccounts.tokenCreator](../../_roles/iam/serviceAccounts/tokenCreator.md) %}

#### iam.serviceAccounts.federatedCredentialViewer {#iam-serviceAccounts-federatedCredentialViewer}

{% include [iam.serviceAccounts.federatedCredentialViewer](../../_roles/iam/serviceAccounts/federatedCredentialViewer.md) %}

#### iam.serviceAccounts.federatedCredentialEditor {#iam-serviceAccounts-federatedCredentialEditor}

{% include [iam.serviceAccounts.federatedCredentialEditor](../../_roles/iam/serviceAccounts/federatedCredentialEditor.md) %}

#### iam.workloadIdentityFederations.auditor {#iam-workloadIdentityFederations-auditor}

{% include [iam.workloadIdentityFederations.auditor](../../_roles/iam/workloadIdentityFederations/auditor.md) %}

#### iam.workloadIdentityFederations.viewer {#iam-workloadIdentityFederations-viewer}

{% include [iam.workloadIdentityFederations.viewer](../../_roles/iam/workloadIdentityFederations/viewer.md) %}

#### iam.workloadIdentityFederations.user {#iam-workloadIdentityFederations-user}

{% include [iam.workloadIdentityFederations.user](../../_roles/iam/workloadIdentityFederations/user.md) %}

#### iam.workloadIdentityFederations.editor {#iam-workloadIdentityFederations-editor}

{% include [iam.workloadIdentityFederations.editor](../../_roles/iam/workloadIdentityFederations/editor.md) %}

#### iam.workloadIdentityFederations.admin {#iam-workloadIdentityFederations-admin}

{% include [iam.workloadIdentityFederations.admin](../../_roles/iam/workloadIdentityFederations/admin.md) %}

#### iam.auditor {#iam-auditor}

{% include [iam.auditor](../../_roles/iam/auditor.md) %}

#### iam.viewer {#iam-viewer}

{% include [iam.viewer](../../_roles/iam/viewer.md) %}

#### iam.editor {#iam-editor}

{% include [iam.editor](../../_roles/iam/editor.md) %}

#### iam.admin {#iam-admin}

{% include [iam.admin](../../_roles/iam/admin.md) %}


### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## What roles do I need {#choosing-roles}

The table below lists the roles required to perform a particular action. You can always assign a role offering more permissions than the one specified. For example, you can assign the `editor` role instead of `viewer`.

Action | Methods | Required roles
----- | ----- | -----
**Viewing data** | |
[Getting an IAM token](../operations/iam-token/create.md) | `create` | None, authentication only
[Viewing user data](../operations/users/get.md) | `get`, `getByLogin` | None, authentication only
[Viewing service account data](../operations/sa/get-id.md) | `get`, `list`, `listOperations` | `iam.serviceAccounts.user` or `viewer` for the service account
Viewing information about a folder or cloud | `get`, `list` | `iam.auditor` for the folder or cloud
Viewing information about any resource | `get`, `list` | `viewer` for the resource
**Managing resources** | |
[Creating](../operations/sa/create.md) service accounts in the folder | `create` | `iam.serviceAccounts.admin` for the folder
[Updating](../operations/sa/update.md) and [deleting](../operations/sa/delete.md) service accounts | `update`, `delete` | `editor` for the service account
Creating and deleting keys for a service account | `create`, `delete` | `iam.serviceAccounts.accessKeyAdmin`, `iam.serviceAccounts.apiKeyAdmin`, `iam.serviceAccounts.authorizedKeyAdmin`, `iam.serviceAccounts.keyAdmin`<br/> for the service account
**Resource access management** | |
[Adding a new user to the cloud](../operations/users/create.md) | `setAccessBindings` | `admin` for the cloud
[Making a new user the owner of the cloud](../operations/roles/grant.md) | `setAccessBindings`, `updateAccessBindings` | `resource-manager.clouds.owner` role for the cloud
[Granting a role](../operations/roles/grant.md), [revoking a role](../operations/roles/revoke.md), and viewing roles granted for the resource | `setAccessBindings`, `updateAccessBindings`, `listAccessBindings` | `admin` for the resource
Getting an IAM token for a service account | `create` | `iam.serviceAccounts.tokenCreator` for the service account

#### What's next {#what-is-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
