---
title: Как получить информацию о шине
description: Следуя данной инструкции, вы сможете получить информацию о шине {{ er-full-name }}.
---

# Получить информацию о шине

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится [шина](../../../concepts/eventrouter/bus.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Выберите шину. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о шине.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для просмотра информации о [шине](../../../concepts/eventrouter/bus.md):

     ```bash
     yc serverless eventrouter bus get --help
     ```

  1. {% include [get-buses-list](../../../../_includes/serverless-integrations/get-buses-list.md) %}

  1. Получите подробную информацию о шине, указав ее имя или идентификатор:

     ```bash
     yc serverless eventrouter bus get <идентификатор_шины>
     ```

     Результат:

     ```bash
     id: f66ngs9760f1********
     folder_id: b1go3el0d8fs********
     cloud_id: b1gia87mbaom********
     created_at: "2025-02-18T13:23:45.126870Z"
     name: my-bus
     status: ACTIVE
     ```

- API {#api}

  Чтобы получить подробную информацию о [шине](../../../concepts/eventrouter/bus.md), воспользуйтесь методом REST API [get](../../../../serverless-integrations/eventrouter/api-ref/Bus/get.md) для ресурса [Bus](../../../../serverless-integrations/eventrouter/api-ref/Bus/index.md) или вызовом gRPC API [BusService/Get](../../../../serverless-integrations/eventrouter/api-ref/grpc/Bus/get.md).

{% endlist %}