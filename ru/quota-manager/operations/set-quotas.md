---
title: Как изменить квоты
---

# Изменить квоты

Потенциально значения квот можно изменить до значений лимитов — ограничений облачной платформы.

{% include [request-quota-restriction](../../_includes/quota-manager/request-quota-restriction.md) %}

{% include [request-quota-roles](../../_includes/quota-manager/request-quota-roles.md) %}

## Запросить изменение квоты {#request-quota-change}

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [request-quota](../../_includes/quota-manager/request-quota.md) %}

- API {#api}

  Чтобы создать запрос на изменение квот, воспользуйтесь методом REST API [Create](../api-ref/QuotaRequest/create.md) для ресурса [QuotaRequest](../api-ref/QuotaRequest/) или вызовом gRPC API [QuotaRequest/create](../api-ref/grpc/QuotaRequest/create.md).

{% endlist %}

Квоты, назначенные по умолчанию, можно посмотреть в документации:

* На общей [странице квот](../../overview/concepts/quotas-limits.md#quotas-limits-default).
* На странице **Концепции > Квоты и лимиты** для каждого сервиса.

В {{ quota-manager-name }} сброс к значениям по умолчанию не предусмотрен.

## Посмотреть статус и операции с запросом на изменение квоты {#view-request-status}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите облако, в котором хотите посмотреть квоты.
  1. На панели справа выберите раздел **{{ ui-key.yacloud.iam.cloud.switch_quotas }}**.
  1. Раскройте секцию **{{ ui-key.yacloud.iam.cloud.quotas.label_pending-requests-title }}**.
  1. Выберите нужный запрос и посмотрите ответы службы поддержки и операции с запросом.

- API {#api}

  Чтобы посмотреть статус запроса на изменение квот, воспользуйтесь методом REST API [get](../api-ref/QuotaRequest/get.md) для ресурса [QuotaRequest](../api-ref/QuotaRequest/) или вызовом gRPC API [QuotaRequest/Get](../api-ref/grpc/QuotaRequest/get.md).

  Чтобы посмотреть операции с запросом на изменение квот, воспользуйтесь методом REST API [listOperations](../api-ref/QuotaRequest/listOperations.md) для ресурса [QuotaRequest](../api-ref/QuotaRequest/) или вызовом gRPC API [QuotaRequest/listOperations](../api-ref/grpc/QuotaRequest/listOperations.md).

{% endlist %}

## Посмотреть список запросов на изменение квот {#list-quota-requests}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В разделе [технической поддержки]({{ link-console-support }}) выберите **{{ ui-key.yacloud_org.support.switch_tickets }}**.
  1. В списке фильтров **{{ ui-key.yacloud_org.support.tickets.table.label_column_ticket_type }}** выберите **{{ ui-key.support-center.search.common.title_suggestion-quotas }}**.

- API {#api}

  Чтобы посмотреть список запросов на изменение квот, воспользуйтесь методом REST API [List](../api-ref/QuotaRequest/list.md) для ресурса [QuotaRequest](../api-ref/QuotaRequest/) или вызовом gRPC API [QuotaRequest/list](../api-ref/grpc/QuotaRequest/list.md).

{% endlist %}

## Отменить запрос на изменение квоты {#cancel-quota-request}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите облако, в котором хотите посмотреть квоты.
  1. На панели справа выберите раздел **{{ ui-key.yacloud.iam.cloud.switch_quotas }}**.
  1. Раскройте секцию **{{ ui-key.yacloud.iam.cloud.quotas.label_pending-requests-title }}**.
  1. Выберите нужный запрос и нажмите кнопку **{{ ui-key.yacloud_components.helpfeedbackdialog.button_close }}**.

- API {#api}

  Чтобы отменить запрос на изменение квот, воспользуйтесь методом REST API [Cancel](../api-ref/QuotaRequest/cancel.md) для ресурса [QuotaRequest](../api-ref/QuotaRequest/) или вызовом gRPC API [QuotaRequest/cancel](../api-ref/grpc/QuotaRequest/cancel.md).

{% endlist %}