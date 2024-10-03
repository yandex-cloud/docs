---
title: Как изменить правило в профиле безопасности {{ sws-full-name }}
description: Следуя данной инструкции, вы сможете изменить правило в профиле безопасности {{ sws-full-name }}.
---

# Изменить правило в профиле безопасности

В [профиле безопасности](../concepts/profiles.md) можно изменить базовые [правила](../concepts/rules.md), а также правила Smart Protection и WAF. Правила ARL [изменяются в профиле ARL](arl-rule-update.md).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится нужный профиль безопасности.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Выберите профиль, в котором вы хотите изменить правило.
  1. На вкладке **{{ ui-key.yacloud.smart-web-security.overview.title_security-rules }}** в строке с нужным правилом нажмите ![options](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. В открывшемся окне задайте новые параметры правила:
  
      {% include [add-rule](../../_includes/smartwebsecurity/add-rule.md) %}

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
