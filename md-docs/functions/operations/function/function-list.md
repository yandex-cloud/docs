# Получить список функций

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите посмотреть список функций.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/curly-brackets-function.svg) **{{ ui-key.yacloud.serverless-functions.switch_list }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить список функций, выполните команду:

  ```bash
  yc serverless function list
  ```

  Результат:

  ```text
  +----------------------+--------------------+----------------------+--------+
  |          ID          |        NAME        |      FOLDER ID       | STATUS |
  +----------------------+--------------------+----------------------+--------+
  | b097d9ous3ge******** | my-beta-function   | aoek49ghmknn******** | ACTIVE |
  +----------------------+--------------------+----------------------+--------+
  ```

- API {#api}

  Чтобы получить список функций, воспользуйтесь методом REST API [list](../../functions/api-ref/Function/list.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionsService/List](../../functions/api-ref/grpc/Function/list.md).


{% endlist %}