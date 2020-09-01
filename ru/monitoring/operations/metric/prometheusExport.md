# Экспорт метрик в формате Prometheus
Чтобы выгрузить метрики в формате Prometheus, воспользуйтесь методом [prometheusMetrics](../../api-ref/MetricsData/prometheusMetrics.md). Для загрузки метрик в Prometheus необходимо предварительно настроить сбор метрик в Prometheus.

Пример настройки сбора метрик из {{ monitoring-name }} в Prometheus:
1. Выберите каталог, с которого вы хотите собирать данные.
1. Выберите сервис из следующего списка:
   - `compute` — {{ compute-name }};
   - `storage` — {{ objstorage-name }};
   - `managed-mongodb` — {{ mmg-name }};
   - `managed-postgresql` — {{ mpg-name }};
   - `managed-mysql` — {{ mmy-name }};
   - `managed-redis` — {{ mrd-name }};
   - `managed-clickhouse` — {{ mch-name }};
   - `managed-kafka` — {{ mkf-name }};
   - `serverless-functions` — {{ sf-name }};
   - `serverless_triggers_client_metrics` — триггеры {{ sf-name }}.
1. Создайте статичный [API-ключ](../../../iam/operations/api-key/create.md) для [сервисного аккаунта](../../../iam/concepts/users/service-accounts).
1. Назначьте сервисному аккаунту роль [viewer](../../../iam/operations/roles/grant#access-to-sa) на выбранный каталог.
1. В [конфигурацию Prometheus](https://prometheus.io/docs/prometheus/latest/configuration/configuration) в секцию для сбора данных добавьте еще одну задачу (`job`):
   ```
   ...
   scrape_configs:
     ...
     - job_name: 'yc-monitoring-export'
       metrics_path: '/monitoring/v2/prometheusMetrics'
       params:
         folderId:
         - '<folderId>' # например, aoeng2krmasimogorn5m
         service:
         - '<service>' # например, managed-mongodb
       bearer_token: '<api_key>'
       # Или через файл (рекомендуется):
       # bearer_token_file: '<имя файла с api_key>'
       static_configs:
       - targets: ['monitoring.api.cloud.yandex.net']
         labels:
           folderId: '<folderId>'
           service: '<serviceId>'
   ```
1. Перезапустите Prometheus.
1. Проверьте сбор данных в пользовательском интерфейсе Prometheus: `http://localhost:9090/targets` (замените `localhost` именем хоста, на котором установлен Prometheus).
1. При необходимости изменения имен меток воспользуйтесь механизмом [relabeling](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config).

{% note tip %}

Если у вас много метрик, увеличьте таймаут на сбор данных (`scrape_timeout`) до 60s.

{% endnote %}
