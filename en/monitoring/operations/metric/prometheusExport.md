# Exporting metrics in Prometheus format

To export metrics in the {{ prometheus-name }} format, use the method [prometheusMetrics](../../api-ref/MetricsData/prometheusMetrics.md). Before uploading metrics to {{ prometheus-name }}, set up metric collection in {{ prometheus-name }}.

An example of metric collection setup from {{ monitoring-name }} in {{ prometheus-name }}:

1. Select the folder you want to collect data from.
1. Select a service from the following list:
   - `compute` — {{ compute-name }}.
   - `storage` — {{ objstorage-name }}.
   - `managed-postgresql` — {{ mpg-name }}.
   - `managed-clickhouse` — {{ mch-name }}.
   - `managed-mongodb` — {{ mmg-name }}.
   - `managed-mysql` — {{ mmy-name }}.
   - `managed-redis` — {{ mrd-name }}.
   - `managed-kafka` — {{ mkf-name }}.
   - `managed-elasticsearch` — {{ mes-name }}.
   - `managed-sqlserver` — {{ mms-name }}.
   - `managed-kubernetes` — {{ managed-k8s-name }}.
   - `serverless-functions` — {{ sf-name }}.
   - `serverless_triggers_client_metrics` — {{ sf-name }} triggers.
   - `ydb` — {{ ydb-name }}.
   - `interconnect` — {{ interconnect-name }}.
   - `certificate-manager` — {{ certificate-manager-name }}.
   - `data-transfer` — {{ data-transfer-name }}.
   - `data-proc` — {{ dataproc-name }}. 
   - `serverless-apigateway` — {{ api-gw-name }}.
1. Create a static [API key](../../../iam/operations/api-key/create.md) for your [service account](../../../iam/concepts/users/service-accounts).
1. [Assign to the service account the role](../../../iam/operations/roles/grant#access-to-sa) `{{ roles-monitoring-viewer }}` for the selected folder.
1. Add a new `job` to the data collection section of the [Prometheus configuration](https://prometheus.io/docs/prometheus/latest/configuration/configuration).

   ```yaml
   ...
   scrape_configs:
     ...
     - job_name: 'yc-monitoring-export'
       metrics_path: '/monitoring/v2/prometheusMetrics'
       params:
         folderId:
         - '<folderId>' # for example, aoeng2krmasimogorn5m
         service:
         - '<service>' # for example, managed-mongodb
       bearer_token: '<api_key>'
       # Or use a file (recommended):
       # bearer_token_file: '<name of file with api_key>'
       static_configs:
       - targets: ['monitoring.api.cloud.yandex.net']
         labels:
           folderId: '<folderId>'
           service: '<serviceId>'
   ```
1. Restart {{ prometheus-name }}.
1. Check the data collection in the {{ prometheus-name }} user interface: `http://localhost:9090/targets` (replace `localhost` with the name of the host running {{ prometheus-name }}).
1. If you need to change label names, use [relabeling](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config).

{% note tip %}

If you have a lot of metrics, increase the data collection timeout (`scrape_timeout`) to 60s.

{% endnote %}

