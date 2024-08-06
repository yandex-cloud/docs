---
title: "Как изменить правило в профиле безопасности {{ sws-full-name }}"
description: "Следуя данной инструкции, вы сможете изменить правило в профиле безопасности {{ sws-full-name }}."
---

# Изменить правило в профиле безопасности

В [профиле безопасности](../concepts/profiles.md) можно изменить базовые [правила](../concepts/rules.md), Smart Protection и WAF. Правила ARL [изменяются в профиле ARL](arl-rule-update.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите изменить правило в профиле безопасности.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Выберите профиль, в котором вы хотите изменить правило.
  1. На вкладке **{{ ui-key.yacloud.smart-web-security.overview.title_security-rules }}** напротив правила, параметры которого вы хотите изменить, нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. Измените основные параметры правила:
      * **{{ ui-key.yacloud.common.name }}**.
      * **{{ ui-key.yacloud.common.description }}**.
      * **{{ ui-key.yacloud.smart-web-security.overview.column_priority }}** правила.

        {% include [preconfigured-rules-priority](../../_includes/smartwebsecurity/preconfigured-rules-priority.md) %}

      * Опцию логирования трафика без дальнейшей фильтрации (dry run).
      * Тип правила:
        * [**{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}**](../concepts/rules.md#base-rules) — правило, которое разрешает или запрещает трафик по заданным условиям.
        * [**{{ ui-key.yacloud.smart-web-security.overview.label_smart-protection-rule }}**](../concepts/rules.md#smart-protection-rules) — правило, которое отправляет трафик на автоматический анализ с помощью алгоритмов машинного обучения и поведенческого анализа. Подозрительные запросы отправляются в {{ captcha-name }} для дополнительной верификации.
        * [**{{ ui-key.yacloud.smart-web-security.overview.label_waf-rule }}**](../../smartwebsecurity/concepts/rules.md#waf-rules) — правило, которое подключает набор правил из профиля WAF. Подозрительные запросы отправляются в {{ captcha-name }} для дополнительной верификации.
      * [**{{ ui-key.yacloud.smart-web-security.overview.column_action-type }}**](../concepts/rules.md#rule-action):
        * Для базового правила: `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}` или `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-allow }}` трафик, параметры которого соответствуют условиям.
        * Для правила Smart Protection или WAF:
          * `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}` — после проверки подозрительные запросы отправляются в {{ captcha-name }}.
          * `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-api }}` — после проверки подозрительные запросы блокируются.
  1. В поле **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** и дополнительных полях ниже измените условия, которым должен соответствовать трафик, чтобы попасть под действие правила. Подробнее см. [Условия действия правила](../concepts/conditions.md).
      
      Вы можете задать несколько условий одного типа. Для разных типов условий действуют разные логические операторы: _и_ или _или_. Чтобы добавить более одного условия определенного типа нажмите кнопки ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.condition-column.condition_and }}** или ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.condition-column.condition_or }}**.

      Чтобы удалить условие, нажмите кнопку ![options](../../_assets/console-icons/trash-bin.svg).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save-changes }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Чтобы посмотреть список имеющихся профилей безопасности в каталоге по умолчанию, выполните команду:

     {% include [security-profile-list-command](../../_includes/smartwebsecurity/security-profile-list-command.md) %}

  1. Обновите профиль безопасности, применив к нему [YAML](https://ru.wikipedia.org/wiki/YAML)-конфигурацию, содержащую измененное описание имеющихся правил безопасности:
  
     1. Чтобы получить YAML-конфигурацию имеющихся в профиле правил безопасности, выполните команду, указав имя или идентификатор профиля безопасности:

         {% include [security-profile-get-command](../../_includes/smartwebsecurity/security-profile-get-command.md) %}

     1. Скопируйте в любой текстовый редактор и сохраните в файл текущую конфигурацию правил (содержимое блока `security_rules`), внеся в нее необходимые изменения. В приведенном ниже примере было изменено имя правила, а действие `DENY` было заменено на `ALLOW`:

         {% cut "security-rules.yaml" %}

         ```yaml
         - name: rule-condition-allow
           priority: "11111"
           dry_run: true
           rule_condition:
             action: ALLOW
             condition:
               authority:
                 authorities:
                   - exact_match: example.com
                   - exact_match: example.net
               http_method:
                 http_methods:
                   - exact_match: GET
                   - exact_match: POST
               request_uri:
                 path:
                   prefix_match: /search
                 queries:
                   - key: firstname
                     value:
                       pire_regex_match: .ivan.
                   - key: lastname
                     value:
                       pire_regex_not_match: .petr.
               headers:
                 - name: User-Agent
                   value:
                     pire_regex_match: .curl.
                 - name: Referer
                   value:
                     pire_regex_not_match: .bot.
               source_ip:
                 ip_ranges_match:
                   ip_ranges:
                     - 1.2.33.44
                     - 2.3.4.56
                 ip_ranges_not_match:
                   ip_ranges:
                     - 8.8.0.0/16
                     - 10::1234:1abc:1/64
                 geo_ip_match:
                   locations:
                     - ru
                     - es
                 geo_ip_not_match:
                   locations:
                     - us
                     - fm
                     - gb
         ```

         {% endcut %}

         {% include [change-profile-rules-alert](../../_includes/smartwebsecurity/change-profile-rules-alert.md) %}

     1. Чтобы внести изменения в профиль безопасности, выполните команду, указав имя или идентификатор профиля:
    
         ```bash
         yc smartwebsecurity security-profile update <имя_или_идентификатор_профиля_безопасности> \
            --security-rules-file <путь_к_файлу_с_правилами_безопасности>
         ```

         Где `--security-rules-file` — путь к [YAML](https://ru.wikipedia.org/wiki/YAML)-файлу с описанием правил безопасности.


         {% cut "Результат:" %}

         ```yaml
         id: fev450d61ucv********
         folder_id: b1gt6g8ht345********
         cloud_id: b1gia87mbaom********
         labels:
           label1: value1
           label2: value2
         name: my-new-profile
         description: my description
         default_action: DENY
         security_rules:
           - name: rule-condition-allow
             priority: "11111"
             dry_run: true
             rule_condition:
               action: ALLOW
               condition:
                 authority:
                   authorities:
                     - exact_match: example.com
                     - exact_match: example.net
                 http_method:
                   http_methods:
                     - exact_match: GET
                     - exact_match: POST
                 request_uri:
                   path:
                     prefix_match: /search
                   queries:
                     - key: firstname
                       value:
                         pire_regex_match: .ivan.
                     - key: lastname
                       value:
                         pire_regex_not_match: .petr.
                 headers:
                   - name: User-Agent
                     value:
                       pire_regex_match: .curl.
                   - name: Referer
                     value:
                       pire_regex_not_match: .bot.
                 source_ip:
                   ip_ranges_match:
                     ip_ranges:
                       - 1.2.33.44
                       - 2.3.4.56
                   ip_ranges_not_match:
                     ip_ranges:
                       - 8.8.0.0/16
                       - 10::1234:1abc:1/64
                   geo_ip_match:
                     locations:
                       - ru
                       - es
                   geo_ip_not_match:
                     locations:
                       - us
                       - fm
                       - gb
             description: My first security rule. This rule it's just example to show possibilities of configuration.
         created_at: "2024-08-05T17:54:48.898624Z"
         ```

         {% endcut %}

  Подробнее о команде `yc smartwebsecurity security-profile update` читайте в [справочнике CLI](../../cli/cli-ref/managed-services/smartwebsecurity/security-profile/update.md).

- API {#api}

  {% include [api-profile-update](../../_includes/smartwebsecurity/api-profile-update.md) %}

{% endlist %}

### См. также {#see-also}

* [{#T}](rule-delete.md)
