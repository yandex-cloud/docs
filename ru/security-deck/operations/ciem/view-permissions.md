---
title: Просмотр списка доступов в {{ ciem-name }} {{ sd-full-name }}
description: В данном разделе вы узнаете, как в {{ ciem-name }} {{ sd-name }} можно посмотреть все имеющиеся у аккаунта или группы права доступа к ресурсам организации.
---

# Просмотреть список доступов субъекта

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

[Модуль диагностики доступов](../../concepts/ciem.md) (Cloud Infrastructure Entitlement Management) позволяет централизованно просматривать полный список прав доступа индивидуальных [субъектов](../../../iam/concepts/access-control/index.md#subject) и групп к [ресурсам](../../../iam/concepts/access-control/resources-with-access-control.md) организации.

Просматривать доступы в [интерфейсе {{ sd-name }}]({{ link-sd-main }}iam-diagnostics/) могут [члены организации](../../../organization/concepts/membership.md), которым на эту организацию назначена [роль](../../../organization/security/index.md#organization-manager-viewer) `organization-manager.viewer` или выше.

Чтобы получить список доступов субъекта к ресурсам организации:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. [Войдите в аккаунт]({{ link-passport-login }}) пользователя организации с [ролью](../../../organization/security/index.md#organization-manager-viewer) `organization-manager.viewer` или выше на эту организацию.
  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![person-gear](../../../_assets/console-icons/person-gear.svg) **Диагностика доступа**.
  1. Нажмите кнопку ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.page.acl-diagnostics.action_select-subject }}** и в открывшемся окне:
  
      1. Выберите нужного [пользователя](../../../overview/roles-and-resources.md#users), [сервисный аккаунт](../../../iam/concepts/users/accounts.md#sa), [группу пользователей](../../../organization/concepts/groups.md), [системную группу](../../../iam/concepts/access-control/system-group.md) или [публичную группу](../../../iam/concepts/access-control/public-group.md).

          При необходимости воспользуйтесь поиском.
      1. Нажмите **{{ ui-key.yacloud.common.select }}**.

{% endlist %}

Откроется список доступов, назначенных выбранному субъекту. Для каждого доступа в списке указывается имя / идентификатор и тип ресурса, к которому выдан доступ, назначенная субъекту на этот ресурс [роль](../../../iam/concepts/access-control/roles.md), а также информация о том, была ли эта роль назначена субъекту напрямую или была унаследована из группы, членом которой является этот субъект.

Если у выбранного субъекта много доступов, отобразится только часть из них. Чтобы отобразить остальные доступы, нажмите кнопку **Загрузить ещё** внизу страницы.

При необходимости воспользуйтесь фильтром по идентификатору ресурса, идентификатору роли или по способу назначения доступа: `{{ ui-key.yacloud_org.iam-bindings.subject.value_role-source-filter_direct }}` или `{{ ui-key.yacloud_org.iam-bindings.subject.value_role-source-filter_group }}`.

Диагностика доступов не отображает права доступа субъектов к [платежным аккаунтам](../../../billing/concepts/billing-account.md) и ресурсам сервиса [{{ datalens-full-name }}](../../../datalens/index.yaml).

#### См. также {#see-also}

* [{#T}](./revoke-permissions.md)
* [{#T}](../../concepts/ciem.md)
* [{#T}](../../security/index.md)