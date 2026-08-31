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
      # Specify either of the two sections: service_s3 or s3.
      service_s3 = {}
      s3 = {
        bucket = "<user_bucket_name>"
      }
    }
  }
  ...
}
```

Where:

* `policy`: Query retry method. The possible values are:

    * `TASK`: Retries the intermediate task within the query that caused worker failure.
    * `QUERY`: Retries all [stages of the query](../../../managed-trino/concepts/index.md#query-execution) in which the worker failed.

* `additional_properties`: Additional query retry parameters in `"<key>" = "<value>"` format. Learn more about parameters in [this {{ TR }} guide]({{ tr.docs }}/admin/fault-tolerant-execution.html#advanced-configuration).

* `exchange_manager`: Exchange Manager storage parameters:

    * `additional_properties`: Additional Exchange Manager storage parameters in `"<key>" = "<value>"` format. Learn more about parameters in [this {{ TR }} guide]({{ tr.docs }}/admin/fault-tolerant-execution.html#id1).
    * Storage type. Specify one of the two sections:

        * `service_s3`: Use a service bucket on the {{ mtr-name }} side. Leave this section empty: `service_s3 = {}`.
        * `s3`: Use a custom [{{ objstorage-name }} bucket](../../../storage/concepts/bucket.md):

            * `bucket`: Bucket name. Make sure to grant the [storage.editor](../../../storage/security/index.md#storage-editor) role to the cluster's [service account](../../../iam/concepts/users/service-accounts.md).

        For more on storage types, see [{#T}](../../../managed-trino/concepts/retry-policy.md#exchange-manager-storage).
