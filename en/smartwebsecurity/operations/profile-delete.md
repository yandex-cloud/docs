---
title: How to delete a {{ sws-full-name }} profile
description: Follow this guide to delete a {{ sws-full-name }} profile.
---

# Deleting a security profile

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the [security profile](../concepts/profiles.md).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Next to the profile in question, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
  1. Confirm the deletion.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../cli/quickstart.md) command for deleting a [security profile](../concepts/profiles.md):

     ```bash
     yc smartwebsecurity security-profile delete --help
     ```

  1. To view a list of current security profiles in the default folder, run this command:

     {% include [security-profile-list-command](../../_includes/smartwebsecurity/security-profile-list-command.md) %}

  1. To delete a security profile, run this command, specifying the profile name or ID:

     ```bash
     yc smartwebsecurity security-profile delete <security_profile_name_or_ID>
     ```

  1. To make sure the security profile is deleted, re-run this command:

     ```bash
     yc smartwebsecurity security-profile list
     ```

     {% note info %}
     
     Deleting a security profile may affect access to the virtual hosts it is connected to.
     
     {% endnote %}

  For more information about the `yc smartwebsecurity security-profile delete` command, see the [CLI reference](../../cli/cli-ref/smartwebsecurity/cli-ref/security-profile/delete.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To delete a {{ sws-full-name }} profile created with {{ TF }}:

  1. Open the {{ TF }} configuration file and delete the section describing the profile.

     {% cut "Example of a security profile description in the {{ TF }} configuration" %}
     
     ```hcl
     resource "yandex_sws_security_profile" "demo-profile-simple" {
       name                             = "<security_profile_name>"
       default_action                   = "DENY"
       captcha_id                       = "<CAPTCHA_ID>"
       advanced_rate_limiter_profile_id = "<ARL_profile_ID>"

       # Smart Protection rule
       security_rule {
         name     = "smart-protection"
         priority = 99999

         smart_protection {
           mode = "API"
         }
       }

       # Basic rule
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

     {% endcut %}

  1. Apply the changes:

       {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check the deletion of the resources using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

  ```bash
  yc smartwebsecurity security-profile list
  ```

- API {#api}

  Use the [delete](../api-ref/SecurityProfile/delete.md) REST API method for the [SecurityProfile](../api-ref/SecurityProfile/) resource or the [SecurityProfileService/Delete](../api-ref/grpc/SecurityProfile/delete.md) gRPC API call.

{% endlist %}
