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

  ```bash
  yc serverless <тип_ресурса> add-access-binding <имя_или_идентификатор_ресурса> \
    --role <роль> \
    --subject <тип_субъекта>:<идентификатор_субъекта>
  ```

  Где:

  * `--role` — назначаемая [роль](../../../security/index.md#roles-list).
  * `--subject` — обозначение [субъекта](../../../../iam/concepts/access-control/index.md#subject), которому назначается роль.

      {% cut "Обозначения субъектов" %}

      {% include [subjects-designations-cli](../../../../_includes/iam/subjects-designations-cli.md) %}

      {% endcut %}

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

  Например, для [шины](../../../concepts/eventrouter/bus.md) воспользуйтесь методом REST API [setAccessBinding](../../../../serverless-integrations/eventrouter/api-ref/Bus/setAccessBindings.md) для ресурса [Bus](../../../../serverless-integrations/eventrouter/api-ref/Bus/index.md) или вызовом gRPC API [BusService/SetAccessBinding](../../../../serverless-integrations/eventrouter/api-ref/grpc/Bus/setAccessBindings.md). В теле запроса в свойстве `action` укажите `ADD`, а в свойстве `subject` — тип и идентификатор [субъекта](../../../../iam/concepts/access-control/index.md#subject).

  {% cut "Обозначения субъектов" %}

  {% include [subjects-designations-api](../../../../_includes/iam/subjects-designations-api.md) %}

  {% endcut %}

{% endlist %}