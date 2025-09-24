---
title: Настройка прав доступа к окружению в {{ sd-full-name }}
description: Из этой инструкции вы узнаете, как настроить права доступа к окружению в {{ sd-full-name }}.
---

# Настроить права доступа к окружению {{ sd-name }}

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

Чтобы настроить доступ к [окружению](../../concepts/workspace.md) {{ sd-name }} для других пользователей:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![vector-circle](../../../_assets/console-icons/vector-circle.svg) **{{ ui-key.yacloud_org.app.security.label_workspace_12Kax }}**.
  1. В верхней части окна нажмите кнопку **{{ ui-key.yacloud_components.cloud-center.action_more }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) и выберите нужное окружение. При необходимости воспользуйтесь поиском.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.security.workspaces.WorkspacePageLayout.acl_tab }}**.
  1. Чтобы назначить новому пользователю права доступа к окружению, нажмите кнопку ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.security.workspaces.WorkspaceParticipantsForm.action_add-user }}** и в открывшемся окне:

      {% include [workspace-create-step4-adding-user-substep](../../../_includes/security-deck/workspace-create-step4-adding-user-substep.md) %}
  1. Чтобы изменить права доступа к окружению для пользователя:

      1. Найдите нужного пользователя в списке. При необходимости воспользуйтесь фильтром в верхней части раздела.
      1. В строке с нужным пользователем нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud_org.security.workspaces.WorkspaceParticipantsForm.WorkspaceAclTable.action_assign-roles }}**. В открывшемся окне:

          1. Чтобы добавить новую роль, нажмите кнопку ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.action.add-role }}** и выберите роль, которую хотите назначить пользователю. Вы можете назначить несколько ролей.
          1. Чтобы удалить назначенную роль, в поле с этой ролью нажмите значок ![xmark](../../../_assets/console-icons/xmark.svg).
          1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
  1. Чтобы отозвать у пользователя доступ к окружению:

      1. Найдите нужного пользователя в списке. При необходимости воспользуйтесь фильтром в верхней части раздела.
      1. В строке с нужным пользователем нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_org.security.workspaces.WorkspaceParticipantsForm.WorkspaceAclTable.action_remove-user }}**.
      1. В открывшемся окне подтвердите отзыв доступа у пользователя.

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/workspace.md)
* [{#T}](./create.md)
* [{#T}](./view-dashboard.md)
* [{#T}](./update.md)
* [{#T}](./delete.md)