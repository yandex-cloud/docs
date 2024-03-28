# Exporting metrics in Prometheus format
To export metrics in the {{ prometheus-name }} format, use the [prometheusMetrics](../../api-ref/MetricsData/prometheusMetrics.md) method. Before uploading metrics to {{ prometheus-name }}, set up metric collection in {{ prometheus-name }}.

An example of metric collection setup from {{ monitoring-name }} in {{ prometheus-name }}:
1. Select the folder you want to collect data from.
1. Select a service from the following list:
   - `application-load-balancer`: {{ alb-name }}
   - `audit-trails`: {{ at-name }}
   - `cdn`: {{ cdn-name }}.
   - `certificate-manager`: {{ certificate-manager-name }}
   - `compute`: {{ compute-name }}
   - `container-registry`: {{ container-registry-name }}
   - `data-proc`: {{ dataproc-name }}
   - `data-streams`: {{ yds-name }}
   - `data-transfer`: {{ data-transfer-name }}
   - `iam`: {{ iam-name }}
   - `interconnect`: {{ interconnect-name }}
   - `kms`: {{ kms-name }}
   - `logging`: {{ cloud-logging-name }}
   - `managed-clickhouse`: {{ mch-name }}
   - `managed-elasticsearch`: {{ mes-name }}
    `managed-greenplum`: {{ mgp-name }}
   - `managed-kafka`: {{ mkf-name }}
   - `managed-kubernetes`: {{ managed-k8s-name }}
   - `managed-mongodb`: {{ mmg-name }}
   - `managed-mysql`: {{ mmy-name }}
   - `managed-opensearch`: {{ mos-name }}
   - `managed-postgresql`: {{ mpg-name }}
   - `managed-redis`: {{ mrd-name }}
   - `managed-sqlserver`: {{ mms-name }}
   - `message-queue`: {{ message-queue-name }}
   - `monitoring`: {{ monitoring-name }}
   - `network-load-balancer`: {{ network-load-balancer-name }}
   - `serverless-apigateway`: {{ api-gw-name }}
   - `serverless-containers`: {{ serverless-containers-name }}
   - `serverless-functions`: {{ sf-name }}
   - `speechkit`: {{ speechkit-name }}
   - `storage`: {{ objstorage-name }}
   - `translate`: {{ translate-name }}
   - `vision`: {{ vision-name }}
   - `ydb`: {{ ydb-name }}
1. Create a static [API key](../../../iam/operations/api-key/create.md) for the [service account](../../../iam/concepts/users/service-accounts).
1. [Assign the service account the `{{ roles-monitoring-viewer }}` role](../../../iam/operations/roles/grant#access-to-sa) for the selected folder.
1. Add a new `job` to the data collection section of the [Prometheus configuration](https://prometheus.io/docs/prometheus/latest/configuration/configuration).
   ```yaml
   ...
   scrape_configs:
     ...
     - job_name: 'yc-monitoring-export'
       metrics_path: '/monitoring/v2/prometheusMetrics'
       scheme: 'https'
       params:
         folderId:
         - '<folder_ID>' # e.g., aoeng2krmasi********
         service:
         - '<service>' # e.g., managed-mongodb
       bearer_token: '<API_key>'
       # Or via a file (recommended):
       # bearer_token_file: '<name_of_the_file_with_the_API_key>'
       static_configs:
       - targets: ['monitoring.{{ api-host }}']
         labels:
           folderId: '<folder_ID>'
           service: '<service_ID>'
   ```
1. Restart {{ prometheus-name }}.
1. Check the data collection in the {{ prometheus-name }} user interface: `http://localhost:9090/targets` (replace `localhost` with the name of the host running {{ prometheus-name }}).
1. If you need to change label names, use [relabeling](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config).

{% note tip %}

If you have a lot of metrics, increase the data collection timeout (`scrape_timeout`) to 60s.

{% endnote %}

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}
