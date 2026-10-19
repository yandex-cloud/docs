---
title: Creating a custom rule set in {{ sd-full-name }}
description: In this section, you will learn how to create custom rule sets in {{ sd-full-name }}.
---

# Creating a custom rule set

Custom [rule sets](../../concepts/standard-compliance/index.md) include security control rules for the [Cloud Security Posture Management ({{ cspm-name }})](../../concepts/cspm.md#rules), [{{ k8s }} Security Posture Management ({{ kspm-name }})](../../concepts/kspm.md) and [Threat Detector ({{ td-name }})](../../concepts/threat-detector.md#rules) modules. These rule sets apply within {{ sd-name }} [workspaces](../../concepts/workspace.md). If you have no workspaces yet, [create](../workspaces/create.md) one.

{% include [custom-reuirements-role](../../../_includes/security-deck/custom-reuirements-role.md) %}

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![seal-check](../../../_assets/console-icons/seal-check.svg) **{{ ui-key.yacloud_org.security-center.label_comp }}**.
  1. At the top of the window, select the workspace.
  1. On the page that opens, click ![plus](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_org.security.comp.CompSetsPage.create_set_button }}**.
  1. Specify a name for the rule set and, optionally, add a description.
  1. Optionally, disable the rule set activation toggle if you do not want to use it immediately.
  1. Optionally, upload an icon for your rule set.
  1. Under **{{ ui-key.yacloud_org.security.comp.RulesFormSection.title_uUdpa }}**, select the rules you want to include in the set.

      Use filters to find the rules you need.

  1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}


#### Useful links {#see-also}

* [{#T}](../cspm/view-rules.md)
* [{#T}](../kspm/view-rules.md)
* [{#T}](../td/view-rules.md)