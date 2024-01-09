---
title: "Получить информацию о контейнере"
description: "Следуя данной инструкции, вы сможете получить информацию о контейнере."
---

# Получить информацию о контейнере

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
    1. На панели слева выберите **{{ ui-key.yacloud.serverless-containers.label_containers }}**.
    1. Выберите контейнер.
    1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о контейнере.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    {% include [note](../../_includes/serverless-containers/sc-list-note.md) %}

    Чтобы получить подробную информацию о контейнере, выполните команду:

    ```
    yc serverless container get <идентификатор_контейнера>
    ```
    Результат:
    ```
    id: bba0hq6q1prb********
    folder_id: b1gtmgn9gbvm********
    created_at: "2023-01-17T11:52:56.800Z"
    name: test
    url: https://bba0hq6q1prb********.{{ serverless-containers-host }}/
    status: ACTIVE
    ```

- API {#api}

  Чтобы получить подробную информацию о контейнере, воспользуйтесь методом REST API [get](../containers/api-ref/Container/get.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/Get](../containers/api-ref/grpc/container_service.md#Get).

{% endlist %}