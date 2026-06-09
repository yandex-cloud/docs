# Получить информацию о наборе правил WAF

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [профиль WAF](../concepts/waf.md).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. Выберите профиль, в котором находится нужный набор правил.
  1. В разделе **{{ ui-key.yacloud.smart-web-security.advanced_waf.sets_priority_section.section_title }}** отобразится информация о наборах правил:
     * Версия набора правил.
     * Количество активных правил.
     * Порог аномальности и уровень паранойи (для набора OWASP).

- {{ TF }}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы получить информацию о [наборе правил WAF](../concepts/waf.md#rules-set) с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

      ```hcl
      data "yandex_sws_waf_rule_set_descriptor" "owasp4" {
        name    = "OWASP Core Ruleset"
        version = "4.0.0"
      }

      output "waf_rules" {
        value = data.yandex_sws_waf_rule_set_descriptor.owasp4.rules
      }
      ```

      Где:

      * `data "yandex_sws_waf_rule_set_descriptor"` — описание набора правил WAF в качестве источника данных:
        * `name` — имя набора правил WAF.
        * `version` — версия набора правил.
      * `output "waf_rules"` — выходная переменная, которая содержит информацию о наборе правил WAF:
        * `value` — возвращаемое значение.

      Вместо `rules` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_sws_waf_rule_set_descriptor` см. в [документации провайдера]({{ tf-provider-datasources-link }}/sws_waf_rule_set_descriptor).

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
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```text
      waf_rules = tolist([
        {
          "anomaly_score" = 5
          "id" = "owasp-crs-v4.0.0-id******-method-enforcement"
          "paranoia_level" = 1
        },
      ...
        {
          "anomaly_score" = 5
          "id" = "owasp-crs-v4.0.0-id******-attack-java"
          "paranoia_level" = 4
        },
      ])
      ```

- API {#api}

  Воспользуйтесь методом REST API [get](../waf/api-ref/WafProfile/get.md) для ресурса [WafProfile](../waf/api-ref/WafProfile/index.md) или вызовом gRPC API [WafProfile/Get](../waf/api-ref/grpc/WafProfile/get.md).

{% endlist %}