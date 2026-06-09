# Сделать ревизию активной

При вызове контейнера запускается [активная ревизия](../concepts/container.md#revision).

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
  1. Выберите контейнер.
  1. В строке с нужной ревизией нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) и в выпадающем списке выберите **{{ ui-key.yacloud.serverless-containers.label_edit-active-revision }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.serverless-containers.popup-confirm-edit-active-revision_button_confirm }}**. Статус ревизии изменится с `Obsolete` на `Active`.
  

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы узнать имя или уникальный идентификатор ревизии контейнера, [получите](revision-list.md) список ревизий контейнера в каталоге.

  Чтобы сделать ревизию контейнера активной, выполните команду:

  ```bash
  yc serverless containers rollback \
   --name <имя_контейнера> \
   --revision-id <идентификатор_ревизии>
  ```

  Где:

  * `--name` — имя контейнера, активную ревизию которого вы хотите изменить.
  * `--revision-id` — идентификатор ревизии контейнера, которую вы хотите сделать активной.

  Результат:

  ```text
  id: bba610kqnj8b********
  folder_id: b1g3f9i71bpm********
  created_at: "2023-11-15T12:49:49.795Z"
  name: container
  url: https://bba610kqnj8b********.containers.yandexcloud.net/
  status: ACTIVE
  ```

- API {#api}

  Чтобы сделать ревизию контейнера активной, воспользуйтесь методом REST API [rollback](../containers/api-ref/Container/rollback.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/Rollback](../containers/api-ref/grpc/Container/rollback.md).

{% endlist %}