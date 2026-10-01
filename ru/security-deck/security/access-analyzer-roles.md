---
title: Роли для работы с модулем {{ access-analyzer-name }} в {{ sd-full-name }}
description: На данной странице приведен список ролей, необходимых для управления доступом к модулю {{ access-analyzer-name }} в сервисе {{ sd-full-name }}.
---

# Роли для работы с модулем {{ access-analyzer-name }}

Просматривать [доступы](../operations/access-analyzer/analyze-permissions.md#view) и [рекомендации](../operations/access-analyzer/use-recommendations.md#view) в [интерфейсе {{ sd-name }}]({{ link-sd-main }}access-analyzer/) могут [члены организации](../../organization/concepts/membership.md), которым на эту организацию назначена [роль](../../organization/security/index.md#organization-manager-viewer) `organization-manager.viewer` или выше.

[Отзывать доступы](../operations/access-analyzer/analyze-permissions.md#revoke) и [принимать рекомендации](../operations/access-analyzer/use-recommendations.md#replace) могут пользователи, обладающие одной из ролей: `admin`, `resource-manager.admin`, `organization-manager.admin`, `resource-manager.clouds.owner`, `organization-manager.organizations.owner` или ролью администратора того [сервиса](../../overview/concepts/services.md), к ресурсу которого у субъекта отзывается доступ.