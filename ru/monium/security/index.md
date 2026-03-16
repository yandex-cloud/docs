---
title: Управление доступом в {{ monium-full-name }}
description: Управление доступом в сервисе мониторинга, который позволяет собирать и хранить метрики, а также отображать их в виде графиков на дашбордах — {{ monium-full-name }}. Чтобы разрешить доступ к ресурсам сервиса {{ monium-name }}, назначьте пользователю нужные роли из приведенного списка.
---

# Управление доступом в {{ monium-name }}

{% include [operate-via-roles-paragraph](../../_includes/iam/operate-via-roles-paragraph.md) %}

Чтобы разрешить доступ к ресурсам сервиса {{ monitoring-full-name }}, назначьте аккаунту на Яндексе, [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), [федеративным](../../iam/concepts/users/accounts.md#saml-federation) или [локальным](../../iam/concepts/users/accounts.md#local) пользователям, [группе пользователей](../../organization/operations/manage-groups.md), [системной группе](../../iam/concepts/access-control/system-group.md) или [публичной группе](../../iam/concepts/access-control/public-group.md) нужные роли из приведенного ниже списка.

Подробнее о наследовании ролей читайте в разделе [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) документации сервиса {{ resmgr-full-name }}.

На данный момент роль может быть назначена только на родительский ресурс (каталог или облако), роли которого наследуются вложенными ресурсами.

{% include [roles-assign](../../_includes/iam/roles-assign.md) %}

## Какие роли действуют в сервисе {#roles-list}

{% cut "Роли алертинга" %}

{% include [monium-alerts](../../_mermaid/roles/monium-alerts.md) %}

{% endcut %}

{% cut "Роли телеметрии" %}

{% include [monium-telemetry](../../_mermaid/roles/monium-telemetry.md) %}

{% endcut %}

{% cut "Роли конфигурации и визуализации" %}

{% include [monium-dashboards](../../_mermaid/roles/monium-dashboards.md) %}

{% endcut %}

Для управления правами доступа в {{ monium-name }} можно использовать как сервисные, так и примитивные роли.

### Сервисные роли {#service-roles}

#### monium.alerts.viewer {#monium-alerts-viewer}

{% include [monium.alerts.viewer](../../_roles/monium/alerts/viewer.md) %}

#### monium.alerts.editor {#monium-alerts-editor}

{% include [monium.alerts.editor](../../_roles/monium/alerts/editor.md) %}

#### monium.channels.viewer {#monium-channels-viewer}

{% include [monium.channels.viewer](../../_roles/monium/channels/viewer.md) %}

#### monium.channels.editor {#monium-channels-editor}

{% include [monium.channels.editor](../../_roles/monium/channels/editor.md) %}

#### monium.contextLinks.viewer {#monium-contextlinks-viewer}

{% include [monium.contextLinks.viewer](../../_roles/monium/contextLinks/viewer.md) %}

#### monium.contextLinks.editor {#monium-contextLinks-editor}

{% include [monium.contextLinks.editor](../../_roles/monium/contextLinks/editor.md) %}

#### monium.quickLinks.viewer {#monium-quickLinks-viewer}

{% include [monium.quickLinks.viewer](../../_roles/monium/quickLinks/viewer.md) %}

#### monium.quickLinks.editor {#monium-quickLinks-editor}

{% include [monium.quickLinks.editor](../../_roles/monium/quickLinks/editor.md) %}

#### monium.dashboards.viewer {#monium-dashboards-viewer}

{% include [monium.dashboards.viewer](../../_roles/monium/dashboards/viewer.md) %}

#### monium.dashboards.editor {#monium-dashboards-editor}

{% include [monium.dashboards.editor](../../_roles/monium/dashboards/editor.md) %}

#### monium.escalations.viewer {#monium-escalations-viewer}

{% include [monium.escalations.viewer](../../_roles/monium/escalations/viewer.md) %}

#### monium.escalations.editor {#monium-escalations-editor}

{% include [monium.escalations.editor](../../_roles/monium/escalations/editor.md) %}

#### monium.escalationPolicies.viewer {#monium-escalationPolicies-viewer}

{% include [monium.escalationPolicies.viewer](../../_roles/monium/escalationPolicies/viewer.md) %}

#### monium.escalationPolicies.editor {#monium-escalationPolicies-editor}

{% include [monium.escalationPolicies.editor](../../_roles/monium/escalationPolicies/editor.md) %}

#### monium.logErrorLabels.viewer {#monium-logErrorLabels-viewer}

{% include [monium.logErrorLabels.viewer](../../_roles/monium/logErrorLabels/viewer.md) %}

#### monium.logErrorLabels.editor {#monium-logErrorLabels-editor}

{% include [monium.logErrorLabels.editor](../../_roles/monium/logErrorLabels/editor.md) %}

#### monium.mutes.viewer {#monium-mutes-viewer}

{% include [monium.mutes.viewer](../../_roles/monium/mutes/viewer.md) %}

#### monium.mutes.editor {#monium-mutes-editor}

{% include [monium.mutes.editor](../../_roles/monium/mutes/editor.md) %}

#### monium.serviceLevelObjectives.viewer {#monium-serviceLevelObjectives-viewer}

{% include [monium.serviceLevelObjectives.viewer](../../_roles/monium/serviceLevelObjectives/viewer.md) %}

#### monium.serviceLevelObjectives.editor {#monium-serviceLevelObjectives-editor}

{% include [monium.serviceLevelObjectives.editor](../../_roles/monium/serviceLevelObjectives/editor.md) %}

#### monium.shards.viewer {#monium-shards-viewer}

{% include [monium.shards.viewer](../../_roles/monium/shards/viewer.md) %}

#### monium.shards.editor {#monium-shards-editor}

{% include [monium.shards.editor](../../_roles/monium/shards/editor.md) %}

#### monium.metrics.reader {#monium-metrics-reader}

{% include [monium.metrics.reader](../../_roles/monium/metrics/reader.md) %}

#### monium.metrics.writer {#monium-metrics-writer}

{% include [monium.metrics.writer](../../_roles/monium/metrics/writer.md) %}

#### monium.logs.reader {#monium-logs-reader}

{% include [monium.logs.reader](../../_roles/monium/logs/reader.md) %}

#### monium.logs.writer {#monium-logs-writer}

{% include [monium.logs.writer](../../_roles/monium/logs/writer.md) %}

#### monium.traces.reader {#monium-traces-reader}

{% include [monium.traces.reader](../../_roles/monium/traces/reader.md) %}

#### monium.traces.writer {#monium-traces-writer}

{% include [monium.traces.writer](../../_roles/monium/traces/writer.md) %}

#### monium.telemetry.reader {#monium-telemetry-reader}

{% include [monium.telemetry.reader](../../_roles/monium/telemetry/reader.md) %}

#### monium.telemetry.writer {#monium-telemetry-writer}

{% include [monium.telemetry.writer](../../_roles/monium/telemetry/writer.md) %}

#### monium.auditor {#monium-auditor}

{% include [monium.auditor](../../_roles/monium/auditor.md) %}

#### monium.viewer {#monium-viewer}

{% include [monium.viewer](../../_roles/monium/viewer.md) %}

#### monium.editor {#monium-editor}

{% include [monium.editor](../../_roles/monium/editor.md) %}

#### monium.admin {#monium-admin}

{% include [monium.admin](../../_roles/monium/admin.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## Назначение ролей {#grant-roles}

Чтобы назначить пользователю роль:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}
