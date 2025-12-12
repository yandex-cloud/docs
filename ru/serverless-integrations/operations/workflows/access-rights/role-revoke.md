---
title: Как отозвать роли, назначенные на рабочий процесс {{ sw-full-name }}
description: Следуя данной инструкции, вы сможете отозвать роли, назначенные на рабочий процесс {{ sw-name }}.
---

# Отозвать роли, назначенные на рабочий процесс

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../../_includes/default-catalogue.md) %}

  Выполните команду, чтобы отозвать роль на [рабочий процесс](../../../concepts/workflows/workflow.md):

  * у пользователя:

      ```bash
      yc serverless workflow remove-access-binding <имя_или_идентификатор_рабочего_процесса> \
        --user-account-id <идентификатор_пользователя> \
        --role <роль>
      ```

  * у [сервисного аккаунта](../../../../iam/concepts/users/service-accounts.md):

      ```bash
      yc serverless workflow remove-access-binding <имя_или_идентификатор_рабочего_процесса> \
        --service-account-id <идентификатор_сервисного_аккаунта> \
        --role <роль>
      ```

  * у всех авторизованных пользователей ([публичная группа](../../../../iam/concepts/access-control/public-group.md) `All authenticated users`):

      ```bash
      yc serverless workflow remove-access-binding <имя_или_идентификатор_рабочего_процесса> \
        --all-authenticated-users \
        --role <роль>
      ```

  **Пример**

  Отозвать роль у сервисного аккаунта на рабочем процессе:

  ```bash
  yc serverless workflow remove-access-binding epdplu8jn7sr******** \
    --service-account-id rrbilgiqaptv******** \
    --role serverless.workflows.auditor
  ```

  Результат:

  ```text
  ...1s...done (3s)
  ```

- API {#api}

  Воспользуйтесь методом REST API [updateAccessBinding](../../../../serverless-integrations/workflows/api-ref/Workflow/updateAccessBindings.md) для ресурса [Workflow](../../../../serverless-integrations/workflows/api-ref/Workflow/index.md) или вызовом gRPC API [WorkflowService/UpdateAccessBinding](../../../../serverless-integrations/workflows/api-ref/grpc/Workflow/updateAccessBindings.md).

{% endlist %}