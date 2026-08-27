[Документация Yandex Cloud](../../index.md) > [Yandex Smart Web Security](../index.md) > [Пошаговые инструкции](index.md) > Профили WAF > Добавить правило-исключение

# Добавить правило-исключение WAF

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [профиль WAF](../concepts/waf.md).
  1. [Перейдите](https://console.yandex.cloud/link/smartwebsecurity) в сервис **Smart Web Security**.
  1. На панели слева выберите ![image](../../_assets/smartwebsecurity/waf.svg) **Профили WAF**.
  1. Выберите профиль, в который вы хотите добавить [правило-исключение](../concepts/waf.md#exclusion-rules).
  1. Выберите ![image](../../_assets/console-icons/file-xmark.svg) **Правила-исключения** и нажмите **Создать правило-исключение**.
  1. Введите имя правила-исключения.
  1. (Опционально) Введите описание.
  1. (Опционально) Включите опцию **Запись логов**, чтобы логировать факты срабатывания правил-исключений.
  1. В блоке **Исключаемые проверки** выберите:
       * `Все правила` — исключение будет срабатывать для всех правил.
         Используйте этот вариант, если нужно полностью отключить проверку выбранного трафика WAF-правилами. Например, если определенный эндпоинт принимает данные в формате, который стабильно вызывает ложные срабатывания.
       * `Выбранные правила` — исключение будет срабатывать для указанных правил. Нажмите **Добавить правила** и выберите правила, вызывающие ложные срабатывания.
  1. В блоке **Условия применения исключения** выберите, для какого трафика нужно отключить проверку:
     
     * `Весь запрос` — исключение будет применяться ко всему HTTP-запросу.
     * `Часть запроса` — исключение будет применяться к выбранным частям запроса, что позволяет исключить из проверки только проблемный параметр. Остальной запрос будет проверяться в соответствии с настройками WAF-профиля.
     
         В поле **Части запроса** выберите один или несколько параметров: 
     
         * `HTTP body` — тело HTTP-запроса. Используйте, если ложное срабатывание возникает при анализе тела запроса, например JSON, XML, формы.
         * `Cookie` — значение в параметре `Cookie`. 
         * `HTTP header` — HTTP-заголовок. Используйте, если ложное срабатывание возникает в значении конкретного заголовка, например `User-Agent`, `Referer`, `Authorization` или пользовательского заголовка.
         * `Query params` — параметры строки запроса.
     
         Для каждого параметра, кроме `HTTP body`, задайте одно или несколько значений. Чтобы добавить еще одно значение для параметра, нажмите ![plus-sign](../../_assets/console-icons/plus.svg) **или**. При необходимости включите опцию **Учитывать регистр**.
  1. В блоке **Условия на трафик** определите трафик, для анализа которого будет использоваться правило:
     * `Весь трафик` — правило будет использоваться для анализа всего трафика.
     * `При условии` — правило будет использоваться для анализа трафика, заданного в поле **Условия**:
         * `IP` — IP-адрес, диапазон адресов или регион IP-адресов;
         * `HTTP header` — строка в заголовке HTTP;
         * `Request URI` — путь запроса;
         * `Host` — домен, на который пришел запрос;
         * `HTTP method` — метод запроса;
         * `Cookie` — строка в заголовке cookie.
         * `Bot name` — имена легитимных ботов, принадлежащих различным компаниям и сервисам.
         * `Bot category` — категории верифицированных ботов по их назначению или характеру действий.
         * `Verified bot` — фильтрация по признаку верификации бота (`да` или `нет`).
         * `Bot score` — фильтрация по уровню роботизированности запроса: от `0` (самый низкий уровень, человек) до `100` (самый высокий уровень, бот).
         * `FingerPrint` — [отпечаток](../concepts/botes.md#fingerprint) SSL/TLS‑соединения.
     
         Вы можете задать несколько условий одного типа. Для этого в поле **Условия** выберите все необходимые типы условий.
     
         Вы также можете задать одновременно несколько условий одного типа. Для этого в секции с нужным условием нажмите кнопку ![plus-sign](../../_assets/console-icons/plus.svg) **и** или ![plus-sign](../../_assets/console-icons/plus.svg) **или**.
     
         Чтобы удалить условие, нажмите ![options](../../_assets/console-icons/trash-bin.svg).
  1. Нажмите **Создать**.

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Откройте файл конфигурации Terraform и измените фрагмент с описанием профиля WAF `yandex_sws_waf_profile`: добавьте блок `exclusion_rule` с правилом-исключением WAF.

      ```hcl
      # Профиль WAF
      resource "yandex_sws_waf_profile" "default" {
        name = "waf-profile-default"

        ...

        # Правило-исключение
        exclusion_rule {
          name = "<имя_правила-исключения>"
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

     {% cut "Пример настройки правил-исключений профиля WAF в конфигурации Terraform" %}

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
       name = "configure-set-rules"
     
       # Базовый набор правил
       rule_set {
         action     = "CAPTCHA"
         is_enabled = true
         priority   = 1
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
     
       # Правило-исключение
       exclusion_rule {
         name = "test-exclusion-1"
     
         condition {
           source_ip {
             ip_ranges_match {
               ip_ranges = [
                 "192.0.2.0/24",
                 "198.51.100.0/24"
               ]
             }
             ip_ranges_not_match {
               ip_ranges = [
                 "203.0.113.10/32",
                 "203.0.113.0/24"
               ]
             }
           }
         }
     
         exclude_rules {
           exclude_all = false
           rule_ids = [
             "owasp-crs-v4.8.0-id942330-attack-sqli",
             "owasp-crs-v4.8.0-id920202-protocol-enforcement"
           ]
         }
     
       }
     }
     ```

     {% endcut %}

      Где:

      * `exclusion_rule` — правило-исключение:

         * `name` — имя правила-исключения.
         * `condition` — [условия](../concepts/conditions.md), при которых будет срабатывать правило-исключение. В приведенном примере применяется условие по IP-адресу источника трафика.

            В блоке `condition` вы можете использовать одновременно несколько разных типов условий.

         * `exclude_rules` — параметры правила-исключения:

            * `exclude_all` — исключение будет срабатывать для всех правил. Возможные значения: `false` или `true`.
            * `rule_ids` — список идентификаторов правил из базового набора, для которых будет срабатывать исключение. Чтобы указать отдельные правила, для параметра `exclude_all` установите значение `false`.

      Подробнее о параметрах ресурса `yandex_sws_waf_profile` в [документации провайдера](../../terraform/resources/sws_waf_profile.md).

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

  Вы можете проверить изменение ресурсов в [консоли управления](https://console.yandex.cloud).

- API {#api}

  Воспользуйтесь методом REST API [update](../waf/api-ref/WafProfile/update.md) для ресурса [WafProfile](../waf/api-ref/WafProfile/index.md) или вызовом gRPC API [WafProfile/Update](../waf/api-ref/grpc/WafProfile/update.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [Настроить наборы правил WAF](configure-set-rules.md)
* [Удалить правило-исключение WAF](exclusion-rule-delete.md)
* [Добавить правило в профиль безопасности](rule-add.md)