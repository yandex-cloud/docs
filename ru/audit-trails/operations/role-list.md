---
title: Как посмотреть роли, назначенные на трейл
description: Следуя данной инструкции, вы сможете посмотреть роли, назначенные на трейл.
---

# Посмотреть роли, назначенные на трейл

{% note info %}

[Роли](../security/index.md#roles-list), назначенные на каталог, облако или организацию, автоматически [наследуются](../../iam/concepts/access-control/index.md#inheritance) трейлом. При этом они не отображаются в списке ролей, назначенных на него. Подробнее о [просмотре ролей](../../iam/operations/roles/get-assigned-roles.md).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для просмотра [ролей](../security/index.md#roles-list), назначенных на [трейл](../concepts/trail.md):

      ```bash
      yc audit-trails trail list-access-bindings --help
      ```

  1. {% include [get-list](../../_includes/audit-trails/get-list.md) %}
  1. Посмотрите роли, назначенные на трейл, указав его имя или идентификатор:

      ```bash
      yc audit-trails trail list-access-bindings <имя_или_идентификатор_трейла>
      ```

      Результат:

      ```text
      +---------------------+--------------+-----------------------+
      |       ROLE ID       | SUBJECT TYPE |      SUBJECT ID       |
      +---------------------+--------------+-----------------------+
      | audit-trails.viewer | system       | allAuthenticatedUsers |
      +---------------------+--------------+-----------------------+
      ```

- API {#api}

  Чтобы посмотреть роли, назначенные на [трейл](../concepts/trail.md), воспользуйтесь методом REST API [listAccessBindings](../../audit-trails/api-ref/Trail/listAccessBindings.md) для ресурса [Trail](../../audit-trails/api-ref/Trail/index.md) или вызовом gRPC API [TrailService/ListAccessBindings](../../audit-trails/api-ref/grpc/Trail/listAccessBindings.md).

{% endlist %}