```hcl
resource "yandex_trino_cluster" "<cluster_name>" {
  ...
  retry_policy = {
    policy = "<object_type_for_retry>"
    additional_properties = {
      <list_of_additional_retry_policy_parameters>
    }
    exchange_manager = {
      additional_properties = {
        <list_of_additional_storage_parameters>
      }
      service_s3 = {}
    }
  }
  ...
}
```

Where:

* `policy`: Query retry method. The possible values are:

    * `TASK`: Retries the intermediate task within the query that caused worker failure.
    * `QUERY`: Retries all [stages of the query](../../../managed-trino/concepts/index.md#query-execution) in which the worker failed.

* `additional_properties`: Additional query retry parameters in `"<key>" = "<value>"` format. For more information about parameters, see the [{{ TR }} documentation]({{ tr.docs}}/admin/fault-tolerant-execution.html#advanced-configuration).

* `exchangeManager`: Exchange Manager storage parameters:

    * `service_s3`: Use an S3 storage to write data when retrying queries.
    * `additional_properties`: Additional Exchange Manager storage parameters in `"<key>" = "<value>"` format. For more information about parameters, see the [{{ TR }} documentation]({{ tr.docs}}/admin/fault-tolerant-execution.html#id1).
