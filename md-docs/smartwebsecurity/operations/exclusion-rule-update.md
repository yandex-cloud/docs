# Изменить правило-исключение WAF

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [профиль WAF](../concepts/waf.md).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. Выберите профиль, в котором вы хотите изменить [правило-исключение](../concepts/waf.md#exclusion-rules).
  1. В меню слева перейдите на вкладку ![image](../../_assets/console-icons/file-xmark.svg) **{{ ui-key.yacloud.smart-web-security.waf.title_exclusion-rules }}**.
  1. В строке с нужным правилом нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**. В открывшемся окне:
      1. Измените имя и описание правила-исключения.
      1. (опционально) Включите опцию **{{ ui-key.yacloud.smart-web-security.waf.field_logging }}**, чтобы логировать факты срабатывания правил-исключений.
      1. В блоке **{{ ui-key.yacloud.smart-web-security.waf.title_exclusion-rule-rules-section }}** измените правила из базового набора, для которых будет срабатывать исключение:
          * `{{ ui-key.yacloud.smart-web-security.waf.value_exclude-all-yes }}` — исключение будет срабатывать для всех правил.
          * `{{ ui-key.yacloud.smart-web-security.waf.value_exclude-all-no }}` — исключение будет срабатывать для выбранных правил.

             Нажмите **{{ ui-key.yacloud.smart-web-security.waf.action_exclusion-rule-add-rules }}**, чтобы выбрать правила из базового набора.

      1. В блоке **{{ ui-key.yacloud.smart-web-security.waf.title_exclusion-rule-condition-section }}** определите трафик, для анализа которого будет использоваться правило:
         * `{{ ui-key.yacloud.component.condition-column.condition_full-trafic }}` — правило будет использоваться для анализа всего трафика.
         * `При условии` — правило будет использоваться для анализа трафика, заданного в поле **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}**:
             * `{{ ui-key.yacloud.component.condition-column.condition_name-ip-range }}` — IP-адрес, диапазон адресов или регион IP-адресов;
             * `{{ ui-key.yacloud.component.condition-column.condition_name-header }}` — строка в заголовке HTTP;
             * `{{ ui-key.yacloud.component.condition-column.condition_name-requestUri }}` — путь запроса;
             * `{{ ui-key.yacloud.component.condition-column.condition_name-host }}` — домен, на который пришел запрос;
             * `{{ ui-key.yacloud.component.condition-column.condition_name-httpMethod }}` — метод запроса;
             * `{{ ui-key.yacloud.component.condition-column.condition_name-cookie }}` — строка в заголовке cookie.
             * `Bot name` — имена легитимных ботов, принадлежащих различным компаниям и сервисам.
             * `Bot category` — категории верифицированных ботов по их назначению или характеру действий.
             * `Verified bot` — фильтрация по признаку верификации бота (`да` или `нет`).
             * `Bot score` — фильтрация по уровню роботизированности запроса: от `0` (самый низкий уровень, человек) до `100` (самый высокий уровень, бот).
             * `FingerPrint` — [отпечаток](../concepts/botes.md#fingerprint) SSL/TLS‑соединения.
         
             Вы можете задать несколько условий одного типа. Для этого в поле **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** выберите все необходимые типы условий.
         
             Вы также можете задать одновременно несколько условий одного типа. Для этого в секции с нужным условием нажмите кнопку ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.condition-column.condition_and }}** или ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.condition-column.condition_or }}**.
         
             Чтобы удалить условие, нажмите ![options](../../_assets/console-icons/trash-bin.svg).

      1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Откройте файл конфигурации {{ TF }} и в описании профиля безопасности `yandex_sws_waf_profile` измените блок `exclusion_rule` c правилом-исключением.

      ```hcl
      # WAF профиль
      resource "yandex_sws_waf_profile" "default" {
        name = "waf-profile-default"
        core_rule_set {
          inbound_anomaly_score = 2
          paranoia_level        = local.waf_paranoia_level
          rule_set {
            name    = "OWASP Core Ruleset"
            version = "4.0.0"
          }
        }

        ...

        # Правило-исключение
        exclusion_rule {
          name = "<имя правила-исключения>"
          condition {
            source_ip {
              ip_ranges_match {
                ip_ranges = [
                  "<диапазон_IP-адресов_1>",
                  "<диапазон_IP-адресов_2>",
                  ...
                  "<диапазон_IP-адресов_n>"
                ]
              }
              ip_ranges_not_match {
                ip_ranges = [
                  "<диапазон_IP-адресов_3>",
                  "<диапазон_IP-адресов_4>",
                  ...
                  "<диапазон_IP-адресов_y>"
                ]
              }
            }
          }

          exclude_rules {
            exclude_all = <true_или_false>
            rule_ids    = [
              "идентификатор_правила_1",
              "идентификатор_правила_2",
              ...
              "идентификатор_правила_n"
            ]
          }
        }
      }
      ```

      Более подробную информацию о параметрах ресурса `sws_waf_profile` в {{ TF }}, см. в [документации провайдера]({{ tf-provider-resources-link }}/sws_waf_profile).

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
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

  Проверить изменение ресурсов можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Воспользуйтесь методом REST API [update](../waf/api-ref/WafProfile/update.md) для ресурса [WafProfile](../waf/api-ref/WafProfile/index.md) или вызовом gRPC API [WafProfile/Update](../waf/api-ref/grpc/WafProfile/update.md).

{% endlist %}

### См. также {#see-also}

* [{#T}](exclusion-rule-add.md)
* [{#T}](exclusion-rule-delete.md)
* [{#T}](configure-set-rules.md)