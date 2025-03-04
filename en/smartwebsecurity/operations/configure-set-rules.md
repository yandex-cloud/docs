---
title: Configuring a WAF basic rule set
description: Follow this guide to configure a basic rule set for a WAF profile.
---

# Configuring a WAF basic rule set

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) the [WAF profile](../concepts/waf.md) is in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. Select the profile to configure a basic rule set in.
  1. Click **{{ ui-key.yacloud.smart-web-security.waf.label_action-edit-settings }}**.
  1. Set the **{{ ui-key.yacloud.smart-web-security.waf.label_anomaly-threshold }}**, which is the sum of [anomaly](../concepts/waf.md#anomaly) values of the triggered rules that will block the request.

      We recommend to start with the anomaly threshold of `25` and gradually reduce it to `5`. To reduce the anomaly threshold, address WAF false positives triggered by legitimate requests. To do so, select rules from the basic set and [configure exclusion rules](exclusion-rule-add.md).

      Use **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry run)** mode to test anomaly thresholds. The mode is activated when you add a WAF rule to the security profile.

  1. Install **{{ ui-key.yacloud.smart-web-security.waf.label_paranoia-level }}**.

      [Paranoia level](../concepts/waf.md#paranoia) classifies rules based on how aggressive they are. The higher the paranoia level, the better the protection, but also the higher the probability of WAF false positives. 
  1. Check the rules you included in the set. Add or delete them as needed. When using rules, pay attention to their anomaly values and paranoia levels. 

      You can turn any rule from the set into a blocking rule. A request that satisfies such a rule will be blocked regardless of the anomaly threshold you specified. To turn a rule into a blocking rule, click ![image](../../_assets/console-icons/ban.svg) to the right of it. If **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry run)** mode is enabled in the security profile, requests will not get blocked.
  1. Click **{{ ui-key.yacloud.smart-web-security.waf.label_save-settings }}**.

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  You can dynamically activate all the basic set rules if their paranoia level is not higher than specified in the user variable. You can manually edit the parameters of dynamically configured rules. For example, you can turn a rule into a blocking one and activate a rule with paranoia level higher than specified in the variable.

  1. Open the {{ TF }} configuration file and edit the fragment with `yandex_sws_waf_profile` description: add either a section named `rule` with a security rule or a section named `dynamic "rule"` with dynamically configured rules.

      ```hcl
      # In the basic set, rules of this paranoia level and below will be active
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

        # Turning the rule into a blocking one: the request will be blocked regardless of the anomaly threshold
        rule {
          rule_id     = "owasp-crs-v4.0.0-id942330-attack-sqli"
          is_enabled  = true
          is_blocking = true
        }

        # Turning the rule with paranoia level 4 into an active one
        rule {
          rule_id     = "owasp-crs-v4.0.0-id920202-protocol-enforcement"
          is_enabled  = true
          is_blocking = false
        }

        # Activating rules from the basic set if their paranoia level is not higher than specified in the waf_paranoia_level variable
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

      Where:
      * `dynamic "rule"`: Dynamic activation of rules from the basic set if their paranoia level is not higher than specified in the `waf_paranoia_level` variable. You can manually edit the parameters of dynamically configured rules. For example, you can turn a rule into a blocking one or activate a rule with the paranoia level higher than specified in the variable.
         * `rule_id`: Rule ID.
         * `is_enabled`: Flag to enable or disable a rule.
         * `is_blocking`: [Blocking](../concepts/waf.md#anomaly) rule flag.

      For more information about the `sws_waf_profile` parameters in {{ TF }}, see the [relevant {{ TF }} article]({{ tf-provider-resources-link }}/sws_waf_profile).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check the resources’ updates in the [management console]({{ link-console-main }}).

- API {#api}

  Use the [update](../waf/api-ref/WafProfile/update.md) REST API method for the [WafProfile](../waf/api-ref/WafProfile/) resource or the [WafProfile/Update](../waf/api-ref/grpc/WafProfile/update.md) gRPC API call.

{% endlist %}


### See also {#see-also}

* [{#T}](exclusion-rule-add.md)
* [{#T}](rule-add.md)
