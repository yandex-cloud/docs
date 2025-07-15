---
title: Configuring a WAF basic rule set
description: Follow this guide to configure a basic rule set for a WAF profile.
---

# Configuring a WAF basic rule set

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the [WAF profile](../concepts/waf.md).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. Select the profile where you want to configure a basic rule set.
  1. Click **{{ ui-key.yacloud.smart-web-security.waf.label_action-edit-settings }}**.
  1. Set the **{{ ui-key.yacloud.smart-web-security.waf.label_anomaly-threshold }}**, which is the total [anomaly](../concepts/waf.md#anomaly) score of triggered rules that results in blocking the request.

      We recommend that you start with an anomaly threshold of `25` and gradually reduce it to `5`. To reduce the anomaly threshold, address WAF false positives triggered by legitimate requests. To do so, select rules from the basic set and [configure exclusion rules](exclusion-rule-add.md).

      Use **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry run)** mode to test anomaly thresholds. The mode gets activated when you add a WAF rule to the security profile.

  1. Set the **{{ ui-key.yacloud.smart-web-security.waf.label_paranoia-level }}**.

      The [paranoia level](../concepts/waf.md#paranoia) classifies rules based on how aggressive they are. The higher the paranoia level, the better the protection, but also the greater the risk of WAF false positives.
  1. Check the rules you included in the set. Add or delete them as needed. When using rules, pay attention to their anomaly values and paranoia levels.

      You can configure any rule in the set to block requests. Requests matching such a rule get blocked regardless of the anomaly threshold you set. To turn a rule into a blocking one, click ![image](../../_assets/console-icons/ban.svg) on its right. Still, if you enabled **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry run)** mode in the security profile, requests will not get blocked.
  1. Click **{{ ui-key.yacloud.smart-web-security.waf.label_save-settings }}**.

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  You can dynamically enable all rules in the basic set if their paranoia level is not higher than the value defined in the user variable. You can manually edit the settings of dynamically configured rules. For example, you can turn a rule into a blocking one and enable a rule with the paranoia level higher than the one defined in the variable.

  1. Open the {{ TF }} configuration file and edit the `yandex_sws_waf_profile` description: add either the `rule` section with a security rule or the `dynamic "rule"` section with dynamically configured rules.

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

        # Turning the rule into a blocking one: the request will get blocked regardless of the anomaly threshold
        rule {
          rule_id     = "owasp-crs-v4.0.0-id942330-attack-sqli"
          is_enabled  = true
          is_blocking = true
        }

        # Enabling the rule with paranoia level 4
        rule {
          rule_id     = "owasp-crs-v4.0.0-id920202-protocol-enforcement"
          is_enabled  = true
          is_blocking = false
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

      Where:
      * `dynamic "rule"`: Dynamically enabling the rules in the basic set if their paranoia level is not higher than the value defined in the `waf_paranoia_level` variable. You can manually edit the settings of dynamically configured rules. For example, you can turn a rule into a blocking one or enable a rule with the paranoia level higher than the one defined in the variable.
         * `rule_id`: Rule ID.
         * `is_enabled`: Flag to enable or disable a rule.
         * `is_blocking`: [Blocking](../concepts/waf.md#anomaly) rule flag.

      For more information about `sws_waf_profile` properties, see [this {{ TF }} provider article]({{ tf-provider-resources-link }}/sws_waf_profile).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check the resource updates in the [management console]({{ link-console-main }}).

- API {#api}

  Use the [update](../waf/api-ref/WafProfile/update.md) REST API method for the [WafProfile](../waf/api-ref/WafProfile/) resource or the [WafProfile/Update](../waf/api-ref/grpc/WafProfile/update.md) gRPC API call.

{% endlist %}


### See also {#see-also}

* [{#T}](exclusion-rule-add.md)
* [{#T}](rule-add.md)
