---
title: Как посмотреть роли, назначенные на рабочий процесс {{ sw-full-name }}
description: Следуя данной инструкции, вы сможете посмотреть роли, назначенные на рабочий процесс {{ sw-name }}.
---

# Посмотреть роли, назначенные на рабочий процесс

{% note info %}

Роли, назначенные на каталог, облако или организацию, автоматически [наследуются](../../../../iam/concepts/access-control/index.md#inheritance) рабочими процессами {{ sw-name }}. При этом они не отображаются в списке ролей, назначенных на них. Подробнее о [просмотре ролей](../../../../iam/operations/roles/get-assigned-roles.md).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  Чтобы посмотреть роли, назначенные на [рабочий процесс](../../../concepts/workflows/workflow.md), выполните команду:

  ```bash
  yc serverless workflow list-access-bindings <имя_или_идентификатор_рабочего_процесса>
  ```

  Результат:

  ```text
  +---------------------------------+----------------+----------------------+
  |             ROLE ID             |  SUBJECT TYPE  |      SUBJECT ID      |
  +---------------------------------+----------------+----------------------+
  | serverless.workflows.admin      | serviceAccount | ajef2lm8ahpc******** |
  | serverless.workflows.viewer     | serviceAccount | rrbilgiqaptv******** |
  | serverless.workflows.executor   | userAccount    | aje9o8d241nl******** |
  +---------------------------------+----------------+----------------------+
  ```

- API {#api}

  Воспользуйтесь методом REST API [listAccessBindings](../../../../serverless-integrations/workflows/api-ref/Workflow/listAccessBindings.md) для ресурса [Workflow](../../../../serverless-integrations/workflows/api-ref/Workflow/index.md) или вызовом gRPC API [WorkflowService/ListAccessBindings](../../../../serverless-integrations/workflows/api-ref/grpc/Workflow/listAccessBindings.md).

{% endlist %}