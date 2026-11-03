---
title: Creating a custom rule in {{ sd-full-name }}
description: In this guide, you will learn how to create a custom rule in {{ sd-full-name }}.
---

# Creating a custom rule

To work with [custom rules](../../concepts/custom-rules.md), you need the `security-deck.rules.editor` [role](../../security/kspm-roles.md) or higher in the workspace.

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. At the top of the window, select the [workspace](../../concepts/workspace.md).
  1. Navigate to the **{{ k8s }}®** tab and click **{{ ui-key.yacloud_org.security.rules.create_rule_pcNF6 }}**.
  1. Under **Main parameters**:

     1. Enter the rule name and description.
     1. Select the **Check type**, which determines the type of rules that apply to the {{ k8s }} cluster. Currently only **Admission** is supported: the rule applies when you create or change a {{ k8s }} object.

        By default, a new rule is created in the `Audit` mode. After you create a rule, you can [change the mode](./manage-rule-modes.md).

     1. Select the rule criticality.
     1. In the **Recommendations** field, describe the set of actions required to fix the violation.

   1. Under **Policy rules**, insert the YAML code of the rule. For Admission type rules, only [Kyverno ClusterPolicy](https://kyverno.io/policies/?type=ClusterPolicy) is supported. Copy only the rule list itself starting with the `- name` field (without the the `spec` or `rules` fields).
        
      Click **Check** to check that the code you entered is correct. The check will also start automatically if you save the rule.

  1. Click **Save**.

{% endlist %}

The new rule will appear in the **Custom** tab. When the rule triggers, the system sends an alert. To view alerts, select ![alerts](../../../_assets/security-deck/alerts.svg) **{{ ui-key.yacloud_org.security-center.label_alerts }}** in the left-hand panel or [open](./use-kspm.md) the {{ kspm-name }} dashboard.

#### Useful links {#see-also}

* [{#T}](../../concepts/custom-rules.md)
* [{#T}](edit-custom-rule.md)
* [{#T}](delete-custom-rule.md)
* [{#T}](../custom-rules-sets/index.md)
