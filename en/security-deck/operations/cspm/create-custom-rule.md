---
title: Creating a custom rule in {{ sd-full-name }}
description: In this guide, you will learn how to create a custom rule in {{ sd-full-name }}.
---

# Creating a custom rule

To work with [custom rules](../../concepts/custom-rules.md), you need the `security-deck.rules.editor` [role](../../security/cspm-roles.md) or higher.

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. At the top of the window, select the [workspace](../../concepts/workspace.md).
  1. Navigate to the **Configuration** tab and click **{{ ui-key.yacloud_org.security.rules.create_rule_pcNF6 }}**.
  1. Under **Basic rule**, select the rule whose parameters will be used as the basis for creating a custom rule.

     You can also select a basic rule from the general list of rules. If a rule in the list allows you to create a custom rule based on it, you can click ![image](../../../_assets/console-icons/ellipsis.svg) next to it and select ![image](../../../_assets/console-icons/copy-plus.svg) **Create rule based on**.

  1. Under **Main parameters**:
     
     1. Update the rule name and description.
     1. Select the rule criticality.
     1. In the **Recommendations** field, describe the set of actions required to fix the violation.

  1. Optionally, Under **Customizable parameters**, edit the settings specific to the basic rule.
  1. Click **Save**.

  {% include [add-rule-to-set](../../../_includes/security-deck/add-rule-to-set.md) %}

{% endlist %}

#### Useful links {#see-also}

* [{#T}](../../concepts/custom-rules.md)
* [{#T}](edit-custom-rule.md)
* [{#T}](delete-custom-rule.md)
* [{#T}](../custom-rules-sets/index.md)
