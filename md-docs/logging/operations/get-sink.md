# Получить информацию о приемнике логов

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится приемник логов.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_logging }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/folder-arrow-down.svg) **{{ ui-key.yacloud.logging.label_sinks }}**.
  1. Выберите приемник.
  1. На странице **{{ ui-key.yacloud.common.overview }}** отобразится подробная информация о приемнике.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы узнать имя или идентификатор приемника логов, [получите](list-sink.md) список приемников в каталоге.

  Чтобы получить информацию о приемнике логов, выполните команду:

  ```bash
  yc logging sink get <имя_приемника>
  ```

  Результат:

  ```text
  id: e23e73lehbfv********
  folder_id: b1gmit33ngp3********
  cloud_id: b1gia87mbaom********
  created_at: "2023-11-07T09:22:28.946Z"
  name: test-sink
  service_account_id: ajejeis235ma********
  s3:
    bucket: test-bucket
  ```

- API {#api}

  Чтобы получить подробную информацию о приемнике логов, воспользуйтесь методом REST API [get](../api-ref/Sink/get.md) для ресурса [Sink](../api-ref/Sink/index.md) или вызовом gRPC API [SinkService/Get](../api-ref/grpc/Sink/get.md).

{% endlist %}