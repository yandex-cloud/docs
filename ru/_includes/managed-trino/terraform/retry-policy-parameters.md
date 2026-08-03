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
      # Укажите один из двух блоков: service_s3 или s3.
      service_s3 = {}
      s3 = {
        bucket = "<имя_пользовательского_бакета>"
      }
    }
  }
  ...
}
```

Где:

* `policy` — способ повторного выполнения запросов. Возможные значения:

    * `TASK` — в рамках запроса повторно выполняется промежуточное задание, вызвавшее сбой воркера.
    * `QUERY` — повторно выполняются все [этапы запроса](../../../managed-trino/concepts/index.md#query-execution), в котором произошел сбой воркера.

* `additional_properties` — дополнительные параметры повторного выполнения запросов в формате `"<ключ>" = "<значение>"`. Подробнее о параметрах в [документации {{ TR }}]({{ tr.docs }}/admin/fault-tolerant-execution.html#advanced-configuration).

* `exchange_manager` — параметры хранилища Exchange Manager:

    * `additional_properties` — дополнительные параметры хранилища Exchange Manager в формате `"<ключ>" = "<значение>"`. Подробнее о параметрах в [документации {{ TR }}]({{ tr.docs }}/admin/fault-tolerant-execution.html#id1).
    * Тип хранилища. Укажите один из двух блоков:

        * `service_s3` — использовать служебный бакет на стороне {{ mtr-name }}. Оставьте блок пустым: `service_s3 = {}`.
        * `s3` — использовать пользовательский [бакет {{ objstorage-name }}](../../../storage/concepts/bucket.md):

            * `bucket` — имя бакета. [Сервисному аккаунту](../../../iam/concepts/users/service-accounts.md) кластера должна быть назначена роль [storage.editor](../../../storage/security/index.md#storage-editor) на этот бакет.

        Подробнее о типах хранилища в разделе [{#T}](../../../managed-trino/concepts/retry-policy.md#exchange-manager-storage).
