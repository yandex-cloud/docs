---
title: "Access management in {{ captcha-name }}"
description: "This section describes what resources you can assign a role for and what roles the service supports."
---

# Access management in {{ captcha-name }}

In this section, you'll learn:

* [Which resources you can assign roles to](#resources).
* [Which roles exist in the service](#roles).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}


## What resources you can assign roles to {#resources}

You can assign a role to an [organization](../../organization/), [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), or [folder](../../resource-manager/concepts/resources-hierarchy.md#folder). Roles assigned to an organization, cloud, or folder also apply to the CAPTCHAs in them.


## What roles exist in the service {#roles}

The list below shows all roles that are considered when verifying access rights in the {{ captcha-name }} service.


### Service roles {#service-roles}

| Role | Permissions |
----- | -----
| `resource-manager.clouds.owner` | Grants you full access to a cloud and the resources in it. You can only assign this role for a cloud. |
| `smart-captcha.viewer` | Enables you to view CAPTCHA information. |
| `smart-captcha.editor` | Enables you to manage CAPTCHAs (create, change, or delete them). Includes all access rights of the `smart-captcha.viewer` role. |
| `smart-captcha.admin` | Enables you to manage CAPTCHAs and access to them. Includes all access rights of the `smart-captcha.editor` role. |


### Primitive roles {#primitive-roles}

{% include notitle [roles-primitive](../../_includes/roles-primitive.md) %}


## What roles do I need {#choosing-roles}

The table shows actions and minimum roles required to perform them. You can always assign a role granting broader access rights than the role from the table. For example, you can assign the `smart-captcha.editor` role instead of the `smart-captcha.viewer` role.

| Action | Role |
----- | -----
| Viewing CAPTCHA information | `smart-captcha.viewer` |
| Creating a CAPTCHA | `smart-captcha.editor` |
| Editing a CAPTCHA | `smart-captcha.editor` |
| Deleting a CAPTCHA | `smart-captcha.editor` |
| Managing roles of CAPTCHA users | `smart-captcha.admin` |
