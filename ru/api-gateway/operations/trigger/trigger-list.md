---
title: Инструкция о том, как получить информацию о триггере в {{ api-gw-full-name }}
description: Из статьи вы узнаете, как получить список триггеров и подробную информацию о триггере в {{ api-gw-full-name }}.
---

# Получить список триггеров в {{ api-gw-name }}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите посмотреть список триггеров.
    1. Откройте сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. На панели слева выберите ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Получите список триггеров:

    ```bash
    yc serverless trigger list
    ```

    Результат:

    ```text
    +----------------------+------------+----------------------+
    |          ID          |    NAME    |      FOLDER ID       |
    +----------------------+------------+----------------------+
    | dd0gj5tsj2p3******** | my-trigger | aoek49ghmki7******** |
    +----------------------+------------+----------------------+
    ```

- API {#api}

  Чтобы получить список триггеров, воспользуйтесь методом REST API [list](../../triggers/api-ref/Trigger/list.md) для ресурса [Trigger](../../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/List](../../triggers/api-ref/grpc/trigger_service.md#List).

{% endlist %}
