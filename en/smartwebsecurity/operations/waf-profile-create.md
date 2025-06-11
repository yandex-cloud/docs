---
title: How to create a {{ sws-full-name }} WAF profile
description: Follow this guide to create a {{ sws-full-name }} WAF profile.
---

# Creating a WAF profile

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a [WAF profile](../concepts/waf.md) in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}** and click **{{ ui-key.yacloud.smart-web-security.waf.label_create-profile }}**.
  1. Enter the profile name.
  1. Optionally, enter a description.
  1. Optionally, add [labels](../../resource-manager/concepts/labels.md) to your profile.
  1. By default, the WAF profile uses the [OWASP Core Rule Set](https://coreruleset.org/). Click the row with the rule set to view the rules it includes.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. In the configuration file, describe the resources you want to create:

      ```hcl
      # In the basic set, rules of this paranoia level and below will be active
      locals {
        waf_paranoia_level = <paranoia_level>
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
          inbound_anomaly_score = <anomaly_threshold>
          paranoia_level        = local.waf_paranoia_level
          rule_set {
            name    = "OWASP Core Ruleset"
            version = "4.0.0"
          }
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
      ```

      Where:
      * `waf_paranoia_level`: [Paranoia level](../concepts/waf.md#paranoia) which classifies rules based on how aggressive they are. The higher the paranoia level, the better the protection, but also the higher the probability of WAF false positives.
      * `data "yandex_sws_waf_rule_set_descriptor"`: {{ TF }} data source for a basic rule set. From the data source, you can get a list of rules and their IDs.
      * `resource "yandex_sws_waf_profile"`: {{ TF }} resource to manage the WAF profile.
         * `name`: WAF profile name.
         * `core_rule_set`: Basic rule set:
            * `inbound_anomaly_score`: Anomaly threshold. This is the sum of [anomaly](../concepts/waf.md#anomaly) values of the triggered rules that will block the request. Possible values: from 2 to 10,000. The higher the value, the more likely it is that the request satisfying the rules is in fact an attack.
            * `paranoia_level`: [Paranoia level](../concepts/waf.md#paranoia) which classifies rules based on how aggressive they are. The higher the paranoia level, the better the protection, but also the higher the probability of false positives. Possible values: from 1 to 4.

              {% note info %}

              The paranoia level has no effect on enabling or disabling rules, it only serves as a recommendation for the user to enable all rules with `paranoia_level` less than or equal to the specified value.

              {% endnote %}

            * `rule_set`: Rule set. Specify name (`name`) and version (`version`) of the rule set.

         * `dynamic "rule"`: Dynamic activation of rules from the basic set if their paranoia level is not higher than set in the `waf_paranoia_level` variable. For dynamically configured rules, you can [change the parameters](configure-set-rules.md) manually. For example, you can turn a rule into a blocking one or activate a rule with the paranoia level higher than specified in the variable.
            * `rule_id`: Rule ID.
            * `is_enabled`: Flag to enable or disable a rule.
            * `is_blocking`: [Blocking](../concepts/waf.md#anomaly) rule flag.

      For more information about `yandex_sws_waf_profile` properties, see [this {{ TF }} article]({{ tf-provider-resources-link }}/sws_waf_profile).

  1. Create the resources:

       {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  {{ TF }} will create all the required resources. You can check the new resources using the [management console]({{ link-console-main }}).

  After creating a WAF profile, you can [customize a set of basic rules](configure-set-rules.md) and [exception rules](exclusion-rule-add).

- API {#api}

  Use the [create](../waf/api-ref/WafProfile/create.md) REST API method for the [WafProfile](../waf/api-ref/WafProfile/) resource or the [WafProfile/Create](../waf/api-ref/grpc/WafProfile/create.md) RPC API call.

{% endlist %}

### See also {#see-also}

* [{#T}](configure-set-rules.md)
* [{#T}](rule-add.md)
* [{#T}](profile-update.md)
* [{#T}](waf-profile-delete.md)
