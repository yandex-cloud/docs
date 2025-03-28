
```hcl
resource "yandex_smartcaptcha_captcha" "demo-advanced-smartcaptcha" {
  name                = "<имя_капчи>"
  style_json          = "<внешний_вид_капчи>"
  complexity          = "<сложность_задания>"
  pre_check_type      = "<тип_основного_задания>"
  challenge_type      = "<тип_дополнительного_задания>"

  allowed_sites = [
    "<первый_хост>",
    "<второй_хост>"
  ]

  # Первый вариант задания
  override_variant {
    uuid        = "<идентификатор_варианта_1>"
    description = "<описание_варианта_1>"

    complexity     = "<сложность_задания>"
    pre_check_type = "<основное_задание>"
    challenge_type = "<дополнительное_задание>"
  }

  # Второй вариант задания 
  override_variant {
    uuid        = "<идентификатор_варианта_2"
    description = "<описание_варианта_2>"

    complexity     = "<сложность_задания>"
    pre_check_type = "<основное_задание>"
    challenge_type = "<дополнительное_задание>"
  }

  # Первое правило
  security_rule {
    name                  = "<название_правила_1>"
    priority              = <приоритет_правила_1>
    description           = "<описание_правила_1>"
    override_variant_uuid = "<идентификатор_варианта_задания>"

    condition {
      host {
        hosts {
          exact_match = "example.com"
        }
        hosts {
          exact_match = "example.net"
        }
      }
    }
  }

  # Второе правило
  security_rule {
    name                  = "<название_правила_2>"
    priority              = <приоритет_правила_2>
    description           = "<описание_правила_2>"
    override_variant_uuid = "<идентификатор_варианта_задания>"

    condition {
      source_ip {
        geo_ip_match {
          locations = ["ru", "es"]
        }
      }
    }
  }
}
```