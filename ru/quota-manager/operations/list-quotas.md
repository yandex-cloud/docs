---
title: Как посмотреть список сервисов и квот
---

# Посмотреть список сервисов и квот

## Посмотреть список сервисов, для которых есть квоты {#list-services}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) слева выберите облако.
  1. Выберите вкладку **{{ ui-key.yacloud.iam.cloud.switch_quotas }}**.
     
     На странице отобразится список сервисов, для которых есть квоты.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Выполните команду:

    ```bash
    yc quota-manager quota-limit list-services --resource-type=<тип_ресурса>
    ```

    Где `--resource-type` — [тип ресурса](../concepts/index.md#resources-types): `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.

- API {#api}

  Чтобы получить список сервисов, воспользуйтесь методом REST API [listServices](../api-ref/QuotaLimit/listServices.md) для ресурса [QuotaLimit](../api-ref/QuotaLimit/) или вызовом gRPC API [QuotaLimitService/ListServices](../api-ref/grpc/QuotaLimit/listServices.md).

{% endlist %}

## Посмотреть квоты для сервиса {#list-service-quotas}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) слева выберите облако.
  1. Выберите вкладку **{{ ui-key.yacloud.iam.cloud.switch_quotas }}**.
  1. Откройте раздел сервиса, для которого хотите посмотреть квоты.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Выполните команду:

  ```bash
  yc quota-manager quota-limit list \
    --service=<название_сервиса> \
    --resource-type=<тип_ресурса> \
    --resource-id=<идентификатор_ресурса>
  ```

  Где:
  * `--service` — название сервиса в [YC CLI](../../cli/cli-ref/).
  * `--resource-id` — идентификатор [ресурса](../../resource-manager/concepts/resources-hierarchy.md): идентификатор облака, организации или платежного аккаунта.
  * `--resource-type` — тип ресурса: `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.


  Пример:

  ```bash
  yc quota-manager quota-limit list \
    --service=compute \
    --resource-type=resource-manager.cloud \
    --resource-id=b1gflhy********
  ```

  Будет выведен список квот для сервиса {{ compute-name }} для облака с идентификатором `b1gflhy********`:

  ```bash
  resource:
    id: b1gflhy********
    type: resource-manager.cloud
  quota_limits:
    - quota_id: compute.dedicatedHosts.count
      limit: 1
      usage: 0
    - quota_id: compute.diskPlacementGroups.count
      limit: 5
      usage: 1
    - quota_id: compute.diskPools.count
      limit: 0
      usage: 0
    - quota_id: compute.disks.count
      limit: 64
      usage: 30
  - quota_id: compute.filesystems.count
      limit: 100
      usage: 1
  - quota_id: compute.hddDisks.size
      limit: 1116691496960
      usage: 464930209792
  ...
  ```

  Где:
  * `limit` — значение квоты;
  * `usage` — потребление квоты.

- API {#api}

  Чтобы получить список квот для определенного сервиса, воспользуйтесь методом REST API [list](../api-ref/QuotaLimit/list.md) для ресурса [QuotaLimit](../api-ref/QuotaLimit/) или вызовом gRPC API [QuotaLimitService/List](../api-ref/grpc/QuotaLimit/list.md).

{% endlist %}
