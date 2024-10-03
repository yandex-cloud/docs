---
title: Как получить список зон DNS
---

# Получить список зон DNS

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором хотите посмотреть список [зон DNS](../concepts/dns-zone.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. На странице **{{ ui-key.yacloud.dns.label_zones-list }}** отобразится список зон DNS.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения списка [зон DNS](../concepts/dns-zone.md):

     ```bash
      yc dns zone list --help
      ```

  1. Чтобы получить список зон DNS, выполните команду:

      ```bash
      yc dns zone list
      ```

      Результат:

      ```text
      +----------------------+------------+---------+------------------------------+-------------+
      |          ID          |    NAME    |  ZONE   |          VISIBILITY          | DESCRIPTION |
      +----------------------+------------+---------+------------------------------+-------------+
      | dns5djfi2h68******** | test-zone. | staging | PRIVATE enpncp31fh3n******** |             |
      +----------------------+------------+---------+------------------------------+-------------+
      ```

- API {#api}

  Чтобы получить список [зон DNS](../concepts/dns-zone.md), воспользуйтесь методом REST API [list](../api-ref/DnsZone/list.md) для ресурса [DnsZone](../api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/List](../api-ref/grpc/dns_zone_service.md#List).

{% endlist %}