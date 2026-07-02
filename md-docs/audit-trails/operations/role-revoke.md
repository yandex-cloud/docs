[Документация Yandex Cloud](../../index.md) > [Yandex Audit Trails](../index.md) > [Пошаговые инструкции](index.md) > Управление правами доступа к трейлу > Отозвать роли, назначенные на трейл

# Отозвать роли, назначенные на трейл

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для отзыва [ролей](../security/index.md#roles-list), назначенных на [трейл](../concepts/trail.md):

      ```bash
      yc audit-trails trail remove-access-binding --help
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
  1. Выполните команду, чтобы отозвать роль, назначенную на трейл.

      * У пользователя:

          ```bash
          yc audit-trails trail remove-access-binding \
            --id <идентификатор_трейла> \
            --user-account-id <идентификатор_пользователя> \
            --role <роль>
          ```
          
          Результат:

          ```text
          done (1s)
          ```

      * У [сервисного аккаунта](../../iam/concepts/users/service-accounts.md):

          ```bash
          yc audit-trails trail remove-access-binding \
            --id <идентификатор_трейла> \
            --service-account-id <идентификатор_сервисного_аккаунта> \
            --role <роль>
          ```

          Результат:

          ```text
          done (1s)
          ```

      * У всех авторизованных пользователей ([публичная группа](../../iam/concepts/access-control/public-group.md) `All authenticated users`):

          ```bash
          yc audit-trails trail remove-access-binding \
            --id <идентификатор_трейла> \
            --all-authenticated-users \
            --role <роль>
          ```

          Результат:
        
          ```text
          done (1s)
          ```

- API {#api}

  Чтобы отозвать роли, назначенные на [трейл](../concepts/trail.md), воспользуйтесь методом REST API [updateAccessBindings](../api-ref/Trail/updateAccessBindings.md) для ресурса [Trail](../api-ref/Trail/index.md) или вызовом gRPC API [TrailService/UpdateAccessBindings](../api-ref/grpc/Trail/updateAccessBindings.md).

{% endlist %}