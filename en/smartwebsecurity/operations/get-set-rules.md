---
title: Getting information about a WAF rule set
description: Follow this guide to get information about a rule set for a WAF profile.
---

# Getting information about a WAF rule set

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the [WAF profile](../concepts/waf.md).
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. Select the profile with the rule set you need.
  1. The **{{ ui-key.yacloud.smart-web-security.advanced_waf.sets_priority_section.section_title }}** section will display the information on rule sets:
     * Rule set version.
     * Number of active rules.
     * Anomaly threshold and paranoia level (for the OWASP set).

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To get information about a [WAF rule set](../concepts/waf.md#rules-set) using {{ TF }}:

  1. Add the `data` and `output` sections to the {{ TF }} configuration file:

      ```hcl
      data "yandex_sws_waf_rule_set_descriptor" "owasp4" {
        name    = "OWASP Core Ruleset"
        version = "4.0.0"
      }

      output "waf_rules" {
        value = data.yandex_sws_waf_rule_set_descriptor.owasp4.rules
      }
      ```

      Where:

      * `data "yandex_sws_waf_rule_set_descriptor"`: Description of the WAF rule set as a data source:
        * `name`: Name of the WAF rule set.
        * `version`: Rule set version.
      * `output "waf_rules"`: Output variable that contains information about the WAF rule set:
        * `value`: Return value.

      You can replace `rules` with any other parameter to get the information you need. For more information about the `yandex_sws_waf_rule_set_descriptor` data source properties, see [this {{ TF }} provider article]({{ tf-provider-datasources-link }}/sws_waf_rule_set_descriptor).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create the required resources and display their output variables. To check the results, run this command:

      ```bash
      terraform output
      ```

      Result:

      ```text
      waf_rules = tolist([
        {
          "anomaly_score" = 5
          "id" = "owasp-crs-v4.0.0-id******-method-enforcement"
          "paranoia_level" = 1
        },
      ...
        {
          "anomaly_score" = 5
          "id" = "owasp-crs-v4.0.0-id******-attack-java"
          "paranoia_level" = 4
        },
      ])
      ```

- API {#api}

  Use the [get](../waf/api-ref/WafProfile/get.md) REST API method for the [WafProfile](../waf/api-ref/WafProfile/) resource or the [WafProfile/Get](../waf/api-ref/grpc/WafProfile/get.md) gRPC API call.

{% endlist %}