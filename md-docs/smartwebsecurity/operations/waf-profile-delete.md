[Документация Yandex Cloud](../../index.md) > [Yandex Smart Web Security](../index.md) > [Пошаговые инструкции](index.md) > Профили WAF > Удалить профиль

# Удалить профиль WAF

Прежде чем удалить профиль WAF, удалите все правила WAF из связанных профилей безопасности.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [профиль WAF](../concepts/waf.md).
  1. [Перейдите](https://console.yandex.cloud/link/smartwebsecurity) в сервис **Smart Web Security**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **Профили WAF**.
  1. Сохраните или запомните идентификатор профиля, который вы хотите удалить.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/profiles.svg) **Профили безопасности** и выберите [профиль безопасности](../concepts/profiles.md), в котором используется профиль WAF, который вы хотите удалить.
  1. На вкладке **Правила безопасности** удалите правила профиля WAF:

     1. В фильтре **Тип правила:** выберите `Web Application Firewall`.
     1. В строке с правилом, которое относится к профилю WAF с нужным идентификатором, нажмите ![options](../../_assets/console-icons/ellipsis.svg) → ![trash-bin](../../_assets/console-icons/trash-bin.svg) **Удалить**.
     1. Подтвердите удаление.

  1. Таким же способом удалите правила WAF из всех связанных профилей безопасности.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **Профили WAF**.
  1. В строке с нужным профилем нажмите ![options](../../_assets/console-icons/ellipsis.svg) → ![trash-bin](../../_assets/console-icons/trash-bin.svg) **Удалить**.
  1. Подтвердите удаление.

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы удалить профиль WAF Yandex Smart Web Security, который вы создали с помощью Terraform:

  1. Откройте файл конфигурации Terraform и удалите фрагмент с описанием профиля WAF.

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

  Вы можете проверить удаление ресурсов в [консоли управления](https://console.yandex.cloud).

- API {#api}

  Воспользуйтесь методом REST API [delete](../waf/api-ref/WafProfile/delete.md) для ресурса [WafProfile](../waf/api-ref/WafProfile/index.md) или вызовом gRPC API [WafProfile/Delete](../waf/api-ref/grpc/WafProfile/delete.md).

{% endlist %}