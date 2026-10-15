[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Quota Manager](../index.md) > [Пошаговые инструкции](index.md) > Посмотреть значение квоты

# Посмотреть значение квоты

В большинстве сервисов квоты действуют на уровне облака. В Resource Manager, Cloud Video и некоторых других сервисах квоты действуют на уровне организации. В IAM есть квоты обоих уровней.

Интерфейсы управления квотами:
* [Cloud Center](https://center.yandex.cloud/quotas) — уровень организации;
* [консоль управления](https://console.yandex.cloud/cloud?section=quotas) — уровень облака;
* [CLI](../cli-ref/index.md) и [API](../api-ref/authentication.md) — уровень организации и облака.

Для просмотра квот [назначьте учетной записи](../../iam/operations/roles/grant.md) роль [quota-manager.viewer](../security/index.md#quota-manager-viewer) или [quota-manager.requestOperator](../security/index.md#quota-manager-requestoperator). Назначьте роль на облако или организацию, к которым относятся квоты.

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы посмотреть значение квоты на уровне облака:

  1. В [консоли управления](https://console.yandex.cloud) выберите облако и на панели слева откройте ![image](../../_assets/console-icons/square-plus.svg) **Квоты**.
  
  1. На вкладке **Список квот**:
     
     * Введите в строку поиска название сервиса, название или идентификатор квоты.
  
     * В группе **Сервисы с потреблением** или **Сервисы без потребления** раскройте раздел нужного сервиса.
  
  1. В строке квоты посмотрите значение в столбце **Использование**:
  
     * Два числа — `потребление квоты / значение квоты`. Например, `2 / 20`.
     * Одно число — `лимит`, изменить его нельзя.
  
  1. Чтобы показать только сервисы, в которых квоты близки к исчерпанию, вверху нажмите **Почти закончились**.

- Интерфейс Cloud Center {#cloud-center}

  Чтобы посмотреть значение квоты на уровне организации:

  1. В [Cloud Center](https://center.yandex.cloud) выберите организацию и на панели слева откройте ![image](../../_assets/console-icons/square-plus.svg) **Квоты**.
  
  1. На вкладке **Список квот**:
     
     * Введите в строку поиска название сервиса, название или идентификатор квоты.
  
     * В группе **Сервисы с потреблением** или **Сервисы без потребления** раскройте раздел нужного сервиса.
  
  1. Посмотрите значение в столбце **Использование**:
  
     * Два числа — `потребление квоты / значение квоты`. Например, `2 / 20`.
     * Одно число — `лимит`, изменить его нельзя.
  
  1. Чтобы показать только сервисы, в которых квоты близки к исчерпанию, вверху нажмите **Почти закончились**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`.
  
  Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Выполните команду:

  ```bash
  yc quota-manager quota-limit get \
    --quota-id=<идентификатор_квоты> \
    --resource-id <идентификатор_ресурса> \
    --resource-type <тип_ресурса>
  ```

  Где:

  * `--quota-id` — идентификатор квоты, полученный при [просмотре списка квот](list-quotas.md#list-service-quotas) для сервиса.
  * `--resource-id` — идентификатор [ресурса](../../resource-manager/concepts/resources-hierarchy.md): идентификатор облака, организации или платежного аккаунта.
  * `--resource-type` — [тип ресурса](../concepts/index.md#resources-types): `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.

  Пример:

  ```bash
  yc quota-manager quota-limit get --quota-id=compute.disks.count --resource-id=b1gia87mbaom********  --resource-type=resource-manager.cloud
  ```

  Будут выведены значение и потребление квоты на количество дисков в сервисе Compute Cloud в облаке `b1gia87mbaom********`:

  ```bash
  quota_id: compute.disks.count
  limit: 64
  usage: 30
  ```

  Где:

  * `limit` — значение квоты;
  * `usage` — потребление квоты.

- API {#api}

    Чтобы посмотреть значение и потребление квоты, воспользуйтесь методом REST API [get](../api-ref/QuotaLimit/get.md) для ресурса [QuotaLimit](../api-ref/QuotaLimit/index.md) или вызовом gRPC API [QuotaLimitService/Get](../api-ref/grpc/QuotaLimit/get.md).

{% endlist %}