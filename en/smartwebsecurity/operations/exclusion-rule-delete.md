---
title: Deleting a WAF exclusion rule
description: Follow this guide to delete a WAF exclusion rule.
---

# Deleting a WAF exclusion rule

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the [WAF profile](../concepts/waf.md).
  1. [Navigate]({{ link-console-main }}/link/smartwebsecurity) to **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. Select the profile where you want to delete an [exclusion rule](../concepts/waf.md#exclusion-rules).
  1. Navigate to the **{{ ui-key.yacloud.smart-web-security.waf.title_exclusion-rules }}** tab.
  1. Click ![options](../../_assets/console-icons/ellipsis.svg) → ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}** next to the rule.
  1. Confirm the deletion.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and delete the `exclusion_rule` section defining your WAF exclusion rule from the `yandex_sws_waf_profile` description.

     {% cut "Example of configuring WAF profile exclusion rules in your {{ TF }} configuration" %}

     {% include [waf-profile-exclusion-terraform-example](../../_includes/smartwebsecurity/waf-profile-exclusion-terraform-example.md) %}

     {% endcut %}

      For more on the properties of the `yandex_sws_waf_profile` resource, see [this provider guide]({{ tf-provider-resources-link }}/sws_waf_profile).

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check the deletion of the resources in the [management console]({{ link-console-main }}).

- API {#api}

  Use the [update](../waf/api-ref/WafProfile/update.md) REST API method for the [WafProfile](../waf/api-ref/WafProfile/) resource or the [WafProfile/Update](../waf/api-ref/grpc/WafProfile/update.md) gRPC API call.

{% endlist %}
