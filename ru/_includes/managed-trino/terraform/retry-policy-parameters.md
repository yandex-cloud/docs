```hcl
resource "yandex_trino_cluster" "<имя_кластера>" {
  ...
  retry_policy = {
    policy = "<тип_объекта_для_перезапроса>"
    additional_properties = {
      <список_дополнительных_параметров_политики_перезапросов>
    }
    exchange_manager = {
      additional_properties = {
        <список_дополнительных_параметров_хранилища>
      }
      service_s3 = {}
    }
  }
  ...
}
```

Где:

* `policy` — способ повторного выполнения запросов. Возможные значения:

    * `TASK` — в рамках запроса повторно выполняется промежуточное задание, вызвавшее сбой воркера.
    * `QUERY` — повторно выполняются все [этапы запроса](../../../managed-trino/concepts/index.md#вquery-execution), в котором произошел сбой воркера.

* `additional_properties` — дополнительные параметры повторного выполнения запросов в формате `"<ключ>" = "<значение>"`. Подробнее о параметрах см. в [документации {{ TR }}]({{ tr.docs}}/admin/fault-tolerant-execution.html#advanced-configuration).

* `exchangeManager` — параметры хранилища Exchange Manager:

    * `service_s3` — использование S3-хранилища для записи данных при перезапросах.
    * `additional_properties` – дополнительные параметры хранилища Exchange Manager в формате `"<ключ>" = "<значение>"`. Подробнее о параметрах см. в [документации {{ TR }}]({{ tr.docs}}/admin/fault-tolerant-execution.html#id1).
