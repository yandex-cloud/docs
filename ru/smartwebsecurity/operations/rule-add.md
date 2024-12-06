---
title: Как добавить правило в профиль безопасности {{ sws-full-name }}
description: Следуя данной инструкции, вы сможете добавить правило в профиль безопасности {{ sws-full-name }}.
---

# Добавить правило в профиль безопасности

В [профиле безопасности](../concepts/profiles.md) можно добавить базовые [правила](../concepts/rules.md), а также правила Smart Protection и WAF. Правила ARL [добавляются в профиле ARL](arl-rule-add.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужный профиль безопасности.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Выберите профиль, в который вы хотите добавить правило.
  1. Нажмите кнопку ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}** и в открывшемся окне:

      {% include [add-rule](../../_includes/smartwebsecurity/add-rule.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Чтобы посмотреть список имеющихся профилей безопасности в каталоге по умолчанию, выполните команду:

     {% include [security-profile-list-command](../../_includes/smartwebsecurity/security-profile-list-command.md) %}

  1. Обновите профиль безопасности, применив к нему [YAML](https://ru.wikipedia.org/wiki/YAML)-конфигурацию, содержащую описание как уже имеющихся, так и новых правил безопасности, которые необходимы для профиля:
  
     1. Чтобы получить YAML-конфигурацию уже имеющихся в профиле правил безопасности, выполните команду, указав имя или идентификатор профиля безопасности:

         {% include [security-profile-get-command](../../_includes/smartwebsecurity/security-profile-get-command.md) %}

     1. Скопируйте в любой текстовый редактор и сохраните в файл текущую конфигурацию правил (содержимое блока `security_rules`), добавив в нее новые правила, например:

         {% include [profile-create-yaml-example](../../_includes/smartwebsecurity/profile-create-yaml-example.md) %}

         {% include [change-profile-rules-alert](../../_includes/smartwebsecurity/change-profile-rules-alert.md) %}

     1. Чтобы внести изменения в профиль безопасности, выполните команду, указав имя или идентификатор профиля:
    
         ```bash
         yc smartwebsecurity security-profile update <имя_или_идентификатор_профиля_безопасности> \
            --security-rules-file <путь_к_файлу_с_правилами_безопасности>
         ```

         Где `--security-rules-file` — путь к [YAML](https://ru.wikipedia.org/wiki/YAML)-файлу с описанием правил безопасности.

         {% include [profile-create-yaml-result](../../_includes/smartwebsecurity/profile-create-yaml-result.md) %}

  Подробнее о команде `yc smartwebsecurity security-profile update` читайте в [справочнике CLI](../../cli/cli-ref/smartwebsecurity/cli-ref/security-profile/update.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Откройте файл конфигурации {{ TF }} и измените фрагмент с описанием профиля безопасности `yandex_sws_security_profile`: добавьте блок `security_rule` c правилом безопасности.

      ```hcl
      resource "yandex_sws_security_profile" "demo-profile-simple" {
        name                             = "<имя_профиля_безопасности>"
        default_action                   = "DENY"
        captcha_id                       = "<идентификатор_капчи>"
        advanced_rate_limiter_profile_id = "<идентификатор_ARL_профиля>"

        # Правило Smart Protection
        security_rule {
          name     = "smart-protection"
          priority = 99999

          smart_protection {
            mode = "API"
          }
        }

        #Базовое правило
        security_rule {
          name = "base-rule-geo"
          priority = 100000
          rule_condition {
            action = "ALLOW"
            condition {
              source_ip {
                geo_ip_match {
                  locations = ["ru", "kz"]
                }
              }
            }
          }
        }

        # Правило c WAF профилем
        security_rule {
          name     = "waf"
          priority = 88888

          waf {
            mode           = "API"
            waf_profile_id = "<идентификатор_WAF_профиля>"
          }
        }
      }
      ```

      Более подробную информацию о параметрах ресурса `yandex_sws_security_profile` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/sws_security_profile).

  1. Создайте ресурсы:

       {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  Проверить изменение ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

  ```bash
  yc smartwebsecurity security-profile get <идентификатор_профиля_безопасности>
  ```

- API {#api}

  {% include [api-profile-update](../../_includes/smartwebsecurity/api-profile-update.md) %}

{% endlist %}

### См. также {#see-also}

* [{#T}](rule-update.md)
* [{#T}](rule-delete.md)
