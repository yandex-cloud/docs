# Назначить роли на рабочий процесс

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

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

  Воспользуйтесь методом REST API [setAccessBinding](../../../workflows/api-ref/Workflow/setAccessBindings.md) для ресурса [Workflow](../../../workflows/api-ref/Workflow/index.md) или вызовом gRPC API [WorkflowService/SetAccessBinding](../../../workflows/api-ref/grpc/Workflow/setAccessBindings.md).

{% endlist %}