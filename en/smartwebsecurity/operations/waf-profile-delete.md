---
title: "Deleting a WAF profile"
description: "Follow this guide to delete a WAF profile."
---

# Deleting a WAF profile

Before deleting a WAF profile, delete all WAF rules from the associated security profiles.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) the [WAF profile](../concepts/waf.md) is in.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
   1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
   1. Save or memorize the ID of the profile you want to delete.
   1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/profiles.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}** and then the [security profile](../concepts/profiles.md) which uses the WAF profile you want to delete.
   1. In the **{{ ui-key.yacloud.smart-web-security.overview.title_security-rules }}** tab, delete the WAF profile rules:

      1. In the **{{ ui-key.yacloud.smart-web-security.label_search-rule-type }}** filter, select `{{ ui-key.yacloud.smart-web-security.overview.label_waf-rule }}`.
      1. In the row with the rule associated with the WAF profile with the required ID, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
      1. Confirm the deletion.
   1. Similarly, delete the WAF rules from all associated security profiles.
   1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
   1. In the profile row, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
   1. Confirm the deletion.

{% endlist %}
