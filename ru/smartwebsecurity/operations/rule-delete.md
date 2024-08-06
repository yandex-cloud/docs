---
title: "Как удалить правило из профиля безопасности {{ sws-full-name }}"
description: "Следуя данной инструкции, вы сможете удалить правило из профиля безопасности {{ sws-full-name }}."
---

# Удалить правило из профиля безопасности

Из профиля безопасности можно удалить базовые правила, Smart Protection и WAF. Правила ARL [удаляются из профиля ARL](arl-rule-delete.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором вы хотите удалить [правило](../concepts/rules.md) из [профиля безопасности](../concepts/profiles.md).
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Выберите профиль, в котором вы хотите удалить правило.
  1. На вкладке **{{ ui-key.yacloud.smart-web-security.overview.title_security-rules }}** напротив правила нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. Подтвердите удаление.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Чтобы посмотреть список имеющихся профилей безопасности в каталоге по умолчанию, выполните команду:

     {% include [security-profile-list-command](../../_includes/smartwebsecurity/security-profile-list-command.md) %}

  1. Обновите профиль безопасности, применив к нему измененную [YAML](https://ru.wikipedia.org/wiki/YAML)-конфигурацию правил безопасности, предварительно удалив из нее ненужные правила:
  
     1. Чтобы получить YAML-конфигурацию уже имеющихся в профиле правил безопасности, выполните команду, указав имя или идентификатор профиля безопасности:

         ```bash
         yc smartwebsecurity security-profile get <имя_или_идентификатор_профиля_безопасности>
         ```

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
           - name: rule-condition-deny
             priority: "11111"
             dry_run: true
             rule_condition:
               action: DENY
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
           - name: rule-condition-allow
             priority: "2"
             rule_condition:
               action: ALLOW
               condition:
                 source_ip:
                   ip_ranges_match:
                     ip_ranges:
                       - 44.44.44.44-44.44.44.45
                       - 44.44.44.77
             description: Let's show how to whitelist IP.
           - name: smart-protection-full
             priority: "11"
             smart_protection:
               mode: FULL
               condition:
                 request_uri:
                   path:
                     prefix_match: /search
             description: Enable smart protection. Allow to show captcha on /search prefix.
           - name: smart-protection-api
             priority: "10"
             smart_protection:
               mode: API
               condition:
                 request_uri:
                   path:
                     prefix_match: /api
             description: Enable smart protection with mode API. We are not expect to see captcha on /api prefix.
         created_at: "2024-08-05T17:54:48.898624Z"
         ```

         {% endcut %}

     1. Скопируйте в любой текстовый редактор и сохраните в файл текущую конфигурацию правил (содержимое блока `security_rules`), удалив из нее лишние правила, например:

         {% cut "security-rules.yaml" %}

         ```yaml
         - name: rule-condition-deny
           description: My first security rule. This rule it's just example to show possibilities of configuration.
           priority: "11111"
           dry_run: true
           rule_condition:
             action: DENY
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
           - name: rule-condition-deny
             priority: "11111"
             dry_run: true
             rule_condition:
               action: DENY
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