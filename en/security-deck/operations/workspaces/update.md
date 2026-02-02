---
title: Updating a {{ sd-full-name }} workspace
description: In this guide, you will learn how to update a workspace in {{ sd-full-name }}.
---

# Updating a {{ sd-name }} workspace and its components

{% include [note-preview](../../../_includes/note-preview.md) %}

## Updating a {{ sd-full-name }} workspace

To update a {{ sd-name }} [workspace](../../concepts/workspace.md):

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![sliders](../../../_assets/console-icons/sliders.svg) **{{ ui-key.yacloud_org.security-center.label_settings }}** and go to the **{{ ui-key.yacloud_org.security.settings.SettingsPageLayout.workspacesLabel_kZyU1 }}** tab.
  1. In the list that opens, click the required workspace to update its settings.

      {% note tip %}

      To quickly find the workspace of interest, use the filter.

      {% endnote %}

  1. Optionally, navigate to the **{{ ui-key.yacloud_org.security.workspaces.WorkspaceEditPageLayout.tabGeneralParams_xc2v2 }}** tab and update the basic workspace settings:

      1. Under **{{ ui-key.yacloud_org.security.workspaces.WorkspaceGeneralParamsForm.workspace_title_365xt }}**, update the workspace name and description.
      1. {% include [workspace-create-step1-substep1](../../../_includes/security-deck/workspace-create-step1-substep1.md) %}
      1. Click **{{ ui-key.yacloud.common.save }}** to save your changes.
  1. Optionally, click the **{{ ui-key.yacloud_org.security.workspaces.WorkspaceEditPageLayout.tabResources_vJuSN }}** tab to update the list of resources controlled by the workspace:

      1. Update the resource list. You can do this with the current [connector](../../concepts/workspace.md#connectors) settings, by changing the connector settings, or by replacing the connector with a different one:

          {% list tabs %}

          - Current settings

            1. In the section with the connector name, click ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_org.security.workspaces.WorkspaceResourcesForm.buttonSelectCloudCatalog }}** to update the resources ([clouds](../../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folders](../../../resource-manager/concepts/resources-hierarchy.md#folder)) the workspace will control the security of. In the window that opens:

                1. Select the resources whose security you want to control in the workspace. You can only select resources that are accessible to the service account linked to the connector.
                1. Click **{{ ui-key.yacloud_org.security.workspaces.ServiceAccountResourceSelectDialog.action_save }}**.

          - Modify settings

            1. In the section with the connector name, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud_org.security.workspaces.WorkspaceResourcesForm.actionEditConnector }}**. In the window that opens:

                {% include [workspace-create-step2-edit-connector](../../../_includes/security-deck/workspace-create-step2-edit-connector.md) %}

             1. {% include [workspace-create-step2-add-resources](../../../_includes/security-deck/workspace-create-step2-add-resources.md) %}

          - Replacing a connector

            1. In the section with the connector name, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
            1. Click the **{{ ui-key.yacloud_org.security.workspaces.ConnectorAddField.addResourcesPlaceholder }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) field and select the required connector from the list that opens.

                {% include [workspace-create-step2-create-connector](../../../_includes/security-deck/workspace-create-step2-create-connector.md) %}

            1. {% include [workspace-create-step2-add-resources](../../../_includes/security-deck/workspace-create-step2-add-resources.md) %}

          {% endlist %}

      1. Click **{{ ui-key.yacloud.common.save }}** to save your changes.
  1. Optionally, navigate to the **{{ ui-key.yacloud_org.security.workspaces.WorkspaceEditPageLayout.tabStandards_wSeaW }}** tab to update the list of standards against which workspace-controlled resources will be checked:

      1. Under **{{ ui-key.yacloud_org.security.workspaces.WorkspaceStandardsForm.standards_title_dBBXP }}**, select the required standards:
      
          {% include [workspace-sec-standard-list](../../../_includes/security-deck/workspace-sec-standard-list.md) %}
      
          You can select several standards at the same time. The **{{ ui-key.yacloud_org.security.workspaces.WorkspaceStandardsForm.modules_title_s8LDi }}** section will thus get new {{ sd-name }} modules, which will be activated in the new workspace to check your resources for compliance with the selected standards and regulations.
      1. Click **{{ ui-key.yacloud.common.save }}** to save your changes.
  1. Optionally, navigate to the **{{ ui-key.yacloud_org.security.workspaces.WorkspaceEditPageLayout.tabKubernetes_rC2uU }}** tab to update the security control settings for {{ k8s }} clusters.

{% endlist %}

{% note info %}

You cannot update the folder that the workspace uses to store its resources and settings.

{% endnote %}

## Editing a connector {#update-connector}

To update a {{ sd-name }} [connector](../../concepts/workspace.md#connectors):

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![sliders](../../../_assets/console-icons/sliders.svg) **{{ ui-key.yacloud_org.security-center.label_settings }}** and go to the **{{ ui-key.yacloud_org.security.settings.SettingsPageLayout.connectorsLabel_2NoP9 }}** tab.

      {% note tip %}

      To quickly find the connector you need, use the filter.

      {% endnote %}

  1. In the list that opens, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) in the row with the required connector and select ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud_org.actions.edit }}**. In the window that opens:

      {% include [workspace-create-step2-edit-connector](../../../_includes/security-deck/workspace-create-step2-edit-connector.md) %}

{% endlist %}

## Updating an alert sink {#update-alert-sink}

To update a {{ sd-name }} [alert sink](../../concepts/workspace.md#alert-sinks):

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![sliders](../../../_assets/console-icons/sliders.svg) **{{ ui-key.yacloud_org.security-center.label_settings }}** and go to the **{{ ui-key.yacloud_org.security.settings.SettingsPageLayout.alertSinkLabel_gvxBa }}** tab.

      {% note tip %}

      To quickly find the alert sink you need, use the filter.

      {% endnote %}
  1. In the list that opens, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) in the row with the required connector and select ![pencil](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud_org.actions.edit }}**.
  1. In the window that opens, update the alert sink settings and click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/workspace.md)
* [{#T}](./create.md)
* [{#T}](./view-dashboard.md)
* [{#T}](./manage-access.md)
* [{#T}](./delete.md)