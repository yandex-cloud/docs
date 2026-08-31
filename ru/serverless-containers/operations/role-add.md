---
title: Назначить роли на контейнер
description: Следуя данной инструкции, вы сможете назначить роли на контейнер.
---

# Назначить роли на контейнер

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните команду, чтобы назначить [роль](../security/index.md) на контейнер:

  ```bash
  yc serverless container add-access-binding \
    --name <имя_контейнера> \
    --role <роль> \
    --subject <тип_субъекта>:<идентификатор_субъекта>
  ```

  Где:

  * `--role` — назначаемая [роль](../security/index.md#roles-list).
  * `--subject` — обозначение [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.

      {% cut "Обозначения субъектов" %}

      {% include [subjects-designations-cli](../../_includes/iam/subjects-designations-cli.md) %}

      {% endcut %}

- API {#api}

  Чтобы назначить роли на контейнер, воспользуйтесь методом REST API [setAccessBindings](../containers/api-ref/Container/setAccessBindings.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/SetAccessBindings](../containers/api-ref/grpc/Container/setAccessBindings.md). В теле запроса в свойстве `action` укажите `ADD`, а в свойстве `subject` — тип и идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject).

  {% cut "Обозначения субъектов" %}

  {% include [subjects-designations-api](../../_includes/iam/subjects-designations-api.md) %}

  {% endcut %}

{% endlist %}