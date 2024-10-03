---
title: Как удалить ресурсную запись в {{ dns-full-name }}
description: Следуя данной инструкции, вы сможете удалить ресурсную запись.
---

# Удалить ресурсную запись

Чтобы удалить [ресурсную запись](../concepts/resource-record.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, где находится зона DNS из которой требуется удалить запись.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Выберите зону из списка.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке записи, которую требуется удалить.
  1. В открывшемся меню нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления записей:

      ```
      yc dns zone delete-records --help
      ```
  1. Получите список всех записей в зоне:

      ```
      yc dns zone list-records --name <имя_зоны>
      ```
  1. Удалите запись:

     ```
     yc dns zone delete-records --name <имя_зоны> \
     --record "<доменное_имя> <TTL> <тип_записи> <значение>"
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы удалить из зоны DNS запись, созданную с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием DNS записи.
     
     {% cut "Пример описания DNS записи в конфигурации {{ TF }}" %}

     ```hcl
     ...
     resource "yandex_dns_recordset" "rs1" {
       zone_id = yandex_dns_zone.zone1.id
       name    = "srv.example.com."
       type    = "A"
       ttl     = 200
       data    = ["10.1.0.1"]
     }
     ...
     ```

     {% endcut %}


  1. В командной строке перейдите в папку, где расположен файл конфигурации {{ TF }}.

  1. Проверьте конфигурацию командой:
     ```
     terraform validate
     ```
     
     Если конфигурация является корректной, появится сообщение:
     
     ```
     Success! The configuration is valid.
     ```

  1. Выполните команду:
     ```
     terraform plan
     ```
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.

  1. Примените изменения конфигурации:
     ```
     terraform apply
     ```
     
  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```
     yc dns zone list-records <имя_зоны>
     ```

- API {#api}

  Чтобы удалить ресурсную запись, воспользуйтесь методом REST API [updateRecordSets](../api-ref/DnsZone/updateRecordSets.md) для ресурса [DnsZone](../api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/UpdateRecordSets](../api-ref/grpc/dns_zone_service.md#UpdateRecordSets).

{% endlist %}