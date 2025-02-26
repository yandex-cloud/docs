---
title: Как получить информацию о правиле
description: Следуя данной инструкции, вы сможете получить информацию о правиле {{ er-full-name }}.
---

# Получить информацию о правиле

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится [правило](../../../concepts/eventrouter/rule.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Слева выберите ![image](../../../../_assets/console-icons/target-dart.svg) **{{ ui-key.yacloud.serverless-event-router.label_rules }}**.
  1. Выберите правило. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о правиле.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для просмотра информации о [правиле](../../../concepts/eventrouter/rule.md):

     ```bash
     yc serverless eventrouter rule get --help
     ```

  1. {% include [get-rules-list](../../../../_includes/serverless-integrations/get-rules-list.md) %}

  1. Получите подробную информацию о правиле, указав его имя или идентификатор:

     ```bash
     yc serverless eventrouter rule get <идентификатор_правила>
     ```

     Результат:

     ```text
     id: f66ir9eeie4e********
     bus_id: f662ctjn8vv4********
     folder_id: b1geoelk7fld********
     cloud_id: b1gia87mbaom********
     created_at: "2025-02-20T12:26:40.769479Z"
     name: rule1
     targets:
       - logging:
           folder_id: b1geoelk7fld********
           service_account_id: ajebg060mvrb********
         status: ENABLED
     status: ENABLED
     ```

- API {#api}

  Чтобы получить информацию о [правиле](../../../concepts/eventrouter/rule.md), воспользуйтесь методом REST API [get](../../../../serverless-integrations/eventrouter/api-ref/Rule/get.md) для ресурса [Rule](../../../../serverless-integrations/eventrouter/api-ref/Rule/index.md) или вызовом gRPC API [RuleService/Get](../../../../serverless-integrations/eventrouter/api-ref/grpc/Rule/get.md).

{% endlist %}