---
title: How to add a rule to a security profile in {{ sws-full-name }}
description: Follow this guide to add a rule to a security profile in {{ sws-full-name }}.
---

# Adding a rule to a security profile

You can add basic [rules](../concepts/rules.md), as well as Smart Protection and WAF rules, to a [security profile](../concepts/profiles.md). ARL rules are [added to an ARL profile](arl-rule-add.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the security profile you need.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Select the profile to add a rule to.
  1. Click ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}** and in the window that opens:

      {% include [add-rule](../../_includes/smartwebsecurity/add-rule.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. To view a list of current security profiles in the default folder, run this command:

     {% include [security-profile-list-command](../../_includes/smartwebsecurity/security-profile-list-command.md) %}

  1. Update the security profile by applying the [YAML](https://en.wikipedia.org/wiki/YAML) configuration with both current and new security rules required for the profile:
  
     1. To get the YAML configuration for the current security rules in the profile, run this command, specifying the security profile name or ID:

         {% include [security-profile-get-command](../../_includes/smartwebsecurity/security-profile-get-command.md) %}

     1. Copy the current rule configuration from the `security_rules` section, paste it into any text editor, and save it to a file after adding new rules, such as the following:

         {% include [profile-create-yaml-example](../../_includes/smartwebsecurity/profile-create-yaml-example.md) %}

         {% include [change-profile-rules-alert](../../_includes/smartwebsecurity/change-profile-rules-alert.md) %}

     1. To update a security profile, run this command, specifying the profile name or ID:
    
         ```bash
         yc smartwebsecurity security-profile update <security_profile_name_or_ID> \
            --security-rules-file <path_to_file_with_security_rules>
         ```

         Where `--security-rules-file` is the path to the [YAML](https://en.wikipedia.org/wiki/YAML) file with the description of security rules.

         {% include [profile-create-yaml-result](../../_includes/smartwebsecurity/profile-create-yaml-result.md) %}

  For more information about the `yc smartwebsecurity security-profile update` command, see the [CLI reference](../../cli/cli-ref/smartwebsecurity/cli-ref/security-profile/update.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and edit the fragment with `yandex_sws_security_profile` description: add a section named `security_rule` with a security rule.

      ```hcl
      resource "yandex_sws_security_profile" "demo-profile-simple" {
        name                             = "<security_profile_name>"
        default_action                   = "DENY"
        captcha_id                       = "<captcha_ID>"
        advanced_rate_limiter_profile_id = "<ARL_profile_ID>"

        # Smart Protection rule
        security_rule {
          name     = "smart-protection"
          priority = 99999

          smart_protection {
            mode = "API"
          }
        }

        #Basic rule
        security_rule {
          name = "base-rule-geo"
          priority = 100000
          rule_condition {
            action = "ALLOW"
            condition {
              source_ip {
                geo_ip_match {
                  locations = ["ru", "kz"]
                }
              }
            }
          }
        }

        # WAF profile rule
        security_rule {
          name     = "waf"
          priority = 88888

          waf {
            mode           = "API"
            waf_profile_id = "<WAF_profile_ID>"
          }
        }
      }
      ```

      For more information about the `yandex_sws_security_profile` resource parameters in {{ TF }}, see the [relevant provider documentation]({{ tf-provider-resources-link }}/sws_security_profile).

  1. Create resources:

       {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check the resources' updates using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

  ```bash
  yc smartwebsecurity security-profile get <security_profile_ID>
  ```

- API {#api}

  {% include [api-profile-update](../../_includes/smartwebsecurity/api-profile-update.md) %}

{% endlist %}

### See also {#see-also}

* [{#T}](rule-update.md)
* [{#T}](rule-delete.md)
