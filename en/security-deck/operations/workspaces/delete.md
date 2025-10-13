---
title: Deleting a {{ sd-full-name }} workspace
description: In this guide, you will learn how to delete a workspace in {{ sd-full-name }}.
---

# Deleting a {{ sd-name }} workspace

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

To delete a {{ sd-name }} [workspace](../../concepts/workspace.md):

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![sliders](../../../_assets/console-icons/sliders.svg) **{{ ui-key.yacloud_org.security-center.label_settings }}** and go to the **{{ ui-key.yacloud_org.security.settings.SettingsPageLayout.workspacesLabel_kZyU1 }}** tab.

      {% note tip %}

      To quickly find the workspace of interest, use the filter.

      {% endnote %}

  1. In the workspace row, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_org.security.workspaces.WorkspaceResourcesForm.actionDelete }}**.
  1. In the window that opens, confirm the deletion. To do this, enter the name of the workspace you want to delete in the text field and click **{{ ui-key.yacloud.common.delete }}**.

{% endlist %}

This will irrevocably delete the workspace. All checks in line with the control rules will be stopped, and the components of the {{ sd-name }} modules will be deleted. The [connector](../../concepts/workspace.md#connectors) and [alert sink](../../concepts/workspace.md#alert-sinks) the workspace was using will be preserved.

#### See also {#see-also}

* [{#T}](../../concepts/workspace.md)
* [{#T}](./create.md)
* [{#T}](./view-dashboard.md)
* [{#T}](./update.md)
* [{#T}](./manage-access.md)