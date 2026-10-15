[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Quota Manager](../index.md) > [Пошаговые инструкции](index.md) > Посмотреть список сервисов и квот

# Посмотреть список сервисов и квот

В большинстве сервисов квоты действуют на уровне облака. В Resource Manager, Cloud Video и некоторых других сервисах квоты действуют на уровне организации. В IAM есть квоты обоих уровней.

Интерфейсы управления квотами:
* [Cloud Center](https://center.yandex.cloud/quotas) — уровень организации;
* [консоль управления](https://console.yandex.cloud/cloud?section=quotas) — уровень облака;
* [CLI](../cli-ref/index.md) и [API](../api-ref/authentication.md) — уровень организации и облака.

Для просмотра квот [назначьте учетной записи](../../iam/operations/roles/grant.md) роль [quota-manager.viewer](../security/index.md#quota-manager-viewer) или [quota-manager.requestOperator](../security/index.md#quota-manager-requestoperator). Назначьте роль на облако или организацию, к которым относятся квоты.

## Посмотреть список сервисов, для которых есть квоты {#list-services}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы посмотреть список сервисов с квотами в облаке:

  1. В [консоли управления](https://console.yandex.cloud) выберите облако и на панели слева откройте ![image](../../_assets/console-icons/square-plus.svg) **Квоты**.

     На вкладке **Список квот** отобразится список сервисов в группах **Сервисы с потреблением** и **Сервисы без потребления**.

- Интерфейс Cloud Center {#cloud-center}

  Чтобы посмотреть список сервисов с квотами в организации:

  1. В [Cloud Center](https://center.yandex.cloud) выберите организацию и на панели слева откройте ![image](../../_assets/console-icons/square-plus.svg) **Квоты**.

     На вкладке **Список квот** отобразится список сервисов в группах **Сервисы с потреблением** и **Сервисы без потребления**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Выполните команду:

  ```bash
  yc quota-manager quota-limit list-services --resource-type=<тип_ресурса>
  ```

  Где `--resource-type` — [тип ресурса](../concepts/index.md#resources-types): `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.

- API {#api}

    Чтобы получить список сервисов, воспользуйтесь методом REST API [listServices](../api-ref/QuotaLimit/listServices.md) для ресурса [QuotaLimit](../api-ref/QuotaLimit/index.md) или вызовом gRPC API [QuotaLimitService/ListServices](../api-ref/grpc/QuotaLimit/listServices.md).

{% endlist %}

## Посмотреть квоты для сервиса {#list-service-quotas}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы посмотреть квоты для сервиса в облаке:

  1. В [консоли управления](https://console.yandex.cloud) выберите облако и на панели слева откройте ![image](../../_assets/console-icons/square-plus.svg) **Квоты**.

  1. На вкладке **Список квот** введите в строку поиска название сервиса, название или идентификатор квоты.

  1. В группе **Сервисы с потреблением** или **Сервисы без потребления** раскройте раздел нужного сервиса.

- Интерфейс Cloud Center {#cloud-center}

  Чтобы посмотреть квоты для сервиса в организации:

  1. В [Cloud Center](https://center.yandex.cloud) выберите организацию и на панели слева откройте ![image](../../_assets/console-icons/square-plus.svg) **Квоты**.

  1. На вкладке **Список квот** введите в строку поиска название сервиса, название или идентификатор квоты.

  1. В группе **Сервисы с потреблением** или **Сервисы без потребления** раскройте раздел нужного сервиса.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Выполните команду:

  ```bash
  yc quota-manager quota-limit list \
    --service=<название_сервиса> \
    --resource-type=<тип_ресурса> \
    --resource-id=<идентификатор_ресурса>
  ```

  Где:

  * `--service` — идентификатор сервиса, полученный при [просмотре списка сервисов](#list-services).
  * `--resource-id` — идентификатор [ресурса](../../resource-manager/concepts/resources-hierarchy.md): идентификатор облака, организации или платежного аккаунта.
  * `--resource-type` — тип ресурса: `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.


  Пример:

  ```bash
  yc quota-manager quota-limit list \
    --service=compute \
    --resource-type=resource-manager.cloud \
    --resource-id=b1gia87mbaom********
  ```

  Будет выведен список квот сервиса Compute Cloud в облаке `b1gia87mbaom********`:

  ```bash
  resource:
    id: b1gia87mbaom********
    type: resource-manager.cloud
  quota_limits:
    - quota_id: compute.dedicatedHosts.count
      limit: 1
      usage: 0
    - quota_id: compute.diskPlacementGroups.count
      limit: 5
      usage: 1
    - quota_id: compute.diskPools.count
      limit: 0
      usage: 0
    - quota_id: compute.disks.count
      limit: 64
      usage: 30
    - quota_id: compute.filesystems.count
      limit: 100
      usage: 1
    - quota_id: compute.hddDisks.size
      limit: 1116691496960
      usage: 464930209792
  ...
  ```

  Где:

  * `limit` — значение квоты;
  * `usage` — потребление квоты.

- API {#api}

    Чтобы получить список квот для определенного сервиса, воспользуйтесь методом REST API [list](../api-ref/QuotaLimit/list.md) для ресурса [QuotaLimit](../api-ref/QuotaLimit/index.md) или вызовом gRPC API [QuotaLimitService/List](../api-ref/grpc/QuotaLimit/list.md).

{% endlist %}