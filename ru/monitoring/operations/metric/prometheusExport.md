---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Экспорт метрик в формате Prometheus
Чтобы выгрузить метрики в формате {{ prometheus-name }}, воспользуйтесь методом [prometheusMetrics](../../api-ref/MetricsData/prometheusMetrics.md). Для загрузки метрик в {{ prometheus-name }} необходимо предварительно настроить сбор метрик в {{ prometheus-name }}.

Пример настройки сбора метрик из {{ monitoring-name }} в {{ prometheus-name }}:
1. Выберите каталог, с которого вы хотите собирать данные.
1. Выберите сервис из следующего списка:
   - `compute` — {{ compute-name }};
   - `storage` — {{ objstorage-name }};
   - `managed-postgresql` — {{ mpg-name }};
   - `managed-clickhouse` — {{ mch-name }};
   - `managed-mongodb` — {{ mmg-name }};
   - `managed-mysql` — {{ mmy-name }};
   - `managed-redis` — {{ mrd-name }};
   - `managed-kafka` — {{ mkf-name }};
   - `managed-elasticsearch` — {{ mes-name }};
   - `managed-sqlserver` — {{ mms-name }}
   - `managed-kubernetes` — {{ managed-k8s-name }};
   - `serverless-functions` — {{ sf-name }};
   - `serverless_triggers_client_metrics` — триггеры {{ sf-name }};
   - `ydb` — {{ ydb-name }};
   - `interconnect` — {{ interconnect-name }};
   - `certificate-manager` — {{ certificate-manager-name }};
   - `data-transfer` — {{ data-transfer-name }};
   - `data-proc` — {{ dataproc-name }};
   - `serverless-apigateway` — {{ api-gw-name }}.
1. Создайте статичный [API-ключ](../../../iam/operations/api-key/create.md) для [сервисного аккаунта](../../../iam/concepts/users/service-accounts).
1. [Назначьте сервисному аккаунту роль](../../../iam/operations/roles/grant#access-to-sa) `{{ roles-monitoring-viewer }}` на выбранный каталог.
1. В [конфигурацию Prometheus](https://prometheus.io/docs/prometheus/latest/configuration/configuration) в секцию для сбора данных добавьте еще одну задачу (`job`):
   ```yaml
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
1. Перезапустите {{ prometheus-name }}.
1. Проверьте сбор данных в пользовательском интерфейсе {{ prometheus-name }}: `http://localhost:9090/targets` (замените `localhost` именем хоста, на котором установлен {{ prometheus-name }}).
1. При необходимости изменения имен меток воспользуйтесь механизмом [relabeling](https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config).

{% note tip %}

Если у вас много метрик, увеличьте таймаут на сбор данных (`scrape_timeout`) до 60s.

{% endnote %}
