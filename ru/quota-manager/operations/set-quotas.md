---
title: Как изменить квоты
description: Следуя данной инструкции, вы сможете запросить изменение квоты, а также узнать статус запроса и отменить его.
---

# Изменить квоты

{% include [preview-quota](../../_includes/quota-manager/preview-quota.md) %}

{% include [quota-level-access](../../_includes/quota-manager/quota-level-access.md) %}

Квоты можно увеличить по запросу в пределах лимитов — технических ограничений платформы.

{% include [request-quota-roles](../../_includes/quota-manager/request-quota-roles.md) %}

## Запросить изменение квоты {#request-quota-change}

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [request-quota](../../_includes/quota-manager/request-quota.md) %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  {% include [request-quota](../../_includes/quota-manager/request-quota-org.md) %}

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

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы посмотреть статус и операции с запросом на изменение квоты для облака:

  1. В [консоли управления]({{ link-console-main }}) выберите облако и на панели слева откройте ![image](../../_assets/console-icons/square-plus.svg) **{{ ui-key.yacloud.dashboard.label_quotas_gAtoT }}**.

  1. Перейдите на вкладку **{{ ui-key.yacloud_components.Quota-manager.label_history-tab_n8GVs }}**. При необходимости используйте фильтр по статусу.

  1. Откройте нужный запрос, чтобы посмотреть его статус, ответы службы поддержки и список операций.

- Интерфейс {{ cloud-center }} {#cloud-center}

  Чтобы посмотреть статус и операции с запросом на изменение квоты для организации:

  1. В [{{ cloud-center }}]({{ cloud-center-link }}) выберите организацию и на панели слева откройте ![image](../../_assets/console-icons/square-plus.svg) **{{ ui-key.yacloud_org.center.navigation.label_quotas }}**.

  1. Перейдите на вкладку **{{ ui-key.yacloud_org.center.quotas.tab_history }}**. При необходимости используйте фильтр по статусу.

  1. Откройте нужный запрос, чтобы посмотреть его статус, ответы службы поддержки и список операций.

- CLI {#cli}

  1. Посмотрите список запросов на изменение квот и найдите статус нужного запроса:

     {% include [list-quota-requests-cli](../../_includes/quota-manager/list-quota-requests-cli.md) %}

  1. Посмотрите список операций с запросом:

     {% include [list-oper-quota-request-cli](../../_includes/quota-manager/list-oper-quota-request-cli.md) %}

- API {#api}

    Чтобы посмотреть статус запроса на изменение квот, воспользуйтесь методом REST API [get](../api-ref/QuotaRequest/get.md) для ресурса [QuotaRequest](../api-ref/QuotaRequest/) или вызовом gRPC API [QuotaRequestService/Get](../api-ref/grpc/QuotaRequest/get.md).

    Чтобы посмотреть операции с запросом на изменение квот, воспользуйтесь методом REST API [listOperations](../api-ref/QuotaRequest/listOperations.md) для ресурса [QuotaRequest](../api-ref/QuotaRequest/) или вызовом gRPC API [QuotaRequestService/ListOperations](../api-ref/grpc/QuotaRequest/listOperations.md).

{% endlist %}

## Посмотреть список запросов на изменение квот {#list-quota-requests}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите облако и на панели слева откройте ![image](../../_assets/console-icons/square-plus.svg) **{{ ui-key.yacloud.dashboard.label_quotas_gAtoT }}**.

  1. Перейдите на вкладку **{{ ui-key.yacloud_components.Quota-manager.label_history-tab_n8GVs }}**. При необходимости используйте фильтры для поиска запросов.

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. В [{{ cloud-center }}]({{ cloud-center-link }}) выберите организацию и на панели слева откройте ![image](../../_assets/console-icons/square-plus.svg) **{{ ui-key.yacloud_org.center.navigation.label_quotas }}**.

  1. Перейдите на вкладку **{{ ui-key.yacloud_org.center.quotas.tab_history }}**. При необходимости используйте фильтры для поиска запросов.

- CLI {#cli}

  {% include [list-quota-requests-cli](../../_includes/quota-manager/list-quota-requests-cli.md) %}

- API {#api}

    Чтобы посмотреть список запросов на изменение квот, воспользуйтесь методом REST API [list](../api-ref/QuotaRequest/list.md) для ресурса [QuotaRequest](../api-ref/QuotaRequest/) или вызовом gRPC API [QuotaRequestService/List](../api-ref/grpc/QuotaRequest/list.md).

{% endlist %}

## Отменить запрос на изменение квоты {#cancel-quota-request}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы отменить запрос на изменение квоты для облака:

  1. В [консоли управления]({{ link-console-main }}) выберите облако и на панели слева откройте ![image](../../_assets/console-icons/square-plus.svg) **{{ ui-key.yacloud.dashboard.label_quotas_gAtoT }}**.

  1. Перейдите на вкладку **{{ ui-key.yacloud_components.Quota-manager.label_history-tab_n8GVs }}** и отфильтруйте запросы со статусом **{{ ui-key.yacloud_components.Quota-manager.value_request-status-processing_jiepM }}**.

  1. Откройте нужный запрос и нажмите **{{ ui-key.yacloud_components.iam.cloud.quotas.action_close_request }}**.

- Интерфейс {{ cloud-center }} {#cloud-center}

  Чтобы отменить запрос на изменение квоты для организации:

  1. В [{{ cloud-center }}]({{ cloud-center-link }}) выберите организацию и на панели слева откройте ![image](../../_assets/console-icons/square-plus.svg) **{{ ui-key.yacloud_org.center.navigation.label_quotas }}**.

  1. Перейдите на вкладку **{{ ui-key.yacloud_org.center.quotas.tab_history }}** и отфильтруйте запросы со статусом **{{ ui-key.yacloud_components.Quota-manager.value_request-status-processing_jiepM }}**.

  1. Откройте нужный запрос и нажмите **{{ ui-key.yacloud_components.iam.cloud.quotas.action_close_request }}**.

- CLI {#cli}

  {% include [cancel-quota-requests-cli](../../_includes/quota-manager/cancel-quota-requests-cli.md) %}

- API {#api}

    Чтобы отменить запрос на изменение квот, воспользуйтесь методом REST API [cancel](../api-ref/QuotaRequest/cancel.md) для ресурса [QuotaRequest](../api-ref/QuotaRequest/) или вызовом gRPC API [QuotaRequestService/Cancel](../api-ref/grpc/QuotaRequest/cancel.md).

{% endlist %}
