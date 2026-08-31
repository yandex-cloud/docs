---
title: Viewing {{ k8s }} control rules
description: In this section, you will learn how to view active {{ k8s }} control rules.
---

# Viewing {{ k8s }} control rules

To view {{ k8s }} control rules, you need the `security-deck.viewer` role or higher for the folder containing the {{ kspm-name }} module resources.

To view active {{ k8s }} control rules:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. At the top of the window, select the [workspace](../../concepts/workspace.md) for which you want to view the rule info.
  1. On the **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** page that opens, go to the **{{ k8s }}®** tab. The section that opens lists the control rules that form a part of the [security standards](../../concepts/workspace.md#standards) specified for the current workspace.

      {% note tip %}

      {% include [rules-display-settings](../../../_includes/security-deck/rules-display-settings.md) %}

      {% endnote %}

      For each rule, the table displays the following information:
      
      
      * ![traffic-light](../../../_assets/console-icons/traffic-light.svg): Rule criticality level; this icon indicates how security-critical the rule is:
      
          * ![cspm-rule-notice-icon](../../../_assets/security-deck/cspm-rule-notice-icon.svg): {{ ui-key.yacloud_org.shared.components.severity_info_biSRh }}
          * ![cspm-low-severity-icon](../../../_assets/security-deck/cspm-low-severity-icon.svg): {{ ui-key.yacloud_org.shared.components.severity_low_tqf9A }}
          * ![cspm-moderate-severity-icon](../../../_assets/security-deck/cspm-moderate-severity-icon.svg): {{ ui-key.yacloud_org.shared.components.severity_medium_8LZ4w }}
          * ![cspm-high-severity-icon](../../../_assets/security-deck/cspm-high-severity-icon.svg): {{ ui-key.yacloud_org.shared.components.severity_high_cahHH }}
      * **{{ ui-key.yacloud_org.security.controls.rule-result.controlRule_kr2Bv }}**: Rule name and brief summary.
      * **{{ ui-key.yacloud_org.security.controls.rule-result.standards_iv6a5 }}**: Icon(s) for the [security standards](../../../security-deck/concepts/workspace.md#standards) that are using this rule. If the icon is colored, it means the rule is checked for the corresponding standard. If the icon is gray, it means it is not.
      * **{{ ui-key.yacloud_org.security.controls.rule-result.verificationMethod_dS9B2 }}**: How the infrastructure controlled in the workspace is checked for compliance with this rule:

          * `Runtime`: Rule type applied to container runtimes and {{ k8s }} nodes.
          * `Admission`: Rule type applied to {{ k8s }} cluster resources. Rules of the `Admission` type have two operation modes:

              {% include [kspm-admission-modes](../../../_includes/security-deck/kspm-admission-modes.md) %}

          * `HostSecurity`: Rule type from the [CIS Benchmark™](../../concepts/standard-compliance/cis-kubernetes-benchmark.md) standard that applies to components on {{ k8s }} worker nodes.

      * **{{ ui-key.yacloud_org.security.controls.ExceptionDrawer.resources_field_id }}**: Rule ID in {{ yandex-cloud }}.
      * **{{ ui-key.yacloud_org.security.controls.rule-result.violations_q7AcU }}**: Number of detected rule violations.

  1. {% include [kspm-view-detailed-info](../../../_includes/security-deck/kspm-view-detailed-info.md) %}

{% endlist %}