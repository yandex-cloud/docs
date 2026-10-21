---
title: Как посмотреть квоты
---

# Посмотреть значение квоты

{% include [get-quota-roles](../../_includes/quota-manager/get-quota-roles.md) %}

{% include [quota-level-access](../../_includes/quota-manager/quota-level-access.md) %}

{% list tabs group=instructions %}

- Консоль управления или {{ cloud-center }} {#console}

  Чтобы посмотреть значение и потребление квоты:

  {% include [get-quota-info-console](../../_includes/quota-manager/get-quota-info-console.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Выполните команду:

  ```bash
  yc quota-manager quota-limit get \
    --quota-id=<идентификатор_квоты> \
    --resource-id <идентификатор_ресурса> \
    --resource-type <тип_ресурса>
  ```

  Где:

  * `--quota-id` — идентификатор квоты, полученный при [просмотре списка квот](../../quota-manager/operations/list-quotas.md#list-service-quotas) для сервиса.
  * `--resource-id` — идентификатор [ресурса](../../resource-manager/concepts/resources-hierarchy.md): идентификатор облака или организации.
  * `--resource-type` ([тип ресурса](../../quota-manager/concepts/index.md#resources-types)) определяет уровень просмотра квот. Для уровня облака укажите `resource-manager.cloud`, для уровня организации — `organization-manager.organization`.

  Пример:

  ```bash
  yc quota-manager quota-limit get --quota-id=compute.disks.count --resource-id=b1gia87mbaom******** --resource-type=resource-manager.cloud
  ```

  Будут выведены значение и потребление квоты на количество дисков в сервисе {{ compute-name }} в облаке `b1gia87mbaom********`:

  ```text
  quota_id: compute.disks.count
  limit: 64
  usage: 30
  ```

  Где:

  * `limit` — значение квоты;
  * `usage` — потребление квоты.

- API {#api}

    Чтобы посмотреть значение и потребление квоты, воспользуйтесь методом REST API [get](../../quota-manager/api-ref/QuotaLimit/get.md) для ресурса [QuotaLimit](../../quota-manager/api-ref/QuotaLimit/index.md) или вызовом gRPC API [QuotaLimitService/Get](../../quota-manager/api-ref/grpc/QuotaLimit/get.md).

{% endlist %}

[*quota-usage]: {% include notitle [quota-usage](../../_popups/quota-manager/quotas.md#quota-usage) %}

[*quota-limit]: {% include notitle [quota-limit](../../_popups/quota-manager/quotas.md#quota-limit) %}
