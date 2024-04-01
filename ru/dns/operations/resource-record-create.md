---
title: "Как создать ресурсную запись в {{ dns-full-name }}"
description: "Следуя данной инструкции, вы сможете создать ресурсную запись." 
---

# Создать ресурсную запись

Значение [TXT-записи](../concepts/resource-record.md#txt) должно быть не более 1024 знаков.

Чтобы создать [ресурсную запись](../concepts/resource-record.md) в зоне DNS:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где находится зона DNS, в которой требуется создать запись.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Выберите зону из списка.
  1. Нажмите кнопку **{{ ui-key.yacloud.dns.button_record-set-create }}**.
  1. Задайте параметры записи:
     1. В поле **{{ ui-key.yacloud.common.name }}** укажите доменное имя записи.
     1. Выберите [тип записи](../concepts/resource-record.md#rr-types) в выпадающем списке.
     1. В поле **{{ ui-key.yacloud.dns.label_form-ttl }}** укажите время жизни записи или выберите из предложенных.
     1. Введите **{{ ui-key.yacloud.dns.label_records }}** записи.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Выполните команду:

  ```bash
  yc dns zone add-records --name <имя_зоны_DNS> \
    --record "<доменное_имя> <TTL> <тип_записи> <значение>"
  ```

  **Пример**

  Создание TXT-записи с DKIM-подписью:

  > ```bash
  > yc dns zone add-records test-zone \
  >   --record "test-record TXT v=DKIM1;k=rsa;p=MIIBIjAN...gkH2v1NTgQdTKfPmDK...YdRiwIDAQAB"
  > ```

  Если значение TXT-записи содержит несколько значений, то следует заключить каждое значение в двойные кавычки `""`:

  > ```bash
  > yc dns zone add-records test-zone \
  >   --record "test-record TXT v=DKIM1;k=rsa;p=MIIBIjAN""gkH2v1NTgQdTKfPmDK""YdRiwIDAQAB"
  > ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать. Вы можете добавить несколько записей одновременно.

     ```hcl
     resource "yandex_vpc_network" "foo" {}
     
     resource "yandex_dns_zone" "zone1" {
       name        = "my-private-zone"
       description = "desc"
     
       labels = {
         label1 = "label-1-value"
       }
     
       zone             = "example.com."
       public           = false
       private_networks = [yandex_vpc_network.foo.id]
     }
     
     resource "yandex_dns_recordset" "rs1" {
       zone_id = yandex_dns_zone.zone1.id
       name    = "srv.example.com."
       type    = "A"
       ttl     = 200
       data    = ["10.1.0.1"]
     }
     
     resource "yandex_dns_recordset" "rs2" {
       zone_id = yandex_dns_zone.zone1.id
       name    = "srv2"
       type    = "A"
       ttl     = 200
       data    = ["10.1.0.2"]
     }

     resource "yandex_dns_recordset" "rs_dkim" {
       zone_id = yandex_dns_zone.zone1.id
       name    = "dkim"
       type    = "TXT"
       ttl     = 200
       data    = ["v=DKIM1;k=rsa;t=s;p=MIIBIjAN...gkH2v1NTgQdTKfPmDK...YdRiwIDAQAB"]
     }
     ```

     Где:

     1. Параметры `yandex_dns_zone`:

        * `zone` — доменная зона. Название зоны должно заканчиваться точкой. Публичные зоны верхнего уровня (TLD-зоны) создавать нельзя. Обязательный параметр.
        * `folder_id` — идентификатор каталога, в котором будет создана зона. Если он не указан, используется каталог по умолчанию. Необязательный параметр.
        * `name` — имя зоны. Должно быть уникальное внутри каталога. Необязательный параметр.
        * `description` — описание зоны. Необязательный параметр.
        * `labels` — набор меток зоны DNS. Необязательный параметр.
        * `public` — видимость зоны: публичная или внутренняя зона. Необязательный параметр.
        * `private_networks` — для публичных зон указываются ресурсы {{ vpc-name }}, которым эта зона видна. Необязательный параметр.

     1. Параметры `yandex_dns_recordset`:

        * `zone_id` — идентификатор зоны, в которой будет находиться этот набор записей. Обязательный параметр.
        * `name` — доменное имя. Обязательный параметр.
        * `type` — тип DNS записи. Обязательный параметр.
        * `ttl` — время жизни записи (TTL, Time to live) в секундах до актуализации информации о значении записи. Необязательный параметр.
        * `data` — значение записи. Необязательный параметр.

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, смотрите в [документации провайдера]({{ tf-provider-link }}/).

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
  
     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc dns zone list-records <имя_зоны>
     ```

- API {#api}

  Чтобы создать ресурсную запись в зоне DNS, воспользуйтесь методом REST API [updateRecordSets](../api-ref/DnsZone/updateRecordSets.md) для ресурса [DnsZone](../api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/UpdateRecordSets](../api-ref/grpc/dns_zone_service.md#UpdateRecordSets).

{% endlist %}

При создании ресурсных AAAA-записей сервис автоматически производит нормализацию адресов IPv6, заменяя пропуски между `:` нулями, например: `2001:db8::` → `2001:db8:0:0:0:0:0:0`.
