---
title: '{{ kspm-full-name }} service roles in {{ sd-full-name }}'
description: This page lists the service roles required to control access to {{ kspm-full-name }} ({{ kspm-name }}) in {{ sd-name }}.
---

# {{ kspm-full-name }} ({{ kspm-name }}) service roles

With [{{ kspm-full-name }}](../concepts/kspm.md) ({{ kspm-name }}) service roles, you can manage user access to the {{ kspm-name }} resources and their settings, as well as to the data contained in the control results and alerts.

{% include [roles-security-deck-kspm](../../_mermaid/roles/security-deck-kspm.md) %}

#### kspm.worker {#kspm-worker}

{% include [kspm.worker](../../_roles/kspm/worker.md) %}

#### kspm.auditor {#kspm-auditor}

{% include [kspm.auditor](../../_roles/kspm/auditor.md) %}

#### kspm.viewer {#kspm-viewer}

{% include [kspm.viewer](../../_roles/kspm/viewer.md) %}

#### kspm.editor {#kspm-editor}

{% include [kspm.editor](../../_roles/kspm/editor.md) %}

#### kspm.admin {#kspm-admin}

{% include [kspm.admin](../../_roles/kspm/admin.md) %}