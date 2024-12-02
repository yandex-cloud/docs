---
title: How to delete a rule from a {{ sws-full-name }} security profile
description: Follow this guide to delete a rule from a {{ sws-full-name }} security profile.
---

# Deleting a rule from a security profile

You can delete basic rules, as well as Smart Protection and WAF rules, from a [security profile](../concepts/profiles.md). ARL rules are [deleted from an ARL profile](arl-rule-delete.md).

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the security profile you need.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
   1. Select the profile to delete a [rule](../concepts/rules.md) from.
   1. On the **{{ ui-key.yacloud.smart-web-security.overview.title_security-rules }}** tab, in the rule row, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
   1. Confirm the deletion.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. To view a list of current security profiles in the default folder, run this command:

      {% include [security-profile-list-command](../../_includes/smartwebsecurity/security-profile-list-command.md) %}

   1. Update the security profile by applying the updated [YAML](https://en.wikipedia.org/wiki/YAML) configuration with security rules after you delete all irrelevant rules from it:

      1. To get the YAML configuration for the current security rules in the profile, run this command, specifying the security profile name or ID:

         ```bash
         yc smartwebsecurity security-profile get <security_profile_name_or_ID>
         ```

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
           - name: rule-condition-deny
             priority: "11111"
             dry_run: true
             rule_condition:
               action: DENY
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
           - name: rule-condition-allow
             priority: "2"
             rule_condition:
               action: ALLOW
               condition:
                 source_ip:
                   ip_ranges_match:
                     ip_ranges:
                       - 44.44.44.44-44.44.44.45
                       - 44.44.44.77
             description: Let's show how to whitelist IP.
           - name: smart-protection-full
             priority: "11"
             smart_protection:
               mode: FULL
               condition:
                 request_uri:
                   path:
                     prefix_match: /search
             description: Enable smart protection. Allow to show captcha on /search prefix.
           - name: smart-protection-api
             priority: "10"
             smart_protection:
               mode: API
               condition:
                 request_uri:
                   path:
                     prefix_match: /api
             description: Enable smart protection with mode API. We are not expect to see captcha on /api prefix.
         created_at: "2024-08-05T17:54:48.898624Z"
         ```

         {% endcut %}

      1. Copy current rule configuration from the `security_rules` section, paste it into any text editor, and save it to a file after removing all irrelevant rules, such as the following:

         {% cut "security-rules.yaml" %}

         ```yaml
         - name: rule-condition-deny
           description: My first security rule. This rule it's just example to show possibilities of configuration.
           priority: "11111"
           dry_run: true
           rule_condition:
             action: DENY
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
           - name: rule-condition-deny
             priority: "11111"
             dry_run: true
             rule_condition:
               action: DENY
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

   For more information about the `yc smartwebsecurity security-profile update` command, see the [CLI reference](../../cli/cli-ref/smartwebsecurity/cli-ref/security-profile/update.md).

- API {#api}

   {% include [api-profile-update](../../_includes/smartwebsecurity/api-profile-update.md) %}

{% endlist %}