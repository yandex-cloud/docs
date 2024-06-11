---
title: "Access management in {{ sf-name }}"
description: "Access management in {{ sf-name }}, a service for running applications without creating and maintaining VM instances. This section describes the resources for which you can assign a role and the roles existing in the service."
---

# Access management in {{ sf-name }}

In this section, you will learn:

* [Which resources you can assign a role for](#resources).
* [Which roles exist in the service](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Roles for a resource can be assigned by users who have the `functions.admin` role or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## Which resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

You can assign a role for a [function](../concepts/function.md) via the YC CLI or the {{ yandex-cloud }} API.

## Which roles exist in the service {#roles-list}

The list below shows all roles that are considered when verifying access rights in the {{ sf-name }} service.

### Service roles {#service-roles}

#### functions.auditor {#functions-auditor}

{% include [functions.auditor](../../_roles/functions/auditor.md) %}

#### functions.viewer {#functions-viewer}

{% include [functions.viewer](../../_roles/functions/viewer.md) %}

#### functions.functionInvoker {#functions-functionInvoker}

{% include [functions.functionInvoker](../../_roles/functions/functionInvoker.md) %}

#### functions.editor {#functions-editor}

{% include [functions.editor](../../_roles/functions/editor.md) %}


#### functions.mdbProxiesUser {#functions-mdbProxiesUser}

{% include [functions.mdbProxiesUser](../../_roles/functions/mdbProxiesUser.md) %}


#### functions.admin {#functions-admin}

{% include [functions.admin](../../_roles/functions/admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}
