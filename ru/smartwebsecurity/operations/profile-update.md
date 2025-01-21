---
title: Как изменить основные параметры профиля безопасности {{ sws-full-name }}
description: Следуя данной инструкции, вы сможете изменить основные параметры профиля безопасности {{ sws-full-name }}.
---

# Изменить основные параметры профиля безопасности

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [профиль безопасности](../concepts/profiles.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. В строке с нужным профилем нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.smart-web-security.overview.action_edit-profile }}**.
  1. В открывшемся окне измените параметры:

      * **{{ ui-key.yacloud.common.name }}**.
      * **{{ ui-key.yacloud.common.description }}**.
      * [**{{ ui-key.yacloud.component.label-set.label_labels }}**](../../resource-manager/concepts/labels.md). Чтобы добавить новую метку, нажмите кнопку **{{ ui-key.yacloud.component.label-set.button_add-label }}**.
      * **{{ ui-key.yacloud.smart-web-security.form.label_default-action }}** — `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}` или `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}`.
      * **{{ ui-key.yacloud.smart-web-security.form.label_arl-profile }}** — выберите или создайте [профиль ARL](../concepts/arl.md).
      * Выберите или создайте капчу [{{ captcha-name }}](../../smartcaptcha/) для проверки подозрительных запросов.
      * {% include [profile-inspect-request](../../_includes/smartwebsecurity/profile-inspect-request.md) %}
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../cli/quickstart.md) для изменения основных параметров [профиля безопасности](../concepts/profiles.md):

     ```bash
     yc smartwebsecurity security-profile update --help
     ```

  1. Чтобы посмотреть список имеющихся профилей безопасности в каталоге по умолчанию, выполните команду:

     {% include [security-profile-list-command](../../_includes/smartwebsecurity/security-profile-list-command.md) %}

  1. Чтобы изменить основные параметры профиля безопасности, выполните команду:

     ```bash
     yc smartwebsecurity security-profile update \
        --name <имя_профиля_безопасности> \
        --new-name <новое_имя_профиля_безопасности> \
        --description "<описание_профиля>" \
        --labels <ключ_метки_1>=<значение_метки_1>,<ключ_метки_2>=<значение_метки_2>,...,<ключ_метки_n>=<значение_метки_n> \
        --default-action <действие> \
        --captcha-id <идентификатор_капчи> \
        --security-rules-file <путь_к_файлу_с_правилами_безопасности>
     ```

     Где:

     * `--name` — имя профиля безопасности. Обязательный параметр. Вместо имени профиля безопасности вы можете передать его идентификатор в параметре `--id`.
     * `--new-name` — новое имя профиля безопасности. Необязательный параметр если имя профиля не изменяется.
     * `--description` — текстовое описание профиля безопасности. Необязательный параметр.
     * `--labels` — список [меток](../../resource-manager/concepts/labels.md) для добавления в профиль в формате `КЛЮЧ=ЗНАЧЕНИЕ`. Необязательный параметр. Например: `--labels foo=baz,bar=baz'`.
     * `--default-action` — действие, которое следует выполнить для трафика, который не попал под условия других правил. Необязательный параметр. По умолчанию установлено значение `allow`, разрешающее все запросы к сервису. Чтобы запретить запросы, установите значение `deny`.
     * `--captcha-id` — идентификатор капчи [{{ captcha-name }}](../../smartcaptcha/) для проверки подозрительных запросов. Необязательный параметр.
     * `--security-rules-file` — путь к файлу с описанием правил безопасности в формате [YAML](https://ru.wikipedia.org/wiki/YAML). Необязательный параметр. Например:

         {% include [profile-create-yaml-example](../../_includes/smartwebsecurity/profile-create-yaml-example.md) %}

     Результат:

     ```text
     id: fev6q4qqnn2q********
     folder_id: b1g07hj5r6i********
     cloud_id: b1gia87mbaom********
     name: my-sample-profile
     new-name: my-update-profile
     description: "my update description"
     labels: label1=value1,label2=value2
     default_action: DENY
     created_at: "2024-07-25T19:21:05.039610Z"
     ```

  Подробнее о команде `yc smartwebsecurity security-profile update` читайте в [справочнике CLI](../../cli/cli-ref/smartwebsecurity/cli-ref/security-profile/update.md).


- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы изменить параметры профиля безопасности {{ sws-full-name }}, созданного с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и измените фрагмент с описанием профиля.

     {% cut "Пример описания профиля безопасности в конфигурации {{ TF }}" %}
     
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

     {% endcut %}

      Более подробную информацию о параметрах ресурса `yandex_sws_security_profile` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/sws_security_profile).

  1. Примените изменения:

       {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  Проверить изменение ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

  ```bash
  yc smartwebsecurity security-profile get <идентификатор_профиля_безопасности>
  ```

- API {#api}

  {% include [api-profile-update](../../_includes/smartwebsecurity/api-profile-update.md) %}

{% endlist %}

### См. также {#see-also}

* [{#T}](rule-add.md)
* [{#T}](rule-update.md)
* [{#T}](host-connect.md)
* [{#T}](profile-delete.md)
