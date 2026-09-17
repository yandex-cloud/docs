---
title: How to create a {{ sws-full-name }} WAF profile
description: Follow this guide to create a {{ sws-full-name }} WAF profile.
---

# Creating a WAF profile

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a [WAF profile](../concepts/waf.md).
  1. [Navigate]({{ link-console-main }}/link/smartwebsecurity) to **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}** and click **{{ ui-key.yacloud.smart-web-security.waf.label_create-profile }}**.
  1. Name the profile.
  1. Optionally, provide a description.
  1. Optionally, add [labels](../../resource-manager/concepts/labels.md) to your profile.
  1. Enable one or multiple [rule sets](../concepts/waf.md#rules-set). [OWASP Core Rule Set](https://coreruleset.org/), Yandex Ruleset, Yandex ML Ruleset. Click the row with the rule set to view its rules.
  1. Select a rule set version.
  1. {% include [waf-verdicts](../../_includes/smartwebsecurity/waf-verdicts.md) %}
  1. Click **{{ ui-key.yacloud.common.create }}**.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. In the configuration file, define the parameters of the resources you want to create:

      ```hcl
      locals {
        # In the basic set, rules of this paranoia level and below will be enabled
        waf_paranoia_level = <paranoia_level>
      }

      # Data source: rule set
      data "yandex_sws_waf_rule_set_descriptor" "source" {
        name    = "<set_name>"
        version = "<set_version>"
      }

      # WAF profile
      resource "yandex_sws_waf_profile" "default" {
        name = "<WAF_profile_name>"

        # Rule set
        rule_set {
          action     = "<action>"
          is_enabled = <true_or_false>
          priority   = <priority>

          # Basic rule set
          core_rule_set {
            inbound_anomaly_score = <anomaly_threshold>
            paranoia_level        = local.waf_paranoia_level
            rule_set {
              name    = "<set_name>"
              version = "<set_version>"
              id      = "<set_ID>"
              type    = "<set_type>"
            }
          }
        }

        # Enabling rules from the basic set if their paranoia level is not higher than the value defined in the waf_paranoia_level variable
        dynamic "rule" {
          for_each = [
            for rule in data.yandex_sws_waf_rule_set_descriptor.source.rules : rule
            if rule.paranoia_level <= local.waf_paranoia_level
          ]
          content {
            rule_id     = rule.value.id
            is_enabled  = true
            is_blocking = false
          }
        }
      }
      ```

     {% cut "Example of a WAF profile description in the {{ TF }} configuration" %}

     {% include [waf-profile-terraform-example](../../_includes/smartwebsecurity/waf-profile-terraform-example.md) %}

     {% endcut %}

      Where:

      * `waf_paranoia_level`: [Level of paranoia](../concepts/waf.md#paranoia). It classifies rules based on their level of aggressiveness. The higher the paranoia level, the better the protection, but also the greater the risk of WAF false positives. The possible values range from 1 to 4.
      * `data "yandex_sws_waf_rule_set_descriptor"`: {{ TF }} data source for the basic rule set. From the data source, you can get a list of rules and their IDs.
      * `resource "yandex_sws_waf_profile"`: {{ TF }} resource to manage the WAF profile.

         * `name`: WAF profile name.
         * `rule_set`: Rule section.

             * `action`: Action to perform when the rule set is triggered:

                * `RULE_SET_ACTION_UNSPECIFIED`: Allow the query.
                * `DENY`: Block the query.
                * `CAPTCHA`: Send the query to {{ captcha-name }}.

             * `is_enabled`: Flag to enable or disable a set of rules.
             * `priority`: Rule set priority. The possible values range from 1 to 1,000,000.
             * `core_rule_set`: Basic rule set:

                * `inbound_anomaly_score`: Anomaly threshold which is the total [anomaly](../concepts/waf.md#anomaly) score of triggered rules that results in blocking the request. The possible values range from 2 to 10,000. The higher the value, the more likely it is that the request matching the rules is in fact an attack.
                * `paranoia_level`: [Level of paranoia](../concepts/waf.md#paranoia). It classifies rules based on their level of aggressiveness. The higher the paranoia level, the better the protection, but also the greater the risk of false positives. The possible values range from 1 to 4.

                   {% note info %}

                   The paranoia level does not affect whether rules are enabled or disabled. It only recommends the user to enable all rules with the `paranoia_level` less than or equal to the specified one.

                   {% endnote %}

                * `rule_set`: Rule set. In this section, specify the ID, name, version, and type of the rule set.

                    {% cut "Possible values" %}

                    {% include [waf-rule-set-terraform-values](../../_includes/smartwebsecurity/waf-rule-set-terraform-values.md) %}

                    {% endcut %}

         * `dynamic "rule"`: Dynamic activation of the basic set rules if their paranoia level is not higher than the `waf_paranoia_level` variable. For dynamically configured rules, you can [update settings](configure-set-rules.md) manually. For example, you can turn a rule into a blocking one or enable a rule with the paranoia level higher than the one defined in the variable.

            * `rule_id`: Rule ID.
            * `is_enabled`: Flag to enable or disable a rule.
            * `is_blocking`: Blocking rule flag. If `true`, the rule becomes the [blocking](../concepts/waf.md#anomaly) one.

      For more on the properties of the `yandex_sws_waf_profile` resource, see [this provider guide]({{ tf-provider-resources-link }}/sws_waf_profile).

  1. Create the resources:

       {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  {{ TF }} will create all the required resources. You can check the update of the resources in the [management console]({{ link-console-main }}).

  After creating a WAF profile, you can [modify](configure-set-rules.md) the set of basic rules and [customize](exclusion-rule-add.md) the set of exception rules.

- API {#api}

  Use the [create](../waf/api-ref/WafProfile/create.md) REST API method for the [WafProfile](../waf/api-ref/WafProfile/) resource or the [WafProfile/Create](../waf/api-ref/grpc/WafProfile/create.md) RPC API call.

{% endlist %}

#### Useful links {#see-also}

* [{#T}](configure-set-rules.md)
* [{#T}](rule-add.md)
* [{#T}](waf-profile-update.md)
* [{#T}](../tutorials/sws-basic-protection.md)
* [{#T}](waf-profile-delete.md)
