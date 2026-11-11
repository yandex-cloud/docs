---
title: Changing a SolidWall WAF profile in {{ sws-full-name }}
description: Change the name, description, pricing plan, and RPS tier for the SolidWall WAF profile in {{ sws-name }}.
---

# Changing a SolidWall WAF profile

In your profile, you can change the name, description, pricing plan, and [RPS tier](../concepts/solidwall-waf.md#tariffs).

Before traffic starts flowing, you can switch between plans freely, with changes taking effect immediately. After traffic appears, switching to another service plan takes effect on the first day of the following month.

To change a profile:

{% list tabs group=instructions %}

- Management console {#console}

  1. Make sure your account has the [smart-web-security.editor](../security/index.md#smart-web-security-editor) role for the folder with SolidWall WAF resources.
  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) with the SolidWall WAF profile.
  1. [Navigate]({{ link-console-main }}/link/smartwebsecurity) to **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. In the row with the profile you need, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.smart-web-security.overview.action_edit-profile }}**.
  1. Change the name, description, rate, or the **{{ ui-key.yacloud.smart-web-security.SolidWallProfileForm.titleRpsLimit_b67eQ }}** value.
  1. Check the selected parameters and the cost in the calculator.
  1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}
