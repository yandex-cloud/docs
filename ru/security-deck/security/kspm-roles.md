---
title: Сервисные роли для модуля Контроль {{ k8s }}® в {{ sd-full-name }}
description: На данной странице приведен список сервисных ролей для управления доступом к модулю Контроль {{ k8s }}® (KSPM) в сервисе {{ sd-name }}.
---

# Сервисные роли для модуля Контроль {{ k8s }}® (KSPM)

С помощью сервисных ролей [модуля Контроль {{ k8s }}®](../concepts/kspm.md) (KSPM) вы можете управлять доступом пользователей к ресурсам модуля и их настройкам, а также к данным, содержащимся в результатах контроля и алертам.

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