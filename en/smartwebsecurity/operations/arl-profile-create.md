---
title: How to create a {{ sws-full-name }} ARL profile
description: Follow this guide to create a {{ sws-full-name }} ARL profile.
---

# Creating an ARL profile

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create an [ARL profile](../concepts/arl.md).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/arl.svg) **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}** and click **{{ ui-key.yacloud.smart-web-security.arl.label_create-profile }}**.
  1. Name the profile.
  1. Optionally, provide a description.
  1. Optionally, add [labels](../../resource-manager/concepts/labels.md) to your profile.
  1. [Add](arl-rule-add.md) ARL rules.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create an [ARL profile](../concepts/arl.md):

  1. In the {{ TF }} configuration file, describe the resources you want to create:

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
      }
      ```

      {% include [arl-profile-parameters](../../_includes/smartwebsecurity/arl-profile-parameters.md) %}

      For more information about the `yandex_sws_advanced_rate_limiter_profile` properties, see [this {{ TF }} provider article]({{ tf-provider-resources-link }}/sws_advanced_rate_limiter_profile).

  1. Create the resources:

       {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

       {{ TF }} will create all the required resources. You can check the new resources in the [management console]({{ link-console-main }}).

  Once your ARL profile is created, you can [add rules](arl-rule-add.md).

- API {#api}

  Use the [create](../advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/create.md) REST API method for the [AdvancedRateLimiterProfile](../advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/index.md) resource or the [AdvancedRateLimiterProfile/Create](../advanced_rate_limiter/api-ref/grpc/AdvancedRateLimiterProfile/create.md) gRPC API call.

{% endlist %}

### See also {#see-also}

* [{#T}](arl-rule-add.md)
* [{#T}](profile-update.md)
* [{#T}](arl-profile-delete.md)
