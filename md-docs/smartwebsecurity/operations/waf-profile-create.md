[Документация Yandex Cloud](../../index.md) > [Yandex Smart Web Security](../index.md) > [Пошаговые инструкции](index.md) > Профили WAF > Создать профиль

# Создать профиль WAF

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать [профиль WAF](../concepts/waf.md).
  1. [Перейдите](https://console.yandex.cloud/link/smartwebsecurity) в сервис **Smart Web Security**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **Профили WAF** и нажмите **Создать профиль WAF**.
  1. Введите имя профиля.
  1. (Опционально) Введите описание.
  1. (Опционально) Добавьте профилю [метки](../../resource-manager/concepts/labels.md).
  1. Включите один или несколько [наборов правил](../concepts/waf.md#rules-set): [OWASP Core Rule Set](https://coreruleset.org/), Yandex Ruleset, Yandex ML Ruleset. Чтобы посмотреть правила, которые входят в набор, нажмите на строку с набором правил.
  1. Выберите версию набора правил.
  1. Если включено несколько наборов:
     
     * Выберите условие срабатывания профиля:
     
         * `Вердикт DENY получен хотя бы в одном выбранном наборе` — запрос распознан как угроза хотя бы одним набором правил.
         * `Вердикт DENY получен в каждом выбранном наборе` — запрос распознан как угроза всеми добавленными наборами правил.
     
     * Расположите наборы по приоритету, в котором правила набора будут анализировать запрос. Чем выше набор, тем выше приоритет.
  1. Нажмите **Создать**.

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры ресурсов, которые вы хотите создать:

      ```hcl
      locals {
        # В базовом наборе будут активны правила этого уровня паранойи и ниже
        waf_paranoia_level = <уровень_паранойи>
      }

      # Источник данных — набор правил
      data "yandex_sws_waf_rule_set_descriptor" "source" {
        name    = "<имя_набора>"
        version = "<версия_набора>"
      }

      # Профиль WAF
      resource "yandex_sws_waf_profile" "default" {
        name = "<имя_WAF_профиля>"

        # Набор правил
        rule_set {
          action     = "<действие>"
          is_enabled = <true_или_false>
          priority   = <приоритет>

          # Базовый набор правил
          core_rule_set {
            inbound_anomaly_score = <порог_аномальности>
            paranoia_level        = local.waf_paranoia_level
            rule_set {
              name    = "<имя_набора>"
              version = "<версия_набора>"
              id      = "<идентификатор_набора>"
              type    = "<тип_набора>"
            }
          }
        }

        # Активируем правила из базового набора, если их уровень паранойи не выше заданного в переменной waf_paranoia_level
        dynamic "rule" {
          for_each = [
            for rule in data.yandex_sws_waf_rule_set_descriptor.source.rules : rule
            if rule.paranoia_level <= local.waf_paranoia_level
          ]
          content {
            rule_id     = rule.value.id
            is_enabled  = true
            is_blocking = false
          }
        }
      }
      ```

     {% cut "Пример описания профиля WAF в конфигурации Terraform" %}

     ```hcl
     # Объявление локальных переменных
     locals {
       # В базовом наборе будут активны правила этого уровня паранойи и ниже
       waf_paranoia_level = 1
     
       # Идентификация набора правил OWASP Core Ruleset
       ruleset_name    = "OWASP Core Ruleset"
       ruleset_version = "4.0.0"
       ruleset_id      = "OWASP_CRS_4_0_0"
       ruleset_type    = "CORE"
     }
     
     # Источник данных OWASP Core Rule Set
     data "yandex_sws_waf_rule_set_descriptor" "source" {
       name    = local.ruleset_name
       version = local.ruleset_version
     }
     
     # Профиль WAF
     resource "yandex_sws_waf_profile" "default" {
       name = "waf-profile-owasp"
     
       # Набор правил
       rule_set {
         action     = "DENY"
         is_enabled = true
         priority   = 1
     
         # Базовый набор правил
         core_rule_set {
           inbound_anomaly_score = 2
           paranoia_level        = local.waf_paranoia_level
           rule_set {
             name    = local.ruleset_name
             version = local.ruleset_version
             id      = local.ruleset_id
             type    = local.ruleset_type
           }
         }
       }
     
       # Активируем правила из базового набора, если их уровень паранойи не выше заданного в переменной waf_paranoia_level
       dynamic "rule" {
         for_each = [
           for rule in data.yandex_sws_waf_rule_set_descriptor.source.rules : rule
           if rule.paranoia_level <= local.waf_paranoia_level
         ]
         content {
           rule_id     = rule.value.id
           is_enabled  = true
           is_blocking = false
         }
       }
     }
     ```

     {% endcut %}

      Где:

      * `waf_paranoia_level` — [уровень паранойи](../concepts/waf.md#paranoia). Он классифицирует правила по степени агрессивности. Чем выше уровень паранойи, тем лучше защита, но больше вероятность ложных срабатываний WAF. Возможные значения от 1 до 4.
      * `data "yandex_sws_waf_rule_set_descriptor"` — источник данных Terraform для набора базовых правил. Из источника данных вы можете получить список правил и их идентификаторы.
      * `resource "yandex_sws_waf_profile"` — ресурс Terraform для управления профилем WAF.

         * `name` — имя профиля WAF.
         * `rule_set` — блок правил:

             * `action` — действие, которое нужно выполнить при срабатывании набора правил:

                * `RULE_SET_ACTION_UNSPECIFIED` — разрешить запрос.
                * `DENY` — заблокировать запрос.
                * `CAPTCHA` — отправить запрос в SmartCaptcha.

             * `is_enabled` — флаг включения или отключения набора правил.
             * `priority` — приоритет набора правил. Возможные значения от 1 до 1000000.
             * `core_rule_set` — блок базовых правил:

                * `inbound_anomaly_score` — порог аномальности. Это суммарная [аномальность](../concepts/waf.md#anomaly) сработавших правил, при которой запрос будет заблокирован. Возможные значения от 2 до 10000. Чем выше заданное значение, тем больше вероятность того, что запрос, удовлетворяющий правилам, является атакой.
                * `paranoia_level` — [уровень паранойи](../concepts/waf.md#paranoia). Он классифицирует правила по степени агрессивности. Чем выше уровень паранойи, тем лучше защита, но больше вероятность ложных срабатываний. Возможные значения от 1 до 4.

                   {% note info %}

                   Уровень паранойи не влияет на включение или отключение правил. Он только рекомендует пользователю включить все правила со значением `paranoia_level` меньше или равным заданному.

                   {% endnote %}

                * `rule_set` — блок с указанием набора правил. В блоке укажите идентификатор, имя, версию и тип набора правил.

                    {% cut "Возможные значения" %}

                    name                 | version  | id                | type
                    -------------------- | -------- | ----------------- | -----
                    `OWASP Core Ruleset` | `4.8.0`  | `OWASP_CRS_4_8_0` | `CORE`
                    `OWASP Core Ruleset` | `4.0.0`  | `OWASP_CRS_4_0_0` | `CORE`
                    `Yandex Ruleset`     | `0.1.1`  | `YARS_0_1_1`      | `YA`
                    `Yandex Ruleset`     | `0.1.0`  | `YARS_0_1_0`      | `YA`
                    `Yandex ML Ruleset`  | `latest` | `YAMS_LATEST`     | `ML`

                    {% endcut %}

         * `dynamic "rule"` — динамическая активация правил из базового набора, если их уровень паранойи не выше заданного в переменной `waf_paranoia_level`. Для правил, которые настроены динамически, можно вручную [изменить параметры](configure-set-rules.md). Например, сделать правило блокирующим или сделать активным правило, у которого уровень паранойи выше, чем указан в переменной.

            * `rule_id` — идентификатор правила.
            * `is_enabled` — флаг включения или отключения правила.
            * `is_blocking` — флаг блокировки правила. Если значение `true`, правило становится [блокирующим](../concepts/waf.md#anomaly).

      Подробнее о параметрах ресурса `yandex_sws_waf_profile` в [документации провайдера](../../terraform/resources/sws_waf_profile.md).

  1. Создайте ресурсы:

       1. В терминале перейдите в директорию с конфигурационным файлом.
       1. Проверьте корректность конфигурации с помощью команды:
       
          ```bash
          terraform validate
          ```
       
          Если конфигурация является корректной, появится сообщение:
       
          ```bash
          Success! The configuration is valid.
          ```
       
       1. Выполните команду:
       
          ```bash
          terraform plan
          ```
       
          В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
       1. Примените изменения конфигурации:
       
          ```bash
          terraform apply
          ```
       
       1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

  Terraform создаст все требуемые ресурсы. Вы можете проверить появление ресурсов в [консоли управления](https://console.yandex.cloud).

  После создания профиля WAF вы можете [изменить](configure-set-rules.md) набор базовых правил и [настроить](exclusion-rule-add.md) набор правил-исключений.

- API {#api}

  Воспользуйтесь методом REST API [create](../waf/api-ref/WafProfile/create.md) для ресурса [WafProfile](../waf/api-ref/WafProfile/index.md) или вызовом gRPC API [WafProfile/Create](../waf/api-ref/grpc/WafProfile/create.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [Настроить наборы правил WAF](configure-set-rules.md)
* [Добавить правило в профиль безопасности](rule-add.md)
* [Изменить основные параметры профиля WAF](waf-profile-update.md)
* [Базовая настройка защиты в Smart Web Security](../tutorials/sws-basic-protection.md)
* [Удалить профиль WAF](waf-profile-delete.md)