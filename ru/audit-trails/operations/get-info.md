---
title: Как получить информацию о трейле
description: Следуя данной инструкции, вы сможете получить информацию о трейле {{ at-full-name }}.
---

# Получить информацию о трейле

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится [трейл](../concepts/trail.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. Выберите трейл. На странице **{{ ui-key.yacloud.audit-trails.label_trail }}** отобразится подробная информация о трейле.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для просмотра информации о [трейле](../concepts/trail.md):

     ```bash
     yc audit-trails trail get --help
     ```

  1. {% include [get-list](../../_includes/audit-trails/get-list.md) %}

  1. Получите подробную информацию о трейле, указав его имя или идентификатор:

     ```bash
     yc audit-trails trail get <идентификатор_трейла>
     ```

     Результат:

     ```text
     id: cnp82sb0phnm********
     folder_id: b1geoelk7fld********
     created_at: "2025-02-20T07:28:00.815Z"
     updated_at: "2025-02-20T07:28:00.815Z"
     name: trailfromapi
     description: trailfromapi
     destination:
       object_storage:
         bucket_id: rsample-logs-bucket
     service_account_id: ajenfbssm9o5********
     status: ACTIVE
     cloud_id: b1gia87mbaom********
     filtering_policy:
       management_events_filter:
         resource_scopes:
           - id: b1geoelk7fld********
             type: resource-manager.folder
       data_events_filters:
         - service: mdb.postgresql
           excluded_events:
             event_types:
               - yandex.cloud.audit.mdb.postgresql.CreateDatabase
               - yandex.cloud.audit.mdb.postgresql.UpdateDatabase
           resource_scopes:
             - id: b1gia87mbaom********
               type: resource-manager.cloud
             - id: b1geoelk7fld********
               type: resource-manager.folder
         - service: storage
           resource_scopes:
             - id: b1geoelk7fld********
               type: resource-manager.folder
             - id: b1g0g14rq0mv********
               type: resource-manager.folder
         - service: compute
           resource_scopes:
             - id: b1geoelk7fld********
               type: resource-manager.folder
     ```

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы получить информацию о [трейле](../concepts/trail.md) с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл Terraform блоки `data` и `output`:

      ```hcl
      data "yandex_audit_trails_trail" "my-trail" {
        trail_id = "<идентификатор_трейла>"
      }

      output "my-trail-status" {
        value = data.yandex_audit_trails_trail.my-trail.status
      }
      ```

      Где:

      * `data "yandex_audit_trails_trail"` — описание трейла в качестве источника данных:
         * `resource_id` — идентификатор ресурса.
      * `output "my-trail-status"` — выходная переменная, которая содержит информацию о текущем статусе трейла (`status`):
         * `value` — возвращаемое значение.

     Вместо `status` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_audit_trails_trail` см. в [документации провайдера]({{ tf-provider-datasources-link }}/audit_trails_trail).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```text
      my-trail-status = ACTIVE
      ```

- API {#api}

  Чтобы получить подробную информацию о [трейле](../concepts/trail.md), воспользуйтесь методом REST API [get](../api-ref/Trail/get.md) для ресурса [Trail](../api-ref/Trail/index.md) или вызовом gRPC API [TrailService/Get](../api-ref/grpc/Trail/get.md).

{% endlist %}