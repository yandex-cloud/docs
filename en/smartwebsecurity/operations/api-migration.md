---
title: Migrating to the new condition format in the API, CLI, and Terraform
description: Follow this guide to update {{ sws-full-name }} profile conditions to the new format used by the API, CLI, and Terraform.
---

# Updating the condition format in the API, CLI, and Terraform

{% note warning %}

Starting June 9, 2026, {{ sws-full-name }} will migrate to the new format of conditions and field names in security profile, WAF, and ARL rules. If using the API, CLI, or {{ TF }}, update your commands and configurations.

{% endnote %}

Earlier, multiple values in the same condition were provided as a list. Now you need to combine such values into a single text field, separated by `|`.

The `http_methods`, `authorities`, `ja3_ranges`, and `ja4_ranges` fields got new names.

## Updating current configurations {#existing-configurations}

All rules created in the old format will be automatically migrated to the new one. The migration will not affect your security settings.

## Condition description format {matching-format}

#|
|| **Field in old format** | **Field in new format** ||
|| `http_methods`:

* GET
* POST | `http_method_matcher`:

GET\|POST ||
|| `authorities`:

* example.com
* example.net | `authority_matcher`:

example\\.com\|example\\.net ||
|| `ja3_ranges`:

* d4e5f6a7b8c9
* a1b2c3d4e5f6 | `ja3_matcher`:

d4e5f6a7b8c9\|a1b2c3d4e5f6 ||
|| `ja4_ranges`:

* t13d1516h2_8daaf6152771
* t13d1812h2_c73b8a5f9d24 | `ja4_matcher`:

t13d1516h2_8daaf6152771\|t13d1812h2_c73b8a5f9d24 ||
|#

If the old configuration used different condition types for these fields, combine them into a [regular expression](https://en.wikipedia.org/wiki/Regular_expression).

Example of different condition types in the old format:

```text
exact_match = example.com
exact_not_match = example.net
prefix_match = aaa/
prefix_match = bbb
prefix_not_match = ccc
pire_regex_match = d.*
pire_regex_not_match = f.*
```

Example of combining conditions in the new format:

```text
"pireRegexMatch": "example\.com|~(example\.net)|aaa(|/.*)|bbb.*|~(ccc)|d.*|~(f.*)"
```

If in your regular expression the special characters `(`, `)`, `{`, `}`, `[`, `]`, `.`, `*`, `+`, `?`, `^`, `$`, `|`, `\`, `&`, or `~` are used as regular characters, escape them with `\`.

The `~` symbol can be used as logical negation.

In addition to regular expressions, you can combine conditions using lists of strings or lists of regular expressions.

## Updating the CLI {#cli-updates}

1. [Update the CLI](../../cli/operations/update-cli.md) to the latest version:

   ```bash
   yc components update
   ```

1. View the new field format in the `create` and `update` commands:

   ```bash
   yc smartwebsecurity security-profile create -h
   yc smartwebsecurity security-profile update -h
   ```

## Examples of using new fields {#migration-examples}

{% list tabs group=instructions %}

- CLI {#cli}

  If you provide parameters directly in the command, replace the old fields with the new ones:

  ```bash
  yc smartwebsecurity security-profile create \
    --name security-profile \
    --default-action ALLOW \
    --security-rules '[
      {
        name = "security-rule",
        priority = 1,
        dry-run = false,
        rule-specifier = {
          rule-condition = {
            action = DENY,
            condition = {
              authority = {
                authority-matcher = {
                  match = {
                    pire-regex-match = "example1|example2"
                  }
                }
              },
              http-method = {
                http-method-matcher = {
                  match = {
                    pire-regex-match = "GET|POST"
                  }
                }
              },
              finger-print = {
                ja3-matcher = {
                  match = {
                    pire-regex-match = "d4e5f6a7b8c9|a1b2c3d4e5f6"
                  }
                },
                ja4-matcher = {
                  match = {
                    pire-regex-match = "t13d1516h2_8daaf6152771|t13d1812h2_c73b8a5f9d24"
                  }
                }
              }
            }
          }
        }
      }
    ]'
  ```

  Example of a command with new fields for [lists](../concepts/lists.md):

  ```
  yc smartwebsecurity security-profile create \
    --name security-profile \
    --default-action ALLOW \
    --security-rules '[
      {
        name = "security-rule",
        priority = 1,
        dry-run = false,
        rule-specifier = {
          rule-condition = {
            action = DENY,
            condition = {
              source-ip = {
                asn-lists-match = {
                  list-ids = ["<list_1_ID>", "<list_2_ID>"]
                },
                asn-lists-not-match = {
                  list-ids = ["<list_1_ID>", "<list_2_ID>"]
                }
              },
              authority = {
                authority-matcher = {
                  match = {
                    lists-matchers = {
                      str-lists-match = {
                        list-ids = ["<list_ID>"]
                      },
                      str-lists-not-match = {
                        list-ids = ["<list_ID>"]
                      },
                      reg-exp-lists-match = {
                        list-ids = ["<list_ID>"]
                      },
                      reg-exp-lists-not-match = {
                        list-ids = ["<list_ID>"]
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    ]'
  ```
   
  If you are using a rules file, update the field names and condition values in it.

  Learn more about the [security-profile create](../../cli/cli-ref/smartwebsecurity/cli-ref/security-profile/create.md) and [security-profile update](../../cli/cli-ref/smartwebsecurity/cli-ref/security-profile/update.md) commands in the CLI reference.

- {{ TF }} {#tf}

  In the {{ TF }} configuration, replace the old fields in blocks of conditions:

  ```hcl
  resource "yandex_sws_security_profile" "yandex-sws-security-profile" {
    name = "test-terraform-yandex-sws-security-profile"
    default_action = "ALLOW"

    security_rule {
      name = "rule-condition-migration"
      priority = 4

      rule_condition {
        action = "ALLOW"

        condition {
          authority {
            authority_matcher {
              pire_regex_match = "example1|example2"
            }
          }
          http_method {
            http_method_matcher {
              pire_regex_match = "GET|POST"
            }
          }
          finger_print {
            ja3_matcher {
              pire_regex_match = "d4e5f6a7b8c9|a1b2c3d4e5f6"
            }
            ja4_matcher {
              pire_regex_match = "t13d1516h2_8daaf6152771|t13d1812h2_c73b8a5f9d24"
            }
          }
        }
      }
    }
  }
  ```

  Example of a configuration with new fields for [lists](../concepts/lists.md):

  ```hcl
  resource "yandex_sws_security_profile" "yandex-sws-security-profile" {
    name = "test-terraform-yandex-sws-security-profile"
    default_action = "ALLOW"

    security_rule {
      name = "rule-condition-new-lists"
      priority = 5

      rule_condition {
        action = "ALLOW"

        condition {
          source_ip {
            asn_lists_match {
              list_ids = ["<list_1_ID>", "<list_2_ID>"]
            }
            asn_lists_not_match {
              list_ids = ["<list_1_ID>", "<list_2_ID>"]
            }
          }

          authority {
            authority_matcher {
              lists_matchers {
                str_lists_match {
                  list_ids = ["<list_ID>"]
                }
                str_lists_not_match {
                  list_ids = ["<list_ID>"]
                }
                reg_exp_lists_match {
                  list_ids = ["<list_ID>"]
                }
                reg_exp_lists_not_match {
                  list_ids = ["<list_ID>"]
                }
              }
            }
          }
        }
      }
    }
  }
  ```
  
  For more on `yandex_sws_security_profile` properties, see [this provider guide]({{ tf-provider-resources-link }}/sws_security_profile).

- API {#api}

  Example of a request with new fields:

  ```bash
  curl -X POST \
    '{{ api-host-sws }}/smartwebsecurity/v1/securityProfiles' \
    -H "Authorization: Bearer $(yc iam create-token)" \
    -H 'Content-Type: application/json' \
    -d '{
      "folderId": "<folder_ID>",
      "name": "security-profile",
      "defaultAction": "ALLOW",
      "securityRules": [
        {
          "name": "rule-condition-migration",
          "priority": 4,
          "ruleCondition": {
            "action": "ALLOW",
            "condition": {
              "authority": {
                "authorityMatcher": {
                  "pireRegexMatch": "example1|example2"
                }
              },
              "httpMethod": {
                "httpMethodMatcher": {
                  "pireRegexMatch": "GET|POST"
                }
              },
              "fingerPrint": {
                "ja3Matcher": {
                  "pireRegexMatch": "d4e5f6a7b8c9|a1b2c3d4e5f6"
                },
                "ja4Matcher": {
                  "pireRegexMatch": "t13d1516h2_8daaf6152771|t13d1812h2_c73b8a5f9d24"
                }
              }
            }
          }
        }
      ]
    }'
  ```

  Example of a request with new fields for [lists](../concepts/lists.md):

  ```bash
  curl -X POST \
    '{{ api-host-sws }}/smartwebsecurity/v1/securityProfiles' \
    -H "Authorization: Bearer $(yc iam create-token)" \
    -H 'Content-Type: application/json' \
    -d '{
      "folderId": "<folder_ID>",
      "name": "security-profile",
      "defaultAction": "ALLOW",
      "securityRules": [
        {
          "name": "rule-condition-new-lists",
          "priority": 5,
          "ruleCondition": {
            "action": "ALLOW",
            "condition": {
              "sourceIp": {
                "asnListsMatch": {
                  "listIds": [
                    "<list_1_ID>",
                    "<list_2_ID>"
                  ]
                },
                "asnListsNotMatch": {
                  "listIds": [
                    "<list_1_ID>",
                    "<list_2_ID>"
                  ]
                }
              },
              "authority": {
                "authorityMatcher": {
                  "listsMatchers": {
                    "strListsMatch": {
                      "listIds": [
                        "<list_ID>"
                      ]
                    },
                    "strListsNotMatch": {
                      "listIds": [
                        "<list_ID>"
                      ]
                    },
                    "regExpListsMatch": {
                      "listIds": [
                        "<list_ID>"
                      ]
                    },
                    "regExpListsNotMatch": {
                      "listIds": [
                        "<list_ID>"
                      ]
                    }
                  }
                }
              }
            }
          }
        }
      ]
    }'
  ```
  
  For more on methods, see the REST API reference: [SecurityProfile.Create](../api-ref/SecurityProfile/create.md) and [SecurityProfile.Update](../api-ref/SecurityProfile/update.md) for the [SecurityProfile](../api-ref/SecurityProfile/) resource.

{% endlist %}


#### See also {#see-also}

* [{#T}](profile-create.md)
* [{#T}](profile-update.md)
* [{#T}](rule-add.md)
* [{#T}](rule-update.md)
