---
title: Как изменить квоты
description: Следуя данной инструкции, вы сможете запросить изменение квоты, а также узнать статус запроса и отменить его.
---

# Изменить квоты

Квоты можно увеличить по запросу в пределах лимитов — технических ограничений платформы.

{% include [request-quota-roles](../../_includes/quota-manager/request-quota-roles.md) %}

Интерфейсы просмотра и запроса квот:

* [{{ cloud-center }}]({{ cloud-center-link }}/quotas) — ссылка на страницу квот последней выбранной организации.
* [Консоль управления]({{ link-console-quotas }}) — ссылка на страницу квот последнего выбранного облака.
* [CLI](../../quota-manager/cli-ref/index.md) и [API](../../quota-manager/api-ref/authentication.md) — управление квотами организаций и облаков. Для работы с запросами на изменение квот обратитесь в [службу поддержки]({{ link-console-support }}).

В большинстве сервисов квоты действуют на уровне облака. В {{ resmgr-name }}, {{ video-name }} и некоторых других сервисах квоты действуют на уровне организации. В {{ iam-short-name }} есть квоты обоих уровней.

## Запросить изменение квоты {#request-quota-change}

{% list tabs group=instructions %}

- Консоль управления или {{ cloud-center }} {#console}

  {% include [request-quota](../../_includes/quota-manager/request-quota.md) %}

- CLI {#cli}

  {% include [request-quota-cli](../../_includes/quota-manager/request-quota-cli.md) %}

- API {#api}

    Чтобы создать запрос на изменение квот, воспользуйтесь методом REST API [create](../api-ref/QuotaRequest/create.md) для ресурса [QuotaRequest](../api-ref/QuotaRequest/) или вызовом gRPC API [QuotaRequestService/Create](../api-ref/grpc/QuotaRequest/create.md).

{% endlist %}

Также можно запросить увеличение квот через [техническую поддержку]({{ link-console-support }}), указав облако или организацию, квоты и желаемые значения.

Квоты, назначенные по умолчанию, можно посмотреть в документации:

* В [справочнике квот](../all-quotas.md).
* В разделе [обзора платформы](../../overview/concepts/quotas-limits.md#quotas-limits-default).
* На странице **Концепции > Квоты и лимиты** для каждого сервиса.

В {{ quota-manager-name }} сброс к значениям по умолчанию не предусмотрен.

## Посмотреть статус и операции с запросом на изменение квоты {#view-request-status}

Проверьте [статус запроса и результат изменения каждой квоты](../concepts/index.md#quota-request-statuses):

{% list tabs group=instructions %}

- Консоль управления или {{ cloud-center }} {#console}

  {% include [view-request-status-console](../../_includes/quota-manager/view-request-status-console.md) %}

- CLI {#cli}

  1. Посмотрите список запросов на изменение квот и найдите статус нужного запроса:

     {% include [list-quota-requests-cli](../../_includes/quota-manager/list-quota-requests-cli.md) %}

     В каждом запросе поле `status` содержит общий статус. В списке `quota_limits` для каждой квоты указаны `status` — статус изменения, `desired_limit` — запрошенное итоговое значение и `approved_limit` — утвержденное.

  1. Посмотрите список операций с запросом:

     {% include [list-oper-quota-request-cli](../../_includes/quota-manager/list-oper-quota-request-cli.md) %}

- API {#api}

    Чтобы посмотреть статус запроса на изменение квот, воспользуйтесь методом REST API [get](../api-ref/QuotaRequest/get.md) для ресурса [QuotaRequest](../api-ref/QuotaRequest/) или вызовом gRPC API [QuotaRequestService/Get](../api-ref/grpc/QuotaRequest/get.md).

    В JSON-ответе поле `status` показывает статус запроса. В списке `quotaLimits` для каждой квоты указаны `status` — статус изменения, `desiredLimit` — запрошенное итоговое значение и `approvedLimit` — утвержденное.

    Чтобы посмотреть операции с запросом на изменение квот, воспользуйтесь методом REST API [listOperations](../api-ref/QuotaRequest/listOperations.md) для ресурса [QuotaRequest](../api-ref/QuotaRequest/) или вызовом gRPC API [QuotaRequestService/ListOperations](../api-ref/grpc/QuotaRequest/listOperations.md).

{% endlist %}

## Посмотреть список запросов на изменение квот {#list-quota-requests}

{% list tabs group=instructions %}

- Консоль управления или {{ cloud-center }} {#console}

  {% include [list-quota-requests-console](../../_includes/quota-manager/list-quota-requests-console.md) %}

- CLI {#cli}

  {% include [list-quota-requests-cli](../../_includes/quota-manager/list-quota-requests-cli.md) %}

- API {#api}

    Чтобы посмотреть список запросов на изменение квот, воспользуйтесь методом REST API [list](../api-ref/QuotaRequest/list.md) для ресурса [QuotaRequest](../api-ref/QuotaRequest/) или вызовом gRPC API [QuotaRequestService/List](../api-ref/grpc/QuotaRequest/list.md).

{% endlist %}

## Отменить запрос на изменение квоты {#cancel-quota-request}

В консоли управления и {{ cloud-center }} можно отменить запрос в статусе **{{ ui-key.yacloud_components.Quota-manager.request_status_processing_6VM8E }}** (`PROCESSING`). Через CLI и API можно отменить изменение отдельных квот в запросе.

{% list tabs group=instructions %}

- Консоль управления или {{ cloud-center }} {#console}

  {% include [cancel-quota-request-console](../../_includes/quota-manager/cancel-quota-request-console.md) %}

- CLI {#cli}

  {% include [cancel-quota-requests-cli](../../_includes/quota-manager/cancel-quota-requests-cli.md) %}

- API {#api}

    Чтобы отменить запрос на изменение квот, воспользуйтесь методом REST API [cancel](../api-ref/QuotaRequest/cancel.md) для ресурса [QuotaRequest](../api-ref/QuotaRequest/) или вызовом gRPC API [QuotaRequestService/Cancel](../api-ref/grpc/QuotaRequest/cancel.md).

    Передайте идентификатор запроса. В поле `quotaIds` для REST API или `quota_ids` для gRPC API укажите идентификаторы квот, изменение которых нужно отменить.

{% endlist %}
