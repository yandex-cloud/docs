---
title: Как посмотреть роли, назначенные на контейнер
description: Следуя данной инструкции, вы сможете посмотреть роли, назначенные на контейнер.
---

# Посмотреть роли, назначенные на контейнер

{% note info %}

[Роли](../security/index.md#roles-list), назначенные на каталог, облако или организацию, автоматически [наследуются](../../iam/concepts/access-control/index.md#inheritance) контейнером. При этом они не отображаются в списке ролей, назначенных на него. Подробнее о [просмотре ролей](../../iam/operations/roles/get-assigned-roles.md).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

    Чтобы посмотреть роли, назначенные на [контейнер](../concepts/container.md), выполните команду:

    ```bash
    yc serverless container list-access-bindings --name=<имя_контейнера>
    ```

    Результат:

    ```text
    +---------+--------------+-----------------------+
    | ROLE ID | SUBJECT TYPE |      SUBJECT ID       |
    +---------+--------------+-----------------------+
    | editor  | system       | allAuthenticatedUsers |
    +---------+--------------+-----------------------+
    ```

- API {#api}

  Чтобы посмотреть роли, назначенные на контейнер, воспользуйтесь методом REST API [listAccessBindings](../containers/api-ref/Container/listAccessBindings.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/ListAccessBindings](../containers/api-ref/grpc/Container/listAccessBindings.md).

{% endlist %}
