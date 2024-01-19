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

Roles can be assigned for a [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), [folder](../../resource-manager/concepts/resources-hierarchy.md#folder), or secret. These roles also apply to nested resources.

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](../../_assets/lockbox/service-roles-hierarchy.svg)

## Which roles exist in the service {#roles-list}

You can manage access to secrets using both service and primitive roles.

### Service roles {#service-roles}

Active roles in the service:

* {% include [lockbox-admin](../../_includes/iam/roles/short-descriptions/lockbox-admin.md) %}
* {% include [lockbox-editor](../../_includes/iam/roles/short-descriptions/lockbox-editor.md) %}
* {% include [lockbox-viewer](../../_includes/iam/roles/short-descriptions/lockbox-viewer.md) %}
* {% include [lockbox-auditor](../../_includes/iam/roles/short-descriptions/lockbox-auditor.md) %}
* {% include [lockbox-payloadviewer](../../_includes/iam/roles/short-descriptions/lockbox-payloadViewer.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

## What roles do I need {#choosing-roles}

The table below lists the roles needed to perform a particular action. You can always assign a role granting more permissions than the role specified. For example, you can assign the `editor` role instead of the `viewer` one.

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
