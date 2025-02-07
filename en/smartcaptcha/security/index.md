---
title: Access management in {{ captcha-name }}
description: This section describes the resources you can assign a role for and roles available in {{ captcha-name }}.
---

# Access management in {{ captcha-name }}

In this section, you will learn:

* [Which resources you can assign a role for](#resources).
* [Which roles exist in the service](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Roles for a resource can be assigned by users who have the `smart-captcha.admin` role or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## Which resources you can assign a role for {#resources}

You can assign a role for an [organization](../../organization/), [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), or [folder](../../resource-manager/concepts/resources-hierarchy.md#folder). Roles assigned for an organization, cloud, or folder also apply to the CAPTCHAs in them.

## Which roles exist in the service {#roles-list}

The list below shows all roles considered when verifying access permissions in {{ captcha-name }}.

### Service roles {#service-roles}

#### smart-captcha.auditor {#smart-captcha-auditor}

{% include [smart-captcha.auditor](../../_roles/smart-captcha/auditor.md) %}

#### smart-captcha.viewer {#smart-captcha-viewer}

{% include [smartcaptcha-viewer](../../_roles/smart-captcha/viewer.md) %}

#### smart-captcha.editor {#smart-captcha-editor}

{% include [smartcaptcha-editor](../../_roles/smart-captcha/editor.md) %}

#### smart-captcha.admin {#smart-captcha-admin}

{% include [smartcaptcha-admin](../../_roles/smart-captcha/admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## What roles do I need {#choosing-roles}

The table shows actions and minimum roles required to perform them. You can always assign a role offering more permissions than the one specified in the table. For example, you can assign `smart-captcha.editor` instead of `smart-captcha.viewer`.

Action | User role
----- | -----
Viewing CAPTCHA information | `smart-captcha.viewer`
Creating a CAPTCHA | `smart-captcha.editor`
Editing a CAPTCHA | `smart-captcha.editor`
Deleting a CAPTCHA | `smart-captcha.editor`
Managing roles of CAPTCHA users | `smart-captcha.admin`
