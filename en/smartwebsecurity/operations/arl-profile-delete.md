---
title: Deleting an ARL profile
description: Follow this guide to delete an ARL profile.
---

# Deleting an ARL profile

Before deleting an ARL profile, delete it from all associated [security profiles](../concepts/profiles.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) with the [ARL profile](../concepts/arl.md).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/arl.svg) **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}**.
  1. In the **{{ ui-key.yacloud.smart-web-security.arl.label_connected-security-profiles }}** field in the row with the ARL profile, select the security profile that uses this ARL profile.
  1. At the top right, click **{{ ui-key.yacloud.smart-web-security.overview.action_edit-profile }}**. In the window that opens:

      1. Select a different ARL profile from the **{{ ui-key.yacloud.smart-web-security.form.label_arl-profile }}** list or click **{{ ui-key.yacloud.common.clear }}**.
      1. Click **{{ ui-key.yacloud.common.save }}**.
  1. Similarly, delete the ARL profile from all other associated security profiles.
  1. Go back to the page of the ARL profile you want to delete.
  1. At the top right, click ![recycle-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}** and confirm your action.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To delete an [ARL profile](../concepts/arl.md) created with {{ TF }}:

  1. Open the {{ TF }} configuration file and delete the section describing the `yandex_sws_advanced_rate_limiter_profile` resource:

      {% cut "Example of an ARL profile description in the {{ TF }} configuration" %}
      
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

      {% endcut %}

  1. Apply the changes:

       {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

       You can check the deletion of the resources in the [management console]({{ link-console-main }}).

- API {#api}

  Use the [delete](../advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/delete.md) REST API method for the [AdvancedRateLimiterProfile](../advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/index.md) resource or the [AdvancedRateLimiterProfile/Delete](../advanced_rate_limiter/api-ref/grpc/AdvancedRateLimiterProfile/delete.md) gRPC API call.

{% endlist %}
