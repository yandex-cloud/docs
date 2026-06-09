# Обновление формата условий в API, CLI и Terraform

{% note warning %}

9 июня 2026 года сервис перейдет на новый формат условий и имена полей в правилах профиля безопасности, WAF и ARL. Если вы используете API, CLI или Terraform, обновите команды и конфигурации.

{% endnote %}

Раньше несколько значений в одном условии задавались списком. Теперь такие значения нужно объединять в одно текстовое поле и разделять символом `|`.

Также меняются имена полей `http_methods`, `authorities`, `ja3_ranges`, `ja4_ranges`.

## Обновление существующих конфигураций {#existing-configurations}

Все правила, которые вы создали в старом формате, будут автоматически перенесены в новый формат. Все настройки безопасности продолжат работать корректно.

## Формат описания условий {matching-format}

#|
|| **Поле в старом формате** | **Поле в новом формате** ||
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

Если в старой конфигурации для этих полей использовались разные типы условий, объедините их в [регулярное выражение](https://ru.wikipedia.org/wiki/Регулярные_выражения).

Пример разных типов условий в старом формате:

```text
exact_match = example.com
exact_not_match = example.net
prefix_match = aaa/
prefix_match = bbb
prefix_not_match = ccc
pire_regex_match = d.*
pire_regex_not_match = f.*
```

Пример объединения условий в новый формат:

```text
"pireRegexMatch": "example\.com|~(example\.net)|aaa(|/.*)|bbb.*|~(ccc)|d.*|~(f.*)"
```

Если в регулярном выражении специальные символы `(`, `)`, `{`, `}`, `[`, `]`, `.`, `*`, `+`, `?`, `^`, `$`, `|`, `\`, `&` или `~` используются как обычные, экранируйте их с помощью `\`.

Символ `~` можно использовать как логическое отрицание.

Помимо регулярных выражений для объединения условий можно использовать списки со строками или списки с регулярными выражениями.

## Обновление CLI {#cli-updates}

1. [Обновите CLI](../../cli/operations/update-cli.md) до последней версии:

   ```bash
   yc components update
   ```

1. Посмотрите формат новых полей в командах `create` и `update`:

   ```bash
   yc smartwebsecurity security-profile create -h
   yc smartwebsecurity security-profile update -h
   ```

## Примеры использования новых полей {#migration-examples}

{% list tabs group=instructions %}

- CLI {#cli}

  Если вы передаете параметры напрямую в команде, замените старые поля на новые:

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

  Пример команды с новыми полями для [списков](../concepts/lists.md):

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
                  list-ids = ["<идентификатор_списка_1>", "<идентификатор_списка_2>"]
                },
                asn-lists-not-match = {
                  list-ids = ["<идентификатор_списка_1>", "<идентификатор_списка_2>"]
                }
              },
              authority = {
                authority-matcher = {
                  match = {
                    lists-matchers = {
                      str-lists-match = {
                        list-ids = ["<идентификатор_списка>"]
                      },
                      str-lists-not-match = {
                        list-ids = ["<идентификатор_списка>"]
                      },
                      reg-exp-lists-match = {
                        list-ids = ["<идентификатор_списка>"]
                      },
                      reg-exp-lists-not-match = {
                        list-ids = ["<идентификатор_списка>"]
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
   
  Если вы используете файл с правилами, обновите в нем названия полей и значения условий.

  Подробнее о командах в справочнике CLI: [security-profile create](../../cli/cli-ref/smartwebsecurity/cli-ref/security-profile/create.md) и [security-profile update](../../cli/cli-ref/smartwebsecurity/cli-ref/security-profile/update.md).

- Terraform {#tf}

  В конфигурации Terraform замените старые поля в блоках условий:

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

  Пример конфигурации с новыми полями для [списков](../concepts/lists.md):

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
              list_ids = ["<идентификатор_списка_1>", "<идентификатор_списка_2>"]
            }
            asn_lists_not_match {
              list_ids = ["<идентификатор_списка_1>", "<идентификатор_списка_2>"]
            }
          }

          authority {
            authority_matcher {
              lists_matchers {
                str_lists_match {
                  list_ids = ["<идентификатор_списка>"]
                }
                str_lists_not_match {
                  list_ids = ["<идентификатор_списка>"]
                }
                reg_exp_lists_match {
                  list_ids = ["<идентификатор_списка>"]
                }
                reg_exp_lists_not_match {
                  list_ids = ["<идентификатор_списка>"]
                }
              }
            }
          }
        }
      }
    }
  }
  ```
  
  Подробнее о параметрах ресурса `yandex_sws_security_profile` в [документации провайдера](../../terraform/resources/sws_security_profile.md).

- API {#api}

  Пример запроса с новыми полями:

  ```bash
  curl -X POST \
    'https://smartwebsecurity.api.cloud.yandex.net/smartwebsecurity/v1/securityProfiles' \
    -H "Authorization: Bearer $(yc iam create-token)" \
    -H 'Content-Type: application/json' \
    -d '{
      "folderId": "<идентификатор_каталога>",
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

  Пример запроса с новыми полями для [списков](../concepts/lists.md):

  ```bash
  curl -X POST \
    'https://smartwebsecurity.api.cloud.yandex.net/smartwebsecurity/v1/securityProfiles' \
    -H "Authorization: Bearer $(yc iam create-token)" \
    -H 'Content-Type: application/json' \
    -d '{
      "folderId": "<идентификатор_каталога>",
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
                    "<идентификатор_списка_1>",
                    "<идентификатор_списка_2>"
                  ]
                },
                "asnListsNotMatch": {
                  "listIds": [
                    "<идентификатор_списка_1>",
                    "<идентификатор_списка_2>"
                  ]
                }
              },
              "authority": {
                "authorityMatcher": {
                  "listsMatchers": {
                    "strListsMatch": {
                      "listIds": [
                        "<идентификатор_списка>"
                      ]
                    },
                    "strListsNotMatch": {
                      "listIds": [
                        "<идентификатор_списка>"
                      ]
                    },
                    "regExpListsMatch": {
                      "listIds": [
                        "<идентификатор_списка>"
                      ]
                    },
                    "regExpListsNotMatch": {
                      "listIds": [
                        "<идентификатор_списка>"
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
  
  Подробнее о методах в справочнике REST API: [SecurityProfile.Create](../api-ref/SecurityProfile/create.md) и [SecurityProfile.Update](../api-ref/SecurityProfile/update.md) для ресурса [SecurityProfile](../api-ref/SecurityProfile/index.md).

{% endlist %}


#### См. также {#see-also}

* [Создать профиль безопасности](profile-create.md)
* [Изменить основные параметры профиля безопасности](profile-update.md)
* [Добавить правило в профиль безопасности](rule-add.md)
* [Изменить правило в профиле безопасности](rule-update.md)