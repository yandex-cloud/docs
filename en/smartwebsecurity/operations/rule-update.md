---
title: "How to update a rule in a {{ sws-full-name }} security profile"
description: "Follow this guide to update a rule in a {{ sws-full-name }} security profile."
---

# Editing a rule in a security profile

You can update [basic rules](../concepts/profiles.md), Smart Protection, and WAF in a [security profile](../concepts/rules.md). ARL rules are [updated in an ARL profile](arl-rule-update.md).

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to update a rule in a security profile.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
   1. Select the profile to update a rule in.
   1. In the **{{ ui-key.yacloud.smart-web-security.overview.title_security-rules }}** tab, next to the rule to edit, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.edit }}**.
   1. Edit the basic rule settings:
      * **{{ ui-key.yacloud.common.name }}**​.
      * **{{ ui-key.yacloud.common.description }}**​.
      * Rule **{{ ui-key.yacloud.smart-web-security.overview.column_priority }}**.

         {% include [preconfigured-rules-priority](../../_includes/smartwebsecurity/preconfigured-rules-priority.md) %}

      * Dry run (logging traffic without further filtering).
      * Rule type:
         * [**{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}**](../concepts/rules.md#base-rules): Allows or denies traffic based on specified conditions.
         * [**{{ ui-key.yacloud.smart-web-security.overview.label_smart-protection-rule }}**](../concepts/rules.md#smart-protection-rules): Sends traffic for automatic processing by machine learning and behavioral analysis algorithms. Suspicious requests are sent to {{ captcha-name }} for additional verification.
         * [**{{ ui-key.yacloud.smart-web-security.overview.label_waf-rule }}**](../../smartwebsecurity/concepts/rules.md#waf-rules): Integrates rules from a WAF profile. Suspicious requests are sent to {{ captcha-name }} for additional verification.
      * [**{{ ui-key.yacloud.smart-web-security.overview.column_action-type }}**](../concepts/rules.md#rule-action):
         * For a basic rule: `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}` or `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-allow }}` traffic whose parameters match the conditions.
         * For a Smart Protection or WAF rule:
            * `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}`: After verification, suspicious requests are sent to {{ captcha-name }}.
            * `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-api }}`: After verification, suspicious requests are blocked.
   1. In the **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** field and the additional fields below, modify the conditions the traffic must satisfy for the rule to apply. For more details, see [Rule action conditions](../concepts/conditions.md).

      You can set multiple conditions of the same type. Different types of conditions use different logical operators: _and_ or _or_. To add more than one condition of a certain type, click ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.condition-column.condition_and }}** or ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.condition-column.condition_or }}**.

      To remove a condition, click ![options](../../_assets/console-icons/trash-bin.svg).
   1. Click **{{ ui-key.yacloud.common.save-changes }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. To view a list of current security profiles in the default folder, run this command:

      {% include [security-profile-list-command](../../_includes/smartwebsecurity/security-profile-list-command.md) %}

   1. Update the security profile by applying the [YAML](https://en.wikipedia.org/wiki/YAML) configuration with updated description of the current security rules:

      1. To get the YAML configuration for the current security rules in the profile, run this command, specifying the security profile name or ID:

         {% include [security-profile-get-command](../../_includes/smartwebsecurity/security-profile-get-command.md) %}

      1. Copy current rule configuration from the `security_rules` section, paste it into any text editor, and save it to a file after editing as appropriate. The example below shows a change in the rule name, along with replacing the `DENY` action with the `ALLOW` one.

         {% cut "security-rules.yaml" %}

         ```yaml
         - name: rule-condition-allow
           priority: "11111"
           dry_run: true
           rule_condition:
             action: ALLOW
             condition:
               authority:
                 authorities:
                   - exact_match: example.com
                   - exact_match: example.net
               http_method:
                 http_methods:
                   - exact_match: GET
                   - exact_match: POST
               request_uri:
                 path:
                   prefix_match: /search
                 queries:
                   - key: firstname
                     value:
                       pire_regex_match: .ivan.
                   - key: lastname
                     value:
                       pire_regex_not_match: .petr.
               headers:
                 - name: User-Agent
                   value:
                     pire_regex_match: .curl.
                 - name: Referer
                   value:
                     pire_regex_not_match: .bot.
               source_ip:
                 ip_ranges_match:
                   ip_ranges:
                     - 1.2.33.44
                     - 2.3.4.56
                 ip_ranges_not_match:
                   ip_ranges:
                     - 8.8.0.0/16
                     - 10::1234:1abc:1/64
                 geo_ip_match:
                   locations:
                     - ru
                     - es
                 geo_ip_not_match:
                   locations:
                     - us
                     - fm
                     - gb
         ```

         {% endcut %}

         {% include [change-profile-rules-alert](../../_includes/smartwebsecurity/change-profile-rules-alert.md) %}

      1. To update a security profile, run this command, specifying the profile name or ID:

         ```bash
         yc smartwebsecurity security-profile update <security_profile_name_or_ID> \
            --security-rules-file <path_to_file_with_security_rules>
         ```

         Where `--security-rules-file` is the path to the [YAML](https://en.wikipedia.org/wiki/YAML) file with security rules.


         {% cut "Result:" %}

         ```yaml
         id: fev450d61ucv********
         folder_id: b1gt6g8ht345********
         cloud_id: b1gia87mbaom********
         labels:
           label1: value1
           label2: value2
         name: my-new-profile
         description: my description
         default_action: DENY
         security_rules:
           - name: rule-condition-allow
             priority: "11111"
             dry_run: true
             rule_condition:
               action: ALLOW
               condition:
                 authority:
                   authorities:
                     - exact_match: example.com
                     - exact_match: example.net
                 http_method:
                   http_methods:
                     - exact_match: GET
                     - exact_match: POST
                 request_uri:
                   path:
                     prefix_match: /search
                   queries:
                     - key: firstname
                       value:
                         pire_regex_match: .ivan.
                     - key: lastname
                       value:
                         pire_regex_not_match: .petr.
                 headers:
                   - name: User-Agent
                     value:
                       pire_regex_match: .curl.
                   - name: Referer
                     value:
                       pire_regex_not_match: .bot.
                 source_ip:
                   ip_ranges_match:
                     ip_ranges:
                       - 1.2.33.44
                       - 2.3.4.56
                   ip_ranges_not_match:
                     ip_ranges:
                       - 8.8.0.0/16
                       - 10::1234:1abc:1/64
                   geo_ip_match:
                     locations:
                       - ru
                       - es
                   geo_ip_not_match:
                     locations:
                       - us
                       - fm
                       - gb
             description: My first security rule. This rule it's just example to show possibilities of configuration.
         created_at: "2024-08-05T17:54:48.898624Z"
         ```

         {% endcut %}

   For more information about the `yc smartwebsecurity security-profile update` command, see the [CLI reference](../../cli/cli-ref/managed-services/smartwebsecurity/security-profile/update.md).

- API {#api}

   {% include [api-profile-update](../../_includes/smartwebsecurity/api-profile-update.md) %}

{% endlist %}

### See also {#see-also}

* [{#T}](rule-delete.md)
