---
title: Deleting a WAF profile
description: Follow this guide to delete a WAF profile.
---

# Deleting a WAF profile

Before deleting a WAF profile, delete all WAF rules from the associated security profiles.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the [WAF profile](../concepts/waf.md).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. Save or memorize the ID of the profile you want to delete.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/profiles.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}** and then the [security profile](../concepts/profiles.md) that uses the WAF profile you want to delete.
  1. In the **{{ ui-key.yacloud.smart-web-security.overview.title_security-rules }}** tab, delete the WAF profile rules:

     1. In the **{{ ui-key.yacloud.smart-web-security.label_search-rule-type }}** filter, select `{{ ui-key.yacloud.smart-web-security.overview.label_waf-rule }}`.
     1. Next to the rule associated with the WAF profile with the relevant ID, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
     1. Confirm the deletion.
  1. Similarly, delete the WAF rules from all associated security profiles.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. Next to the profile in question, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
  1. Confirm the deletion.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To delete a {{ sws-full-name }} WAF profile created with {{ TF }}:

  1. Open the {{ TF }} configuration file and delete the section describing the WAF profile.

     {% cut "Example of a WAF profile description in the {{ TF }} configuration" %}

     ```hcl
      # In the basic set, rules of this paranoia level and below will be enabled
      locals {
        waf_paranoia_level = 1
      }

      # OWASP Core Rule Set data source
      data "yandex_sws_waf_rule_set_descriptor" "owasp4" {
        name    = "OWASP Core Ruleset"
        version = "4.0.0"
      }

      # WAF profile
      resource "yandex_sws_waf_profile" "default" {
        name = "<WAF_profile_name>"

        # Basic rule set
        core_rule_set {
          inbound_anomaly_score = 2
          paranoia_level        = local.waf_paranoia_level
          rule_set {
            name    = "OWASP Core Ruleset"
            version = "4.0.0"
          }
        }

        # Enabling rules from the basic set if their paranoia level is not higher than the value defined in the waf_paranoia_level variable
        dynamic "rule" {
          for_each = [
            for rule in data.yandex_sws_waf_rule_set_descriptor.owasp4.rules : rule
            if rule.paranoia_level <= local.waf_paranoia_level
          ]
          content {
            rule_id     = rule.value.id
            is_enabled  = true
            is_blocking = false
          }
        }

        analyze_request_body {
          is_enabled        = true
          size_limit        = 8
          size_limit_action = "IGNORE"
        }
      }
     ```

     {% endcut %}

  1. Apply the changes:

       {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check the deletion of the resources in the [management console]({{ link-console-main }}).

- API {#api}

  Use the [delete](../waf/api-ref/WafProfile/delete.md) REST API method for the [WafProfile](../waf/api-ref/WafProfile/) resource or the [WafProfile/Delete](../waf/api-ref/grpc/WafProfile/delete.md) gRPC API call.

{% endlist %}
