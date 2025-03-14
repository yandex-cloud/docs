---
title: Как назначить роли на ресурс {{ er-full-name }}
description: Следуя данной инструкции, вы сможете назначить роли на ресурс {{ er-name }}.
---

# Назначить роли на ресурс {{ er-name }}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  Выполните команду, чтобы назначить роль на ресурс {{ er-name }}:

  * пользователю:

      ```bash
      yc serverless <тип_ресурса> add-access-binding <имя_или_идентификатор_ресурса> \
        --user-account-id <идентификатор_пользователя> \
        --role <роль>
      ```

  * [сервисному аккаунту](../../../../iam/concepts/users/service-accounts.md):

      ```bash
      yc serverless <тип_ресурса> add-access-binding <имя_или_идентификатор_ресурса> \
        --service-account-id <идентификатор_сервисного_аккаунта> \
        --role <роль>
      ```

  * всем авторизованным пользователям ([публичная группа](../../../../iam/concepts/access-control/public-group.md) `All authenticated users`):

      ```bash
      yc serverless <тип_ресурса> add-access-binding <имя_или_идентификатор_ресурса> \
        --all-authenticated-users \
        --role <роль>
      ```

  **Пример**

  Назначить роль сервисному аккаунту на [шину](../../../concepts/eventrouter/bus.md):

  ```bash
  yc serverless eventrouter bus add-access-binding epdplu8jn7sr******** \
    --service-account-id rrbilgiqaptv******** \
    --role serverless.eventrouter.auditor
  ```

  Результат:

  ```text
  ...1s...done (3s)
  ```

- API {#api}

  Воспользуйтесь методом REST API `setAccessBinding` для соответствующего ресурса или вызовом gRPC API `<сервис>/SetAccessBinding`.

  Например, для [шины](../../../concepts/eventrouter/bus.md) воспользуйтесь методом REST API [setAccessBinding](../../../../serverless-integrations/eventrouter/api-ref/Bus/setAccessBindings.md) для ресурса [Bus](../../../../serverless-integrations/eventrouter/api-ref/Bus/index.md) или вызовом gRPC API [BusService/SetAccessBinding](../../../../serverless-integrations/eventrouter/api-ref/grpc/Bus/setAccessBindings.md).

{% endlist %}