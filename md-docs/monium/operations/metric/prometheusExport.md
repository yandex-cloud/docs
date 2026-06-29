# Экспорт метрик в формате Prometheus

Чтобы выгрузить метрики в формате Prometheus, воспользуйтесь методом [prometheusMetrics](../../api-ref/MetricsData/prometheusMetrics.md). Для загрузки метрик в Prometheus необходимо предварительно настроить сбор метрик в Prometheus.

Пример настройки сбора метрик из Monium Metrics в Prometheus:
1. Выберите каталог, с которого вы хотите собирать данные.
1. Выберите сервис из следующего списка:
   * `application-load-balancer` — Application Load Balancer.
   * `audit-trails` — Audit Trails.
   * `yccdn` — Cloud CDN.
   * `certificate-manager` — Certificate Manager.
   * `compute` — Compute Cloud.
   * `container-registry` — Container Registry.
   * `data-proc` — Yandex Data Processing.
   * `data-streams` — Data Streams.
   * `data-transfer` — Data Transfer.
   * `iam` — Identity and Access Management.
   * `interconnect` — Cloud Interconnect.
   * `kms` — Key Management Service.
   * `logging` — Cloud Logging.
   * `managed-clickhouse` — Managed Service for ClickHouse®.
   * `managed-gitlab` — Managed Service for GitLab.
   * `managed-greenplum` — Yandex MPP Analytics for PostgreSQL.
   * `managed-kafka` — Managed Service for Apache Kafka®.
   * `managed-kubernetes` — Managed Service for Kubernetes.
   * `managed-mongodb` — Yandex StoreDoc.
   * `managed-mysql` — Managed Service for MySQL®.
   * `managed-opensearch` — Managed Service for OpenSearch.
   * `managed-postgresql` — Managed Service for PostgreSQL.
   * `managed-valkey` — Yandex Managed Service for Valkey™.
   * `managed-sqlserver` — Managed Service for SQL Server.
   * `message-queue` — Message Queue.
   * `monitoring` — Monium Metrics.
   * `network-load-balancer` — Network Load Balancer.
   * `postbox` — Yandex Cloud Postbox.
   * `serverless-apigateway` — API Gateway.
   * `serverless-containers` — Serverless Containers.
   * `serverless-functions` — Cloud Functions.
   * `speechkit` — SpeechKit.
   * `storage` — Object Storage.
   * `translate` — Translate.
   * `vision` — Vision OCR.
   * `ydb` — Managed Service for YDB.

1. Создайте [API-ключ](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) для [сервисного аккаунта](../../../iam/concepts/users/service-accounts.md).
1. [Назначьте сервисному аккаунту роль](../../../iam/operations/roles/grant.md#access-to-sa) `monitoring.viewer` на выбранный каталог.
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
       - targets: ['monitoring.api.cloud.yandex.net']
         labels:
           folderId: '<идентификатор_каталога>'
           service: '<идентификатор_сервиса>'
   ```

1. Перезапустите Prometheus.
1. Проверьте сбор данных в пользовательском интерфейсе Prometheus: `http://localhost:9090/targets` (замените `localhost` именем хоста, на котором установлен Prometheus).
1. При необходимости изменения имен меток воспользуйтесь механизмом [relabeling](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config).

{% note tip %}

Если у вас много метрик, увеличьте таймаут на сбор данных (`scrape_timeout`) до 60s.

{% endnote %}

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._