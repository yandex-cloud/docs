---
title: Editing a custom rule in {{ sd-full-name }}
description: 'In this guide, you will learn how to update the settings of a custom security rule: its name, description, severity, remediation recommendations, and more.'
---

# Editing a custom rule

To work with [custom rules](../../concepts/custom-rules.md), you need the `security-deck.rules.editor` [role](../../security/kspm-roles.md) or higher in the workspace.

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. At the top of the window, select the [workspace](../../concepts/workspace.md).
  1. On the **Custom** tab, click ![image](../../../_assets/console-icons/ellipsis.svg) next to the rule and select ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.

{% endlist %}

#### Useful links {#see-also}

* [{#T}](../../concepts/custom-rules.md)
* [{#T}](create-custom-rule.md)
* [{#T}](delete-custom-rule.md)
* [{#T}](../custom-rules-sets/index.md)
