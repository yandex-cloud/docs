---
title: Deleting a WAF exclusion rule
description: Follow this guide to delete a WAF exclusion rule.
---

# Deleting a WAF exclusion rule

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the [WAF profile](../concepts/waf.md).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. Select the profile where you want to delete an [exclusion rule](../concepts/waf.md#exclusion-rules).
  1. In the left-hand menu, go to the ![image](../../_assets/console-icons/file-xmark.svg) **{{ ui-key.yacloud.smart-web-security.waf.title_exclusion-rules }}** tab.
  1. Next to the rule in question, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
  1. Confirm the deletion.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and delete the `exclusion_rule` section defining your WAF exclusion rule from the `yandex_sws_waf_profile` description.

      {% cut "Example of an exclusion rule description in the {{ TF }} configuration" %}

      ```hcl
      # WAF profile
      resource "yandex_sws_waf_profile" "default" {
        name = "waf-profile-default"
        core_rule_set {
          inbound_anomaly_score = 2
          paranoia_level        = local.waf_paranoia_level
          rule_set {
            name    = "OWASP Core Ruleset"
            version = "4.0.0"
          }
        }

        ...

        # Exclusion rule
        exclusion_rule {
          name = "<exclusion_rule_name>"
          exclude_rules {
            exclude_all = <true_or_false>
            rule_ids    = ["rule_1_ID","rule_2_ID"]
          }
        }
      }
      ```

      {% endcut %}

      For more information about `sws_waf_profile` properties, see [this {{ TF }} provider article]({{ tf-provider-resources-link }}/sws_waf_profile).

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check the deletion of the resources in the [management console]({{ link-console-main }}).

- API {#api}

  Use the [update](../waf/api-ref/WafProfile/update.md) REST API method for the [WafProfile](../waf/api-ref/WafProfile/) resource or the [WafProfile/Update](../waf/api-ref/grpc/WafProfile/update.md) gRPC API call.

{% endlist %}
