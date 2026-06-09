# Изменить квоты

{% note info %}

Для работы с запросами на изменение квот через CLI и API обратитесь в [службу поддержки]({{ link-console-support }}).

{% endnote %}

Потенциально значения квот можно изменить до значений лимитов — ограничений облачной платформы.

Для работы с запросами на изменение квот [учетной записи]({{ link-console-iam-users }}) потребуются роли:
* на уровне [организации](../../resource-manager/concepts/resources-hierarchy.md#cloud) — [quota-manager.requestOperator](../security/index.md#quota-manager-requestoperator), [organization-manager.viewer](../../organization/security/index.md#organization-manager-viewer);
* на уровне облака — [resource-manager.viewer](../../resource-manager/security/index.md#resource-manager-viewer).

## Запросить изменение квоты {#request-quota-change}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Запросите изменение квоты одним из способов:
     * На [странице квот]({{ link-console-quotas }}) выберите ресурсы и нажмите **{{ ui-key.yacloud.iam.cloud.quotas.button_action-request }}**.
     * Обратитесь в [техническую поддержку]({{ link-console-support }}) и опишите, какие потребляемые квоты нужно увеличить и на сколько.

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

  Чтобы создать запрос на изменение квот, воспользуйтесь методом REST API [Create](../api-ref/QuotaRequest/create.md) для ресурса [QuotaRequest](../api-ref/QuotaRequest/index.md) или вызовом gRPC API [QuotaRequest/create](../api-ref/grpc/QuotaRequest/create.md).

{% endlist %}

Квоты, назначенные по умолчанию, можно посмотреть в документации:

* В [справочнике квот](../all-quotas.md).
* В разделе [обзора платформы](../../overview/concepts/quotas-limits.md#quotas-limits-default).
* На странице **Концепции > Квоты и лимиты** для каждого сервиса.

В {{ quota-manager-name }} сброс к значениям по умолчанию не предусмотрен.

## Посмотреть статус и операции с запросом на изменение квоты {#view-request-status}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите облако, в котором хотите посмотреть квоты.
  1. На панели справа выберите раздел **{{ ui-key.yacloud.iam.cloud.switch_quotas }}**.
  1. Раскройте секцию **{{ ui-key.yacloud.iam.cloud.quotas.label_pending-requests-title }}**.
  1. Выберите нужный запрос и посмотрите ответы службы поддержки и операции с запросом.

- CLI {#cli}

  1. Посмотрите статус запроса на изменение квот:
      
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
      yc quota-manager quota-request list-operations --id <идентификатор_запроса> --limit <количество_запросов>
      ```
      
      Где:
      
      * `--id` — идентификатор запроса, по которому нужно посмотреть операции.
      * `--limit` — количество запросов на странице.

- API {#api}

  Чтобы посмотреть статус запроса на изменение квот, воспользуйтесь методом REST API [get](../api-ref/QuotaRequest/get.md) для ресурса [QuotaRequest](../api-ref/QuotaRequest/index.md) или вызовом gRPC API [QuotaRequest/Get](../api-ref/grpc/QuotaRequest/get.md).

  Чтобы посмотреть операции с запросом на изменение квот, воспользуйтесь методом REST API [listOperations](../api-ref/QuotaRequest/listOperations.md) для ресурса [QuotaRequest](../api-ref/QuotaRequest/index.md) или вызовом gRPC API [QuotaRequest/listOperations](../api-ref/grpc/QuotaRequest/listOperations.md).

{% endlist %}

## Посмотреть список запросов на изменение квот {#list-quota-requests}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В разделе [технической поддержки]({{ link-console-support }}) выберите **{{ ui-key.yacloud_org.support.switch_tickets }}**.
  1. В списке фильтров **{{ ui-key.yacloud_org.support.tickets.table.label_column_ticket_type }}** выберите **{{ ui-key.support-center.search.common.title_suggestion-quotas }}**.

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

  Чтобы посмотреть список запросов на изменение квот, воспользуйтесь методом REST API [List](../api-ref/QuotaRequest/list.md) для ресурса [QuotaRequest](../api-ref/QuotaRequest/index.md) или вызовом gRPC API [QuotaRequest/list](../api-ref/grpc/QuotaRequest/list.md).

{% endlist %}

## Отменить запрос на изменение квоты {#cancel-quota-request}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите облако, в котором хотите посмотреть квоты.
  1. На панели справа выберите раздел **{{ ui-key.yacloud.iam.cloud.switch_quotas }}**.
  1. Раскройте секцию **{{ ui-key.yacloud.iam.cloud.quotas.label_pending-requests-title }}**.
  1. Выберите нужный запрос и нажмите кнопку **{{ ui-key.yacloud_components.helpfeedbackdialog.button_close }}**.

- CLI {#cli}
      
  ```bash
  yc quota-manager quota-request cancel --id <идентификатор_запроса> --quota-id=<идентификатор_квоты>
  ```
  Где:
  
  * `--id` — идентификатор запроса, который требуется отменить.
  * `--quota-id` — идентификатор квоты в запросе. Чтобы указать несколько квот, добавьте несколько параметров `--quota-id`.

- API {#api}

  Чтобы отменить запрос на изменение квот, воспользуйтесь методом REST API [Cancel](../api-ref/QuotaRequest/cancel.md) для ресурса [QuotaRequest](../api-ref/QuotaRequest/index.md) или вызовом gRPC API [QuotaRequest/cancel](../api-ref/grpc/QuotaRequest/cancel.md).

{% endlist %}