---
title: Changing a SolidWall WAF application in {{ sws-full-name }}
description: Change the name and description of a SolidWall WAF application in {{ sws-name }}.
---

# Changing a SolidWall WAF application

You can change security rules and session binding methods by contacting [support](../../support/overview.md). In the console, you can only change the name and description of your application.

To change an application:

{% list tabs group=instructions %}

- Management console {#console}

  1. Make sure your account has the [smart-web-security.editor](../security/index.md#smart-web-security-editor) role for the folder with SolidWall WAF resources.
  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) with the SolidWall WAF profile.
  1. [Navigate]({{ link-console-main }}/link/smartwebsecurity) to **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. Open the profile with your application.
  1. In the application row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
  1. Change the name or description of the application.
  1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}
