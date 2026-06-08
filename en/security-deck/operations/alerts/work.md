---
title: Working with alerts in {{ sd-full-name }}
description: In this section, you will learn how to work with alerts in {{ sd-full-name }}.
---

# Working with alerts

## Changing alert status {#status}

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}**.
  1. At the top of the window, select the [workspace](../../concepts/workspace.md).
  1. Click the table row containing the [alert](../../concepts/alerts.md) name.
  1. In the window that opens, select the status in the top-left corner.

{% endlist %}


## Analyzing alerts with the help of AI {#ai-analysis}

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}**.
  1. At the top of the window, select the [workspace](../../concepts/workspace.md).
  1. Click the table row containing the alert name.
  1. In the window that opens, click ![sparkles](../../../_assets/console-icons/sparkles-fill.svg) **{{ ui-key.yacloud_org.security-center.alert.action_alert_analysis }}**.

      The AI ​​assistant's dialog panel with its analysis will open on the right.

{% endlist %}


## Leaving a comment on an alert {#comment}

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}**.
  1. At the top of the window, select the [workspace](../../concepts/workspace.md).
  1. Click the table row containing an alert name.
  1. In the window that opens, go to the **{{ ui-key.yacloud_org.security-center.alerts.title_alert_comments }}** tab.
  1. Enter and finalize your comment, then click ![paper-plane](../../../_assets/console-icons/paper-plane.svg) **{{ ui-key.yacloud_org.security.alerts.comment_form.send }}**.

{% endlist %}


## Creating an alert exception {#create-exception}

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}**.
  1. At the top of the window, select the [workspace](../../concepts/workspace.md).
  1. Select an alert.
  1. In the window that opens:

      * To create an exception for all alert resources, click ![slasheye](../../../_assets/console-icons/eye-slash.svg) **{{ ui-key.yacloud_org.security.alerts-base.action_create-exception_kyUtB }}**.
      * To create an exception for only some resources, on the **{{ ui-key.yacloud_org.security-center.alerts.title_alert_overview }}** tab, under **Access scope**, select the resources and click ![slasheye](../../../_assets/console-icons/eye-slash.svg) **{{ ui-key.yacloud_org.security.alerts-base.action_create-exception_kyUtB }}**.

  1. In the window that opens, configure the exception settings based on the relevant module:

      {% list tabs %}

      - {{ cspm-name }}

        1. Under **{{ ui-key.yacloud_org.security.controls.ExceptionOverview.info_type_1dxbZ }}**, select an action option for the exception you are creating:

            {% include [cspm-exception-types](../../../_includes/security-deck/cspm-exception-types.md) %}

        1. Under **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.section-title }}**, select the {{ cspm-name }} module rules for which the selected resources should not be checked:

            * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_all }}`: To exclude the selected resources from the check for compliance with all the {{ cspm-name }} module rules.
            * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_selected }}`: To exclude the selected resources from the check for compliance with a given set of rules. To select the rules:

                * Click ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.action_select-rules }}**.
                * In the window that opens, select the rules you want to exclude from compliance checks. If required, use the filter or search at the top of the window.
                * Click **{{ ui-key.yacloud_org.security.workspaces.ServiceAccountResourceSelectDialog.action_save }}**.

        1. Under **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.section-title_3YcSF }}**, give in any format the reason why you are creating an exception.
        1. Click **{{ ui-key.yacloud_org.security.controls.ControlsExceptionsPage.action_create }}**.

      - {{ kspm-name }}

        1. Under **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.section-title }}**, select the {{ k8s }} control rules the selected resources should not be checked against:

            * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_all }}`: To exclude the selected resources from the check for compliance with all the {{ k8s }} control rules.
            * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_selected }}`: To exclude the selected resources from the check for compliance with a given set of rules. To select the rules:

                * Click ![circle-plus](../../../_assets/console-icons/circle-plus.svg) **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.action_select-rules }}**.
                * In the window that opens, select the rules you want to exclude from compliance checks. If required, use the filter or search at the top of the window.
                * Click **{{ ui-key.yacloud_org.security.workspaces.ServiceAccountResourceSelectDialog.action_save }}**.

        1. Under **{{ ui-key.yacloud_org.security.workspaces.section-title_9BLTm }}**, use a namespace to specify the objects to exclude from the check:
            * Enable **{{ ui-key.yacloud_org.security.workspaces.namespace-checkbox_85krx }}**.
            * Enter the object name from the namespace. Follow these naming requirements:

              {% include [name-format](../../../_includes/name-format.md) %}

            To exclude multiple objects at once, use wildcards. For example, a pattern like `*-ns` will exclude objects with the `ns` suffix, such as `prod-ns` and `test-ns`.

        1. Under **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.section-title_3YcSF }}**, give in any format the reason why you are creating an exception.
        1. Select ![image](../../../_assets/console-icons/toggle-on.svg) **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.label_active-exclusion_fjPgA }}**.
        1. Click **{{ ui-key.yacloud_org.security.controls.ControlsExceptionsPage.action_create }}**.

      {% endlist %}

{% endlist %}

The created exception will be displayed in the ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}** section of the relevant module.