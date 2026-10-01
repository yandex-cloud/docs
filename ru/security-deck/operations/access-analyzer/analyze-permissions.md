---
title: Диагностика доступов в модуле {{ sd-full-name }} {{ access-analyzer-name }}
description: В данном разделе вы узнаете, как в {{ sd-full-name }} можно посмотреть права доступа, назначенные аккаунту или группе к ресурсам организации, и отозвать такие права доступа.
---

# Диагностика доступов в модуле {{ access-analyzer-name }}

{% include [note-preview](../../../_includes/note-preview.md) %}

[Модуль {{ access-analyzer-name }}](../../concepts/access-analyzer.md) позволяет централизованно просматривать список доступов [субъектов](../../../iam/concepts/access-control/index.md#subject) и групп к [ресурсам](../../../iam/concepts/access-control/resources-with-access-control.md) [организации](*organization_definition) и отзывать лишние доступы.

## Просмотреть список доступов субъекта {#view}

Просматривать доступы в [интерфейсе {{ sd-name }}]({{ link-sd-main }}access-analyzer/) могут [члены организации](../../../organization/concepts/membership.md), которым на эту организацию назначена [роль](../../../organization/security/index.md#organization-manager-viewer) `organization-manager.viewer` или выше.

Чтобы получить список доступов субъекта к ресурсам организации:

{% include [view-subject-access-bindings](../../../_includes/security-deck/view-subject-access-bindings.md) %}

## Отозвать доступ у субъекта {#revoke}

Отозвать доступ может пользователь, обладающий одной из ролей: `admin`, `resource-manager.admin`, `organization-manager.admin`, `resource-manager.clouds.owner`, `organization-manager.organizations.owner` или ролью администратора того [сервиса](../../../overview/concepts/services.md), к ресурсу которого у субъекта отзывается доступ.

Чтобы отозвать у субъекта доступ (роль) к ресурсу:

1. [Откройте](#view) список доступов нужного субъекта и выберите доступ, который требуется отозвать.

    При необходимости воспользуйтесь фильтром по идентификатору ресурса, идентификатору роли или по способу назначения доступа (`{{ ui-key.yacloud_org.iam-bindings.subject.value_role-source-filter_direct }}` или `{{ ui-key.yacloud_org.iam-bindings.subject.value_role-source-filter_group }}`).

1. В зависимости от способа назначения доступа, отзовите его:

    {% list tabs %}

    - Доступ назначен напрямую

      Если доступ назначен субъекту напрямую (поле **{{ ui-key.yacloud_org.iam-bindings.subject.title_group }}** не заполнено):

      1. В строке с нужным доступом нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![person-xmark](../../../_assets/console-icons/person-xmark.svg) **{{ ui-key.yacloud_org.iam-bindings.subject.title_revoke-access-dialog }}**.
      1. В открывшемся окне проверьте правильность информации ресурсе, к которому отзывается доступ, и выберите роли, которые вы хотите отозвать.
      1. Нажмите кнопку **{{ ui-key.yacloud_components.revoke-access-dialog.action_revoke-all }}** (или **Отозвать выбранные**, если вы выбрали не все роли).

    - Доступ назначен через группу

      Если доступ назначен субъекту через группу (в поле **{{ ui-key.yacloud_org.iam-bindings.subject.title_group }}** указано имя группы и ее идентификатор), то такой доступ у этого субъекта отозвать нельзя. Вместо этого вы можете либо исключить субъекта из этой группы пользователей, либо отозвать доступ у всей группы.

      * Чтобы исключить субъекта из [группы пользователей](../../../organization/concepts/groups.md):

          1. В строке с нужным доступом нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![person-xmark](../../../_assets/console-icons/person-xmark.svg) **{{ ui-key.yacloud_org.entity.group.action_remove-user }}**.
          1. В открывшемся окне ознакомьтесь со списком доступов, которые субъект потеряет при исключении его из группы, и нажмите кнопку **{{ ui-key.yacloud_org.actions.exclude }}**.

          Исключить субъекта из [системной группы](../../../iam/concepts/access-control/system-group.md) или [публичной группы](../../../iam/concepts/access-control/public-group.md) нельзя: чтобы отозвать доступ, выданный через одну из таких групп, необходимо отозвать этот доступ у всей группы.

      * Чтобы отозвать доступ у всей группы, [откройте](#view) список доступов этой группы и воспользуйтесь инструкцией для отзыва доступа, назначенного напрямую.

    {% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](../../concepts/access-analyzer.md)
* [{#T}](./use-recommendations.md)

[*organization_definition]: {% include [organization-definition](../../../_popups/identity-hub/organization-definition.md) %}