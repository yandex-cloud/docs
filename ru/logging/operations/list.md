---
title: "Получение списка лог-групп"
description: "Следуя данной инструкции, вы сможете получить список лог-групп."
---

# Получение списка лог-групп

{% list tabs %}

- Консоль управления

    В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится лог-группа, и выберите сервис **{{ cloud-logging-name }}**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список лог-групп в каталоге, выполните команду:

    ```
    yc logging group list
    ```

    Результат:

    ```
    +----------------------+---------+----------------------+--------+
    |          ID          |  NAME   |      FOLDER ID       | STATUS |
    +----------------------+---------+----------------------+--------+
    | af36gk8qv2********** | default | aoek6qrs8t********** | ACTIVE |
    +----------------------+---------+----------------------+--------+
    ```

- API

  Чтобы получить список лог-групп, воспользуйтесь методом REST API [list](../api-ref/LogGroup/list.md) для ресурса [LogGroup](../api-ref/LogGroup/index.md) или вызовом gRPC API [LogGroupService/List](../api-ref/grpc/log_group_service.md#List).

{% endlist %}
