---
title: Managing the operating modes of security control rules in {{ kspm-name }}
description: Guide for managing the operating modes of security control rules in {{ k8s }}® Security Posture Management ({{ kspm-name }}) in {{ sd-full-name }}.
---

# Managing the operating modes of security control rules of {{ kspm-name }}

The `Admission` type security control rules of the {{ kspm-name }} module have two operating modes:

{% include [kspm-admission-modes](../../../_includes/security-deck/kspm-admission-modes.md) %}

## Enabling {{ ui-key.yacloud_org.security.kspm.ControlModeSelect.value_enforce_ttbjL }} mode {#enable-enforce}

To enable `{{ ui-key.yacloud_org.security.kspm.ControlModeSelect.value_enforce_ttbjL }}` mode for a rule:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. At the top of the window, select the [workspace](*workspace) you want to change the rule mode in.
  1. On the **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** page that opens, go to the **{{ k8s }}®** tab. In the list that appears, find the `Admission` type rule whose mode you want to change. Optionally, use the filter at the top of the list.
  1. Click **{{ ui-key.yacloud_org.security.kspm.ControlModeSelect.label_mode_rDqYa }}: {{ ui-key.yacloud_org.security.kspm.ControlModeSelect.value_audit_jtY6w }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) next to the rule and select `{{ ui-key.yacloud_org.security.kspm.ControlModeSelect.action_enable_enforce_bdsK9 }}`.
  1. In the window that opens, confirm enabling lock mode.

  You can also change the rule's operating mode in the **{{ ui-key.yacloud_org.security.controls.RuleOverview.scan_kind_8Kgmz }}** field on the rule's detailed info page.

{% endlist %}

## Enabling {{ ui-key.yacloud_org.security.kspm.ControlModeSelect.value_audit_jtY6w }} mode {#enable-audit}

To enable `{{ ui-key.yacloud_org.security.kspm.ControlModeSelect.value_audit_jtY6w }}` mode for a rule (if `{{ ui-key.yacloud_org.security.kspm.ControlModeSelect.value_enforce_ttbjL }}` mode was previously enabled for this rule):

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. At the top of the window, select the [workspace](*workspace) you want to change the rule mode in.
  1. On the **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** page that opens, go to the **{{ k8s }}®** tab. In the list that appears, find the `Admission` type rule whose mode you want to change. Optionally, use the filter at the top of the list.
  1. Click **{{ ui-key.yacloud_org.security.kspm.ControlModeSelect.label_mode_rDqYa }}: {{ ui-key.yacloud_org.security.kspm.ControlModeSelect.value_enforce_ttbjL }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) next to the rule and select `{{ ui-key.yacloud_org.security.kspm.ControlModeSelect.action_disable_enforce_oYV96 }}`.
  1. In the window that opens, confirm disabling lock mode.

  You can also change the rule's operating mode in the **{{ ui-key.yacloud_org.security.controls.RuleOverview.scan_kind_8Kgmz }}** field on the rule's detailed info page.

{% endlist %}

## Managing lock mode with the help of exceptions {#apply-exception}

When you activate `{{ ui-key.yacloud_org.security.kspm.ControlModeSelect.value_enforce_ttbjL }}` mode for a rule, by default it applies to all {{ k8s }}® clusters in the [workspace](*workspace).

To change this logic and explicitly specify which {{ k8s }}® resources in the workspace will not be subject to `{{ ui-key.yacloud_org.security.kspm.ControlModeSelect.value_enforce_ttbjL }}` mode, create an [exception](*exception) to the rule:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. At the top of the window, select the [workspace](*workspace) in which you want to set up an exception for the security control rule.
  1. On the **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** page that opens, navigate to the **{{ k8s }}®** tab and select from the list the `Admission` type rule you want to create an exception for. Optionally, use the filter at the top of the list.
  1. In the rule info window that opens, go to the **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_exceptions_pHKkb }}** tab and click **{{ ui-key.yacloud_org.security.controls.RuleExceptions.placeholder_action_t5zxy }}**.
  1. Under **{{ ui-key.yacloud_org.security.kspm.KspmExceptionForm.section-title_mode }}**, select the correct lock mode:
  
      * `{{ ui-key.yacloud_org.security.kspm.KspmExceptionForm.title_ignore }}`: Checks for compliance with the rule for the resources named in the exception are off completely; no violations are logged.
      * `{{ ui-key.yacloud_org.security.kspm.KspmExceptionForm.title_audit }}`: Violations of the rule for the resources named in the exception will be logged, but deployment of workloads in {{ k8s }}® clusters will not be blocked.
  1. Under **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.scopeOfControl_aRkwB }}**, specify the clusters for which to cancel the lock, configure other settings, and complete the exception setup.

      {% note tip %}

      If necessary, look up [{#T}](./manage-exceptions.md).

      {% endnote %}

{% endlist %}

[*workspace]: {{ sd-name }} workspaces allow you to manage {{ yandex-cloud }} infrastructure security in a more granular way. They are containers for settings and resources of {{ sd-name }} modules, lists of controlled resources, control parameters, etc. For more information, see [{#T}](../../concepts/workspace.md).

[*exception]: You can use {{ kspm-name }} exceptions to specify objects you want excluded from the control rules in place. For more information on exceptions, see [{#T}](./manage-exceptions.md).
