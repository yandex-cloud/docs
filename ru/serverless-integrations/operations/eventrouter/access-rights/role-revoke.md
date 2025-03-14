---
title: Как отозвать роли, назначенные на ресурс {{ er-full-name }}
description: Следуя данной инструкции, вы сможете отозвать роли, назначенные на ресурс {{ er-name }}.
---

# Отозвать роли, назначенные на ресурс {{ er-name }}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  Выполните команду, чтобы отозвать роль на ресурс {{ er-name }}:

  * у пользователя:

      ```bash
      yc serverless <тип_ресурса> remove-access-binding <имя_или_идентификатор_ресурса> \
        --user-account-id <идентификатор_пользователя> \
        --role <роль>
      ```

  * у [сервисного аккаунта](../../../../iam/concepts/users/service-accounts.md):

      ```bash
      yc serverless <тип_ресурса> remove-access-binding <имя_или_идентификатор_ресурса> \
        --service-account-id <идентификатор_сервисного_аккаунта> \
        --role <роль>
      ```

  * у всех авторизованных пользователей ([публичная группа](../../../../iam/concepts/access-control/public-group.md) `All authenticated users`):

      ```bash
      yc serverless <тип_ресурса> remove-access-binding <имя_или_идентификатор_ресурса> \
        --all-authenticated-users \
        --role <роль>
      ```

  **Пример**

  Отозвать роль у сервисного аккаунта на [шину](../../../concepts/eventrouter/bus.md):

  ```bash
  yc serverless eventrouter bus remove-access-binding epdplu8jn7sr******** \
    --service-account-id rrbilgiqaptv******** \
    --role serverless.eventrouter.auditor
  ```

  Результат:

  ```text
  ...1s...done (3s)
  ```

- API {#api}

  Воспользуйтесь методом REST API `updateAccessBinding` для соответствующего ресурса или вызовом gRPC API `<сервис>/UpdateAccessBinding`.

  Например, для [шины](../../../concepts/eventrouter/bus.md) воспользуйтесь методом REST API [updateAccessBinding](../../../../serverless-integrations/eventrouter/api-ref/Bus/updateAccessBindings.md) для ресурса [Bus](../../../../serverless-integrations/eventrouter/api-ref/Bus/index.md) или вызовом gRPC API [BusService/UpdateAccessBinding](../../../../serverless-integrations/eventrouter/api-ref/grpc/Bus/updateAccessBindings.md).

{% endlist %}