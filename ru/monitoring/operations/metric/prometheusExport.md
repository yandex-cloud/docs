# Экспорт метрик в формате Prometheus
Чтобы выгрузить метрики в формате {{ prometheus-name }}, воспользуйтесь методом [prometheusMetrics](../../api-ref/MetricsData/prometheusMetrics.md). Для загрузки метрик в {{ prometheus-name }} необходимо предварительно настроить сбор метрик в {{ prometheus-name }}.

Пример настройки сбора метрик из {{ monitoring-name }} в {{ prometheus-name }}:
1. Выберите каталог, с которого вы хотите собирать данные.
1. Выберите сервис из следующего списка:
   - `application-load-balancer` — {{ alb-name }}.
   - `audit-trails` — {{ at-name }}.
   - `cdn` — {{ cdn-name }}.
   - `certificate-manager` — {{ certificate-manager-name }}.
   - `compute` — {{ compute-name }}.
   - `container-registry` — {{ container-registry-name }}.
   - `data-proc` — {{ dataproc-name }}.
   - `data-streams` — {{ yds-name }}.
   - `data-transfer` — {{ data-transfer-name }}.
   - `iam` — {{ iam-name }}.
   - `interconnect` — {{ interconnect-name }}.
   - `kms` — {{ kms-name }}.
   - `logging` — {{ cloud-logging-name }}.
   - `managed-clickhouse` — {{ mch-name }}.
   - `managed-elasticsearch` — {{ mes-name }}.
   - `managed-greenplum` — {{ mgp-name }}.
   - `managed-kafka` — {{ mkf-name }}.
   - `managed-kubernetes` — {{ managed-k8s-name }}.
   - `managed-mongodb` — {{ mmg-name }}.
   - `managed-mysql` — {{ mmy-name }}.
   - `managed-opensearch` — {{ mos-name }}.
   - `managed-postgresql` — {{ mpg-name }}.
   - `managed-redis` — {{ mrd-name }}.
   - `managed-sqlserver` — {{ mms-name }}.
   - `message-queue` — {{ message-queue-name }}.
   - `monitoring` — {{ monitoring-name }}.
   - `network-load-balancer` — {{ network-load-balancer-name }}.
   - `serverless-apigateway` — {{ api-gw-name }}.
   - `serverless-containers` — {{ serverless-containers-name }}.
   - `serverless-functions` — {{ sf-name }}.
   - `speechkit` — {{ speechkit-name }}.
   - `storage` — {{ objstorage-name }}.
   - `translate` — {{ translate-name }}.
   - `vision` — {{ vision-name }}.
   - `ydb` — {{ ydb-name }}.


1. Создайте статичный [API-ключ](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) для [сервисного аккаунта](../../../iam/concepts/users/service-accounts).
1. [Назначьте сервисному аккаунту роль](../../../iam/operations/roles/grant#access-to-sa) `{{ roles-monitoring-viewer }}` на выбранный каталог.
1. В [конфигурацию Prometheus](https://prometheus.io/docs/prometheus/latest/configuration/configuration) в секцию для сбора данных добавьте еще одну задачу (`job`):
   ```yaml
   ...
   scrape_configs:
     ...
     - job_name: 'yc-monitoring-export'
       metrics_path: '/monitoring/v2/prometheusMetrics'
       scheme: 'https'
       params:
         folderId:
         - '<идентификатор_каталога>' # например, aoeng2krmasi********
         service:
         - '<сервис>' # например, managed-mongodb
       bearer_token: '<API-ключ>'
       # Или через файл (рекомендуется):
       # bearer_token_file: '<имя_файла_с_API-ключом>'
       static_configs:
       - targets: ['monitoring.{{ api-host }}']
         labels:
           folderId: '<идентификатор_каталога>'
           service: '<идентификатор_сервиса>'
   ```
1. Перезапустите {{ prometheus-name }}.
1. Проверьте сбор данных в пользовательском интерфейсе {{ prometheus-name }}: `http://localhost:9090/targets` (замените `localhost` именем хоста, на котором установлен {{ prometheus-name }}).
1. При необходимости изменения имен меток воспользуйтесь механизмом [relabeling](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config).

{% note tip %}

Если у вас много метрик, увеличьте таймаут на сбор данных (`scrape_timeout`) до 60s.

{% endnote %}

{% include [clickhouse-disclaimer](../../../_includes/clickhouse-disclaimer.md) %}
