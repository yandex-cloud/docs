---
title: Managing exceptions to {{ k8s }}® Security Posture Management (KSPM) rules in {{ sd-full-name }}
description: How to manage exceptions to security control rules in the KSPM module.
---

# Managing exceptions to the KSPM module's security control rules

{% include [note-preview](../../../_includes/note-preview.md) %}

## Viewing the list of exceptions from the rules {#view-exceptions-list}

To view the list of exceptions from the {{ k8s }} security control rules applicable to the [workspace](../../concepts/workspace.md):

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. At the top of the window, click **{{ ui-key.yacloud_components.cloud-center.action_more }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) and select the [workspace](../../concepts/workspace.md) for which you want to view the info on control rule exceptions. Use search, if required.
  1. On the **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** page that opens, go to the **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}** tab.

      The list of exceptions for the {{ k8s }} rules is provided under **{{ ui-key.yacloud_org.security.controls.ControlsExceptionsPage.exceptions_header_qJD5D }}** and contains the following fields:
      * **Exception**: Reason for exception.
      * **Status**: Active or inactive.
      * **Rules**: List of rules for which compliance check has been excluded.
      * **Author**: User who created the exception.
      * **Date of creation**: Date and time the exception was created.

{% endlist %}

## Creating an exception {#create-exception}

To create a new exception for the {{ k8s }} control rules:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. At the top of the window, click **{{ ui-key.yacloud_components.cloud-center.action_more }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) and select the [workspace](../../concepts/workspace.md) in which you want to create an exception to the control rules. Use search, if required.
  1. On the **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** page that opens, go to the **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}** tab.
  1. In the top-right corner, click **{{ ui-key.yacloud_org.security.controls.ControlsExceptionsPage.action_create }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) and select `{{ ui-key.yacloud_org.security.controls.ControlsExceptionsPage.exceptions_header_vqsTb }}`. In the window that opens, do the following:
      1. Under **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.scopeOfControl_aRkwB }}**, specify the resources you want to exclude when checking the {{ k8s }} control rules:

          * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.allResources_2ax5E }}`: To exclude all resources controlled in the [workspace](../../concepts/workspace.md).
          * `Selected resources`: To exclude only some resources. To select resources to exclude from the check:

              * Click ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.selectResources_bD5MC }}**.
              * In the window that opens, select the resources to exclude from the rule and click **{{ ui-key.yacloud.common.apply }}**.
      1. Under **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.section-title }}**, select the {{ k8s }} control rules the selected resources should not be checked against:

          * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_all }}`: To exclude the selected resources from the check for compliance with all the {{ k8s }} control rules.
          * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_selected }}`: To exclude the selected resources from the check for compliance with a given set of rules. To select rules whose compliance checks will be disabled based on the exception you are creating:

              * Click ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.action_select-rules }}**.
              * In the window that opens, select the rules you want to exclude from compliance checks. If required, use the filter or search at the top of the window.
              * Click **Save selection**.
      1. Under **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.section-title_3YcSF }}**, give in any format the reason why you are creating an exception.
      1. Select ![image](../../../_assets/console-icons/toggle-on.svg) **Activate exception**.
      1. Click **{{ ui-key.yacloud_org.security.controls.ControlsExceptionsPage.action_create }}**.

{% endlist %}

The new exception will now be displayed under **{{ ui-key.yacloud_org.security.controls.ControlsExceptionsPage.exceptions_header_vqsTb }}** on the **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}** tab of the **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** page.

## Deleting an exception {#delete-exception}

To delete an exception for the {{ k8s }} control rules:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. At the top of the window, click **{{ ui-key.yacloud_components.cloud-center.action_more }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) and select the [workspace](../../concepts/workspace.md) in which you want to delete an exception from the control rules. Use search, if required.
  1. On the **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** page that opens, go to the **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}** tab.
  1. Under **{{ ui-key.yacloud_org.security.controls.ExceptionOverview.header_caption_cspm_9dTJt }}**, in the row with the exception you want to delete, click ![ellipsis](../../../_assets/console-icons/ellipsis.svg) and select ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.

{% endlist %}

This will remove the exception from the [workspace](../../concepts/workspace.md) and cancel the restrictions it imposed on rule checks.