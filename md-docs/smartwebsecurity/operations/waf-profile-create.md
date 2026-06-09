# Создать профиль WAF

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создать [профиль WAF](../concepts/waf.md).
  1. Перейдите в сервис **Smart Web Security**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **Профили WAF** и нажмите кнопку **Создать профиль WAF**.
  1. Введите имя профиля.
  1. (Опционально) Введите описание.
  1. (Опционально) Добавьте профилю [метки](../../resource-manager/concepts/labels.md).
  1. Включите один или несколько [наборов правил](../concepts/waf.md#rules-set): [OWASP Core Rule Set](https://coreruleset.org/), Yandex Ruleset, Yandex ML Ruleset. Чтобы посмотреть правила, которые входят в набор, нажмите на строку с набором правил.
  1. Выберите версию набора правил.
  1. Если включено несколько наборов:
     * Выберите условие срабатывания профиля:
       * **Вердикт получен хотя бы в одном наборе** — запрос распознан как угроза хотя бы одним набором правил.
       * **Вердикт получен в каждом наборе** — запрос распознан как угроза всеми добавленными наборами правил.
     * Расположите наборы по приоритету, в котором правила набора будут анализировать запрос. Чем выше набор, тем выше приоритет.
  1. Нажмите кнопку **Создать**.

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

      ```hcl
      # В базовом наборе будут активны правила этого уровня паранойи и ниже
      locals {
        waf_paranoia_level = <уровень_паранойи>
      }

      # Источник данных OWASP Core Rule Set
      data "yandex_sws_waf_rule_set_descriptor" "owasp4" {
        name    = "OWASP Core Ruleset"
        version = "4.0.0"
      }

      # WAF профиль
      resource "yandex_sws_waf_profile" "default" {
        name = "<имя_WAF_профиля>"

        # Базовый набор правил
        core_rule_set {
          inbound_anomaly_score = <порог_аномальности>
          paranoia_level        = local.waf_paranoia_level
          rule_set {
            name    = "OWASP Core Ruleset"
            version = "4.0.0"
          }
        }

        # Активируем правила из базового набора, если их уровень паранойи не выше заданного в переменной waf_paranoia_level
        dynamic "rule" {
          for_each = [
            for rule in data.yandex_sws_waf_rule_set_descriptor.owasp4.rules : rule
            if rule.paranoia_level <= local.waf_paranoia_level
          ]
          content {
            rule_id     = rule.value.id
            is_enabled  = true
            is_blocking = false
          }
        }
      ```

      Где:
      * `waf_paranoia_level` — [уровень паранойи](../concepts/waf.md#paranoia) классифицирует правила по степени агрессивности. Чем выше уровень паранойи, тем лучше уровень защиты, но и больше вероятность ложных срабатываний WAF.
      * `data "yandex_sws_waf_rule_set_descriptor"` — источник данных Terraform для набора базовых правил. Из источника данных вы можете получить список правил и их идентификаторы.
      * `resource "yandex_sws_waf_profile"` — ресурс Terraform для управления WAF профилем.
         * `name` — имя WAF профиля.
         * `core_rule_set` — блок базовых правил:
            * `inbound_anomaly_score` — порог аномальности. Это суммарная [аномальность](../concepts/waf.md#anomaly) сработавших правил, при которой запрос будет заблокирован. Возможные значения от 2 до 10000. Чем выше заданное значение, тем больше вероятность того, что запрос, удовлетворяющий правилам, является атакой.
            * `paranoia_level` — [уровень паранойи](../concepts/waf.md#paranoia), классифицирует правила по степени агрессивности. Чем выше уровень паранойи, тем лучше защита, но больше вероятность ложных срабатываний. Возможные значения от 1 до 4.

              {% note info %}

              Уровень паранойи не влияет на включение или отключение правил, он используется только как рекомендация для пользователя включить все правила со значением `paranoia_level` меньше или равно заданному.

              {% endnote %}

            * `rule_set` — блок с указанием набора правил. Указывается `name` — имя и `version` — версия набора правил.

         * `dynamic "rule"` — динамическая активация правил из базового набора, если их уровень паранойи не выше заданного в переменной `waf_paranoia_level`. Для динамически настроенных правил можно вручную [изменить параметры](configure-set-rules.md). Например, сделать правило блокирующим или сделать активным правило, у которого уровень паранойи выше, чем указан в переменной.
            * `rule_id` — идентификатор правила.
            * `is_enabled` — флаг включения или отключения правила.
            * `is_blocking` — флаг, который назначает правило [блокирующим](../concepts/waf.md#anomaly).

      Более подробную информацию о параметрах ресурса `yandex_sws_waf_profile` в Terraform, см. в [документации провайдера](../../terraform/resources/sws_waf_profile.md).

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

  Terraform создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления](https://console.yandex.cloud).

  После создания WAF профиля вы можете [настроить набор базовых правил](configure-set-rules.md) и [правил-исключений](exclusion-rule-add.md).

- API {#api}

  Воспользуйтесь методом REST API [create](../waf/api-ref/WafProfile/create.md) для ресурса [WafProfile](../waf/api-ref/WafProfile/index.md) или вызовом gRPC API [WafProfile/Create](../waf/api-ref/grpc/WafProfile/create.md).

{% endlist %}

### См. также {#see-also}

* [Настроить наборы правил WAF](configure-set-rules.md)
* [Добавить правило в профиль безопасности](rule-add.md)
* [Изменить основные параметры профиля безопасности](profile-update.md)
* [Базовая настройка защиты в Smart Web Security](../tutorials/sws-basic-protection.md)
* [Удалить профиль WAF](waf-profile-delete.md)