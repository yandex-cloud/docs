---
title: Как посмотреть список сервисов и квот
---

# Посмотреть список сервисов и квот

{% include [quota-level-access](../../_includes/quota-manager/quota-level-access.md) %}

{% include [get-quota-roles](../../_includes/quota-manager/get-quota-roles.md) %}

## Посмотреть список сервисов, для которых есть квоты {#list-services}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы посмотреть список сервисов с квотами в облаке:

  1. В [консоли управления]({{ link-console-main }}) выберите облако и на панели слева откройте ![image](../../_assets/console-icons/square-plus.svg) **{{ ui-key.yacloud.dashboard.label_quotas_gAtoT }}**.

     На вкладке **{{ ui-key.yacloud_components.Quota-manager.label_quotas-tab_323nV }}** отобразится список сервисов в группах **{{ ui-key.yacloud_components.Quota-manager.label_quotas-with-usage_dWfzm }}** и **{{ ui-key.yacloud_components.Quota-manager.label_quotas-without-usage_nAfZB }}**.

- Интерфейс {{ cloud-center }} {#cloud-center}

  Чтобы посмотреть список сервисов с квотами в организации:

  1. В [{{ cloud-center }}]({{ cloud-center-link }}) выберите организацию и на панели слева откройте ![image](../../_assets/console-icons/square-plus.svg) **{{ ui-key.yacloud_org.center.navigation.label_quotas }}**.

     На вкладке **{{ ui-key.yacloud_org.center.quotas.tab_quotas }}** отобразится список сервисов в группах **{{ ui-key.yacloud_components.Quota-manager.label_quotas-with-usage_dWfzm }}** и **{{ ui-key.yacloud_components.Quota-manager.label_quotas-without-usage_nAfZB }}**.

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

  Чтобы посмотреть квоты для сервиса в облаке:

  1. В [консоли управления]({{ link-console-main }}) выберите облако и на панели слева откройте ![image](../../_assets/console-icons/square-plus.svg) **{{ ui-key.yacloud.dashboard.label_quotas_gAtoT }}**.

  1. На вкладке **{{ ui-key.yacloud_components.Quota-manager.label_quotas-tab_323nV }}** введите в строку поиска название сервиса, название или идентификатор квоты.

  1. В группе **{{ ui-key.yacloud_components.Quota-manager.label_quotas-with-usage_dWfzm }}** или **{{ ui-key.yacloud_components.Quota-manager.label_quotas-without-usage_nAfZB }}** раскройте раздел нужного сервиса.

- Интерфейс {{ cloud-center }} {#cloud-center}

  Чтобы посмотреть квоты для сервиса в организации:

  1. В [{{ cloud-center }}]({{ cloud-center-link }}) выберите организацию и на панели слева откройте ![image](../../_assets/console-icons/square-plus.svg) **{{ ui-key.yacloud_org.center.navigation.label_quotas }}**.

  1. На вкладке **{{ ui-key.yacloud_org.center.quotas.tab_quotas }}** введите в строку поиска название сервиса, название или идентификатор квоты.

  1. В группе **{{ ui-key.yacloud_components.Quota-manager.label_quotas-with-usage_dWfzm }}** или **{{ ui-key.yacloud_components.Quota-manager.label_quotas-without-usage_nAfZB }}** раскройте раздел нужного сервиса.

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

  * `--service` — идентификатор сервиса, полученный при [просмотре списка сервисов](#list-services).
  * `--resource-id` — идентификатор [ресурса](../../resource-manager/concepts/resources-hierarchy.md): идентификатор облака, организации или платежного аккаунта.
  * `--resource-type` — тип ресурса: `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.


  Пример:

  ```bash
  yc quota-manager quota-limit list \
    --service=compute \
    --resource-type=resource-manager.cloud \
    --resource-id=b1gia87mbaom********
  ```

  Будет выведен список квот сервиса {{ compute-name }} в облаке `b1gia87mbaom********`:

  ```bash
  resource:
    id: b1gia87mbaom********
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
