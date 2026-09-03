---
title: Как отозвать роли, назначенные на ресурс {{ er-full-name }}
description: Следуя данной инструкции, вы сможете отозвать роли, назначенные на ресурс {{ er-name }}.
---

# Отозвать роли, назначенные на ресурс {{ er-name }}

{% include [sunset-note](../../../../_includes/serverless-integrations/sunset-note.md) %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  Выполните команду, чтобы отозвать роль на ресурс {{ er-name }}:

  ```bash
  yc serverless <тип_ресурса> remove-access-binding <имя_или_идентификатор_ресурса> \
    --user-account-id <идентификатор_пользователя> \
    --role <роль>
  ```

  Где:

  * `--role` — идентификатор роли, которую надо отозвать.
  * `--subject` — обозначение [субъекта](../../../../iam/concepts/access-control/index.md#subject), у которого отзывается роль.

      {% cut "Обозначения субъектов" %}

      {% include [subjects-designations-cli](../../../../_includes/iam/subjects-designations-cli.md) %}

      {% endcut %}

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

  Например, для [шины](../../../concepts/eventrouter/bus.md) воспользуйтесь методом REST API [updateAccessBinding](../../../../serverless-integrations/eventrouter/api-ref/Bus/updateAccessBindings.md) для ресурса [Bus](../../../../serverless-integrations/eventrouter/api-ref/Bus/index.md) или вызовом gRPC API [BusService/UpdateAccessBinding](../../../../serverless-integrations/eventrouter/api-ref/grpc/Bus/updateAccessBindings.md). В теле запроса в свойстве `action` укажите `REMOVE`, а в свойстве `subject` — тип и идентификатор [субъекта](../../../../iam/concepts/access-control/index.md#subject).

  {% cut "Обозначения субъектов" %}

  {% include [subjects-designations-api](../../../../_includes/iam/subjects-designations-api.md) %}

  {% endcut %}

{% endlist %}