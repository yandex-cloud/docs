---
title: Как посмотреть список сервисов и квот
---

# Посмотреть список сервисов и квот

{% include [get-quota-roles](../../_includes/quota-manager/get-quota-roles.md) %}

{% include [quota-level-access](../../_includes/quota-manager/quota-level-access.md) %}

## Посмотреть список сервисов, для которых есть квоты {#list-services}

{% list tabs group=instructions %}

- Консоль управления или {{ cloud-center }} {#console}

  1. Выберите облако в [консоли управления]({{ link-console-main }}) или организацию в [{{ cloud-center }}]({{ cloud-center-link }}).

  1. На панели слева откройте ![image](../../_assets/console-icons/square-plus.svg) **{{ ui-key.yacloud.dashboard.label_quotas_gAtoT }}**.

     На вкладке **{{ ui-key.yacloud_org.center.quotas.tab_quotas }}** две группы сервисов:

     * **{{ ui-key.yacloud_components.Quota-manager.label_quotas-with-usage_dWfzm }}** — потребление хотя бы одной квоты больше нуля.
     * **{{ ui-key.yacloud_components.Quota-manager.label_quotas-without-usage_nAfZB }}** — потребление всех квот равно нулю.

  1. Чтобы показать квоты, близкие к исчерпанию, справа вверху нажмите **{{ ui-key.yacloud_components.Quota-manager.value_usage-status-almost-expired_9NhmR }}**. Для сброса фильтра нажмите **{{ ui-key.yacloud_components.Quota-manager.value_status-all_uAiLf }}**.
  
  На этой же странице можно [запросить изменение квот](set-quotas.md).

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Посмотрите список сервисов с квотами на уровне облака:

  {% include [list-quota-services-cli](../../_includes/quota-manager/list-quota-services-cli.md) %}

- API {#api}

    Чтобы получить список сервисов, воспользуйтесь методом REST API [listServices](../api-ref/QuotaLimit/listServices.md) для ресурса [QuotaLimit](../api-ref/QuotaLimit/) или вызовом gRPC API [QuotaLimitService/ListServices](../api-ref/grpc/QuotaLimit/listServices.md).

{% endlist %}

## Посмотреть квоты для сервиса {#list-service-quotas}

{% list tabs group=instructions %}

- Консоль управления или {{ cloud-center }} {#console}

  1. Выберите облако в [консоли управления]({{ link-console-main }}) или организацию в [{{ cloud-center }}]({{ cloud-center-link }}).

  1. На панели слева откройте ![image](../../_assets/console-icons/square-plus.svg) **{{ ui-key.yacloud.dashboard.label_quotas_gAtoT }}**.

  1. На вкладке **{{ ui-key.yacloud_org.center.quotas.tab_quotas }}** введите в строку поиска название сервиса, название или идентификатор квоты.

  1. В группе **{{ ui-key.yacloud_components.Quota-manager.label_quotas-with-usage_dWfzm }}** или **{{ ui-key.yacloud_components.Quota-manager.label_quotas-without-usage_nAfZB }}** раскройте раздел нужного сервиса.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc quota-manager quota-limit list \
    --service=<идентификатор_сервиса> \
    --resource-type=<тип_ресурса> \
    --resource-id=<идентификатор_ресурса>
  ```

  Где:

  * `--service` — идентификатор сервиса, полученный при [просмотре списка сервисов](#list-services).
  * `--resource-id` — идентификатор [ресурса](../../resource-manager/concepts/resources-hierarchy.md): идентификатор облака или организации.
  * `--resource-type` ([тип ресурса](../../quota-manager/concepts/index.md#resources-types)) определяет уровень просмотра квот. Для уровня облака укажите `resource-manager.cloud`, для уровня организации — `organization-manager.organization`.


  Пример:

  ```bash
  yc quota-manager quota-limit list \
    --service=compute \
    --resource-type=resource-manager.cloud \
    --resource-id=b1gia87mbaom********
  ```

  Будет выведен список квот сервиса {{ compute-name }} в облаке `b1gia87mbaom********`. Ниже приведена часть ответа:

  ```text
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
