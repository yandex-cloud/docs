---
title: "Отзыв доступов в CIEM {{ sd-full-name }}"
description: "В данном разделе вы узнаете, как в {{ sd-name }} можно отозвать у аккаунта или группы права доступа к ресурсам организации."
---

# Отозвать доступ у субъекта

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

[Диагностика доступов (CIEM)](../../concepts/ciem.md) {{ sd-name }} позволяет централизованно просматривать список доступов [субъектов](../../../iam/concepts/access-control/index.md#subject) и групп к [ресурсам](../../../iam/concepts/access-control/resources-with-access-control.md) организации и отзывать лишние доступы.

Отозвать доступ может пользователь, обладающий одной из ролей: `admin`, `resource-manager.admin`, `organization-manager.admin`, `resource-manager.clouds.owner`, `organization-manager.organizations.owner` или ролью администратора того [сервиса](../../../overview/concepts/services.md), к ресурсу которого у субъекта отзывается доступ.

Чтобы отозвать у субъекта доступ (роль) к ресурсу:

1. [Откройте](./view-permissions.md) список доступов нужного субъекта и выберите доступ, который требуется отозвать.

    При необходимости воспользуйтесь фильтром по идентификатору ресурса, идентификатору роли или по способу назначения доступа (`{{ ui-key.yacloud_org.iam-bindings.subject.value_role-source-filter_direct }}` или `{{ ui-key.yacloud_org.iam-bindings.subject.value_role-source-filter_group }}`).

1. В зависимости от способа назначения доступа, отзовите его:

    {% list tabs %}

    - Доступ назначен напрямую

      Если доступ назначен субъекту напрямую (поле **{{ ui-key.yacloud_org.iam-bindings.subject.title_group }}** не заполнено):

      1. В строке с нужным доступом нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![person-xmark](../../../_assets/console-icons/person-xmark.svg) **{{ ui-key.yacloud_org.iam-bindings.subject.title_revoke-access-dialog }}**.
      1. В открывшемся окне проверьте правильность информации ресурсе, к которому отзывается доступ, и выберите роли, которые вы хотите отозвать.
      1. Нажмите кнопку **{{ ui-key.yacloud_org.iam-bindings.subject.action_revoke-all }}** (или **Отозвать выбранные**, если вы выбрали не все роли).

    - Доступ назначен через группу

      Если доступ назначен субъекту через группу (в поле **{{ ui-key.yacloud_org.iam-bindings.subject.title_group }}** указано имя группы и ее идентификатор), то такой доступ у этого субъекта отозвать нельзя. Вместо этого вы можете либо исключить субъекта из этой группы пользователей, либо отозвать доступ у всей группы.

      * Чтобы исключить субъекта из [группы пользователей](../../../organization/concepts/groups.md):

          1. В строке с нужным доступом нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![person-xmark](../../../_assets/console-icons/person-xmark.svg) **{{ ui-key.yacloud_org.entity.group.action_remove-user }}**.
          1. В открывшемся окне ознакомьтесь со списком доступов, которые субъект потеряет при исключении его из группы, и нажмите кнопку **{{ ui-key.yacloud_org.actions.exclude }}**.

          Исключить субъекта из [системной группы](../../../iam/concepts/access-control/system-group.md) или [публичной группы](../../../iam/concepts/access-control/public-group.md) нельзя: чтобы отозвать доступ, выданный через одну из таких групп, необходимо отозвать этот доступ у всей группы.

      * Чтобы отозвать доступ у всей группы, [откройте](./view-permissions.md) список доступов этой группы и воспользуйтесь инструкцией для отзыва доступа, назначенного напрямую.

{% endlist %}

#### См. также {#see-also}

* [{#T}](./view-permissions.md)
* [{#T}](../../concepts/ciem.md)
* [{#T}](../../security/index.md)