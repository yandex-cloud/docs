---
title: Getting information about a security profile in {{ sws-full-name }}
description: Follow this guide to get information about a security profile in {{ sws-full-name }}.
---

# Getting information about a security profile

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the [security profile](../concepts/profiles.md).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Select the required security profile.
  1. The **{{ ui-key.yacloud.common.overview }}** page will show the profile details.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to get [security profile](../concepts/profiles.md) information:

      ```bash
      yc smartwebsecurity security-profile --help
      ```

  1. Get information about a security profile by specifying its name or ID:

      ```bash
      yc smartwebsecurity security-profile get <security_profile_name>
      ```

      Result:

      ```text
      id: fev0mcqgth1q********
      folder_id: b1geoelk7fld********
      name: demo-profile-simple
      default_action: ALLOW
      security_rules:
        - name: smart-protection
          priority: "99999"
          smart_protection:
            mode: API
        - name: rule-condition-2
          priority: "1"
          rule_condition:
            action: ALLOW
            condition:
              authority:
                authorities:
                  - exact_match: example.com
                  - exact_match: example.net
      created_at: "2024-11-20T17:49:53.615527Z"
      cloud_id: b1gia87mbaom********
      captcha_id: bpna2egcj76e********
      advanced_rate_limiter_profile_id: fevihb5krdcp********
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To get information about a [security profile](../concepts/profiles.md) using {{ TF }}:

  1. Add the `data` and `output` sections to the {{ TF }} configuration file:

     ```hcl
     data "yandex_sws_security_profile" "my-profile" {
       security_profile_id = "<security_profile_ID>"
     }

     output "profile-created" {
       value = data.yandex_sws_security_profile.my-profile.created_at
     }
     ```

     Where:
     * `data "yandex_sws_security_profile"`: Description of the security profile as a data source:
       * `security_profile_id`: Security profile ID.
     * `output "profile-created"`: Output variable that contains information about the security profile creation timestamp:
       * `value`: Returned value.

     You can replace `created_at` with any other parameter to get the information you need. For more information about the `yandex_sws_security_profile` data source parameters, see the [relevant provider documentation]({{ tf-provider-datasources-link }}/sws_security_profile).

  1. Create resources:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} will create the required resources and display the output variable values in the terminal. To check the results, run:

     ```bash
     terraform output
     ```

     Result:

     ```text
     profile-created = "2024-11-20T17:49:53Z"
     ```

- API {#api}

  To get detailed information about a [security profile](../concepts/profiles.md), use the [get](../api-ref/SecurityProfile/get.md) REST API method for the [SecurityProfile](../api-ref/SecurityProfile/index.md) resource or the [SecurityProfile/Get](../api-ref/grpc/SecurityProfile/get.md) gRPC API call and provide the security profile's ID in the `securityProfileId` request parameter.

{% endlist %}

#### See also {#see-also}

* [{#T}](operation-logs.md)
