---
title: Сервисные роли для модуля {{ td-full-name }} в {{ sd-full-name }}
description: На данной странице приведен список сервисных ролей для управления доступом к модулю {{ td-full-name }} ({{ td-name }}) в сервисе {{ sd-name }}.
---

# Сервисные роли для модуля {{ td-full-name }} ({{ td-name }})

С помощью сервисных ролей [модуля {{ td-full-name }}](../concepts/threat-detector.md) ({{ td-name }}) вы можете управлять доступом пользователей к ресурсам модуля и их настройкам, а также к данным о выявленных угрозах.

{% include [roles-security-deck-threat-detector](../../_mermaid/roles/security-deck-td.md) %}

#### threat-detector.worker {#threat-detector-worker}

{% include [threat-detector.worker](../../_roles/threat-detector/worker.md) %}

#### threat-detector.auditor {#threat-detector-auditor}

{% include [threat-detector.auditor](../../_roles/threat-detector/auditor.md) %}

#### threat-detector.viewer {#threat-detector-viewer}

{% include [threat-detector.viewer](../../_roles/threat-detector/viewer.md) %}

#### threat-detector.editor {#threat-detector-editor}

{% include [threat-detector.editor](../../_roles/threat-detector/editor.md) %}

#### threat-detector.admin {#threat-detector-admin}

{% include [threat-detector.admin](../../_roles/threat-detector/admin.md) %}