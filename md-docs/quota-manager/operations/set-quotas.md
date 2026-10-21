[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Quota Manager](../index.md) > [Пошаговые инструкции](index.md) > Изменить квоты

# Изменить квоты

Квоты можно увеличить по запросу в пределах лимитов — технических ограничений платформы.

Чтобы запрашивать изменение квот, [назначьте учетной записи](../../iam/operations/roles/grant.md) роль [quota-manager.requestOperator](../security/index.md#quota-manager-requestoperator) на облако или организацию.

Интерфейсы просмотра и запроса квот:

* [Cloud Center](https://center.yandex.cloud/quotas) — ссылка на страницу квот последней выбранной организации.
* [Консоль управления](https://console.yandex.cloud/cloud?section=quotas) — ссылка на страницу квот последнего выбранного облака.
* [CLI](../cli-ref/index.md) и [API](../api-ref/authentication.md) — управление квотами организаций и облаков. Для работы с запросами на изменение квот обратитесь в [службу поддержки](https://center.yandex.cloud/support).

В большинстве сервисов квоты действуют на уровне облака. В Resource Manager, Cloud Video и некоторых других сервисах квоты действуют на уровне организации. В IAM есть квоты обоих уровней.

## Запросить изменение квоты {#request-quota-change}

{% list tabs group=instructions %}

- Консоль управления или Cloud Center {#console}

  1. Выберите облако в [консоли управления](https://console.yandex.cloud) или организацию в [Cloud Center](https://center.yandex.cloud).
  
  1. На панели слева откройте ![image](../../_assets/console-icons/square-plus.svg) **Квоты**.
  
  1. На вкладке **Список квот**:
  
     * Введите в строку поиска название сервиса, название или идентификатор квоты.
  
     * В группе **Сервисы с потреблением** или **Сервисы без потребления** раскройте раздел нужного сервиса.
  
  1. Отметьте квоты, которые хотите увеличить, и нажмите **Изменить**.
  
  1. Укажите новые значения квот и нажмите **Отправить**.
  
  1. Дождитесь рассмотрения запроса.

- CLI {#cli}

  [Посмотрите идентификатор квоты](../all-quotas.md) и создайте запрос на ее изменение:
  
  ```bash
  yc quota-manager quota-request create \
    --resource-type <тип_ресурса> \
    --resource-id <идентификатор_ресурса> \
    --desired-limit quota-id=<идентификатор_квоты>,value=<новое_значение_квоты>
  ```
  
  Где:
  
  * `--resource-type` ([тип ресурса](../concepts/index.md#resources-types)) определяет уровень изменения квот. Для уровня облака укажите `resource-manager.cloud`, для уровня организации — `organization-manager.organization`.
  * `--resource-id` — идентификатор ресурса (облака или организации).
  * `--desired-limit` — данные для изменения квоты:
    * `quota-id` — идентификатор квоты.
    * `value` — желаемое итоговое значение квоты.
  
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

Проверьте [статус запроса и результат изменения каждой квоты](../concepts/index.md#quota-request-statuses):

{% list tabs group=instructions %}

- Консоль управления или Cloud Center {#console}

  1. Выберите облако в [консоли управления](https://console.yandex.cloud) или организацию в [Cloud Center](https://center.yandex.cloud).
  
  1. На панели слева откройте ![image](../../_assets/console-icons/square-plus.svg) **Квоты**.
  
  1. Перейдите на вкладку **История запросов**. При необходимости используйте фильтр по статусу.
  
  1. Раскройте нужный запрос. Его статус указан рядом с номером, а в строке каждой квоты отображаются:
  
     * **Запрошено** — запрошенное итоговое значение квоты.
     * **Утверждено** — значение, согласованное по результатам рассмотрения.
     * **Статус** — [статус изменения квоты](../concepts/index.md#quota-change-statuses).
  
  1. Чтобы посмотреть ответы службы поддержки, нажмите **Перейти к обращению**.

- CLI {#cli}

  1. Посмотрите список запросов на изменение квот и найдите статус нужного запроса:

     ```bash
     yc quota-manager quota-request list \
       --resource-type <тип_ресурса> \
       --resource-id <идентификатор_ресурса> \
       --limit <количество_запросов>
     ```
     
     Где:
     
     * `--resource-type` ([тип ресурса](../concepts/index.md#resources-types)) определяет уровень просмотра запросов на изменение квот. Для уровня облака укажите `resource-manager.cloud`, для уровня организации — `organization-manager.organization`.
     * `--resource-id` — идентификатор ресурса (облака или организации).
     * `--limit` — максимальное количество запросов в выводе.

     В каждом запросе поле `status` содержит общий статус. В списке `quota_limits` для каждой квоты указаны `status` — статус изменения, `desired_limit` — запрошенное итоговое значение и `approved_limit` — утвержденное.

  1. Посмотрите список операций с запросом:

     ```bash
     yc quota-manager quota-request list-operations --id <идентификатор_запроса> --limit <количество_операций>
     ```
     
     Где:
     
     * `--id` — идентификатор запроса, по которому нужно посмотреть операции.
     * `--limit` — максимальное количество операций в выводе.

- API {#api}

    Чтобы посмотреть статус запроса на изменение квот, воспользуйтесь методом REST API [get](../api-ref/QuotaRequest/get.md) для ресурса [QuotaRequest](../api-ref/QuotaRequest/index.md) или вызовом gRPC API [QuotaRequestService/Get](../api-ref/grpc/QuotaRequest/get.md).

    В JSON-ответе поле `status` показывает статус запроса. В списке `quotaLimits` для каждой квоты указаны `status` — статус изменения, `desiredLimit` — запрошенное итоговое значение и `approvedLimit` — утвержденное.

    Чтобы посмотреть операции с запросом на изменение квот, воспользуйтесь методом REST API [listOperations](../api-ref/QuotaRequest/listOperations.md) для ресурса [QuotaRequest](../api-ref/QuotaRequest/index.md) или вызовом gRPC API [QuotaRequestService/ListOperations](../api-ref/grpc/QuotaRequest/listOperations.md).

{% endlist %}

## Посмотреть список запросов на изменение квот {#list-quota-requests}

{% list tabs group=instructions %}

- Консоль управления или Cloud Center {#console}

  1. Выберите облако в [консоли управления](https://console.yandex.cloud) или организацию в [Cloud Center](https://center.yandex.cloud).
  
  1. На панели слева откройте ![image](../../_assets/console-icons/square-plus.svg) **Квоты**.
  
  1. Перейдите на вкладку **История запросов**. При необходимости используйте фильтры для поиска запросов.

- CLI {#cli}

  ```bash
  yc quota-manager quota-request list \
    --resource-type <тип_ресурса> \
    --resource-id <идентификатор_ресурса> \
    --limit <количество_запросов>
  ```
  
  Где:
  
  * `--resource-type` ([тип ресурса](../concepts/index.md#resources-types)) определяет уровень просмотра запросов на изменение квот. Для уровня облака укажите `resource-manager.cloud`, для уровня организации — `organization-manager.organization`.
  * `--resource-id` — идентификатор ресурса (облака или организации).
  * `--limit` — максимальное количество запросов в выводе.

- API {#api}

    Чтобы посмотреть список запросов на изменение квот, воспользуйтесь методом REST API [list](../api-ref/QuotaRequest/list.md) для ресурса [QuotaRequest](../api-ref/QuotaRequest/index.md) или вызовом gRPC API [QuotaRequestService/List](../api-ref/grpc/QuotaRequest/list.md).

{% endlist %}

## Отменить запрос на изменение квоты {#cancel-quota-request}

В консоли управления и Cloud Center можно отменить запрос в статусе **В обработке** (`PROCESSING`). Через CLI и API можно отменить изменение отдельных квот в запросе.

{% list tabs group=instructions %}

- Консоль управления или Cloud Center {#console}

  1. Выберите облако в [консоли управления](https://console.yandex.cloud) или организацию в [Cloud Center](https://center.yandex.cloud).
  
  1. На панели слева откройте ![image](../../_assets/console-icons/square-plus.svg) **Квоты**.
  
  1. Перейдите на вкладку **История запросов** и отфильтруйте запросы со статусом **В обработке**.
  
  1. Откройте нужный запрос и нажмите **Закрыть запрос**.

- CLI {#cli}

  ```bash
  yc quota-manager quota-request cancel --id <идентификатор_запроса> --quota-id=<идентификатор_квоты>
  ```
  
  Где:
  
  * `--id` — идентификатор запроса на изменение квот.
  * `--quota-id` — идентификатор квоты в запросе. Чтобы указать несколько квот, добавьте несколько параметров `--quota-id`.

- API {#api}

    Чтобы отменить запрос на изменение квот, воспользуйтесь методом REST API [cancel](../api-ref/QuotaRequest/cancel.md) для ресурса [QuotaRequest](../api-ref/QuotaRequest/index.md) или вызовом gRPC API [QuotaRequestService/Cancel](../api-ref/grpc/QuotaRequest/cancel.md).

    Передайте идентификатор запроса. В поле `quotaIds` для REST API или `quota_ids` для gRPC API укажите идентификаторы квот, изменение которых нужно отменить.

{% endlist %}