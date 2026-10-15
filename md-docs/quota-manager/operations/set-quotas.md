[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Quota Manager](../index.md) > [Пошаговые инструкции](index.md) > Изменить квоты

# Изменить квоты

{% note info %}

Для работы с запросами на изменение квот через CLI и API обратитесь в [службу поддержки](https://center.yandex.cloud/support).

{% endnote %}

В большинстве сервисов квоты действуют на уровне облака. В Resource Manager, Cloud Video и некоторых других сервисах квоты действуют на уровне организации. В IAM есть квоты обоих уровней.

Интерфейсы управления квотами:
* [Cloud Center](https://center.yandex.cloud/quotas) — уровень организации;
* [консоль управления](https://console.yandex.cloud/cloud?section=quotas) — уровень облака;
* [CLI](../cli-ref/index.md) и [API](../api-ref/authentication.md) — уровень организации и облака.

Квоты можно увеличить по запросу в пределах лимитов — технических ограничений платформы.

Для просмотра квот и создания запросов на их изменение [назначьте учетной записи](../../iam/operations/roles/grant.md) роль [quota-manager.requestOperator](../security/index.md#quota-manager-requestoperator). Назначьте роль на облако или организацию, к которым относятся квоты.

## Запросить изменение квоты {#request-quota-change}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы запросить увеличение квот облака:
  
  1. В [консоли управления](https://console.yandex.cloud) выберите облако и на панели слева откройте ![image](../../_assets/console-icons/square-plus.svg) **Квоты**.
  
  1. На вкладке **Список квот**:
  
     * Введите в строку поиска название сервиса, название или идентификатор квоты.
  
     * В группе **Сервисы с потреблением** или **Сервисы без потребления** раскройте раздел нужного сервиса.
  
  1. Отметьте квоты, которые хотите увеличить, и нажмите **Изменить**.
  
  1. Укажите новые значения квот и нажмите **Отправить**.

- Интерфейс Cloud Center {#cloud-center}

  Чтобы запросить увеличение квот организации:
  
  1. В [Cloud Center](https://center.yandex.cloud) выберите организацию и на панели слева откройте ![image](../../_assets/console-icons/square-plus.svg) **Квоты**.
  
  1. На вкладке **Список квот**:
  
     * Введите в строку поиска название сервиса, название или идентификатор квоты.
  
     * В группе **Сервисы с потреблением** или **Сервисы без потребления** раскройте раздел нужного сервиса.
  
  1. Отметьте квоты, которые хотите увеличить, и нажмите **Запросить изменение**.
  
  1. Укажите новые значения квот и нажмите **Отправить**.

- CLI {#cli}

  [Посмотрите идентификатор квоты](../../overview/concepts/quotas-limits.md#quotas-limits-default) и создайте запрос на ее изменение:
  
  ```bash
  yc quota-manager quota-request create \
    --resource-type <тип_ресурса> \
    --resource-id <идентификатор_ресурса> \
    --desired-limit quota-id=<идентификатор_квоты>,value=<новое_значение_квоты>
  ```
  
  Где:
  
  * `--resource-type` — тип ресурса: `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.
  * `--resource-id` — идентификатор ресурса (облака, организации или платежного аккаунта).
  * `--desired-limit` — данные для изменения квоты:
    * `quota-id` — идентификатор квоты.
    * `value` — новое значение, которое нужно присвоить квоте.
  
  В одном запросе можно указать несколько квот. Для этого добавьте несколько параметров `--desired-limit`.

- API {#api}

    Чтобы создать запрос на изменение квот, воспользуйтесь методом REST API [create](../api-ref/QuotaRequest/create.md) для ресурса [QuotaRequest](../api-ref/QuotaRequest/index.md) или вызовом gRPC API [QuotaRequestService/Create](../api-ref/grpc/QuotaRequest/create.md).

{% endlist %}

Также можно запросить увеличение квот через [техническую поддержку](https://center.yandex.cloud/support), указав облако или организацию, квоты и желаемые значения.

Квоты, назначенные по умолчанию, можно посмотреть в документации:

* В [справочнике квот](../all-quotas.md).
* В разделе [обзора платформы](../../overview/concepts/quotas-limits.md#quotas-limits-default).
* На странице **Концепции > Квоты и лимиты** для каждого сервиса.

В Cloud Quota Manager сброс к значениям по умолчанию не предусмотрен.

## Посмотреть статус и операции с запросом на изменение квоты {#view-request-status}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы посмотреть статус и операции с запросом на изменение квоты для облака:

  1. В [консоли управления](https://console.yandex.cloud) выберите облако и на панели слева откройте ![image](../../_assets/console-icons/square-plus.svg) **Квоты**.

  1. Перейдите на вкладку **История запросов**. При необходимости используйте фильтр по статусу.

  1. Откройте нужный запрос, чтобы посмотреть его статус, ответы службы поддержки и список операций.

- Интерфейс Cloud Center {#cloud-center}

  Чтобы посмотреть статус и операции с запросом на изменение квоты для организации:

  1. В [Cloud Center](https://center.yandex.cloud) выберите организацию и на панели слева откройте ![image](../../_assets/console-icons/square-plus.svg) **Квоты**.

  1. Перейдите на вкладку **История запросов**. При необходимости используйте фильтр по статусу.

  1. Откройте нужный запрос, чтобы посмотреть его статус, ответы службы поддержки и список операций.

- CLI {#cli}

  1. Посмотрите список запросов на изменение квот и найдите статус нужного запроса:

     ```bash
     yc quota-manager quota-request list \
       --resource-type <тип_ресурса> \
       --resource-id <идентификатор_ресурса> \
       --limit <количество_запросов>
     ```
     
     Где:
     * `--resource-type` — тип ресурса: `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.
     * `--resource-id` — идентификатор ресурса (облака, организации или платежного аккаунта).
     * `--limit` — количество запросов на странице.

  1. Посмотрите список операций с запросом:

     ```bash
     yc quota-manager quota-request list-operations --id <идентификатор_запроса> --limit <количество_операций>
     ```
     
     Где:
     
     * `--id` — идентификатор запроса, по которому нужно посмотреть операции.
     * `--limit` — максимальное количество операций в выводе.

- API {#api}

    Чтобы посмотреть статус запроса на изменение квот, воспользуйтесь методом REST API [get](../api-ref/QuotaRequest/get.md) для ресурса [QuotaRequest](../api-ref/QuotaRequest/index.md) или вызовом gRPC API [QuotaRequestService/Get](../api-ref/grpc/QuotaRequest/get.md).

    Чтобы посмотреть операции с запросом на изменение квот, воспользуйтесь методом REST API [listOperations](../api-ref/QuotaRequest/listOperations.md) для ресурса [QuotaRequest](../api-ref/QuotaRequest/index.md) или вызовом gRPC API [QuotaRequestService/ListOperations](../api-ref/grpc/QuotaRequest/listOperations.md).

{% endlist %}

## Посмотреть список запросов на изменение квот {#list-quota-requests}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите облако и на панели слева откройте ![image](../../_assets/console-icons/square-plus.svg) **Квоты**.

  1. Перейдите на вкладку **История запросов**. При необходимости используйте фильтры для поиска запросов.

- Интерфейс Cloud Center {#cloud-center}

  1. В [Cloud Center](https://center.yandex.cloud) выберите организацию и на панели слева откройте ![image](../../_assets/console-icons/square-plus.svg) **Квоты**.

  1. Перейдите на вкладку **История запросов**. При необходимости используйте фильтры для поиска запросов.

- CLI {#cli}

  ```bash
  yc quota-manager quota-request list \
    --resource-type <тип_ресурса> \
    --resource-id <идентификатор_ресурса> \
    --limit <количество_запросов>
  ```
  
  Где:
  * `--resource-type` — тип ресурса: `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.
  * `--resource-id` — идентификатор ресурса (облака, организации или платежного аккаунта).
  * `--limit` — количество запросов на странице.

- API {#api}

    Чтобы посмотреть список запросов на изменение квот, воспользуйтесь методом REST API [list](../api-ref/QuotaRequest/list.md) для ресурса [QuotaRequest](../api-ref/QuotaRequest/index.md) или вызовом gRPC API [QuotaRequestService/List](../api-ref/grpc/QuotaRequest/list.md).

{% endlist %}

## Отменить запрос на изменение квоты {#cancel-quota-request}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы отменить запрос на изменение квоты для облака:

  1. В [консоли управления](https://console.yandex.cloud) выберите облако и на панели слева откройте ![image](../../_assets/console-icons/square-plus.svg) **Квоты**.

  1. Перейдите на вкладку **История запросов** и отфильтруйте запросы со статусом **В обработке**.

  1. Откройте нужный запрос и нажмите **Закрыть запрос**.

- Интерфейс Cloud Center {#cloud-center}

  Чтобы отменить запрос на изменение квоты для организации:

  1. В [Cloud Center](https://center.yandex.cloud) выберите организацию и на панели слева откройте ![image](../../_assets/console-icons/square-plus.svg) **Квоты**.

  1. Перейдите на вкладку **История запросов** и отфильтруйте запросы со статусом **В обработке**.

  1. Откройте нужный запрос и нажмите **Закрыть запрос**.

- CLI {#cli}

  ```bash
  yc quota-manager quota-request cancel --id <идентификатор_запроса> --quota-id=<идентификатор_квоты>
  ```
  Где:
  
  * `--id` — идентификатор запроса, который требуется отменить.
  * `--quota-id` — идентификатор квоты в запросе. Чтобы указать несколько квот, добавьте несколько параметров `--quota-id`.

- API {#api}

    Чтобы отменить запрос на изменение квот, воспользуйтесь методом REST API [cancel](../api-ref/QuotaRequest/cancel.md) для ресурса [QuotaRequest](../api-ref/QuotaRequest/index.md) или вызовом gRPC API [QuotaRequestService/Cancel](../api-ref/grpc/QuotaRequest/cancel.md).

{% endlist %}