---
title: Viewing the workspace dashboard and operations in {{ sd-full-name }}
description: In this guide, you will learn how to view a dashboard and operations for a workspace in {{ sd-full-name }}.
---

# Viewing the workspace dashboard and operations in {{ sd-name }}

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

## Viewing a dashboard {#view-dashboard}

To view a {{ sd-name }} [workspace dashboard](../../concepts/workspace.md#dashboard):

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![vector-circle](../../../_assets/console-icons/vector-circle.svg) **{{ ui-key.yacloud_org.app.security.label_workspace_12Kax }}**.
  1. At the top of the window, click **{{ ui-key.yacloud_components.cloud-center.action_more }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) and select the [workspace](../../concepts/workspace.md) at hand. Use search, if required.
  1. Navigate to the **{{ ui-key.yacloud_org.security.workspaces.WorkspacePageLayout.overview_tab }}** tab.

      The dashboard that opens shows key information about security check results for the selected workspace. The dashboard shows cards with general information depending on the {{ sd-name }} modules configured in the workspace:

      {% include [dashboard-contents](../../../_includes/security-deck/dashboard-contents.md) %}

{% endlist %}

## Viewing operations {#view-operations}

To view a list of operations with a {{ sd-name }} [workspace](../../concepts/workspace.md):

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![vector-circle](../../../_assets/console-icons/vector-circle.svg) **{{ ui-key.yacloud_org.app.security.label_workspace_12Kax }}**.
  1. At the top of the window, click **{{ ui-key.yacloud_components.cloud-center.action_more }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) and select the workspace. Use search, if required.
  1. Navigate to the **{{ ui-key.yacloud_org.security.workspaces.WorkspacePageLayout.operations_tab }}** tab.

      The page that opens shows the list of all completed and ongoing operations for the selected workspace. The list of operations contains the following operation details:

      * Status
      * ID
      * Operation initiator username
      * Operation description
      * Operation start date and time
      * Operation status change date and time
      * Error message (for failed operations)

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/workspace.md)
* [{#T}](./create.md)
* [{#T}](./update.md)
* [{#T}](./manage-access.md)
* [{#T}](./delete.md)