---
title: Как получить информацию о коннекторе
description: Следуя данной инструкции, вы сможете получить информацию о коннекторе {{ er-full-name }}.
---

# Получить информацию о коннекторе

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится [коннектор](../../../concepts/eventrouter/connector.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}** и выберите шину. 
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/broadcast-signal.svg) **{{ ui-key.yacloud.serverless-event-router.label_connectors }}** и выберите коннектор.
  1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о коннекторе.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для просмотра информации о [коннекторе](../../../concepts/eventrouter/connector.md):

     ```bash
     yc serverless eventrouter connector get --help
     ```

  1. {% include [get-connectors-list](../../../../_includes/serverless-integrations/get-connectors-list.md) %}

  1. Получите подробную информацию о коннекторе, указав его имя или идентификатор:

     ```bash
     yc serverless eventrouter connector get <идентификатор_коннектора>
     ```

     Результат:

     ```bash
     id: f66b9arad2ui********
     bus_id: f669a9niloj3********
     folder_id: b1gk6obg9bqf********
     cloud_id: b1gia87mbaom********
     created_at: "2025-02-23T14:01:46.256658Z"
     name: my-connector
     source:
       message_queue:
         queue_arn: yrn:yc:ymq:ru-central1:b1gk6obg9bqf********:my-queue
         service_account_id: ajeis9398lmk********
         visibility_timeout: 43200s
         batch_size: "10"
         polling_timeout: 10s
     status: RUNNING
     ```

- API {#api}

  Чтобы получить подробную информацию о [коннекторе](../../../concepts/eventrouter/connector.md), воспользуйтесь методом REST API [get](../../../../serverless-integrations/eventrouter/api-ref/Connector/get.md) для ресурса [Connector](../../../../serverless-integrations/eventrouter/api-ref/Connector/index.md) или вызовом gRPC API [ConnectorService/Get](../../../../serverless-integrations/eventrouter/api-ref/grpc/Connector/get.md).

{% endlist %}
