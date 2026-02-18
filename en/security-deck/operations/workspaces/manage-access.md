---
title: Configuring workspace access permissions in {{ sd-full-name }}
description: In this guide, you will learn how to configure workspace access permissions in {{ sd-full-name }}.
---

# Configuring the {{ sd-name }} workspace access permissions

{% include [note-preview](../../../_includes/note-preview.md) %}

To configure the {{ sd-name }} [workspace](../../concepts/workspace.md) access permissions for other users:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![vector-circle](../../../_assets/console-icons/vector-circle.svg) **{{ ui-key.yacloud_org.app.security.label_workspace_12Kax }}**.
  1. At the top of the window, click **{{ ui-key.yacloud_components.cloud-center.action_more }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) and select the workspace. Use search, if required.
  1. Navigate to the **{{ ui-key.yacloud_org.security.workspaces.WorkspacePageLayout.acl_tab }}** tab.
  1. To assign workspace access permissions to a new user, click ![person-plus](../../../_assets/console-icons/person-plus.svg) **{{ ui-key.yacloud_org.security.workspaces.WorkspaceParticipantsForm.action_add-user }}** and in the window that opens:

      {% include [workspace-create-step4-adding-user-substep](../../../_includes/security-deck/workspace-create-step4-adding-user-substep.md) %}
  1. To update user workspace access permissions:

      1. Find the user in the list. Optionally, use the filter in the right part of the section.
      1. In the row with the user, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.resource-acl.button_assign-binding }}**. In the window that opens:

          1. To add a new role, click ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.action.add-role }}** and select the role you want to assign to the user. You can assign multiple roles.
          1. To delete an assigned role, click ![xmark](../../../_assets/console-icons/xmark.svg) in the field with this role.
          1. Click **{{ ui-key.yacloud.common.save }}**.
  1. To revoke user's workspace access permissions:

      1. Find the user in the list. Optionally, use the filter in the right part of the section.
      1. In the row with the user, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_components.acl.action.revoke-access }}**.
      1. In the window that opens, confirm revoking access from the user.

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/workspace.md)
* [{#T}](./create.md)
* [{#T}](./view-dashboard.md)
* [{#T}](./update.md)
* [{#T}](./delete.md)