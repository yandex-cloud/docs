---
title: Как изменить квоты
---

# Изменить квоты

{% include [preview-quota](../../_includes/quota-manager/preview-quota.md) %}

Потенциально значения квот можно изменить до значений лимитов — ограничений облачной платформы.

{% include [request-quota-roles](../../_includes/quota-manager/request-quota-roles.md) %}

## Запросить изменение квоты {#request-quota-change}

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [request-quota](../../_includes/quota-manager/request-quota.md) %}

- CLI {#cli}

  {% include [request-quota-cli](../../_includes/quota-manager/request-quota-cli.md) %}

- API {#api}

  Чтобы создать запрос на изменение квот, воспользуйтесь методом REST API [Create](../api-ref/QuotaRequest/create.md) для ресурса [QuotaRequest](../api-ref/QuotaRequest/) или вызовом gRPC API [QuotaRequest/create](../api-ref/grpc/QuotaRequest/create.md).

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
      
      {% include [list-quota-requests-cli](../../_includes/quota-manager/list-quota-requests-cli.md) %}

  1. Посмотрите список операций с запросом:

      {% include [list-oper-quota-request-cli](../../_includes/quota-manager/list-oper-quota-request-cli.md) %}

- API {#api}

  Чтобы посмотреть статус запроса на изменение квот, воспользуйтесь методом REST API [get](../api-ref/QuotaRequest/get.md) для ресурса [QuotaRequest](../api-ref/QuotaRequest/) или вызовом gRPC API [QuotaRequest/Get](../api-ref/grpc/QuotaRequest/get.md).

  Чтобы посмотреть операции с запросом на изменение квот, воспользуйтесь методом REST API [listOperations](../api-ref/QuotaRequest/listOperations.md) для ресурса [QuotaRequest](../api-ref/QuotaRequest/) или вызовом gRPC API [QuotaRequest/listOperations](../api-ref/grpc/QuotaRequest/listOperations.md).

{% endlist %}

## Посмотреть список запросов на изменение квот {#list-quota-requests}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В разделе [технической поддержки]({{ link-console-support }}) выберите **{{ ui-key.yacloud_org.support.switch_tickets }}**.
  1. В списке фильтров **{{ ui-key.yacloud_org.support.tickets.table.label_column_ticket_type }}** выберите **{{ ui-key.support-center.search.common.title_suggestion-quotas }}**.

- CLI {#cli}

  {% include [list-quota-requests-cli](../../_includes/quota-manager/list-quota-requests-cli.md) %}

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

- CLI {#cli}
      
  {% include [cancel-quota-requests-cli](../../_includes/quota-manager/cancel-quota-requests-cli.md) %}

- API {#api}

  Чтобы отменить запрос на изменение квот, воспользуйтесь методом REST API [Cancel](../api-ref/QuotaRequest/cancel.md) для ресурса [QuotaRequest](../api-ref/QuotaRequest/) или вызовом gRPC API [QuotaRequest/cancel](../api-ref/grpc/QuotaRequest/cancel.md).

{% endlist %}