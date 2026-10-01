---
title: Модуль {{ access-analyzer-name }} в {{ sd-full-name }}
description: В данном разделе описан модуль {{ sd-full-name }} {{ access-analyzer-name }}, который позволяет просматривать имеющиеся у субъектов организации права доступа к ресурсам и при необходимости изменять или отзывать такие права доступа.
---

# Модуль {{ access-analyzer-name }}

В целях обеспечения [безопасности](../../security/standard/all.md) данных и облачной инфраструктуры необходимо регулярно проводить аудит прав доступа, имеющихся у [пользователей](../../overview/roles-and-resources.md#users) и [сервисных аккаунтов](../../iam/concepts/users/accounts.md#sa).

[Модуль {{ access-analyzer-name }}]({{ link-sd-main }}access-analyzer/) предназначен для анализа прав доступа [субъектов](../../iam/concepts/access-control/index.md#subject) к ресурсам организации, выявления неиспользуемых и избыточно выданных привилегий, а также проведения диагностики доступов с целью снижения рисков информационной безопасности.

## Рекомендации {#recommendations}

{% include [access-analyzer-recommendations-preview-notice](../../_includes/security-deck/access-analyzer-recommendations-preview-notice.md) %}

Модуль {{ access-analyzer-name }} автоматически анализирует роли, которые назначены пользователям и группам на [каталоги](*folder_definition), [облака](*cloud_definition) и [организации](*organization_definition), и для каждого случая выдает индивидуальные _рекомендации_ по повышению уровня безопасности. Модуль не выдает рекомендации в отношении ролей, которые выданы субъектам на отдельные ресурсы сервисов {{ yandex-cloud }}, такие как виртуальные машины, сервисные аккаунты, кластеры управляемых баз данных и т.п.

Анализ ролей запускается при включении модуля {{ access-analyzer-name }} в настройках [окружения](./workspace.md) и в дальнейшем выполняется регулярно и автоматически. Дата и время выполнения последнего анализа [отображаются](../operations/access-analyzer/use-recommendations.md#view) на странице со списком рекомендаций под строкой фильтра.

Если модуль {{ access-analyzer-name }} отключен в настройках окружения, функциональность рекомендаций недоступна.

При выполнении анализа и подготовке рекомендаций {{ access-analyzer-name }} использует системные логи авторизаций сервиса [{{ iam-full-name }}](../../iam/index.yaml) за последние 90 дней.

{% include [access-analyzer-recommendations-view-role-notice](../../_includes/security-deck/access-analyzer-recommendations-view-role-notice.md) %}

Отзывать или изменять роли могут пользователи, обладающие одной из ролей: `admin`, `resource-manager.admin`, `organization-manager.admin`, `resource-manager.clouds.owner`, `organization-manager.organizations.owner`.

### Типы рекомендаций {#recommendation-types}

Каждая рекомендация содержит предложение выполнить одно из следующих действий:

* [Заменить текущую роль](../operations/access-analyzer/use-recommendations.md#replace) на другую, более [гранулярную](*granular_definition) роль или группу ролей.

    В зависимости от ситуации сервис может предложить на замену от одной до пяти ролей. При этом совокупный объем разрешений, которые предоставляют новые роли, всегда ниже, чем у текущей роли.
* [Отозвать роль](../operations/access-analyzer/use-recommendations.md#revoke) у субъекта.

    Отзыв роли рекомендуется в случаях, когда разрешения, которые предоставляет текущая роль субъекта, не использовались для авторизации операций в {{ yandex-cloud }} в течение последних 90 дней.

Если какие-то рекомендации вам не подходят, вы можете [скрыть](../operations/access-analyzer/use-recommendations.md#manage-visibility) их.

Подробнее о работе с рекомендациями читайте в разделе [{#T}](../operations/access-analyzer/use-recommendations.md).

{% include [access-analyzer-recommendations-responsibility-alert](../../_includes/security-deck/access-analyzer-recommendations-responsibility-alert.md) %}

## Диагностика доступов {#viewing-permissions}

{% note info %}

Функциональность диагностики доступов {{ access-analyzer-name }} находится на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}

Функциональность диагностики доступов позволяет просматривать доступы, назначенные индивидуальному субъекту (пользователю или сервисному аккаунту):

* напрямую;
* через группу пользователей;
* через системную группу;
* через публичную группу.

Для каждого доступа в выводимом списке указывается имя/идентификатор и тип [ресурса](../../iam/concepts/access-control/resources-with-access-control.md), к которому выдан доступ, назначенная субъекту на этот ресурс [роль](../../iam/concepts/access-control/roles.md), а также информация о том, была ли эта роль назначена субъекту напрямую или была унаследована из группы, членом которой является этот субъект.

Понять, назначен ли доступ на определенный ресурс индивидуальному субъекту напрямую или через группу, можно по значению поля **{{ ui-key.yacloud_org.iam-bindings.subject.title_group }}** таблицы с доступами субъекта. Если поле не заполнено, значит роль выдана напрямую. В остальных случаях в поле указано имя группы и ее идентификатор.

Доступы группам назначаются только напрямую, поэтому для групп поле **{{ ui-key.yacloud_org.iam-bindings.subject.title_group }}** таблицы с доступами всегда пустое.

Список выданных субъекту доступов можно фильтровать:

* по идентификатору ресурса, к которому выдан доступ;
* по идентификатору выданной роли;
* по способу назначения: `{{ ui-key.yacloud_org.iam-bindings.subject.value_role-source-filter_direct }}` или `{{ ui-key.yacloud_org.iam-bindings.subject.value_role-source-filter_group }}`.

Просматривать доступы в [интерфейсе {{ sd-name }}]({{ link-sd-main }}access-analyzer/) могут [члены организации](../../organization/concepts/membership.md), которым на эту организацию назначена [роль](../../organization/security/index.md#organization-manager-viewer) `organization-manager.viewer` или выше. При этом диагностику доступов можно использовать, даже если модуль {{ access-analyzer-name }} не включен в настройках [окружения](./workspace.md).

Функциональность диагностики доступов позволяет при необходимости [отзывать](../operations/access-analyzer/analyze-permissions.md#revoke) у индивидуальных субъектов и групп лишние доступы, а также исключать индивидуальных субъектов из групп пользователей.

Отзывать доступы могут пользователи, обладающие одной из ролей: `admin`, `resource-manager.admin`, `organization-manager.admin`, `resource-manager.clouds.owner`, `organization-manager.organizations.owner` или ролью администратора того [сервиса](../../overview/concepts/services.md), к ресурсу которого у субъекта отзывается доступ.

Исключить субъекта можно только из группы, созданной администратором организации. Исключить субъекта из системной или публичной группы нельзя.

#### Полезные ссылки {#see-also}

* [{#T}](../operations/access-analyzer/use-recommendations.md)
* [{#T}](../operations/access-analyzer/analyze-permissions.md)

[*folder_definition]: {% include [folder-definition](../../_popups/resource-manager/folder-definition.md) %}

[*cloud_definition]: {% include [cloud-definition](../../_popups/resource-manager/cloud-definition.md) %}

[*organization_definition]: {% include [organization-definition](../../_popups/identity-hub/organization-definition.md) %}

[*granular_definition]: {% include [granularity-in-access-management-definition](../../_popups/granularity-in-access-management-definition.md) %}
