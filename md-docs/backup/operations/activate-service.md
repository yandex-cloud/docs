# Активировать сервис


Чтобы активировать сервис, у вас должна быть _минимальная_ [роль](../security/index.md#backup-user) `backup.user` на [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором вы хотите создавать резервные копии ВМ или серверов BareMetal.

Активация сервиса запускает работу провайдера резервного копирования. Подробнее о провайдере резервного копирования и передаваемых ему данных смотрите в разделе [Активация сервиса и провайдер резервного копирования](../concepts/index.md#providers).

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы хотите создать ВМ или сервер Yandex BareMetal с подключением к Cloud Backup.
  1. Перейдите в сервис **Cloud Backup**.
  1. Нажмите кнопку **Активировать**.

      Если кнопки **Активировать** нет, и вам доступно создание ВМ с подключением к Cloud Backup, значит, сервис уже активирован.

  После активации автоматически создаются следующие политики резервного копирования:
  * `Default daily` — ежедневное создание инкрементальной копии с сохранением последних 15 копий.
  * `Default weekly` — еженедельное создание инкрементальной копии с сохранением последних 15 копий.
  * `Default monthly` — ежемесячное создание инкрементальной копии с сохранением последних 15 копий.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).
  
  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
  
  1. Посмотрите описание команды [CLI](../../cli/index.md) для активации сервиса:
  
     ```bash
     yc backup provider activate --help
     ```
  
  1. Активируйте сервис в каталоге по умолчанию:
  
     ```bash
     yc backup provider activate --async
     ```
  
     Где `--async` — отображение информации о прогрессе операции. Необязательный параметр.
  
  1. После выполнения команды появится предупреждение об активации `This command will activate backup provider for your folder. Do you confirm this action to be executed? [Yes/no][y/N]`. Подтвердите активацию — в терминале введите `yes` или `y`.
  
     {% note tip %}
  
     Чтобы активировать сервис без подтверждения, используйте флаг `--force`.
  
     {% endnote %}
  
     Результат:
  
     ```text
     id: cdgmnefxiatx********
     description: activate provider
     created_at: "2024-10-14T09:03:47.960564Z"
     created_by: ajec1gaqcmtr********
     modified_at: "2024-10-14T09:03:47.960564Z"
     done: true
     metadata:
       '@type': type.googleapis.com/yandex.cloud.backup.v1.ActivateProviderMetadata
       folder_id: b1go3el0d8fs********
     response:
       '@type': type.googleapis.com/google.protobuf.Empty
       value: {}
     ```
  
  После активации автоматически создаются следующие политики резервного копирования:
  * `Default daily` — ежедневное создание инкрементальной копии с сохранением последних 15 копий.
  * `Default weekly` — еженедельное создание инкрементальной копии с сохранением последних 15 копий.
  * `Default monthly` — ежемесячное создание инкрементальной копии с сохранением последних 15 копий.
  
  Если вы не хотите их создавать, используйте параметр `--skip-default-policy`.

- API {#api}

  Воспользуйтесь методом REST API [Activate](../backup/api-ref/Provider/activate.md) для ресурса [Provider](../backup/api-ref/Provider/index.md) или вызовом gRPC API [ProviderService/Activate](../backup/api-ref/grpc/Provider/activate.md).

{% endlist %}