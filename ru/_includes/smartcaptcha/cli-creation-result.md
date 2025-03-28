Результат:

```bash
id: bpnd6cm6qpr5********
folder_id: b1g0ijbfaqsn********
cloud_id: b1gia87mbaom********
client_key: ysc1_2lla0Yn6dhlnEaTv2QNg2BhuA8Nqlyk4L7pZk3dz********
created_at: "2025-03-02T21:38:48.830498Z"
name: my-first-captcha
allowed_sites:
  - exmaple.com
  - exmaple.net
complexity: MEDIUM
style_json: '{"focus-color":"rgb(250, 192, 0)","base-background-color":"#fff"}'
turn_off_hostname_check: true
pre_check_type: CHECKBOX
challenge_type: IMAGE_TEXT
security_rules:
  - name: rule1
    priority: "11"
    description: My first security rule.
    condition:
      host:
        hosts:
          - exact_match: example.com
          - exact_match: example.net
    override_variant_uuid: variant-1
  - name: rule2
    priority: "12"
    condition:
      source_ip:
      geo_ip_match:
        locations:
          - ru
          - es
    override_variant_uuid: variant-2
override_variants:
  - uuid: variant-1
    description: override variant 1
    complexity: EASY
    pre_check_type: CHECKBOX
    challenge_type: SILHOUETTES
  - uuid: variant-2
    description: override variant 2
    complexity: HARD
    pre_check_type: CHECKBOX
    challenge_type: KALEIDOSCOPE
```