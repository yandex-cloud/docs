---
title: Getting information about a {{ sws-full-name }} ARL profile
description: Follow this guide to get information about a {{ sws-full-name }} ARL profile.
---

# Getting information about an ARL profile

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the [ARL security profile](../concepts/arl.md).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/arl.svg) **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}**.
  1. Select the profile in question.
  1. The **{{ ui-key.yacloud.common.overview }}** page will show the profile details.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To get information about a {{ sws-full-name }} [ARL profile](../concepts/arl.md) using {{ TF }}:

  1. Add the `data` and `output` sections to the {{ TF }} configuration file:

     ```hcl
     data "yandex_sws_advanced_rate_limiter_profile" "arl-profile" {
        name = yandex_sws_advanced_rate_limiter_profile.arl-profile.name
     }

     output "profile-created" {
       value = data.yandex_sws_advanced_rate_limiter_profile.arl-profile.created_at
     }
     ```

     Where:
     * `data "yandex_sws_advanced_rate_limiter_profile"`: Description of the ARL profile as a data source:
       * `name`: ARL profile name.
     * `output "profile-created"`: Output variable that contains information about the ARL profile creation timestamp:
       * `value`: Return value.

     You can replace `created_at` with any other parameter to get the information you need. For more information about `yandex_sws_advanced_rate_limiter_profile` data source properties, see [this {{ TF }} provider article]({{ tf-provider-datasources-link }}/sws_advanced_rate_limiter_profile).

  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create the required resources and display their output variables. To check the results, run this command:

     ```bash
     terraform output
     ```

     Result:

     ```text
     profile-created = "2024-12-15T12:21:20Z"
     ```

- API {#api}

  Use the [get](../advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/get.md) REST API method for the [AdvancedRateLimiterProfile](../advanced_rate_limiter/api-ref/AdvancedRateLimiterProfile/index.md) resource or the [AdvancedRateLimiterProfile/Get](../advanced_rate_limiter/api-ref/grpc/AdvancedRateLimiterProfile/get.md) gRPC API call.

{% endlist %}
