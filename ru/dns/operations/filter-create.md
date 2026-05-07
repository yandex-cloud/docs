---
title: Как создать фильтр DNS в {{ dns-full-name }}
description: Следуя данной инструкции, вы сможете создать фильтр DNS.
---

# Создать фильтр DNS

Чтобы создать [фильтр DNS](../concepts/dns-filter.md):

{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы создать новый фильтр DNS и применить его на уровне облака:

  1. Посмотрите описание команды CLI для создания зоны:

     ```bash
     yc dns firewall create --help
     ```

  1. Создайте фильтр DNS в нужном каталоге с действием на уровне облака:

     ```bash
     yc dns firewall create --name filter-1 \
       --description 'DNS Filter #1' \
       --folder-id b1g23..........4kpv3 \
       --enabled \
       --cloud-ids 'b1g38..........qg4nl' \
       --whitelist-fqdns 'dom1.net.,*.dom5.net.,*.ru.' \ 
       --blacklist-fqdns 'www.dom1.net.,info.dom5.net.' 
     ```

     Где:

     * `--name` — имя фильтра. Должно быть уникальным внутри каталога.
     * `--description` — описание фильтра.
     * `--folder-id` — идентификатор каталога, в котором будет создан фильтр.
     * `--enabled` — определяет состояние фильтра: включен или выключен. Если не указывать, фильтр будет создан в выключенном состоянии.
     * `--whitelist-fqdns`, `--blacklist-fqdns` — список FQDN. [Правила использования DNS-фильтров](../concepts/dns-filter.md#rules).
     * `--cloud-ids` — список идентификаторов облаков, на ресурсы из которых будет действовать данный фильтр.
     * `--folder-ids` — список идентификаторов каталогов, на ресурсы из которых будет действовать данный фильтр.
     * `--network-ids` — список идентификаторов сетей (VPC), на ресурсы из которых будет действовать данный фильтр.
     * `--lock-resources` — включение режима [централизованного управления фильтрами](../concepts/dns-filter.md#lock).

     Результат:

     ```text
      id: dnscmtk2r6neivr20q2l
      folder_id: b1g23..........4kpv3
      created_at: "2026-04-29T04:53:06.591Z"
      name: filter-1
      description: 'DNS Filter #1'
      enabled: true
      resource_config:
      type: CLOUD
      resource_ids:
          - b1g38..........qg4nl
      whitelist_fqdns:
      - dom1.net.
      - '*.dom5.net.'
      - '*.ru.'
      blacklist_fqdns:
      - www.dom1.net.
      - info.dom5.net.
     ```

     После создания фильтра можно проверить доступность FQDN из белого и черного списков с помощью команд `dig` и `ping` с соответствующих облачных ресурсов (ВМ).

    Результат:

     ```text
     dig www.dom1.net 
     
     ; <<>> DiG 9.18.39-0ubuntu0.24.04.3-Ubuntu <<>> www.dom1.net
     ;; global options: +cmd
     ;; Got answer:
     ;; ->>HEADER<<- opcode: QUERY, status: REFUSED, id: 50976
     ;; flags: qr rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 0, ADDITIONAL: 1
     
     ;; OPT PSEUDOSECTION:
     ; EDNS: version: 0, flags:; udp: 65494
     ;; QUESTION SECTION:
     ;www.dom1.net.			IN	A
     
     ;; Query time: 1 msec
     ;; SERVER: 127.0.0.53#53(127.0.0.53) (UDP)
     ;; WHEN: Tue Apr 28 13:44:20 UTC 2026
     ;; MSG SIZE  rcvd: 40
     ```

     ```text
     ping www.dom1.net
     ping: www.dom1.net: Temporary failure in name resolution
     ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     ```hcl
     resource "yandex_dns_firewall" "filter1" {
       name        = "filter-1"
       description = "DNS Filter #1"
       folder_id   = "b1g27..........pe3fg"

       labels = {
         label1 = "label-1-value"
       }

       enabled         = true
       whitelist_fqdns = ["dom1.net.","*.dom5.net.","*.ru."]
       blacklist_fqdns = ["www.dom1.net.","info.dom5.net."]

       resource_config = {
         type           = "CLOUD"
         resource_ids   = ["b1g38..........qg4nl"]
         lock_resources = false
       }

        deletion_protection = false
     }
     ```

     Где:

     * `name` — имя фильтра. Должно быть уникальным внутри каталога.
     * `description` — описание фильтра.
     * `folder_id` — идентификатор каталога, в котором будет создан фильтр.
     * `enabled` — определяет состояние фильтра: включен или выключен. Если не указывать, фильтр будет создан в выключенном состоянии.
     * `deletion_protection` — включение для создаваемого ресурса защиты от удаления.
     * `whitelist_fqdns`, `blacklist_fqdns` — список FQDN. [Правила использования DNS-фильтров](../concepts/dns-filter.md#rules).
     * `resource_config` — блок атрибутов ресурса, к которому будет применен фильтр:
          * `type` — тип ресурса. Допустимые значения: `CLOUD`, `FOLDER`, `NETWORK`.
          * `resource_ids` — список идентификаторов ресурсов заданного типа.
          * `lock_resources` — включение режима [централизованного управления фильтрами](../concepts/dns-filter.md#lock).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc dns firewall get <имя-фильтра>
     ```

{% endlist %}
