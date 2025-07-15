---
title: Editing basic ARL profile settings
description: Follow this guide to edit basic ARL profile settings.
---

# Editing basic ARL profile settings

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) with the [ARL profile](../concepts/arl.md).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/arl.svg) **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}**.
  1. Click ![options](../../_assets/console-icons/ellipsis.svg) next to the profile in question and select **{{ ui-key.yacloud.smart-web-security.overview.action_edit-profile }}**.
  1. In the window that opens, edit the following settings as needed:
      * **{{ ui-key.yacloud.common.name }}**.
      * **{{ ui-key.yacloud.common.description }}**.
      * [**{{ ui-key.yacloud.component.label-set.label_labels }}**](../../resource-manager/concepts/labels.md). To add a label, click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To edit basic [ARL profile](../concepts/arl.md) settings:

  1. Open the {{ TF }} configuration file and edit the `yandex_sws_advanced_rate_limiter_profile` description:

      ```hcl
      # ARL profile

      resource "yandex_sws_advanced_rate_limiter_profile" "arl-profile" {
        name        = "<new_profile_name>"
        description = "<new_profile_description>"

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

      For more information about the `yandex_sws_advanced_rate_limiter_profile` properties, see [this {{ TF }} provider article]({{ tf-provider-resources-link }}/sws_advanced_rate_limiter_profile).

  1. Apply the changes:

       {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

       You can check the resource updates in the [management console]({{ link-console-main }}).

- API {#api}

  Use the [update](../advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/update.md) REST API method for the [AdvancedRateLimiterProfile](../advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/index.md) resource or the [AdvancedRateLimiterProfile/Update](../advanced_rate_limiter/api-ref/grpc/AdvancedRateLimiterProfile/update.md) gRPC API call.

{% endlist %}

### See also {#see-also}

* [{#T}](arl-profile-delete.md)
* [{#T}](arl-rule-add.md)
* [{#T}](arl-rule-update.md)
