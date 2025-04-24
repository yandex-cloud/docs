---
title: Updating a rule in an ARL profile
description: Follow this guide to update a rule in an ARL profile.
---

# Updating a rule in an ARL profile

You can only update ARL rules in an [ARL](../concepts/arl.md) profile. Basic [rules](../concepts/rules.md), as well as Smart Protection and WAF rules, are [updated in a security profile](rule-update.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) the ARL profile resides in.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/arl.svg) **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}**.
  1. Select the profile to update a rule in.
  1. In the rule row, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**. In the window that opens:
      1. Edit the basic rule settings:
          * **{{ ui-key.yacloud.common.name }}**.
          * **{{ ui-key.yacloud.common.description }}**.
          * Rule **priority**. The smaller the value, the higher is the rule priority.
          * Dry run (logging without request blocking) settings.

      1. {% include [arl-rule-traffic-conditions](../../_includes/smartwebsecurity/arl-rule-traffic-conditions.md) %}

      1. Change the request counting method and grouping criteria:

          {% include [arl-rule-request-count](../../_includes/smartwebsecurity/arl-rule-request-count.md) %}

      1. Click **{{ ui-key.yacloud.smart-web-security.arl.label_save-rule }}**.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To update a rule in an ARL profile:

  1. Open the {{ TF }} configuration file and update the `advanced_rate_limiter_rule` security rule section in the `yandex_sws_advanced_rate_limiter_profile` ARL profile description.

      ```hcl
      # ARL profile

      resource "yandex_sws_advanced_rate_limiter_profile" "arl-profile" {
        name        = "<profile_name>"
        description = "<profile_description>"


        # Rule 1

        advanced_rate_limiter_rule {
          name        = "<new_rule_name>"
          priority    = <new_rule_priority>
          description = "<new_rule_description>"
          dry_run     = true

          static_quota {
            action = "DENY"
            limit  = <new_rule_limit>
            period = <new_rule_period>
            condition {
              request_uri {
                path {
                  exact_match = "/api"
                }
              }
            }
          }
        }

        # Rule 2

        advanced_rate_limiter_rule {
          name        = "<rule_name>"
          priority    = <rule_priority>
          description = "<rule_description>"
          dry_run     = true
  
          static_quota {
            action = "DENY"
            limit  = <rule_limit>
            period = <rule_period>
            condition {
              source_ip {
                geo_ip_match {
                  locations = ["ru", "kz"]
                }
              }
            }
          }
        }
      }
      ```

      For more information about the `yandex_sws_advanced_rate_limiter_profile` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/sws_advanced_rate_limiter_profile).

  1. Apply the changes:

       {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

       You can check the resources’ updates in the [management console]({{ link-console-main }}).

- API {#api}

  Use the [update](../advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/update.md) REST API method for the [AdvancedRateLimiterProfile](../advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/index.md) resource or the [AdvancedRateLimiterProfile/Update](../advanced_rate_limiter/api-ref/grpc/AdvancedRateLimiterProfile/update.md) gRPC API call.

{% endlist %}

### See also {#see-also}

* [{#T}](rule-delete.md)
