---
title: Deleting a custom rule in {{ sd-full-name }}
description: In this guide, you will learn how to delete a custom security rule if you no longer need it to check your infrastructure.
---

# Deleting a custom rule

To work with [custom rules](../../concepts/custom-rules.md), you need the `security-deck.rules.editor` [role](../../security/cspm-roles.md) or higher.

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. At the top of the window, select the [workspace](../../concepts/workspace.md).
  1. Go to the **Custom** tab.
  1. Next to the rule, click ![image](../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, confirm the deletion.

{% endlist %}

#### Useful links {#see-also}

* [{#T}](../../concepts/custom-rules.md)
* [{#T}](create-custom-rule.md)
* [{#T}](edit-custom-rule.md)
* [{#T}](../custom-rules-sets/index.md)
