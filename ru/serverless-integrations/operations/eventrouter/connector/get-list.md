---
title: Как получить список коннекторов
description: Следуя данной инструкции, вы сможете посмотреть список доступных коннекторов {{ er-full-name }}.
---

# Получить список коннекторов

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите посмотреть список [коннекторов](../../../concepts/eventrouter/connector.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-integrations }}**.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/object-align-center-vertical.svg) **{{ ui-key.yacloud.serverless-event-router.label_service }}** и выберите шину.
  1. На панели слева нажмите ![image](../../../../_assets/console-icons/broadcast-signal.svg) **{{ ui-key.yacloud.serverless-event-router.label_connectors }}**. На странице **{{ ui-key.yacloud.serverless-event-router.label_connectors }}** отобразится список коннекторов.

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для просмотра списка [коннекторов](../../../concepts/eventrouter/connector.md):

     ```bash
     yc serverless eventrouter connector list --help
     ```

  1. {% include [get-connectors-list](../../../../_includes/serverless-integrations/get-connectors-list.md) %}

- API {#api}

  Чтобы посмотреть список [коннекторов](../../../concepts/eventrouter/connector.md), воспользуйтесь методом REST API [list](../../../../serverless-integrations/eventrouter/api-ref/Connector/list.md) для ресурса [Connector](../../../../serverless-integrations/eventrouter/api-ref/Connector/index.md) или вызовом gRPC API [ConnectorService/List](../../../../serverless-integrations/eventrouter/api-ref/grpc/Connector/list.md).

{% endlist %}
