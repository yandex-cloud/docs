---
title: '{{ sw-full-name }} service roles in {{ si-full-name }}'
description: This page lists the service roles required to control access to the {{ sw-full-name }} features in {{ si-full-name }}.
---

# Service roles for {{ sw-name }}

With [{{ sw-name }}](../concepts/index.md#workflows) service roles, you can manage user access to {{ sw-name }} [workflows](../concepts/workflows/workflow.md).

{% note info %}

The ability to execute and manage workflows from specific [cloud networks](../../vpc/concepts/network.md#network) or IP addresses, or associate workflows with specific cloud networks, may be restricted by [access policies](../../iam/concepts/access-control/access-policies.md) at the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder), [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud), or [organization](../../organization/concepts/organization.md) level. 

{% endnote %}

{% include [serverless-integrations-workflows](../../_mermaid/roles/serverless-integrations-workflows.md) %}

#### serverless.workflows.auditor {#serverless-workflows-auditor}

{% include [serverless.workflows.auditor](../../_roles/serverless/workflows/auditor.md) %}

#### serverless.workflows.viewer {#serverless-workflows-viewer}

{% include [serverless.workflows.viewer](../../_roles/serverless/workflows/viewer.md) %}

#### serverless.workflows.executor {#serverless-workflows-executor}

{% include [serverless.workflows.executor](../../_roles/serverless/workflows/executor.md) %}

#### serverless.workflows.editor {#serverless-workflows-editor}

{% include [serverless.workflows.editor](../../_roles/serverless/workflows/editor.md) %}

#### serverless.workflows.admin {#serverless-workflows-admin}

{% include [serverless.workflows.admin](../../_roles/serverless/workflows/admin.md) %}
