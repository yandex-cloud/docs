---
title: Как получить список шин
description: Следуя данной инструкции, вы сможете посмотреть список доступных шин {{ er-full-name }}.
---

# Получить список шин

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите посмотреть список [шин](../../../concepts/eventrouter/bus.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева выберите ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}**. На странице **{{ ui-key.yacloud.serverless-event-router.label_buses }}** отобразится список шин.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для просмотра списка [шин](../../../concepts/eventrouter/bus.md):

      ```bash
      yc serverless eventrouter bus list --help
      ```

  1. {% include [get-buses-list](../../../../_includes/serverless-integrations/get-buses-list.md) %}

- API {#api}

  Чтобы посмотреть список [шин](../../../concepts/eventrouter/bus.md), воспользуйтесь методом REST API [list](../../../../serverless-integrations/eventrouter/api-ref/Bus/list.md) для ресурса [Bus](../../../../serverless-integrations/eventrouter/api-ref/Bus/index.md) или вызовом gRPC API [BusService/List](../../../../serverless-integrations/eventrouter/api-ref/grpc/Bus/list.md).

{% endlist %}