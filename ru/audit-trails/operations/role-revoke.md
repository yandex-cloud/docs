---
title: Отозвать роли, назначенные на трейл
description: Следуя данной инструкции, вы сможете отозвать роли, назначенные на трейл.
---

# Отозвать роли, назначенные на трейл

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для отзыва [ролей](../security/index.md#roles-list), назначенных на [трейл](../concepts/trail.md):

      ```bash
      yc audit-trails trail remove-access-binding --help
      ```

  1. {% include [get-list](../../_includes/audit-trails/get-list.md) %}
  1. Выполните команду, чтобы отозвать роль, назначенную на трейл.

      * У пользователя:

          ```bash
          yc audit-trails trail remove-access-binding \
            --id <идентификатор_трейла> \
            --user-account-id <идентификатор_пользователя> \
            --role <роль>
          ```
          
          Результат:

          ```text
          done (1s)
          ```

      * У [сервисного аккаунта](../../iam/concepts/users/service-accounts.md):

          ```bash
          yc audit-trails trail remove-access-binding \
            --id <идентификатор_трейла> \
            --service-account-id <идентификатор_сервисного_аккаунта> \
            --role <роль>
          ```

          Результат:

          ```text
          done (1s)
          ```

      * У всех авторизованных пользователей ([публичная группа](../../iam/concepts/access-control/public-group.md) `All authenticated users`):

          ```bash
          yc audit-trails trail remove-access-binding \
            --id <идентификатор_трейла> \
            --all-authenticated-users \
            --role <роль>
          ```

          Результат:
        
          ```text
          done (1s)
          ```

- API {#api}

  Чтобы отозвать роли, назначенные на [трейл](../concepts/trail.md), воспользуйтесь методом REST API [updateAccessBindings](../../audit-trails/api-ref/Trail/updateAccessBindings.md) для ресурса [Trail](../../audit-trails/api-ref/Trail/index.md) или вызовом gRPC API [TrailService/UpdateAccessBindings](../../audit-trails/api-ref/grpc/Trail/updateAccessBindings.md).

{% endlist %}
