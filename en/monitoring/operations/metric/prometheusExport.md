# Exporting metrics in Prometheus format
To export metrics in {{ prometheus-name }} format, use the [prometheusMetrics](../../api-ref/MetricsData/prometheusMetrics.md) method. Set up metric collection in {{ prometheus-name }} before pushing metrics to it.

Here is an example of setting up {{ monitoring-name }} metric collection in {{ prometheus-name }}:
1. Select the folder you want to collect data from.
1. Select a service from the following list:
   - `application-load-balancer`: {{ alb-name }}.
   - `audit-trails`: {{ at-name }}.
   - `cdn`: {{ cdn-name }}.
   - `certificate-manager`: {{ certificate-manager-name }}.
   - `compute`: {{ compute-name }}.
   - `container-registry`: {{ container-registry-name }}.
   - `data-proc`: {{ dataproc-name }}.
   - `data-streams`: {{ yds-name }}.
   - `data-transfer`: {{ data-transfer-name }}.
   - `iam`: {{ iam-name }}.
   - `interconnect`: {{ interconnect-name }}.
   - `kms`: {{ kms-name }}.
   - `logging`: {{ cloud-logging-name }}.
   - `managed-clickhouse`: {{ mch-name }}.
   - `managed-elasticsearch`: {{ mes-name }}.
   - `managed-gitlab`: {{ mgl-name }}.
   - `managed-greenplum`: {{ mgp-name }}.
   - `managed-kafka`: {{ mkf-name }}.
   - `managed-kubernetes`: {{ managed-k8s-name }}.
   - `managed-mongodb`: {{ mmg-name }}.
   - `managed-mysql`: {{ mmy-name }}.
   - `managed-opensearch`: {{ mos-name }}.
   - `managed-postgresql`: {{ mpg-name }}.
   - `managed-redis`: {{ mrd-name }}.
   - `managed-sqlserver`: {{ mms-name }}.
   - `message-queue`: {{ message-queue-name }}.
   - `monitoring`: {{ monitoring-name }}.
   - `network-load-balancer`: {{ network-load-balancer-name }}.
   - `postbox`: {{ postbox-name }}.
   - `serverless-apigateway`: {{ api-gw-name }}.
   - `serverless-containers`: {{ serverless-containers-name }}.
   - `serverless-functions`: {{ sf-name }}.
   - `speechkit`: {{ speechkit-name }}.
   - `storage`: {{ objstorage-name }}.
   - `translate`: {{ translate-name }}.
   - `vision`: {{ vision-name }}.
   - `ydb`: {{ ydb-name }}.


1. Create a static [API key](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) for the [service account](../../../iam/concepts/users/service-accounts).
1. [Assign the service account the `{{ roles-monitoring-viewer }}`](../../../iam/operations/roles/grant#access-to-sa) role for the selected folder.
1. In the [Prometheus configuration](https://prometheus.io/docs/prometheus/latest/configuration/configuration), add another `job` to the data collection section:
   ```yaml
   ...
   scrape_configs:
     ...
     - job_name: 'yc-monitoring-export'
       metrics_path: '/monitoring/v2/prometheusMetrics'
       scheme: 'https'
       params:
         folderId:
         - '<folder_ID>' # For example, it can be `aoeng2krmasi`********.
         service:
         - '<service>' # For example, it can be `managed-mongodb`.
       bearer_token: '<API_key>'
       # Alternatively, you can use a file (recommended):
       # bearer_token_file: '<name_of_file_with_API_key>'
       static_configs:
       - targets: ['monitoring.{{ api-host }}']
         labels:
           folderId: '<folder_ID>'
           service: '<service_ID>'
   ```
1. Restart {{ prometheus-name }}.
1. Check data collection in the {{ prometheus-name }} UI: `http://localhost:9090/targets` (replace `localhost` with the name of your host running {{ prometheus-name }}).
1. If you need to change label names, use [relabeling](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config).

{% note tip %}

When dealing with lots of metrics, increase `scrape_timeout` to `60s`.

{% endnote %}

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}
