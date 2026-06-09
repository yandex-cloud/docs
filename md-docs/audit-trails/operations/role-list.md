# Посмотреть роли, назначенные на трейл

{% note info %}

[Роли](../security/index.md#roles-list), назначенные на каталог, облако или организацию, автоматически [наследуются](../../iam/concepts/access-control/index.md#inheritance) трейлом. При этом они не отображаются в списке ролей, назначенных на него. Подробнее о [просмотре ролей](../../iam/operations/roles/get-assigned-roles.md).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для просмотра [ролей](../security/index.md#roles-list), назначенных на [трейл](../concepts/trail.md):

      ```bash
      yc audit-trails trail list-access-bindings --help
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

  Чтобы посмотреть роли, назначенные на [трейл](../concepts/trail.md), воспользуйтесь методом REST API [listAccessBindings](../api-ref/Trail/listAccessBindings.md) для ресурса [Trail](../api-ref/Trail/index.md) или вызовом gRPC API [TrailService/ListAccessBindings](../api-ref/grpc/Trail/listAccessBindings.md).

{% endlist %}