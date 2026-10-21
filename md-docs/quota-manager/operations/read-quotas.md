[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Quota Manager](../index.md) > [Пошаговые инструкции](index.md) > Посмотреть значение квоты

# Посмотреть значение квоты

Для просмотра квот [назначьте учетной записи](../../iam/operations/roles/grant.md) роль [quota-manager.viewer](../security/index.md#quota-manager-viewer) на облако или организацию, к которым относятся квоты.

Интерфейсы управления квотами:

* [Cloud Center](https://center.yandex.cloud/quotas) — уровень организации.
* [Консоль управления](https://console.yandex.cloud/cloud?section=quotas) — уровень облака.
* [CLI](../cli-ref/index.md) и [API](../api-ref/authentication.md) — уровень организации и облака. Для работы с запросами на изменение квот через CLI и API обратитесь в [службу поддержки](https://center.yandex.cloud/support).

В большинстве сервисов квоты действуют на уровне облака. В Resource Manager, Cloud Video и некоторых других сервисах квоты действуют на уровне организации. В IAM есть квоты обоих уровней.

{% list tabs group=instructions %}

- Консоль управления или Cloud Center {#console}

  Чтобы посмотреть значение и потребление квоты:

  1. Выберите облако в [консоли управления](https://console.yandex.cloud) или организацию в [Cloud Center](https://center.yandex.cloud).
  
  1. На панели слева откройте ![image](../../_assets/console-icons/square-plus.svg) **Квоты**.
  
  1. На вкладке **Список квот** введите в строку поиска название сервиса, название или идентификатор квоты.
  
  1. Раскройте нужный сервис в одной из групп:
  
     * **Сервисы с потреблением** — потребление хотя бы одной квоты больше нуля.
     * **Сервисы без потребления** — потребление всех квот равно нулю.
  
  1. В строке квоты посмотрите столбец **Использование**:
  
     * Числа — [потребление квоты](*quota-usage) / [значение квоты](*quota-limit).
     * **Квота не выделена** — значение квоты не установлено.
  
  1. Чтобы показать только сервисы, в которых квоты близки к исчерпанию, вверху нажмите **Почти закончились**.
  
  Если квоты близки к исчерпанию или не выделены, на этой же странице можно [запросить их изменение](set-quotas.md#request-quota-change).

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
  * `--resource-id` — идентификатор [ресурса](../../resource-manager/concepts/resources-hierarchy.md): идентификатор облака или организации.
  * `--resource-type` ([тип ресурса](../concepts/index.md#resources-types)) определяет уровень просмотра квот. Для уровня облака укажите `resource-manager.cloud`, для уровня организации — `organization-manager.organization`.

  Пример:

  ```bash
  yc quota-manager quota-limit get --quota-id=compute.disks.count --resource-id=b1gia87mbaom******** --resource-type=resource-manager.cloud
  ```

  Будут выведены значение и потребление квоты на количество дисков в сервисе Compute Cloud в облаке `b1gia87mbaom********`:

  ```text
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

[*quota-usage]: #### {#quota-usage}
                
                Потребление квоты — объем фактически используемого ресурса. Подробнее в разделе [Концепции Cloud Quota Manager](../concepts/index.md).
                
                #### {#quota-limit}
                
                Значение квоты — установленная верхняя граница потребления ресурса. Подробнее в разделе [Концепции Cloud Quota Manager](../concepts/index.md).

[*quota-limit]: #### {#quota-usage}
                
                Потребление квоты — объем фактически используемого ресурса. Подробнее в разделе [Концепции Cloud Quota Manager](../concepts/index.md).
                
                #### {#quota-limit}
                
                Значение квоты — установленная верхняя граница потребления ресурса. Подробнее в разделе [Концепции Cloud Quota Manager](../concepts/index.md).