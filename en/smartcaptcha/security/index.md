---
title: Access management in {{ captcha-name }}
description: This section lists the resources supporting role assignment and roles available in {{ captcha-name }}.
---

# Access management in {{ captcha-name }}

In this section, you will learn about:

* [Resources supporting role assignment](#resources).
* [Roles available in the service](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

To assign a role for a resource, you need the `smart-captcha.admin` role or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## Resources supporting role assignment {#resources}

You can assign roles for [organizations](../../organization/), [clouds](../../resource-manager/concepts/resources-hierarchy.md#cloud), or [folders](../../resource-manager/concepts/resources-hierarchy.md#folder). Roles assigned for organizations, clouds, and folders also apply to the CAPTCHAs within them.

## Roles available in the service {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

{% include [smartcaptcha](../../_mermaid/roles/smartcaptcha.md) %}

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

## Required roles {#choosing-roles}

The table below maps actions to the minimum roles required to perform them. You are free to assign a role with broader permissions than the one listed in the table, e.g., `smart-captcha.editor` instead of `smart-captcha.viewer`.

Action | Role
----- | -----
Viewing CAPTCHA details | `smart-captcha.viewer`
Creating a CAPTCHA | `smart-captcha.editor`
Editing a CAPTCHA | `smart-captcha.editor`
Deleting a CAPTCHA | `smart-captcha.editor`
Managing CAPTCHA user roles | `smart-captcha.admin`
