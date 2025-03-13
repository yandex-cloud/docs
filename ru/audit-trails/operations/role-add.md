---
title: Назначить роли на трейл
description: Следуя данной инструкции, вы сможете назначить роли на трейл.
---

# Назначить роли на трейл

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для назначения [ролей](../security/index.md#roles-list) на [трейл](../concepts/trail.md):

      ```bash
      yc audit-trails trail set-access-bindings --help
      ```

  1. {% include [get-list](../../_includes/audit-trails/get-list.md) %}
  1. Выполните команду, чтобы назначить роль на трейл:

      * Пользователю:

          ```bash
          yc audit-trails trail set-access-bindings \
            --id <идентификатор_трейла> \
            --access-binding role=<роль>,user-account-id=<идентификатор_пользователя>
          ```

          ```text
          done (1s)
          ```

      * [Сервисному аккаунту](../../iam/concepts/users/service-accounts.md):

          ```bash
          yc audit-trails trail set-access-bindings \
            --id <идентификатор_трейла> \
            --access-binding role=<роль>,service-account-id=<идентификатор_сервисного_аккаунта>
          ```

          ```text
          done (1s)
          ```

      * Всем авторизованным пользователям ([публичная группа](../../iam/concepts/access-control/public-group.md) `All authenticated users`):

          ```bash
          yc audit-trails trail set-access-bindings \
            --id <идентификатор_трейла> \
            --access-binding role=<роль>,all-authenticated-users
          ```

          ```text
          done (1s)
          ```

- API {#api}

  Чтобы назначить роли на [трейл](../concepts/trail.md), воспользуйтесь методом REST API [setAccessBindings](../../audit-trails/api-ref/Trail/setAccessBindings.md) для ресурса [Trail](../../audit-trails/api-ref/Trail/index.md) или вызовом gRPC API [TrailService/SetAccessBindings](../../audit-trails/api-ref/grpc/Trail/setAccessBindings.md).

{% endlist %}