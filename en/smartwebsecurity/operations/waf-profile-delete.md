---
title: "Deleting a WAF profile"
description: "Follow this guide to delete a WAF profile."
---

# Deleting a WAF profile

Before deleting a WAF profile, delete all WAF rules from the associated security profiles.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder with the [WAF profile](../concepts/waf.md).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Go to ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. Select the profile you want to delete. Memorize its ID.
  1. Under **{{ ui-key.yacloud.smart-web-security.waf.title_connected-profiles }}**, select the security profile.
  1. In the **{{ ui-key.yacloud.smart-web-security.overview.title_security-rules }}** tab, delete the WAF profile rules:
     1. In the **{{ ui-key.yacloud.smart-web-security.label_search-rule-type }}** filter, select **Web Application Firewall**.
     1. Next to the rule associated with the WAF profile featuring the required ID, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
     1. Confirm the deletion.
  1. Similarly, delete the WAF rules from all associated security profiles.
  1. Go back to the WAF profile page.
  1. Click ![options](../../_assets/console-icons/ellipsis.svg) at the top right and select **{{ ui-key.yacloud.common.delete }}**.
  1. Confirm the deletion.

{% endlist %}
