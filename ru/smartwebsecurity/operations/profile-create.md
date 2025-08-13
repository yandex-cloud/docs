---
title: Как создать профиль безопасности {{ sws-full-name }}
description: Следуя данной инструкции, вы сможете создать профиль безопасности {{ sws-full-name }}.
---

# Создать профиль безопасности

{% include [user-data-to-ml](../../_includes/smartwebsecurity/user-data-to-ml.md)%}

![profiles-rules](../../_assets/smartwebsecurity/profiles-rules.svg)

{% include [security-profile-sa-roles](../../_includes/smartwebsecurity/security-profile-sa-roles.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать [профиль безопасности](../concepts/profiles.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.action_empty }}**.
  1. Выберите один из вариантов создания:
      * **{{ ui-key.yacloud.smart-web-security.title_default-template }}** (рекомендуется). Преднастроенный профиль содержит:

        * [базовое правило](../concepts/rules.md#base-rules) по умолчанию, включенное для всего трафика с [типом действия](../concepts/rules.md#rule-action) — `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}`;
        * [правило Smart Protection](../concepts/rules.md#smart-protection-rules), включенное для всего трафика, с типом действия — `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}`.
      * **{{ ui-key.yacloud.smart-web-security.title_no-template }}**. Профиль содержит только базовое правило по умолчанию, включенное для всего трафика.

  1. Введите имя профиля.
  1. (опционально) Введите описание.
  1. (опционально) Добавьте профилю [метки](../../resource-manager/concepts/labels.md).
  1. В поле **{{ ui-key.yacloud.smart-web-security.form.label_default-action }}** выберите, что делать с трафиком, который не попал под условия других правил: `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}` или `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}`.
  1. Выберите или создайте [профиль ARL](../operations/arl-profile-create.md), чтобы установить лимиты на количество запросов.
  1. Выберите или создайте капчу [{{ captcha-full-name }}](../../smartcaptcha/) для проверки подозрительных запросов:

        {% include [captcha-integration](../../_includes/smartwebsecurity/captcha-integration.md) %}

  1. {% include [profile-inspect-request](../../_includes/smartwebsecurity/profile-inspect-request.md) %}
  1. Нажмите кнопку ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
  1. В окне создания правила:

      {% include [add-rule](../../_includes/smartwebsecurity/add-rule.md) %}

  1. Если для базового правила по умолчанию установлено действие `Запретить` и запросы отправляются на проверку в {{ captcha-name }}, [добавьте](captcha-rule.md) разрешающее правило.
  1. Последовательно добавьте все правила, которые вы хотите задействовать в профиле.

      В блоке **{{ ui-key.yacloud.smart-web-security.form.section_security-rules }}** в таблице появятся созданные вами правила.
  1. (Опционально) Включите или отключите использование информации об HTTP-запросах для улучшения моделей машинного обучения в разделе **{{ ui-key.yacloud.component.disallow-data-processing.title_ml-model-training }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../cli/quickstart.md) для создания [профиля безопасности](../concepts/profiles.md):

     ```bash
     yc smartwebsecurity security-profile create --help
     ```

  1. Чтобы создать профиль безопасности, выполните команду:

     ```bash
     yc smartwebsecurity security-profile create \
        --name <имя_профиля_безопасности> \
        --description "<описание_профиля>" \
        --labels <ключ_метки_1>=<значение_метки_1>,<ключ_метки_2>=<значение_метки_2>,...,<ключ_метки_n>=<значение_метки_n> \
        --default-action <действие> \
        --captcha-id <идентификатор_капчи> \
        --security-rules-file <путь_к_файлу_с_правилами>
     ```

     Где:

     * `--name` — имя профиля безопасности. Обязательный параметр. Если задать только имя профиля без дополнительных параметров, в профиле безопасности будет создано одно [базовое правило](../concepts/rules.md#base-rules).
     * `--description` — текстовое описание профиля безопасности. Необязательный параметр.
     * `--labels` — список [меток](../../resource-manager/concepts/labels.md) для добавления в профиль в формате `КЛЮЧ=ЗНАЧЕНИЕ`. Необязательный параметр. Например: `--labels foo=baz,bar=baz'`.
     * `--default-action` — действие, которое следует выполнить для трафика, который не попал под условия других правил. Необязательный параметр. По умолчанию установлено значение `allow`, разрешающее все запросы к сервису. Чтобы запретить запросы, установите значение `deny`.
     * `--captcha-id` — идентификатор капчи [{{ captcha-full-name }}](../../smartcaptcha/) для проверки подозрительных запросов. Необязательный параметр.
      * `--security-rules-file` — путь к файлу с описанием правил безопасности в формате [YAML](https://ru.wikipedia.org/wiki/YAML). Необязательный параметр. Например:

          {% include [profile-create-yaml-example](../../_includes/smartwebsecurity/profile-create-yaml-example.md) %}

     Результат:

     ```text
     id: fev6q4qqnn2q********
     folder_id: b1g07hj5r6i********
     cloud_id: b1gia87mbaom********
     name: my-sample-profile
     description: "my description"
     labels: label1=value1,label2=value2
     default_action: DENY
     created_at: "2024-07-25T19:21:05.039610Z"
     ```

  Подробнее о команде `yc smartwebsecurity security-profile create` читайте в [справочнике CLI](../../cli/cli-ref/smartwebsecurity/cli-ref/security-profile/create.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле {{ TF }} параметры ресурсов, которые необходимо создать:

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

        # Базовое правило
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

      Где:
      * `name` — имя профиля безопасности.
      * `default_action` — действие для базового правила по умолчанию. Будет применяться к трафику, который не попал под условия других правил.  Возможные значения: `ALLOW` — разрешает все запросы к сервису, `DENY` — запрещает.
      * `captcha_id` — идентификатор капчи [{{ captcha-full-name }}](../../smartcaptcha/) для проверки подозрительных запросов. Необязательный параметр.
      * `advanced_rate_limiter_profile_id` — идентификатор [ARL профиля безопасности](../concepts/arl.md). Необязательный параметр.
      * `security_rule` — описание [правила](../concepts/rules.md) безопасности:
         * `name` — имя правила безопасности.
         * `priority` — [приоритет](../concepts/rules.md) правила. Возможные значения от 1 до 1000000.
         * `smart_protection` — описание [правила Smart Protection](../concepts/rules.md#smart-protection-rules), включенное для всего трафика, с указанным типом действия в параметре `mode`.
            * `mode` — [действие правила](../concepts/rules.md#rule-action). Возможные значения: `FULL` — полная защита (подозрительные запросы отправляются на капчу) или `API` — защита API (подозрительные запросы блокируются).
         * `waf` — описание правила Web Application Firewall. Чтобы добавить правило WAF, сначала надо [создать профиль WAF](waf-profile-create.md). Необязательный блок параметров, содержит:
            * `waf_profile_id` — идентификатор [WAF профиля](../concepts/waf.md).

      Если не указать тип правила `smart_protection` или `waf`, будет создано базовое правило с простой фильтрацией по заданным условиям в блоке `rule_condition`.

      Более подробную информацию о параметрах ресурса `yandex_sws_security_profile` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/sws_security_profile).

  1. Создайте ресурсы:

       {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

  ```bash
  yc smartwebsecurity security-profile get <идентификатор_профиля_безопасности>
  ```

- API {#api}

  Воспользуйтесь методом REST API [create](../api-ref/SecurityProfile/create.md) для ресурса [SecurityProfile](../api-ref/SecurityProfile/) или вызовом gRPC API [SecurityProfileService/Create](../api-ref/grpc/SecurityProfile/create.md).

{% endlist %}

### См. также {#see-also}

* [{#T}](host-connect.md)
* [{#T}](profile-update.md)
* [{#T}](profile-delete.md)
