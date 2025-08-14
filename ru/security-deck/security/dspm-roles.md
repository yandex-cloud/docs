---
title: Сервисные роли {{ dspm-name }} в {{ sd-full-name }}
description: На данной странице приведен список сервисных ролей для управления доступом к модулю контроля данных ({{ dspm-name }}) в сервисе {{ sd-name }}.
---

# Сервисные роли для контроля данных ({{ dspm-name }})

С помощью сервисных ролей [модуля контроля данных](../concepts/dspm.md) ({{ dspm-name }}) вы можете управлять доступом пользователей к ресурсам модуля контроля данных и их настройкам, а также к данным, содержащимся в результатах сканирования источников на наличие чувствительной информации.

#### dspm.worker {#dspm-worker}

{% include [dspm.worker](../../_roles/dspm/worker.md) %}

#### dspm.inspector {#dspm-inspector}

{% include [dspm.inspector](../../_roles/dspm/inspector.md) %}

#### dspm.auditor {#dspm-auditor}

{% include [dspm.auditor](../../_roles/dspm/auditor.md) %}

#### dspm.viewer {#dspm-viewer}

{% include [dspm.viewer](../../_roles/dspm/viewer.md) %}

#### dspm.editor {#dspm-editor}

{% include [dspm.editor](../../_roles/dspm/editor.md) %}

#### dspm.admin {#dspm-admin}

{% include [dspm.admin](../../_roles/dspm/admin.md) %}