{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the cloud to view quotas for.
  1. Select the **{{ ui-key.yacloud.iam.cloud.switch_quotas }}** tab.
     
     The page will display a list of services used in your cloud.
  
  1. Expand the relevant service section and view the values in the **{{ ui-key.yacloud.iam.cloud.quotas.column_usage }}** column.
  
     * Two numbers stand for `consumed quota / quota value`, e.g., `2 / 20` or `1.203 / 5,120 GB`.

     * A single number is a non-adjustable `limit`.

  1. To estimate resource consumption, at the top right, select:
     * **{{ ui-key.yacloud.iam.cloud.quotas.value_status-warning }}**: Resources consuming over a half of the quota.
     * **{{ ui-key.yacloud.iam.cloud.quotas.value_status-error }}**: Resources that are almost exhausted.


- API {#api}

  To view the value of a certain quota, i.e., the current resource limit, use the [get](../../quota-manager/api-ref/QuotaLimit/get.md) REST API method for the [QuotaLimit](../api-ref/QuotaLimit/) resource or the [QuotaLimitService/Get](../../quota-manager/api-ref/grpc/QuotaLimit/get.md) gRPC API call.

{% endlist %}