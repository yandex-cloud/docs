---
title: "Access management in {{ captcha-name }}"
description: "This section describes the resources for which you can assign a role and the roles existing in the service."
---

# Access management in {{ captcha-name }}

In this section, you will learn:

* [Which resources you can assign a role for](#resources).
* [Which roles exist in the service](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Which resources you can assign a role for {#resources}

You can assign a role to an [organization](../../organization/), [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), or [folder](../../resource-manager/concepts/resources-hierarchy.md#folder). Roles assigned to an organization, cloud, or folder also apply to the CAPTCHAS in them.

## Which roles exist in the service {#roles-list}

The list below shows all roles that are considered when verifying access rights in the {{ captcha-name }} service.

### Service roles {#service-roles}

| Role | Permissions |
----- | -----
| `smart-captcha.auditor` | Enables you to view CAPTCHA information and permissions. |
| `smart-captcha.viewer` | Enables you to view CAPTCHA information and permissions. It includes all access rights of the `smart-captcha.auditor` role. |
| `smart-captcha.editor` | Enables you to manage CAPTCHAS (create, change, or delete them). It includes all access rights of the `smart-captcha.viewer` role. |
| `smart-captcha.admin` | Enables you to manage CAPTCHAS and access to them. It includes all access rights of the `smart-captcha.editor` role. |

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

## What roles do I need {#choosing-roles}

The table shows actions and minimum roles required to perform them. You can always assign a role granting broader access rights than the role from the table. For example, you can assign the `smart-captcha.editor` role instead of the `smart-captcha.viewer` role.

| Action | Role |
----- | -----
| Viewing CAPTCHA information | `smart-captcha.viewer` |
| Creating a CAPTCHA | `smart-captcha.editor` |
| Editing a CAPTCHA | `smart-captcha.editor` |
| Deleting a CAPTCHA | `smart-captcha.editor` |
| Managing roles of CAPTCHA users | `smart-captcha.admin` |
