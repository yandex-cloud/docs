---
title: Миграция на новый формат условий в API, CLI и Terraform
description: Следуя данной инструкции, вы сможете обновить условия в {{ captcha-full-name }} для нового формата API, CLI и Terraform.
---

# Обновление формата условий в API, CLI и Terraform

{% note warning %}

9 июня 2026 года сервис перейдет на новый формат условий и имя поля в правилах показа капчи. Если вы используете API, CLI или {{ TF }}, обновите команды и конфигурации.

{% endnote %}

Раньше несколько значений в условии `host` задавались списком. Теперь такие значения нужно объединять в одно текстовое поле и разделять символом `|`.

Также меняется имя поля `hosts` на `host_matcher`.

## Обновление существующих конфигураций {#existing-configurations}

Все правила, которые вы создали в старом формате, будут автоматически перенесены в новый формат. Текущие настройки продолжат работать корректно.

## Формат описания условий {matching-format}

#|
|| **Старый формат** | **Новый формат** ||
|| `hosts`:

* example.com
* example.net | `host_matcher`:

example\\.com\|example\\.net ||
|#

Если в старой конфигурации для этого поля использовались разные типы условий, объедините их в [регулярное выражение](https://ru.wikipedia.org/wiki/Регулярные_выражения).

Пример разных типов условий в старом формате:

```text
exact_match = example.com
exact_not_match = example.net
```

Пример объединения условий в новый формат:

```text
"pireRegexMatch": "example\.com|~(example\.net)"
```

Если в регулярном выражении специальные символы `(`, `)`, `{`, `}`, `[`, `]`, `.`, `*`, `+`, `?`, `^`, `$`, `|`, `\`, `&` или `~` используются как обычные, экранируйте их с помощью `\`.

Символ `~` можно использовать как логическое отрицание.

## Обновление CLI {#cli-updates}

1. [Обновите CLI](../../cli/operations/update-cli.md) до последней версии:

   ```bash
   yc components update
   ```

1. Посмотрите формат новых полей в командах `create` и `update`:

   ```bash
   yc smartcaptcha captcha create -h
   yc smartcaptcha captcha update -h
   ```

## Примеры использования нового поля {#migration-examples}

{% list tabs group=instructions %}

- CLI {#cli}

  Если вы указываете правила показа в команде, используйте новый формат:

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

  Если вы храните правила показа капчи в файле YAML, обновите в нем поле условия `host` для параметра `--security-rules-file`.

  Подробнее о командах в справочнике CLI: [captcha create](../../cli/cli-ref/smartcaptcha/cli-ref/captcha/create.md) и [captcha update](../../cli/cli-ref/smartcaptcha/cli-ref/captcha/update.md).

- {{ TF }} {#tf}

  В конфигурации {{ TF }} замените блок `hosts` на `host_matcher`:

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

  Подробнее о параметрах ресурса `yandex_smartcaptcha_captcha` в [документации провайдера]({{ tf-provider-resources-link }}/smartcaptcha_captcha).

- API {#api}

  Пример запроса с новым полем:

  ```bash
  curl -X POST \
    '{{ api-host-captcha }}/smartcaptcha/v1/captchas' \
    -H "Authorization: Bearer $(yc iam create-token)" \
    -H 'Content-Type: application/json' \
    -d '{
      "folderId": "<идентификатор_каталога>",
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

  Подробнее о методах в справочнике REST API: [Captcha.Create](../../smartcaptcha/api-ref/Captcha/create.md) и [Captcha.Update](../../smartcaptcha/api-ref/Captcha/update.md) для ресурса [Captcha](../../smartcaptcha/api-ref/Captcha/index.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](create-captcha.md)
* [{#T}](get-info.md)
* [{#T}](validate-captcha.md)
