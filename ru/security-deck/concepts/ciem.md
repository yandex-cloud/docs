---
title: Диагностика доступов в {{ sd-full-name }}
description: В данном разделе описан модуль диагностики доступов {{ sd-name }} ({{ ciem-name }}), который позволяет просматривать имеющиеся у пользователей организации права доступа к ресурсам организации и при необходимости отзывать такие права доступа.
---

# Модуль диагностики доступов ({{ ciem-name }})

В целях обеспечения [безопасности](../../security/standard/all.md) данных и облачной инфраструктуры необходимо регулярно проводить аудит прав доступа, имеющихся у [пользователей](../../overview/roles-and-resources.md#users) и [сервисных аккаунтов](../../iam/concepts/users/accounts.md#sa).

[Модуль диагностики доступов]({{ link-sd-main }}iam-diagnostics/) или {{ ciem-name }} (Cloud Infrastructure Entitlement Management) — это инструмент, позволяющий централизованно [просматривать](../operations/ciem/view-permissions.md) полный список доступов [субъектов](../../iam/concepts/access-control/index.md#subject): пользователей, сервисных аккаунтов, [групп пользователей](../../organization/concepts/groups.md), [системных групп](../../iam/concepts/access-control/system-group.md) и [публичных групп](../../iam/concepts/access-control/public-group.md) к [ресурсам](../../iam/concepts/access-control/resources-with-access-control.md) организации. Этот инструмент также позволяет легко [отзывать](../operations/ciem/revoke-permissions.md) у субъектов лишние доступы.

## Просмотр доступов {#viewing-permissions}

Просматривать доступы в [интерфейсе {{ sd-name }}]({{ link-sd-main }}iam-diagnostics/) могут [члены организации](../../organization/concepts/membership.md), которым на эту организацию назначена [роль](../../organization/security/index.md#organization-manager-viewer) `organization-manager.viewer` или выше.

Для каждого доступа в выводимом списке указывается имя / идентификатор и тип ресурса, к которому выдан доступ, назначенная субъекту на этот ресурс [роль](../../iam/concepts/access-control/roles.md), а также информация о том, была ли эта роль назначена субъекту напрямую или была унаследована из группы, членом которой является этот субъект.

Диагностика доступов позволяет просматривать доступы, назначенные индивидуальному субъекту (пользователю или сервисному аккаунту):
* напрямую;
* через группу пользователей;
* через системную группу;
* через публичную группу.

Понять, назначен ли доступ на определенный ресурс индивидуальному субъекту напрямую или через группу, можно по значению поля **{{ ui-key.yacloud_org.iam-bindings.subject.title_group }}** таблицы с доступами субъекта. Если поле не заполнено, значит роль выдана напрямую. В остальных случаях в поле указано имя группы и ее идентификатор.

Доступы группам назначаются только напрямую, поэтому для групп поле **{{ ui-key.yacloud_org.iam-bindings.subject.title_group }}** таблицы с доступами всегда пустое.

Список выданных субъекту доступов можно фильтровать:
* по идентификатору ресурса, к которому выдан доступ;
* по идентификатору выданной роли;
* по способу назначения: `{{ ui-key.yacloud_org.iam-bindings.subject.value_role-source-filter_direct }}` или `{{ ui-key.yacloud_org.iam-bindings.subject.value_role-source-filter_group }}`.

{% note warning %}

В настоящее время диагностика доступов не отображает права доступа субъектов к [платежным аккаунтам](../../billing/concepts/billing-account.md) и ресурсам сервиса [{{ datalens-full-name }}](../../datalens/index.yaml).

{% endnote %}

## Отзыв доступов {#revoking-permissions}

Диагностика доступов позволяет при необходимости [отзывать](../operations/ciem/revoke-permissions.md) у индивидуальных субъектов и групп лишние доступы а также исключать индивидуальных субъектов из групп пользователей.

Отзывать доступы могут пользователи, обладающие одной из ролей: `admin`, `resource-manager.admin`, `organization-manager.admin`, `resource-manager.clouds.owner`, `organization-manager.organizations.owner` или ролью администратора того [сервиса](../../overview/concepts/services.md), к ресурсу которого у субъекта отзывается доступ.

Исключить субъекта можно только из группы, созданной администратором организации. Исключить субъекта из системной или публичной группы нельзя.

#### См. также {#see-also}

* [{#T}](../operations/ciem/view-permissions.md)
* [{#T}](../operations/ciem/revoke-permissions.md)