---
title: Как запустить коннектор
description: Следуя данной инструкции, вы сможете запустить коннектор.
---

# Запустить коннектор

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите запустить [коннектор](../../../concepts/eventrouter/connector.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**.
  1. Выберите нужную [шину](../../../concepts/eventrouter/bus.md).
  1. Перейдите на вкладку ![image](../../../../_assets/console-icons/broadcast-signal.svg) **{{ ui-key.yacloud.serverless-event-router.label_connectors }}**.
  1. В строке с нужным коннектором нажмите ![image](../../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../../_assets/console-icons/play.svg) **{{ ui-key.yacloud.common.start }}**.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для запуска [коннектора](../../../concepts/eventrouter/connector.md):

      ```bash
      yc serverless eventrouter connector start --help
      ```

  1. {% include [get-connectors-list](../../../../_includes/serverless-integrations/get-connectors-list.md) %}
  1. Запустите коннектор:

      ```bash
      yc serverless eventrouter connector start <имя_или_идентификатор_коннектора>
      ```

      Результат:

      ```text
      id: f66g4h59ih2g********
      bus_id: f66qn4p7uk6p********
      folder_id: b1g681qpemb4********
      cloud_id: b1gia87mbaom********
      created_at: "2025-02-20T15:30:05.248052Z"
      name: renamed-ydb
      ...
      status: RUNNING
      ```

- API {#api}

  Чтобы запустить [коннектор](../../../concepts/eventrouter/connector.md), воспользуйтесь методом REST API [Start](../../../../serverless-integrations/eventrouter/api-ref/Connector/start.md) для ресурса [Connector](../../../../serverless-integrations/eventrouter/api-ref/Connector/index.md) или вызовом gRPC API [Connector/Start](../../../../serverless-integrations/eventrouter/api-ref/grpc/Connector/start.md).

{% endlist %}