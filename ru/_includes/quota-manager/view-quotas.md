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


- API {#api}

  Чтобы посмотреть значение определенной квоты — текущее ограничение, установленное для ресурса, воспользуйтесь методом REST API [get](../../quota-manager/api-ref/QuotaLimit/get.md) для ресурса [QuotaLimit](../api-ref/QuotaLimit/) или вызовом gRPC API [QuotaLimitService/Get](../../quota-manager/api-ref/grpc/QuotaLimit/get.md).

{% endlist %}