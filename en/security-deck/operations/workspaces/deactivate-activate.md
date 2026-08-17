---
title: Deactivating and activating a {{ sd-full-name }} workspace
description: Follow this guide to deactivate and activate a workspace in {{ sd-full-name }}.
---

# Deactivating and activating a workspace

## Deactivate a workspace {#deactivate}

To stop security checks, deactivate your workspace:

{% include [workspace-after-deactivation](../../../_includes/security-deck/workspace-after-deactivation.md) %}

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![vector-circle](../../../_assets/console-icons/vector-circle.svg) **{{ ui-key.yacloud_org.app.security.label_workspace_12Kax }}**.
  1. At the top of the window, select the correct [workspace](../../concepts/workspace.md).
  1. To the right of the workspace name, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![alt text](../../../_assets/console-icons/ban.svg) **{{ ui-key.yacloud_org.security.workspaces.WorkspaceActionsMenu.stop_wvkkb }}**.
  1. In the window that opens, confirm the deactivation.

{% endlist %}

## Activate a workspace {#activate}

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![vector-circle](../../../_assets/console-icons/vector-circle.svg) **{{ ui-key.yacloud_org.app.security.label_workspace_12Kax }}**.
  1. At the top of the window, select the correct workspace.
  1. Click **{{ ui-key.yacloud_org.security.workspaces.WorkspaceInactiveAlert.activate_Y5mCr }}**.
  1. In the window that opens, confirm the activation.

{% endlist %}

#### Useful links {#see-also}

* [{#T}](../../concepts/workspace.md)
* [{#T}](./create.md)
* [{#T}](./update.md)
* [{#T}](./view-dashboard.md)
* [{#T}](./manage-access.md)
* [{#T}](./delete.md)