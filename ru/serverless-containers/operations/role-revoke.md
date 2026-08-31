---
title: Отозвать роли, назначенные на контейнер
description: Следуя данной инструкции, вы сможете отозвать роли, назначенные на контейнер.
---

# Отозвать роли, назначенные на контейнер

{% list tabs group=instructions %}

- CLI {#cli}

  Выполните команду, чтобы отозвать [роль](../security/index.md) на контейнер:

  ```bash
  yc serverless container remove-access-binding \
    --name <имя_контейнера> \
    --role <идентификатор_роли> \
    --subject <тип_субъекта>:<идентификатор_субъекта>
  ```

  Где:

  * `--role` — идентификатор роли, которую надо отозвать.
  * `--subject` — обозначение [субъекта](../../iam/concepts/access-control/index.md#subject), у которого отзывается роль.

      {% cut "Обозначения субъектов" %}

      {% include [subjects-designations-cli](../../_includes/iam/subjects-designations-cli.md) %}

      {% endcut %}

- API {#api}

  Чтобы отозвать роли, назначенные на контейнер, воспользуйтесь методом REST API [updateAccessBindings](../containers/api-ref/Container/updateAccessBindings.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/UpdateAccessBindings](../containers/api-ref/grpc/Container/updateAccessBindings.md). В теле запроса в свойстве `action` укажите `REMOVE`, а в свойстве `subject` — тип и идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject).

  {% cut "Обозначения субъектов" %}

  {% include [subjects-designations-api](../../_includes/iam/subjects-designations-api.md) %}

  {% endcut %}

{% endlist %}