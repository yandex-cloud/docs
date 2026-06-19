---
title: Migrating to the new condition format in the API, CLI, and Terraform
description: Follow this guide to update {{ captcha-full-name }} conditions to the new format used by the API, CLI, and Terraform.
---

# Updating the condition format in the API, CLI, and Terraform

{% note warning %}

Starting June 9, 2026, {{ captcha-full-name }} will migrate to the new format of conditions and field names in captcha display rules. If using the API, CLI, or {{ TF }}, update your commands and configurations.

{% endnote %}

Earlier, multiple values in the `host` condition were provided as a list. Now you need to combine such values into a single text field, separated by `|`.

The `hosts` field is also renamed to `host_matcher`.

## Updating current configurations {#existing-configurations}

All rules created in the old format will be automatically migrated to the new one. Your current settings will continue to apply correctly.

## Condition description format {matching-format}

#|
|| **Old format** | **New format** ||
|| `hosts`:

* example.com
* example.net | `host_matcher`:

example\\.com\|example\\.net ||
|#

If the old configuration uses different condition types for this field, combine them into a [regular expression](https://en.wikipedia.org/wiki/Regular_expression).

Example of different condition types in the old format:

```text
exact_match = example.com
exact_not_match = example.net
```

Example of combining conditions in the new format:

```text
"pireRegexMatch": "example\.com|~(example\.net)"
```

If in your regular expression the special characters `(`, `)`, `{`, `}`, `[`, `]`, `.`, `*`, `+`, `?`, `^`, `$`, `|`, `\`, `&`, or `~` are used as regular characters, escape them with `\`.

The `~` symbol can be used as logical negation.

## Updating the CLI {#cli-updates}

1. [Update the CLI](../../cli/operations/update-cli.md) to the latest version:

   ```bash
   yc components update
   ```

1. View the new field format in the `create` and `update` commands:

   ```bash
   yc smartcaptcha captcha create -h
   yc smartcaptcha captcha update -h
   ```

## Examples of using the new field {#migration-examples}

{% list tabs group=instructions %}

- CLI {#cli}

  If you specify display rules in a command, use the new format:

  ```bash
    yc smartcaptcha captcha create \
    --name captcha \
    --security-rules '[
      {
        name = "captcha-rule",
        priority = 1,
        condition = {
          host = {
            host-matcher = {
              match = {
                pire-regex-match = "example.com|example.net"
              }
            }
          }
        }
      }
    ]'
  ```

  If you store captcha display rules in a YAML file, update the `host` condition field for the `--security-rules-file` parameter.

  For more information about the commands, see the CLI reference: [captcha create](../../cli/cli-ref/smartcaptcha/cli-ref/captcha/create.md) and [captcha update](../../cli/cli-ref/smartcaptcha/cli-ref/captcha/update.md).

- {{ TF }} {#tf}

  In the {{ TF }} configuration, replace the `hosts` section with `host_matcher`:

  ```hcl
  resource "yandex_smartcaptcha_captcha" "yandex-smartcaptcha-captcha" {
    name = "test-terraform-yandex-smartcaptcha-captcha"
    security_rule {
      name = "rule-condition-migration"
      priority = 1
      condition {
        host {
          host_matcher {
            pire_regex_match = "a|b"
          }
        }
      }
    }
  }
  ```

  For more on `yandex_smartcaptcha_captcha` properties, see [this provider guide]({{ tf-provider-resources-link }}/smartcaptcha_captcha).

- API {#api}

  Example of a request with the new field:

  ```bash
  curl -X POST \
    '{{ api-host-captcha }}/smartcaptcha/v1/captchas' \
    -H "Authorization: Bearer $(yc iam create-token)" \
    -H 'Content-Type: application/json' \
    -d '{
      "folderId": "<folder_ID>",
      "name": "captcha",
      "securityRules": [
        {
          "name": "captcha-rule",
          "priority": 1,
          "condition": {
            "host": {
              "hostMatcher": {
                "pireRegexMatch": "a|b"
              }
            }
          }
        }
      ]
    }'
  ```

  For more on methods, see the REST API reference: [Captcha.Create](../../smartcaptcha/api-ref/Captcha/create.md) and [Captcha.Update](../../smartcaptcha/api-ref/Captcha/update.md) for the [Captcha](../../smartcaptcha/api-ref/Captcha/index.md) resource.

{% endlist %}

#### See also {#see-also}

* [{#T}](create-captcha.md)
* [{#T}](get-info.md)
* [{#T}](validate-captcha.md)
