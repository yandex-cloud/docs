---
title: Viewing {{ k8s }} control rules
description: In this section, you will learn how to view active {{ k8s }} control rules.
---

# Viewing {{ k8s }} control rules

{% include [note-preview-kspm](../../../_includes/security-deck/note-preview-kspm.md) %}

To view Kubernetes control rules, you need the `security-deck.viewer` role or higher for the folder containing the KSPM module resources.

To view active {{ k8s }} control rules:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. At the top of the window, click **{{ ui-key.yacloud_components.cloud-center.action_more }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) and select the [workspace](../../concepts/workspace.md) for which you want to view the rule info. Use search, if required.
  1. On the **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** page that opens, go to the **{{ ui-key.yacloud_org.security.controls.ControlsPage.kubernetes_jRCmt }}** tab. The section that opens lists the control rules that form a part of the [security standards](../../concepts/workspace.md#standards) specified for the current workspace.

      For each rule, the table displays the following information:
      
      {% note tip %}
      
      If you need to, you can change the info columns displayed in the table. Do it by clicking ![gear](../../../_assets/console-icons/gear.svg) in the row with the table column headers, selecting the info columns you need, and clicking **{{ ui-key.yacloud_org.common.apply }}**.
      
      {% endnote %}
      
      * ![traffic-light](../../../_assets/console-icons/traffic-light.svg): Rule criticality level; this icon indicates how security-critical the rule is:
      
          * ![cspm-rule-notice-icon](../../../_assets/security-deck/cspm-rule-notice-icon.svg): {{ ui-key.yacloud_org.shared.components.severity_info_biSRh }}
          * ![cspm-low-severity-icon](../../../_assets/security-deck/cspm-low-severity-icon.svg): {{ ui-key.yacloud_org.shared.components.severity_low_tqf9A }}
          * ![cspm-moderate-severity-icon](../../../_assets/security-deck/cspm-moderate-severity-icon.svg): {{ ui-key.yacloud_org.shared.components.severity_medium_8LZ4w }}
          * ![cspm-high-severity-icon](../../../_assets/security-deck/cspm-high-severity-icon.svg): {{ ui-key.yacloud_org.shared.components.severity_high_cahHH }}
      * **{{ ui-key.yacloud_org.security.controls.rule-result.controlRule_kr2Bv }}**: Rule name and brief summary.
      * **{{ ui-key.yacloud_org.security.controls.rule-result.standards_iv6a5 }}**: Icon(s) for the [security standards](../../../security-deck/concepts/workspace.md#standards) that are using this rule. If the icon is colored, it means the rule is checked for the corresponding standard. If the icon is gray, it means it is not.
      * **{{ ui-key.yacloud_org.security.controls.rule-result.verificationMethod_dS9B2 }}**: How the infrastructure controlled in the workspace is checked for compliance with this rule:      
          * `automatic`
          * `manual`
      * **{{ ui-key.yacloud_org.security.controls.ExceptionDrawer.resources_field_id }}**: Rule ID in {{ yandex-cloud }}.
      * **{{ ui-key.yacloud_org.security.controls.rule-result.violations_q7AcU }}**: Number of rule violations detected.

  1. To view detailed information about a specific rule, click the table row with its name. The detailed info window that opens includes the following tabs:

      {% list tabs %}

      - {{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_overview_s9riS }}

        In addition to the data shown in the general rule info table, the **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_overview_s9riS }}** tab contains:
        * Date and time of the most recent security check.
        * Details on the monitored features, their configurations, or actions performed with them.

      - {{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_violations_dkbdT }}

        The **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_violations_dkbdT }}** tab lists security violations detected during checks. Detected violations will not appear in this list if they satisfy the [exception](../../concepts/cspm.md#exceptions) criteria specified for the rule.

      - {{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_recommendations_qq61Z }}

        The **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_recommendations_qq61Z }}** tab provides guides and solutions to assist you with rule compliance.

      {% endlist %}

{% endlist %}