---
title: Как назначить роли на рабочий процесс {{ sw-full-name }}
description: Следуя данной инструкции, вы сможете назначить роли на рабочий процесс {{ sw-name }}.
---

# Назначить роли на рабочий процесс

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  Выполните команду, чтобы назначить роль на [рабочий процесс](../../../concepts/workflows/workflow.md):

  * пользователю:

      ```bash
      yc serverless workflow add-access-binding <имя_или_идентификатор_рабочего_процесса> \
        --user-account-id <идентификатор_пользователя> \
        --role <роль>
      ```

  * [сервисному аккаунту](../../../../iam/concepts/users/service-accounts.md):

      ```bash
      yc serverless workflow add-access-binding <имя_или_идентификатор_рабочего_процесса> \
        --service-account-id <идентификатор_сервисного_аккаунта> \
        --role <роль>
      ```

  * всем авторизованным пользователям ([публичная группа](../../../../iam/concepts/access-control/public-group.md) `All authenticated users`):

      ```bash
      yc serverless workflow add-access-binding <имя_или_идентификатор_рабочего_процесса> \
        --all-authenticated-users \
        --role <роль>
      ```

  **Пример**

  Назначить роль сервисному аккаунту на рабочий процесс:

  ```bash
  yc serverless workflow add-access-binding epdplu8jn7sr******** \
    --service-account-id rrbilgiqaptv******** \
    --role serverless.workflows.auditor
  ```

  Результат:

  ```text
  ...1s...done (3s)
  ```

- API {#api}

  Воспользуйтесь методом REST API [setAccessBinding](../../../../serverless-integrations/workflows/api-ref/Workflow/setAccessBindings.md) для ресурса [Workflow](../../../../serverless-integrations/workflows/api-ref/Workflow/index.md) или вызовом gRPC API [WorkflowService/SetAccessBinding](../../../../serverless-integrations/workflows/api-ref/grpc/Workflow/setAccessBindings.md).

{% endlist %}