---
title: Adding a rule to an ARL profile
description: Follow this guide to add a rule to an ARL profile.
---

# Adding a rule to an ARL profile

You can only add ARL rules to an [ARL](../concepts/arl.md) profile. Basic [rules](../concepts/rules.md), as well as Smart Protection and WAF rules, are [added to a security profile](rule-add.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) the ARL profile resides in.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/arl.svg) **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}**.
  1. Select the profile to add a rule to.
  1. Click ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}** and in the window that opens:

      {% include [add-arl-rule](../../_includes/smartwebsecurity/add-arl-rule.md) %}

- API {#api}

  [Get](arl-profile-get.md) information about the ARL profile and then update the ARL profile using the [update](../advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/update.md) REST API method for the [AdvancedRateLimiterProfile](../advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/index.md) resource or the [AdvancedRateLimiterProfile/Update](../advanced_rate_limiter/api-ref/grpc/AdvancedRateLimiterProfile/update.md) gRPC API call.

{% endlist %}

### See also {#see-also}

* [{#T}](rule-update.md)
* [{#T}](rule-delete.md)
