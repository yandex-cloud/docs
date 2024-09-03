```bash
yc smartwebsecurity security-profile get <security_profile_name_or_ID>
```

{% cut "Result" %}

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