[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for GitLab](../../index.md) > [Пошаговые инструкции](../index.md) > Остановка и запуск инстанса

# Остановка и запуск инстанса GitLab

При необходимости вы можете остановить [инстанс GitLab](../../concepts/index.md#instance) и запустить его заново. При остановке инстанса все данные в нем сохранятся.

Время простоя остановленного инстанса не тарифицируется: вы продолжаете платить только за объем хранимых данных инстанса и объем резервных копий, которые хранятся в Yandex Object Storage, в соответствии с [тарифом](../../pricing.md#prices-storage).

## Остановить инстанс {#stop-instance}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **Managed Service for&nbsp;GitLab**.
  1. Найдите нужный инстанс в списке, нажмите на значок ![options](../../../_assets/console-icons/ellipsis.svg) и выберите пункт **Остановить**.
  1. В открывшемся диалоге подтвердите остановку инстанса и нажмите кнопку **Остановить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы остановить инстанс GitLab, выполните команду:

  ```bash
  yc managed-gitlab instance stop <имя_или_идентификатор_инстанса>
  ```

  Идентификатор или имя инстанса можно [запросить](instance-list.md#list) со списком инстансов в каталоге.

  Результат:

  ```text
  done (20s)
  id: c17ab1ehdfag********
  folder_id: b1gmm82dtdb3********
  created_at: "2024-01-29T16:11:45.859Z"
  updated_at: "2025-06-25T20:38:41.325Z"
  name: inst-gitlab
  resource_preset_id: s2.micro
  disk_size: "32212254720"
  status: STOPPED
  admin_login: <логин_администратора>
  admin_email: <электронная_почта>
  domain: example.gitlab.yandexcloud.net
  subnet_id: e9bp8qmchqh2********
  backup_retain_period_days: "7"
  approval_rules_id: NONE
  gitlab_version: 17.11.4
  ```

  Подробнее о команде читайте в [справочнике CLI](../../cli-ref/instance/stop.md).

- API {#api}

  Воспользуйтесь методом REST API [Stop](../../api-ref/Instance/stop.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Stop](../../api-ref/grpc/Instance/stop.md).

{% endlist %}

## Запустить инстанс {#start-instance}

Инстанс в статусе **Stopped** можно запустить заново.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **Managed Service for&nbsp;GitLab**.
  1. Найдите нужный остановленный инстанс в списке, нажмите на значок ![options](../../../_assets/console-icons/ellipsis.svg) и выберите пункт **Запустить**.
  1. В открывшемся диалоге подтвердите запуск инстанса нажатием на кнопку **Запустить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы запустить инстанс GitLab, выполните команду:

  ```bash
  yc managed-gitlab instance start <имя_или_идентификатор_инстанса>
  ```

  Идентификатор или имя инстанса можно [запросить](instance-list.md#list) со списком инстансов в каталоге.

  Результат:

  ```text
  done (1m44s)
  id: c17ab1ehdfag********
  folder_id: b1gmm82dtdb3********
  created_at: "2024-01-29T16:11:45.859Z"
  updated_at: "2025-06-25T20:38:41.325Z"
  name: inst-gitlab
  resource_preset_id: s2.micro
  disk_size: "32212254720"
  status: RUNNING
  admin_login: <логин_администратора>
  admin_email: <электронная_почта>
  domain: example.gitlab.yandexcloud.net
  subnet_id: e9bp8qmchqh2********
  backup_retain_period_days: "7"
  approval_rules_id: NONE
  gitlab_version: 17.11.4
  ```

  Подробнее о команде читайте в [справочнике CLI](../../cli-ref/instance/start.md).

- API {#api}

  Воспользуйтесь методом REST API [Start](../../api-ref/Instance/start.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/Start](../../api-ref/grpc/Instance/start.md).

{% endlist %}