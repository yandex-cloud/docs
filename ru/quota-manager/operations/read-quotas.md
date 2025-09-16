---
title: Как посмотреть квоты
---

# Посмотреть значение квоты

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите облако, в котором хотите посмотреть квоты.
  1. Выберите вкладку **{{ ui-key.yacloud.iam.cloud.switch_quotas }}**.
     
     На странице отобразится список сервисов, которые используются в вашем облаке.
  
  1. Раскройте раздел сервиса и посмотрите значения в столбце **{{ ui-key.yacloud.iam.cloud.quotas.column_usage }}**:
  
     * Два числа — `потребление квоты / значение квоты`. Например, `2 / 20` или `1.203 / 5120 ГБ`.

     * Одно число — `лимит`, изменить его нельзя.

  1. Чтобы оценить потребление ресурсов, вверху справа в списке выберите:
     * **{{ ui-key.yacloud.iam.cloud.quotas.value_status-warning }}** — ресурсы, которые потребляют более половины установленной квоты.
     * **{{ ui-key.yacloud.iam.cloud.quotas.value_status-error }}** — ресурсы, которые почти израсходованы.

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

  Чтобы посмотреть значение определенной квоты — текущее ограничение, установленное для ресурса, воспользуйтесь методом REST API [get](../../quota-manager/api-ref/QuotaLimit/get.md) для ресурса [QuotaLimit](../../quota-manager/api-ref/QuotaLimit/index.md) или вызовом gRPC API [QuotaLimitService/Get](../../quota-manager/api-ref/grpc/QuotaLimit/get.md).

{% endlist %}