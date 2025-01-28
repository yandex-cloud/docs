---
title: Access management in {{ data-transfer-full-name }}
description: Access management in {{ data-transfer-full-name }}, a service for data transfer between storages. This section describes the roles required to perform a particular action, the resources for which you can assign a role, and the roles existing in the service.
---

# Access management in {{ data-transfer-name }}


In this section, you will learn:

* [Which resources you can assign a role for](#resources).
* [Which roles exist in the service](#roles-list).
* [Which roles are required](#required-roles) for particular actions.

To use the service, log in to the management console with a [Yandex account](../../iam/concepts/users/accounts.md#passport) or [federated account](../../iam/concepts/users/accounts.md#saml-federation).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

{% include [roles-assign](../../_includes/iam/roles-assign.md) %}

## Which resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## Which roles exist in the service {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](../../_assets/data-transfer/security/service-roles-hierarchy.svg)

### Service roles {#service-roles}

#### data-transfer.auditor {#data-transfer-auditor}

{% include [data-transfer.auditor](../../_roles/data-transfer/auditor.md) %}

#### data-transfer.viewer {#data-transfer-viewer}

{% include [data-transfer.viewer](../../_roles/data-transfer/viewer.md) %}

#### data-transfer.privateAdmin {#data-transfer-privateadmin}

{% include [data-transfer.privateadmin](../../_roles/data-transfer/privateAdmin.md) %}

#### data-transfer.admin {#data-transfer-admin}

{% include [data-transfer.admin](../../_roles/data-transfer/admin.md) %}

### Primitive roles {#primitive-roles}

#### {{ roles-viewer }} {#viewer}

{% include [roles-viewer](../../_roles/primitive-roles/viewer.md) %}

#### {{ roles-editor }} {#editor}

{% include [roles-editor](../../_roles/primitive-roles/editor.md) %}

#### {{ roles-admin }} {#admin}

{% include [roles-admin](../../_roles/primitive-roles/admin.md) %}

## Roles required {#required-roles}

To use the service, you need the `editor` [role](../../iam/concepts/access-control/roles.md) or higher for the folder where you want to create {{ data-transfer-name }} resources. With the `viewer` role, you can only view the list of the projects and the contents of uploaded files.

If you are creating a managed database endpoint for a cluster residing in a different folder, you will need a service or primitive [`viewer` role](../../iam/roles-reference.md#viewer) for that folder.

If you are creating a managed database endpoint for a third-party cluster with internet access, you will need the primitive `admin` role or the `data-transfer.admin` service role for the folder where you are creating the endpoint.

You can always assign a role offering more permissions (e.g., `admin` instead of `editor`) or assign roles that allow only specific actions. For more information about the roles required to perform particular actions with {{ data-transfer-name }} resources, see this table:

| Action                                                                    | Required roles             |
|-----------------------------------------------------------------------------|------------------------------|
| Getting metadata on transfers and endpoints                              | `data-transfer.viewer`       |
| Getting information about {{ data-transfer-name }} quotas               | `data-transfer.viewer`       |
| Getting information about transfers and endpoints                               | `data-transfer.viewer`       |
| Creating an endpoint in {{ yandex-cloud }}                                       | `data-transfer.editor` |
| Updating an endpoint in {{ yandex-cloud }}                                      | `data-transfer.editor` |
| Deleting an endpoint in {{ yandex-cloud }}                                       | `data-transfer.editor` |
| Creating a data transfer in {{ yandex-cloud }}                    | `data-transfer.privateAdmin` |
| Updating a data transfer in {{ yandex-cloud }}                   | `data-transfer.privateAdmin` |
| Activating a data transfer in {{ yandex-cloud }}               | `data-transfer.privateAdmin` |
| Deactivating a data transfer in {{ yandex-cloud }}             | `data-transfer.privateAdmin` |
| Deleting a data transfer in {{ yandex-cloud }}                    | `data-transfer.editor` |
| Creating an endpoint in or outside {{ yandex-cloud }}                  | `data-transfer.editor`        |
| Updating an endpoint in or outside {{ yandex-cloud }}                 | `data-transfer.editor`        |
| Deleting an endpoint in or outside {{ yandex-cloud }}                  | `data-transfer.editor`        |
| Creating a data transfer to {{ yandex-cloud }} or over the internet | `data-transfer.admin`        |
| Updating a data transfer to {{ yandex-cloud }} or over the internet | `data-transfer.admin`       |
| Activating a data transfer to {{ yandex-cloud }} or over the internet | `data-transfer.admin`   |
| Deactivating a data transfer to {{ yandex-cloud }} or over the internet | `data-transfer.admin` |
| Deleting a data transfer to {{ yandex-cloud }} or over the internet | `data-transfer.editor`        |

## What's next {#whats-next}

* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

