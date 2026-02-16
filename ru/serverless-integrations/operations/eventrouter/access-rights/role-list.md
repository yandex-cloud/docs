---
title: Как посмотреть роли, назначенные на ресурс {{ er-full-name }}
description: Следуя данной инструкции, вы сможете посмотреть роли, назначенные на ресурс {{ er-name }}.
---

# Посмотреть роли, назначенные на ресурс {{ er-name }}

{% note info %}

Роли, назначенные на каталог, облако или организацию, автоматически [наследуются](../../../../iam/concepts/access-control/index.md#inheritance) ресурсами {{ er-name }}. При этом они не отображаются в списке ролей, назначенных на них. Подробнее о [просмотре ролей](../../../../iam/operations/roles/get-assigned-roles.md).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  Чтобы посмотреть роли, назначенные на ресурс {{ er-name }}, выполните команду:

  ```bash
  yc serverless <тип_ресурса> list-access-bindings <имя_или_идентификатор_ресурса>
  ```

  **Пример**

  Посмотреть роли, назначенные на [шину](../../../concepts/eventrouter/bus.md):

  ```bash
  yc serverless eventrouter bus list-access-bindings epdplu8jn7sr********
  ```

  Результат:

  ```text
  +---------------------------------+----------------+----------------------+
  |             ROLE ID             |  SUBJECT TYPE  |      SUBJECT ID      |
  +---------------------------------+----------------+----------------------+
  | serverless.eventrouter.admin    | serviceAccount | ajef2lm8ahpc******** |
  | serverless.eventrouter.auditor  | serviceAccount | rrbilgiqaptv******** |
  +---------------------------------+----------------+----------------------+
  ```

- API {#api}

  Воспользуйтесь методом REST API `listAccessBindings` для соответствующего ресурса или вызовом gRPC API `<сервис>/ListAccessBindings`.

  Например, для [шины](../../../concepts/eventrouter/bus.md) воспользуйтесь методом REST API [listAccessBindings](../../../../serverless-integrations/eventrouter/api-ref/Bus/listAccessBindings.md) для ресурса [Bus](../../../../serverless-integrations/eventrouter/api-ref/Bus/index.md) или вызовом gRPC API [BusService/ListAccessBindings](../../../../serverless-integrations/eventrouter/api-ref/grpc/Bus/listAccessBindings.md).

{% endlist %}