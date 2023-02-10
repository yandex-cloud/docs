# Exporting metrics in Prometheus format
To export metrics in the {{ prometheus-name }} format, use the method [prometheusMetrics](../../api-ref/MetricsData/prometheusMetrics.md). Before uploading metrics to {{ prometheus-name }}, set up metric collection in {{ prometheus-name }}.

An example of metric collection setup from {{ monitoring-name }} in {{ prometheus-name }}:
1. Select the folder you want to collect data from.
1. Select a service from the following list:
   - `application-load-balancer`: {{ alb-name }}.
   - `audit-trails`: {{ at-name }}.
   - `certificate-manager`: {{ certificate-manager-name }}.
   - `compute`: {{ compute-name }}.
   - `container-registry`: {{ container-registry-name }}.
   {% if product == "yandex-cloud" %}- `data-proc`: {{ dataproc-name }}.{% endif %}
   {% if product == "yandex-cloud" %}- `data-streams`: {{ yds-name }}.{% endif %}
   - `data-transfer`: {{ data-transfer-name }}.
   - `iam`: {{ iam-name }}.
   {% if product == "yandex-cloud" %}- `interconnect`: {{ interconnect-name }}.{% endif %}
   - `kms`: {{ kms-name }}.
   {% if product == "yandex-cloud" %}- `logging`: {{ cloud-logging-name }}.{% endif %}
   - `managed-clickhouse`: {{ mch-name }}.
   {% if product == "yandex-cloud" %}- `managed-elasticsearch`: {{ mes-name }}.{% endif %}
   {% if product == "yandex-cloud" %} `managed-greenplum`: {{ mgp-name }}.{% endif %}
   - `managed-kafka`: {{ mkf-name }}.
   - `managed-kubernetes`: {{ managed-k8s-name }}.
   {% if product == "yandex-cloud" %}- `managed-mongodb`: {{ mmg-name }}.{% endif %}
   - `managed-mysql`: {{ mmy-name }}.
   - `managed-postgresql`: {{ mpg-name }}.
   {% if product == "yandex-cloud" %}- `managed-redis`: {{ mrd-name }}.{% endif %}
   {% if product == "yandex-cloud" %}- `managed-sqlserver`: {{ mms-name }}.{% endif %}
   - `message-queue`: {{ message-queue-name }}.
   - `monitoring`: {{ monitoring-name }}.
   - `network-load-balancer`: {{ network-load-balancer-name }}.
   {% if product == "yandex-cloud" %}- `serverless-apigateway`: {{ api-gw-name }}.{% endif %}
   {% if product == "yandex-cloud" %}- `serverless-containers`: {{ serverless-containers-name }}.{% endif %}
   {% if product == "yandex-cloud" %}- `serverless-functions`: {{ sf-name }}.{% endif %}
   {% if product == "yandex-cloud" %}- `speechkit`: {{ speechkit-name }}.{% endif %}
   - `storage`: {{ objstorage-name }}.
   {% if product == "yandex-cloud" %}- `translate`: {{ translate-name }}.{% endif %}
   {% if product == "yandex-cloud" %}- `vision`: {{ vision-name }}.{% endif %}
   {% if product == "yandex-cloud" %}- `ydb`: {{ ydb-name }}.{% endif %}
1. Create a static [API key](../../../iam/operations/api-key/create.md) for the [service account](../../../iam/concepts/users/service-accounts).
1. [Assign the service account the role](../../../iam/operations/roles/grant#access-to-sa) `{{ roles-monitoring-viewer }}` for the selected folder.
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
         - '<folderId>' # for example, aoeng2krmasimogorn5m
         service:
         - '<service>' # for example, managed-mongodb
       bearer_token: '<api_key>'
       # Or via a file (recommended):
       # bearer_token_file: '<name of the file with api_key>'
       static_configs:
       - targets: ['monitoring.{{ api-host }}']
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
