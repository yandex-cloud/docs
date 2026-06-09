---
title: Сервисные роли {{ sw-full-name }} в {{ si-full-name }}
description: На данной странице приведен список сервисных ролей для управления доступом к функциональности {{ sw-full-name }} в сервисе {{ si-full-name }}.
---

# Сервисные роли для {{ sw-name }}

С помощью сервисных ролей [{{ sw-name }}](../concepts/index.md#workflows) вы можете управлять доступом пользователей к [рабочим процессам](../concepts/workflows/workflow.md) {{ sw-name }}.

{% note info %}

Возможность запускать рабочие процессы и управлять ими из определенных [облачных сетей](../../vpc/concepts/network.md#network) или с определенных IP-адресов, а также привязывать к рабочим процессам определенные облачные сети может быть ограничена [политиками авторизации](../../iam/concepts/access-control/access-policies.md) на уровне [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder), [облака](../../resource-manager/concepts/resources-hierarchy.md#cloud) или [организации](../../organization/concepts/organization.md). 

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
