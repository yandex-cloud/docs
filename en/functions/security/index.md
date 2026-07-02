---
title: Access management in {{ sf-name }}
description: Access management in {{ sf-name }}, a service for running applications without creating and maintaining VMs. This section describes the resources for which you can assign a role and the roles {{ sf-name }} has.
---

# Access management in {{ sf-name }}

In this section, you will learn about the following:

* [Resources you can assign a role for](#resources).
* [Roles this service has](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

To assign a role for a resource, you need the `functions.admin` role or one of the following roles for that resource:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

{% note info %}

The ability to call and manage functions from specific [cloud networks](../../vpc/concepts/network.md#network) or IP addresses, or associate functions with specific cloud networks may be restricted by [access policies](../../iam/concepts/access-control/access-policies.md) at the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder), [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), or [organization](../../organization/concepts/organization.md) level. 

{% endnote %}

## Resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

To assign a role for a [function](../concepts/function.md), use the {{ yandex-cloud }} [CLI](../../cli/cli-ref/serverless/cli-ref/function/add-access-binding.md), [API](../api-ref/functions/authentication.md), or [{{ TF }}]({{ tf-provider-resources-link }}/function_iam_binding).

## Roles this service has {#roles-list}

The list below shows all the roles used for access control in {{ sf-name }}.

{% include [functions](../../_mermaid/roles/functions.md) %}

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

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}