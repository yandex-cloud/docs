---
title: '{{ k8s }}® Security Posture Management service roles in {{ sd-full-name }}'
description: This page enlists service roles required to control access to the {{ k8s }}® Security Posture Management (KSPM) module in {{ sd-name }}.
---

# {{ k8s }}® Security Posture Management (KSPM) service roles

With [{{ k8s }}® Security Posture Management](../concepts/kspm.md) (KSPM) service roles, you can manage user access to the KSPM resources and their settings, as well as to the data contained in the control results and alerts.

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