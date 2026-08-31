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

      ```bash
      yc audit-trails trail remove-access-binding \
        --id <идентификатор_трейла> \
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

  Чтобы отозвать роли, назначенные на [трейл](../concepts/trail.md), воспользуйтесь методом REST API [updateAccessBindings](../../audit-trails/api-ref/Trail/updateAccessBindings.md) для ресурса [Trail](../../audit-trails/api-ref/Trail/index.md) или вызовом gRPC API [TrailService/UpdateAccessBindings](../../audit-trails/api-ref/grpc/Trail/updateAccessBindings.md). В теле запроса в свойстве `action` укажите `REMOVE`, а в свойстве `subject` — тип и идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject).

  {% cut "Обозначения субъектов" %}

  {% include [subjects-designations-api](../../_includes/iam/subjects-designations-api.md) %}

  {% endcut %}

{% endlist %}
