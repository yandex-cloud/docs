---
title: Viewing the {{ cspm-name }} module's security control rules in {{ sd-full-name }}
description: In this section, you will learn how to view the current security rules and learn about related violations in the Cloud Security Posture Management ({{ cspm-name }}) module in {{ sd-full-name }}.
---

# Viewing {{ cspm-name }} security control rules and related violations

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

{% include [cspm-use-in-workspaces](../../../_includes/security-deck/cspm-use-in-workspaces.md) %}

## Viewing general information about security control rules {#general-info}

To view [general information](../../concepts/cspm.md#general-info) about the {{ cspm-name }} module's current security control rules and related violation cases:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. At the top of the window, click **{{ ui-key.yacloud_components.cloud-center.action_more }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) and select the [workspace](../../concepts/workspace.md) for which you want to view the rule info. Use search, if required.
  1. On the **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** page that opens, go to the **{{ ui-key.yacloud_org.security.controls.ControlsPageLayout.configuration_w7Kw7 }}** tab. The section that opens lists the control rules that form a part of the [security standards](../../concepts/workspace.md#standards) specified for the current workspace.

      {% include [cspm-view-general-info](../../../_includes/security-deck/cspm-view-general-info.md) %}

{% endlist %}

## Viewing detailed information about security control rules {#detailed-info}

To view [detailed information](../../concepts/cspm.md#detailed-info) about a specific security control rule of the {{ cspm-name }} module:

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. In the left-hand panel, select ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. At the top of the window, click **{{ ui-key.yacloud_components.cloud-center.action_more }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) and select the [workspace](../../concepts/workspace.md) for which you want to view the rule info. Use search, if required.
  1. On the **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** page that opens, go to the **{{ ui-key.yacloud_org.security.controls.ControlsPageLayout.configuration_w7Kw7 }}** tab. The section that opens lists the control rules that form a part of the [security standards](../../concepts/workspace.md#standards) specified for the current workspace.
  1. {% include [cspm-view-detailed-info](../../../_includes/security-deck/cspm-view-detailed-info.md) %}

{% endlist %}

#### See also {#see-also}

* [{#T}](./manage-exceptions.md)
* [{#T}](../../concepts/cspm.md)
* [{#T}](../../concepts/workspace.md)