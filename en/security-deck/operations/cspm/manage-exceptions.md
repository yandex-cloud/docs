---
title: Managing exceptions to the {{ cspm-name }} module's security control rules in {{ sd-full-name }}
description: In this section, you will learn how to create, modify, and delete exceptions to rules in the {{ sd-full-name }} {{ cspm-name }} module.
---

# Managing exceptions to the {{ cspm-name }} module's security control rules

{% include [note-preview](../../../_includes/note-preview.md) %}

{% include [cspm-use-in-workspaces](../../../_includes/security-deck/cspm-use-in-workspaces.md) %}

[Exceptions](../../concepts/cspm.md#exceptions) to the {{ cspm-name }} module's security control [rules](../../concepts/cspm.md#rules) allow you to flexibly configure when and for which objects the results of a rule check should be ignored.

## Viewing a list of exceptions {#view-exceptions-list}

To view the list of exceptions from the {{ cspm-name }} module's security control rules applicable to the [workspace](../../concepts/workspace.md):

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. At the top of the window, select the [workspace](../../concepts/workspace.md) for which you want to view the info on control rule exceptions.
  1. On the **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** page that opens, go to the **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}** tab.

      The list of exceptions for the {{ cspm-name }} module rules is provided under **{{ ui-key.yacloud_org.security.controls.ExceptionOverview.header_caption_cspm_9dTJt }}** and contains the following fields:

      * **{{ ui-key.yacloud_org.security.controls.ScopeFilterTable.field_reason_qN8a7 }}**: User-specified exception reason when creating the exception.
      * **{{ ui-key.yacloud_org.security.controls.ScopeFilterTable.field_type_kCG8J }}**: Action option for the exception you are creating:

          * `{{ ui-key.yacloud_org.security.controls.ScopeFilterTable.field_type_manual_mbKxp }}`: If the conditions specified in the exception are met, the resource will generate only rule compliance signals.
          * `{{ ui-key.yacloud_org.security.controls.ScopeFilterTable.field_type_exclude_cigcD }}`: If the conditions specified in the exception are met, the resource will not generate any signals, neither on compliance nor on violation.
      * **{{ ui-key.yacloud_org.security.controls.ScopeFilterTable.field_rules_vBK4W }}**: Number of rules for which compliance checking is excluded. To view a detailed list of excluded rules, click the line with the exception.
      * **{{ ui-key.yacloud_org.security.controls.ScopeFilterTable.field_author_8hf4z }}**: Information about the user who created the exception, as well as the date and time of creation.

{% endlist %}

## Creating an exception {#create-exception}

To create a new exception for the {{ cspm-name }} module's security control rules:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. At the top of the window, select the [workspace](../../concepts/workspace.md) in which you want to create an exception from the control rules.
  1. On the **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** page that opens, go to the **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}** tab.
  1. In the top-right corner, click **{{ ui-key.yacloud_org.security.controls.ControlsExceptionsPage.action_create }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) and select `{{ ui-key.yacloud_org.security.controls.ControlsExceptionsPage.scope_filter_header_7CrSm }}`. In the window that opens:

      1. Under **{{ ui-key.yacloud_org.security.controls.ExceptionOverview.info_type_1dxbZ }}**, select an action option for the exception you are creating:

          {% include [cspm-exception-types](../../../_includes/security-deck/cspm-exception-types.md) %}

      1. Under **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.scopeOfControl_aRkwB }}**, specify the resources you want to exclude when checking the {{ cspm-name }} module rules:

          * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.allResources_2ax5E }}`: To exclude all resources controlled in the [workspace](../../concepts/workspace.md).
          * `{{ ui-key.yacloud_org.security.dspm.data-sources.bXXxQ }}`: To exclude only some resources. To select resources excluded from the check:

              * Click ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.selectResources_bD5MC }}**.
              * In the window that opens, select the resources to exclude from the rule and click **{{ ui-key.yacloud.common.apply }}**.
      1. Under **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.section-title }}**, select the {{ cspm-name }} module rules for which the selected resources should not be checked:

          * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_all }}`: To exclude the selected resources from the check for compliance with all the {{ cspm-name }} module rules.
          * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_selected }}`: To exclude checks for compliance with a given set of rules. To select rules whose compliance checks will be disabled based on the exception you are creating:

              * Click ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.action_select-rules }}**.
              * In the window that opens, select the rules you want to exclude from compliance checks. If required, use the filter or search at the top of the window.
              * Click **{{ ui-key.yacloud_org.security.workspaces.ServiceAccountResourceSelectDialog.action_save }}**.
      1. Under **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.section-title_3YcSF }}**, give in any format the reason why you are creating an exception.
      1. Click **{{ ui-key.yacloud_org.security.controls.ControlsExceptionsPage.action_create }}**.

{% endlist %}

After the next infrastructure check is completed, the new exception will be displayed on the **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** page, on the **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}** tab, under **{{ ui-key.yacloud_org.security.controls.ExceptionOverview.header_caption_cspm_9dTJt }}**. The frequency of checks is 8 hours.

## Deleting an exception {#delete-exception}

To delete an exception for the {{ cspm-name }} module's security control rules:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. At the top of the window, select the [workspace](../../concepts/workspace.md) in which you want to delete an exception from the control rules.
  1. On the **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** page that opens, go to the **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}** tab.
  1. Under **{{ ui-key.yacloud_org.security.controls.ExceptionOverview.header_caption_cspm_9dTJt }}**, in the row with the exception you want to delete, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.

{% endlist %}

This exception will be deleted from the [environment](../../concepts/workspace.md), and the limitations it placed on rule compliance checks will be canceled after the next infrastructure scan is completed. The frequency of checks is 8 hours.

#### See also {#see-also}

* [{#T}](./view-rules.md)
* [{#T}](../../concepts/cspm.md)
* [{#T}](../../concepts/workspace.md)