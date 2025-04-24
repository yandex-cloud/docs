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

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To add a rule to your [ARL profile](../concepts/arl.md):

    1. Open the {{ TF }} configuration file and edit the part with the `yandex_sws_advanced_rate_limiter_profile` resource description: add the `advanced_rate_limiter_rule` section containing the security rule.

        ```hcl
        # ARL profile

        resource "yandex_sws_advanced_rate_limiter_profile" "arl-profile" {
          name        = "<profile_name>"
          description = "<profile_description>"

          # Rule 1

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
  
        {% include [arl-profile-parameters](../../_includes/smartwebsecurity/arl-profile-parameters.md) %}
  
        For more information about the `yandex_sws_advanced_rate_limiter_profile` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/sws_advanced_rate_limiter_profile).
  
    1. Apply the changes:
  
         {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

         You can check the resources’ updates in the [management console]({{ link-console-main }}).

- API {#api}

  [Get](arl-profile-get.md) information about the ARL profile and then update the ARL profile using the [update](../advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/update.md) REST API method for the [AdvancedRateLimiterProfile](../advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/index.md) resource or the [AdvancedRateLimiterProfile/Update](../advanced_rate_limiter/api-ref/grpc/AdvancedRateLimiterProfile/update.md) gRPC API call.

{% endlist %}

### See also {#see-also}

* [{#T}](rule-update.md)
* [{#T}](rule-delete.md)
