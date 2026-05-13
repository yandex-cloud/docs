# Изменить основные параметры профиля WAF

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [профиль WAF](../concepts/waf.md).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Smart Web Security**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **Профили WAF**.
  1. В строке с нужным профилем нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **Редактировать**.
  1. На странице редактирования профиля измените основные параметры:
      * **Имя**.
      * **Описание**.
      * [**Метки**](../../resource-manager/concepts/labels.md). Чтобы добавить новую метку, нажмите кнопку **Добавить метку**.
  1. Включите или выключите наборы правил для профиля WAF.
  1. Выберите версию набора правил.
  1. Если включено несколько наборов:
     * Выберите условие срабатывания профиля:
       * **Вердикт получен хотя бы в одном наборе** — запрос распознан как угроза хотя бы одним набором правил.
       * **Вердикт получен в каждом наборе** — запрос распознан как угроза всеми добавленными наборами правил.
     * Расположите наборы по приоритету, в котором правила набора будут анализировать запрос. Чем выше набор, тем выше приоритет.
  1. Нажмите кнопку **Сохранить**.
  1. При необходимости [настройте правила](configure-set-rules.md) в каждом из добавленных наборов.

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  Чтобы изменить параметры WAF профиля Yandex Smart Web Security, созданного с помощью Terraform:

  1. Откройте файл конфигурации Terraform и измените фрагмент с описанием WAF профиля.

     {% cut "Пример описания WAF профиля в конфигурации Terraform" %}

      ```hcl
      # В базовом наборе будут активны правила этого уровня паранойи и ниже
      locals {
        waf_paranoia_level = 1
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
          inbound_anomaly_score = 2
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

     {% endcut %}

      Более подробную информацию о параметрах ресурса `sws_waf_profile` в Terraform, см. в [документации провайдера](../../terraform/resources/sws_waf_profile.md).

  1. Примените изменения:

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

  Проверить изменение ресурсов можно в [консоли управления](https://console.yandex.cloud).

- API {#api}

  Воспользуйтесь методом REST API [update](../waf/api-ref/WafProfile/update.md) для ресурса [WafProfile](../waf/api-ref/WafProfile/index.md) или вызовом gRPC API [WafProfile/Update](../waf/api-ref/grpc/WafProfile/update.md).

{% endlist %}

### См. также {#see-also}

* [Удалить профиль WAF](waf-profile-delete.md)
* [Добавить правило в профиль безопасности](rule-add.md)
* [Изменить правило в профиле безопасности](rule-update.md)