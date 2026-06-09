# Отозвать роли, назначенные на рабочий процесс

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

  Воспользуйтесь методом REST API [updateAccessBinding](../../../workflows/api-ref/Workflow/updateAccessBindings.md) для ресурса [Workflow](../../../workflows/api-ref/Workflow/index.md) или вызовом gRPC API [WorkflowService/UpdateAccessBinding](../../../workflows/api-ref/grpc/Workflow/updateAccessBindings.md).

{% endlist %}