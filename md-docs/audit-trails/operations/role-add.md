# Назначить роли на трейл

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для назначения [ролей](../security/index.md#roles-list) на [трейл](../concepts/trail.md):

      ```bash
      yc audit-trails trail set-access-bindings --help
      ```

  1. Получите список трейлов:
     
     ```bash
     yc audit-trails trail list
     ```
     
     Результат:
     
     ```text
     +----------------------+--------------+--------+-------------------+
     |          ID          |     NAME     | STATUS |      FILTERS      |
     +----------------------+--------------+--------+-------------------+
     | cnp82sb0phnm******** | trailfromapi | ACTIVE | storage compute   |
     |                      |              |        | management.events |
     | cnp8v52idttr******** | tf-trail     | ACTIVE | storage compute   |
     |                      |              |        | mdb.postgresql    |
     | cnpnkcubr529******** | test-2       | ACTIVE | compute           |
     +----------------------+--------------+--------+-------------------+
     ```
  1. Выполните команду, чтобы назначить роль на трейл:

      * Пользователю:

          ```bash
          yc audit-trails trail set-access-bindings \
            --id <идентификатор_трейла> \
            --access-binding role=<роль>,user-account-id=<идентификатор_пользователя>
          ```

          ```text
          done (1s)
          ```

      * [Сервисному аккаунту](../../iam/concepts/users/service-accounts.md):

          ```bash
          yc audit-trails trail set-access-bindings \
            --id <идентификатор_трейла> \
            --access-binding role=<роль>,service-account-id=<идентификатор_сервисного_аккаунта>
          ```

          ```text
          done (1s)
          ```

      * Всем авторизованным пользователям ([публичная группа](../../iam/concepts/access-control/public-group.md) `All authenticated users`):

          ```bash
          yc audit-trails trail set-access-bindings \
            --id <идентификатор_трейла> \
            --access-binding role=<роль>,all-authenticated-users
          ```

          ```text
          done (1s)
          ```

- API {#api}

  Чтобы назначить роли на [трейл](../concepts/trail.md), воспользуйтесь методом REST API [setAccessBindings](../api-ref/Trail/setAccessBindings.md) для ресурса [Trail](../api-ref/Trail/index.md) или вызовом gRPC API [TrailService/SetAccessBindings](../api-ref/grpc/Trail/setAccessBindings.md).

{% endlist %}