---
title: Managing exceptions from {{ kspm-full-name }} ({{ kspm-name }}) security control rules in {{ sd-full-name }}
description: Guide on how to manage exceptions from {{ kspm-name }} security control rules.
---

# Managing exceptions from {{ kspm-name }} security control rules

{% include [note-preview](../../../_includes/note-preview.md) %}

You can use the {{ kspm-name }} module's exceptions to specify objects you want excluded from the [control rules](../../concepts/kspm.md) in place: all {{ k8s }} resources within the workspace or specific objects.

## Viewing the list of exceptions from the rules {#view-exceptions-list}

To view the list of exceptions from the {{ k8s }} security control rules applicable to the [workspace](../../concepts/workspace.md):

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. At the top of the window, select the [workspace](../../concepts/workspace.md) for which you want to view the info on control rule exceptions.
  1. On the **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** page that opens, go to the **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}** tab.

      The list of exceptions for the {{ k8s }} rules is provided under **{{ kspm-full-name }}** and contains the following fields:
      * **{{ ui-key.yacloud_org.security.controls.ControlsExceptionTable.field_status }}**: Active or inactive.
      * **{{ ui-key.yacloud_org.security.controls.ControlsExceptionTable.field_rules }}**: List of rules subject to exception.
      * **{{ ui-key.yacloud_org.security.controls.ControlsExceptionTable.field_resources }}**: List of resources.
      * **{{ ui-key.yacloud_org.security.controls.ControlsExceptionTable.field_objects_5dGQy }}**: List of objects.
      * **{{ ui-key.yacloud_org.security.controls.ControlsExceptionTable.field_reason }}**: Reason for exception.
      * **{{ ui-key.yacloud_org.security.controls.ControlsExceptionTable.field_author }}**: User who created the exception, along with the date and time of its creation.

{% endlist %}

## Creating an exception {#create-exception}

To create a new exception for the {{ k8s }} control rules:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. At the top of the window, select the [workspace](../../concepts/workspace.md) in which you want to create an exception from the control rules.
  1. On the **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** page that opens, go to the **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}** tab.
  1. In the top-right corner, click **{{ ui-key.yacloud_org.security.controls.ControlsExceptionsPage.action_create }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) and select `{{ kspm-full-name }}`. On the page that opens:
      1. Under **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.section-title }}**, select the {{ k8s }} control rules the selected resources should not be checked against:

          * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_all }}`: To exclude the selected resources from the check for compliance with all the {{ k8s }} control rules.
          * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_selected }}`: To exclude the selected resources from the check for compliance with a given set of rules. To select rules that the new exception will disable compliance checks for:

              * Click ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.action_select-rules }}**.
              * In the window that opens, select the rules you want to exclude from compliance checks. If required, use the filter or search at the top of the window.
              * Click **{{ ui-key.yacloud_org.security.workspaces.ServiceAccountResourceSelectDialog.action_save }}**.
      1. Under **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.scopeOfControl_aRkwB }}**, specify the resources you want to exclude when checking the {{ k8s }} control rules:

          * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.allResources_2ax5E }}`: To exclude all resources controlled in the [workspace](../../concepts/workspace.md).
          * `{{ ui-key.yacloud_org.security.dspm.data-sources.bXXxQ }}`: To exclude only some resources. To select resources excluded from the check:

              * Click ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.selectResources_bD5MC }}**.
              * In the window that opens, select the resources to exclude from the rule and click **{{ ui-key.yacloud.common.apply }}**.
      1. Optionally, under **{{ ui-key.yacloud_org.security.workspaces.section-title_9BLTm }}**, specify objects for the exception to cover. You can specify multiple values separated by a comma, space, or `Enter`. To set a value for a parameter or its part, use `*` in names and labels.

          * Check **{{ ui-key.yacloud_org.security.workspaces.namespace-checkbox_85krx }}** and enter the namespace name. The naming requirements are as follows:

            * It may be up to 63 characters long.
            * It can only include lowercase Latin letters, numbers, hyphens, and the wildcard symbol (`*`).

          * Check **{{ ui-key.yacloud_org.security.workspaces.workload-names-checkbox_Wn4Cb }}** and enter the workload name. The naming requirements are as follows:

            * It may be up to 63 characters long.
            * It can only include lowercase Latin letters, numbers, hyphens, and the wildcard symbol (`*`).
            * The first and last characters must be a letter, number, or `*`.

          * Check **{{ ui-key.yacloud_org.security.workspaces.workload-types-checkbox_Wt4Cb }}** and enter the workload type. It can be `Deployment`, `StatefulSet`, `DaemonSet`, `Job`, `CronJob`, `ReplicaSet`, or `Pod`. Format requirements:

            * It may be up to 63 characters long.
            * It may only include Latin letters and numbers.

          * Check **{{ ui-key.yacloud_org.security.workspaces.workload-labels-checkbox_Wl4Cb }}** and enter the pod label. Format requirements:

            * The label must be in `key=value` format.
            * The key and value must be no longer than 63 characters each.
            * The key and value can include Latin letters, numbers, hyphens, underscores, and dots.
            * The key may include a forward slash.
            * The value may include `*`.
            * The first and last characters must be a letter or number. 

      1. Under **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.section-title_3YcSF }}**, give in any format the reason why you are creating an exception.
      1. Select ![image](../../../_assets/console-icons/toggle-on.svg) **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.label_active-exclusion_fjPgA }}**.
      1. Click **{{ ui-key.yacloud_org.security.controls.ControlsExceptionsPage.action_create }}**.

{% endlist %}

The new exception will now be displayed under **{{ kspm-full-name }}** on the **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}** tab of the **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** page.

You can also create an exception on the alert page. For more information, see [{#T}](../alerts/work.md#create-exception).

## Deleting an exception {#delete-exception}

To delete an exception for the {{ k8s }} control rules:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. At the top of the window, select the [workspace](../../concepts/workspace.md) in which you want to delete an exception from the control rules.
  1. On the **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** page that opens, go to the **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}** tab.
  1. Under **{{ kspm-full-name }}**, in the row with the exception you want to delete, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.

{% endlist %}

This will remove the exception from the [workspace](../../concepts/workspace.md) and cancel the restrictions it imposed on rule checks.