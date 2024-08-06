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
- name: rule-condition-allow
  description: Let's show how to whitelist IP.
  priority: "2"
  rule_condition:
    action: ALLOW
    condition:
      source_ip:
        ip_ranges_match:
          ip_ranges:
            - 44.44.44.44-44.44.44.45
            - 44.44.44.77
- name: smart-protection-full
  description: Enable smart protection. Allow to show captcha on /search prefix.
  priority: "11"
  smart_protection:
    mode: FULL
    condition:
      request_uri:
        path:
          prefix_match: /search
- name: smart-protection-api
  description: Enable smart protection with mode API. We are not expect to see captcha on /api prefix.
  priority: "10"
  smart_protection:
    mode: API
    condition:
      request_uri:
        path:
          prefix_match: /api
```

{% endcut %}