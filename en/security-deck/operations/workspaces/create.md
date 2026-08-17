---
title: Creating an workspace in {{ sd-full-name }}
description: In this guide, you will learn how to create an workspace in {{ sd-full-name }} to monitor your cloud infrastructure for compliance with with industry standards.
---

# Creating a {{ sd-name }} workspace 

Before creating a [workspace](../../concepts/workspace.md):

1. Make sure you have the necessary [permissions](../../security/index.md) to work with the {{ sd-name }} modules. You optimal roles are:

   * `security-deck.admin` for the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) to store the {{ sd-name }} resources and modules.
   * `auditor` for the [organization](../../../organization/concepts/organization.md), [cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud), or folder security in which will be controlled by the workspace.
1. [Create](../../../iam/operations/sa/create.md) a service account and [assign](../../../iam/operations/sa/assign-role-for-sa.md) to it the `security-deck.worker` [role](../../security/index.md#security-deck-worker) for the organization, cloud, or folder security in which will be controlled by the workspace.

To create a {{ sd-name }} workspace:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![vector-circle](../../../_assets/console-icons/vector-circle.svg) **{{ ui-key.yacloud_org.app.security.label_workspace_12Kax }}**.
  1. If you do not have any workspaces yet, click **{{ ui-key.yacloud_org.security.workspaces.WorkspacesPlaceholder.createWorkspace_8yAnK }}**.

      If you already have a workspace and want to create another one to complement your existing environment, click **{{ ui-key.yacloud_org.common.more }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) at the top of the window and click **{{ ui-key.yacloud_org.security.workspaces.WorkspacesPlaceholder.createWorkspace_8yAnK }}**.
  1. {% include [workspace-create-step1](../../../_includes/security-deck/workspace-create-step1.md) %}
  1. {% include [workspace-create-step2](../../../_includes/security-deck/workspace-create-step2.md) %}
  1. {% include [workspace-create-step3](../../../_includes/security-deck/workspace-create-step3.md) %}
  1. {% include [workspace-create-step4](../../../_includes/security-deck/workspace-create-step4.md) %}

{% endlist %}

#### Useful links {#see-also}

* [{#T}](../../concepts/workspace.md)
* [{#T}](./view-dashboard.md)
* [{#T}](./update.md)
* [{#T}](./manage-access.md)
* [{#T}](./deactivate-activate.md)
* [{#T}](./delete.md)