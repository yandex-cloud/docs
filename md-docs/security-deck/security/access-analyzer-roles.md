[Документация Yandex Cloud](../../index.md) > [Yandex Security Deck](../index.md) > [Управление доступом](index.md) > Роли Access Analyzer

# Роли для работы с модулем Access Analyzer

Просматривать [доступы](../operations/access-analyzer/analyze-permissions.md#view) и [рекомендации](../operations/access-analyzer/use-recommendations.md#view) в [интерфейсе Security Deck](https://center.yandex.cloud/security/access-analyzer/) могут [члены организации](../../organization/concepts/membership.md), которым на эту организацию назначена [роль](../../organization/security/index.md#organization-manager-viewer) `organization-manager.viewer` или выше.

[Отзывать доступы](../operations/access-analyzer/analyze-permissions.md#revoke) и [принимать рекомендации](../operations/access-analyzer/use-recommendations.md#replace) могут пользователи, обладающие одной из ролей: `admin`, `resource-manager.admin`, `organization-manager.admin`, `resource-manager.clouds.owner`, `organization-manager.organizations.owner` или ролью администратора того [сервиса](../../overview/concepts/services.md), к ресурсу которого у субъекта отзывается доступ.