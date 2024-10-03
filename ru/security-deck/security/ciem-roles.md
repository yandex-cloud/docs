---
title: Роли для диагностики доступов в {{ sd-full-name }}
description: На данной странице приведен список ролей, необходимых для управления доступом к модулю диагностики доступов (CIEM) в сервисе {{ sd-name }}.
---

# Роли для диагностики доступов (CIEM)

[Просматривать](../operations/ciem/view-permissions.md) доступы в [интерфейсе {{ sd-name }}]({{ link-sd-main }}iam-diagnostics/) могут [члены организации](../../organization/concepts/membership.md), которым на эту организацию назначена [роль](../../organization/security/index.md#organization-manager-viewer) `organization-manager.viewer` или выше.

[Отзывать](../operations/ciem/revoke-permissions.md) доступы могут пользователи, обладающие одной из ролей: `admin`, `resource-manager.admin`, `organization-manager.admin`, `resource-manager.clouds.owner`, `organization-manager.organizations.owner` или ролью администратора того [сервиса](../../overview/concepts/services.md), к ресурсу которого у субъекта отзывается доступ.