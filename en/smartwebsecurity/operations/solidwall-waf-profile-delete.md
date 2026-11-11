---
title: Deleting a SolidWall WAF profile
description: Follow this guide to delete a SolidWall WAF profile.
---

# Deleting a SolidWall WAF profile

Before deleting a SolidWall WAF profile, [delete all applications](solidwall-waf-application-delete.md). Before deleting each application, disconnect all domains from it. You cannot delete a profile that contains applications.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Navigate]({{ link-console-main }}/link/smartwebsecurity) to **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. In the profile row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **Delete**.
  1. If a window appears with a warning about applications, delete them and then initiate the deletion process again.
  1. In the **Deleting a SolidWall WAF profile** window, enter the profile name.
  1. Click **Delete**.

{% endlist %}
