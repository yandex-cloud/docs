---
title: "Access management in {{ lockbox-full-name }}"
description: "Access management in {{ lockbox-full-name }}, a secret storage system. This section describes the resources for which you can assign a role, the roles existing in the service, and the roles required to perform a particular action."
---

# Access management in {{ lockbox-name }}

In this section, you will learn:
* [Which resources you can assign a role for](#resources).
* [Which roles exist in the service](#roles-list).
* [Which roles are required](#choosing-roles) for particular actions.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Which resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

You can assign a role for a [secret](../concepts/secret.md) in the management console, via the YC CLI or {{ yandex-cloud }} API.

## Which roles exist in the service {#roles-list}

You can manage access to secrets using both service and primitive roles.

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](../../_assets/lockbox/service-roles-hierarchy.svg)

### Service roles {#service-roles}

#### lockbox.auditor {#lockbox-auditor}

{% include [lockbox.auditor](../../_roles/lockbox/auditor.md) %}

#### lockbox.viewer {#lockbox-viewer}

{% include [lockbox.viewer](../../_roles/lockbox/viewer.md) %}

#### lockbox.editor {#lockbox-editor}

{% include [lockbox.editor](../../_roles/lockbox/editor.md) %}

#### lockbox.admin {#lockbox-admin}

{% include [lockbox.admin](../../_roles/lockbox/admin.md) %}

#### lockbox.payloadViewer {#lockbox-payloadViewer}

{% include [lockbox.payloadViewer](../../_roles/lockbox/payloadViewer.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

## What roles do I need {#choosing-roles}

The table below lists the roles needed to perform a particular action. You can always assign a role granting more permissions than the role specified. For example, you can assign the `editor` role instead of `viewer`.

| Action | `{{ roles-lockbox-admin }}` | `{{ roles-lockbox-editor }}` | `{{ roles-lockbox-viewer }}` | `{{ roles-lockbox-payloadviewer }}` | `kms.keys.encrypterDecrypter` |
----- | ----- | ----- | ----- | ----- | -----
| Create and delete secrets | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | - | - | - |
| Change the metadata of the secret | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | - | - | - |
| Read the metadata of the secret | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | - | - |
| Change the content of the secret version | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | - | - | - |
| Read the content of the secret version | ![image](../../_assets/common/yes.svg) | - | - | ![image](../../_assets/common/yes.svg) | - |
| Control access to the secret | ![image](../../_assets/common/yes.svg) | - | - | - | - |
| Secret encryption and decryption operations | - | - | - | - | ![image](../../_assets/common/yes.svg) |

#### What's next {#what-is-next}

* [How to use {{ yandex-cloud }} securely](../../iam/best-practices/using-iam-securely.md)
* [How to assign a role](../../iam/operations/roles/grant.md).
* [How to revoke a role](../../iam/operations/roles/revoke.md).
* [Learn more about access management in {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Learn more about inheriting roles](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
* [Access management in {{ kms-full-name }}](../../kms/security/index.md)
