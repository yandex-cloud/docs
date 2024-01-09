---
title: "Как изменить ресурсную запись в {{ dns-full-name }}"
description: "Следуя данной инструкции, вы сможете изменить ресурсную запись." 
---

# Изменить ресурсную запись

Вы можете изменить значение [ресурсной записи](../concepts/resource-record.md). Чтобы изменить запись:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет изменена запись зоны DNS.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_dns }}**.
  1. Выберите зону из списка.
  1. Нажмите значок ![image](../../_assets/options.svg) напротив имени нужной записи и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. Измените TTL или значение записи.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить зону DNS:

  1. Посмотрите описание команды CLI для изменения записи:

     ```
     yc dns zone replace-records --help
     ```

  1. Измените значение записи:

     ```
     yc dns zone replace-records --name <имя_зоны> \
     --record "<доменное_имя> 600 <тип_записи> <новое_значение>"
     ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы изменить DNS запись, созданную с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и измените фрагмент с описанием DNS записи.

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

     Проверить изменение DNS записи можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```
     yc dns zone list-records <имя_зоны>
     ```

- API {#api}

  Чтобы изменить ресурсную запись, воспользуйтесь методом REST API [updateRecordSets](../api-ref/DnsZone/updateRecordSets.md) для ресурса [DnsZone](../api-ref/DnsZone/index.md) или вызовом gRPC API [DnsZoneService/UpdateRecordSets](../api-ref/grpc/dns_zone_service.md#UpdateRecordSets).

{% endlist %}

Значение ресурсных [TXT-записей](../concepts/resource-record.md#txt) не может содержать больше 255 знаков в одной строке и 1024 знака всего. Если новое значение записи содержит больше знаков, разделите его на несколько значений.
