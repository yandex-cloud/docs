---
title: Как изменить зону DNS в {{ dns-full-name }}
description: Следуя данной инструкции, вы сможете изменить зону DNS.
---

# Изменить зону DNS

После создания [зоны DNS](../concepts/dns-zone.md) ее можно изменить: переименовать или добавить описание.

Чтобы изменить зону DNS:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется изменить зону DNS.
  1. [Перейдите]({{ link-console-main }}/link/dns) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке зоны, которую требуется изменить.
  1. В открывшемся меню нажмите кнопку **{{ ui-key.yacloud.common.edit }}**.
  1. Измените параметры зоны.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить зону DNS:

  1. Посмотрите описание команды CLI для изменения зоны:

     ```bash
     yc dns zone update --help
     ```

  1. Измените видимость зоны в сетях:

     ```bash
     yc dns zone update <имя_или_идентификатор_зоны> --network-ids=<идентификаторы_сетей_для_зоны>,
     ```

     Где `--network-ids` — идентификаторы сетей для зоны.

     Результат:

     ```text
     id: aet29qhara5j********
     folder_id: aoerb349v3h4********
     created_at: "2021-02-21T09:21:03.935Z"
     name: new-zone-name
     zone: staging.
     private_visibility:
       network_ids:
       - c645mh47vsc********
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы обновить зону DNS, созданную с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и измените фрагмент с описанием зоны DNS.

     {% cut "Пример описания зоны DNS в конфигурации {{ TF }}" %}

     ```hcl
     resource "yandex_vpc_network" "foo" {}

     resource "yandex_dns_zone" "zone1" {
       name        = "my-public-zone"
       description = "Test public zone"

       labels = {
         label1 = "test-public"
       }

       zone    = "test.example-public2.com."
     }
     ```

     {% endcut %}

  1. Примените изменения конфигурации:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     Проверить изменение параметров зоны DNS можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc dns zone get <имя_зоны>
     ```

- API {#api}

  Чтобы изменить зону DNS, воспользуйтесь методом REST API [update](../api-ref/DnsZone/update.md) для ресурса [DnsZone](../api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/Update](../api-ref/grpc/DnsZone/update.md).

{% endlist %}
