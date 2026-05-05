---
title: Viewing {{ td-name }} security control rules in {{ sd-full-name }}
description: In this section, you will learn how to view the active security rules in {{ sd-full-name }}'s {{ td-full-name }} ({{ td-name }}) module.
---

# Viewing {{ td-full-name }} ({{ td-name }}) security control rules

{% include [td-use-in-workspaces](../../../_includes/security-deck/td-use-in-workspaces.md) %}

## Viewing general information about security control rules {#general-info}

To view general information about {{ td-full-name }}'s active security control rules:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. At the top of the window, select the [workspace](../../concepts/workspace.md) for which you want to view the rule info.
  1. On the **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** page that opens, go to the **{{ td-full-name }}** tab. The section that opens lists {{ td-full-name }} control rules for the current workspace.

      {% include [td-view-general-info](../../../_includes/security-deck/td-view-general-info.md) %}

{% endlist %}

## Viewing detailed information about security control rules {#detailed-info}

To view detailed information about a specific {{ td-full-name }} security control rule:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. At the top of the window, select the [workspace](../../concepts/workspace.md) for which you want to view the rule info.
  1. On the **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** page that opens, go to the **{{ td-full-name }}** tab. The section that opens lists {{ td-full-name }} control rules for the current workspace.
  1. {% include [td-view-detailed-info](../../../_includes/security-deck/td-view-detailed-info.md) %}

{% endlist %}

#### See also {#see-also}

* [{#T}](./manage-exceptions.md)
* [{#T}](../../concepts/threat-detector.md)
* [{#T}](../../concepts/workspace.md)