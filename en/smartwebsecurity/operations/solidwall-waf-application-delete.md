---
title: Deleting a SolidWall WAF application in {{ sws-full-name }}
description: Disable domains and delete applications from a SolidWall WAF profile in {{ sws-full-name }}.
---

# Deleting a SolidWall WAF application

Before deleting an application, disconnect all domains from it. You cannot delete an application that has connected domains. When you delete an application, all its data in the SolidWall WAF profile gets deleted too.

To delete the application:

{% list tabs group=instructions %}

- Management console {#console}

  1. Make sure your account has the [smart-web-security.editor](../security/index.md#smart-web-security-editor) role for the folder with SolidWall WAF resources.
  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) with the SolidWall WAF profile.
  1. [Navigate]({{ link-console-main }}/link/smartwebsecurity) to **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. Open the profile and the application.
  1. In the connected domain row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.smart-web-security.SolidWallDomainsActions.label_disable_7HM58 }}**.
  1. Confirm the domain disconnection. Repeat the action for all application domains.
  1. Go back to the profile page. In the application row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
  1. In the **{{ ui-key.yacloud.smart-web-security.SolidWallApplicationActions.popup_delete-application-title_eC8hf }}** window, confirm the app deletion.

{% endlist %}

Disconnecting domains from an app preserves the domains and their security profiles in {{ sws-name }}. After deleting all applications, you can [delete the profile](solidwall-waf-profile-delete.md).
