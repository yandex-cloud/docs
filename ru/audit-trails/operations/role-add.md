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

      ```bash
      yc audit-trails trail set-access-bindings \
        --id <идентификатор_трейла> \
        --access-binding role=<роль>,subject=<тип_субъекта>:<идентификатор_субъекта>
      ```

      Где:

      * `--id` — идентификатор ключевой пары электронной подписи.
      * `--access-binding` — назначаемая [роль](../security/index.md#roles-list) и обозначение [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.

          {% cut "Обозначения субъектов" %}

          {% include [subjects-designations-cli](../../_includes/iam/subjects-designations-cli.md) %}

          {% endcut %}

      Для каждой роли передайте отдельный параметр `--access-binding`. Пример:

      ```bash
      yc audit-trails trail set-access-bindings \
        --id <идентификатор_трейла> \
        --access-binding role=<роль1>,subject=<тип_субъекта>:<идентификатор_субъекта> \
        --access-binding role=<роль2>,subject=<тип_субъекта>:<идентификатор_субъекта> \
        --access-binding role=<роль3>,subject=<тип_субъекта>:<идентификатор_субъекта>
      ```

- API {#api}

  Чтобы назначить роли на [трейл](../concepts/trail.md), воспользуйтесь методом REST API [setAccessBindings](../../audit-trails/api-ref/Trail/setAccessBindings.md) для ресурса [Trail](../../audit-trails/api-ref/Trail/index.md) или вызовом gRPC API [TrailService/SetAccessBindings](../../audit-trails/api-ref/grpc/Trail/setAccessBindings.md). Передайте в запросе массив из объектов, каждый из которых соответствует отдельной роли и содержит следующие данные:

   * Роль в параметре `access_bindings[].role_id`.
   * Идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначаются роли, в параметре `access_bindings[].subject.id`.
   * Тип субъекта, которому назначаются роли, в параметре `access_bindings[].subject.type`.

       {% cut "Обозначения субъектов" %}

       {% include [subjects-designations-api](../../_includes/iam/subjects-designations-api.md) %}

       {% endcut %}

{% endlist %}
