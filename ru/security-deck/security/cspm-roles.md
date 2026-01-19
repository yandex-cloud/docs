---
title: Сервисные роли {{ cspm-name }} в {{ sd-full-name }}
description: На данной странице приведен список сервисных ролей для управления доступом к модулю Контроль конфигурации ({{ cspm-name }}) в сервисе {{ sd-full-name }}.
---

# Сервисные роли для модуля Контроль конфигурации ({{ cspm-name }})

С помощью сервисных ролей модуля [Контроль конфигурации ({{ cspm-name }})](../concepts/cspm.md) вы можете управлять доступом пользователей к ресурсам модуля {{ cspm-name }} и их настройкам, а также к данным, содержащимся в результатах проверок конфигурации на соответствие [стандартам безопасности](../concepts/cspm.md#standards).

{% include [roles-security-deck-cspm](../../_mermaid/roles/security-deck-cspm.md) %}

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