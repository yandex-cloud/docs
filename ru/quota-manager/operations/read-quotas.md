---
title: Как посмотреть квоты
---

# Посмотреть значение квоты

{% include [quota-level-access](../../_includes/quota-manager/quota-level-access.md) %}

{% include [get-quota-roles](../../_includes/quota-manager/get-quota-roles.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы посмотреть значение квоты на уровне облака:

  {% include [get-quota](../../_includes/quota-manager/get-quota-info-cloud.md) %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  Чтобы посмотреть значение квоты на уровне организации:

  {% include [get-quota](../../_includes/quota-manager/get-quota-info-org.md) %}

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
  * `--resource-id` — идентификатор [ресурса](../../resource-manager/concepts/resources-hierarchy.md): идентификатор облака, организации или платежного аккаунта.
  * `--resource-type` — [тип ресурса](../../quota-manager/concepts/index.md#resources-types): `resource-manager.cloud`, `organization-manager.organization`, `billing.account`.

  Пример:

  ```bash
  yc quota-manager quota-limit get --quota-id=compute.disks.count --resource-id=b1gia87mbaom********  --resource-type=resource-manager.cloud
  ```

  Будут выведены значение и потребление квоты на количество дисков в сервисе {{ compute-name }} в облаке `b1gia87mbaom********`:

  ```bash
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
