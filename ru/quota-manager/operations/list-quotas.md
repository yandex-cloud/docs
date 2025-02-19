---
title: Как посмотреть список сервисов и квот
---

# Посмотреть список сервисов и квот

## Посмотреть список сервисов, для которых есть квоты

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) слева выберите облако.
  1. Выберите вкладку **{{ ui-key.yacloud.iam.cloud.switch_quotas }}**.
     
     На странице отобразится список сервисов, для которых есть квоты.


- API {#api}

  Чтобы получить список сервисов, воспользуйтесь методом REST API [listServices](../api-ref/QuotaLimit/listServices.md) для ресурса [QuotaLimit](../api-ref/QuotaLimit/) или вызовом gRPC API [QuotaLimitService/ListServices](../api-ref/grpc/QuotaLimit/listServices.md).

{% endlist %}

## Посмотреть список квот для сервиса

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) слева выберите облако.
  1. Выберите вкладку **{{ ui-key.yacloud.iam.cloud.switch_quotas }}**.
  1. Откройте раздел сервиса, для которого хотите посмотреть квоты.


- API {#api}

  Чтобы получить список квот для определенного сервиса, воспользуйтесь методом REST API [list](../api-ref/QuotaLimit/list.md) для ресурса [QuotaLimit](../api-ref/QuotaLimit/) или вызовом gRPC API [QuotaLimitService/List](../api-ref/grpc/QuotaLimit/list.md).

{% endlist %}