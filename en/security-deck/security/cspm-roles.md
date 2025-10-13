---
title: '{{ cspm-name }} service roles in {{ sd-full-name }}'
description: This page enlists service roles required to control access to the Cloud Security Posture Management ({{ cspm-name }}) module in {{ sd-full-name }}.
---

# Cloud Security Posture Management ({{ cspm-name }}) service roles

With [{{ cspm-name }}](../concepts/cspm.md) service roles, you can manage user access to the {{ cspm-name }} resources and their settings, as well as to the results of configuration compliance checks with [security standards](../concepts/cspm.md#standards).

#### cspm.worker {#cspm-worker}

{% include [cspm.worker](../../_roles/cspm/worker.md) %}

#### cspm.auditor {#cspm-auditor}

{% include [cspm.auditor](../../_roles/cspm/auditor.md) %}

#### cspm.viewer {#cspm-viewer}

{% include [cspm.viewer](../../_roles/cspm/viewer.md) %}

#### cspm.editor {#cspm-editor}

{% include [cspm.editor](../../_roles/cspm/editor.md) %}

#### cspm.admin {#cspm-admin}

{% include [cspm.admin](../../_roles/cspm/admin.md) %}