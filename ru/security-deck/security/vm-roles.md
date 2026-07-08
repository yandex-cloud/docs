---
title: Сервисные роли для модуля {{ vuln-man-name }} в {{ sd-full-name }}
description: На данной странице приведен список сервисных ролей для управления доступом к модулю {{ vuln-man-name }} ({{ vuln-man-short-name }}) в сервисе {{ sd-name }}.
---

# Сервисные роли для модуля {{ vuln-man-name }} ({{ vuln-man-short-name }})

С помощью сервисных ролей [модуля {{ vuln-man-name }}](../concepts/vulnerability-management.md) ({{ vuln-man-short-name }}) вы можете управлять доступом пользователей к ресурсам модуля и их настройкам, а также к результатам сканирований на уязвимости.

{% include [roles-security-deck-vulnerability-manager](../../_mermaid/roles/security-deck-vm.md) %}

#### vulnerability-manager.auditor {#vulnerability-manager-auditor}

{% include [vulnerability-manager.auditor](../../_roles/vulnerability-manager/auditor.md) %}

#### vulnerability-manager.viewer {#vulnerability-manager-viewer}

{% include [vulnerability-manager.viewer](../../_roles/vulnerability-manager/viewer.md) %}

#### vulnerability-manager.editor {#vulnerability-manager-editor}

{% include [vulnerability-manager.editor](../../_roles/vulnerability-manager/editor.md) %}

#### vulnerability-manager.admin {#vulnerability-manager-admin}

{% include [vulnerability-manager.admin](../../_roles/vulnerability-manager/admin.md) %}