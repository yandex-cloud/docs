[Документация Yandex Cloud](../index.md) > Yandex Monitoring > Monitoring

# Yandex Monitoring

Yandex Monitoring позволяет собирать и хранить метрики, а также отображать их в виде графиков на дашбордах.

Для сервиса действует <a href="https://yandex.ru/legal/cloud_sla">соглашение об уровне обслуживания</a>. Уровень обслуживания сервиса определен в документе <a href="https://yandex.ru/legal/cloud_sla_ym">Уровень обслуживания Yandex Monitoring</a>.

# Yandex Monitoring

 - [Начало работы](quickstart.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Работа с метриками

 - [Обзор метрик](operations/metric/metric-explorer.md)

 - [Поставка системных метрик Linux](operations/unified-agent/linux_metrics.md)

 - [Поставка метрик пользовательских приложений](operations/unified-agent/pull_prometheus.md)

 - [Поставка метрик HAProxy и других сторонних приложений](operations/unified-agent/haproxy.md)

 - [Поставка метрик с хостов вне Yandex Cloud](operations/unified-agent/non-yc.md)

 - [Запись пользовательских метрик через API](operations/metric/add.md)

 - [Получение списка метрик](operations/metric/list.md)

 - [Выгрузка метрик](operations/metric/get.md)

 - [Экспорт метрик в формате Prometheus](operations/metric/prometheusExport.md)

### Работа с дашбордами

 - [Создание и управление дашбордом](operations/dashboard/create.md)

 - [Копирование дашборда](operations/dashboard/copy.md)

 - [Добавление виджета на дашборд](operations/dashboard/add-widget.md)

 - [Добавление параметра дашборда](operations/dashboard/add-parameters.md)

 - [Управление виджетами](operations/dashboard/widget-management.md)

 - [Удаление виджета с дашборда](operations/dashboard/delete-widget.md)

 - [Удаление дашборда](operations/dashboard/delete-dashboard.md)

 - [Примеры работы с gRPC API](operations/dashboard/api-examples.md)

### Работа с алертами

 - [Создание алерта](operations/alert/create-alert.md)

 - [Создание канала уведомлений с получателем](operations/alert/create-channel.md)

 - [Создание канала уведомлений с вызовом функции](operations/alert/create-channel-function.md)

 - [Создание webhook с вызовом внешнего API](operations/alert/alert-call-function.md)

 - [Создание политики эскалаций](operations/alert/create-escalation.md)

 - [Удаление алерта](operations/alert/delete-alert.md)

## Агент сбора метрик

 - [Обзор](concepts/data-collection/unified-agent/index.md)

 - [Установка и обновление](concepts/data-collection/unified-agent/installation.md)

 - [Запуск и остановка](concepts/data-collection/unified-agent/run-and-stop.md)

### Конфигурирование

 - [Обзор](concepts/data-collection/unified-agent/configuration.md)

 - [Входы](concepts/data-collection/unified-agent/inputs.md)

 - [Выходы](concepts/data-collection/unified-agent/outputs.md)

 - [Маршрутизация](concepts/data-collection/unified-agent/routing.md)

 - [Хранилища](concepts/data-collection/unified-agent/storage.md)

 - [Фильтры](concepts/data-collection/unified-agent/filters.md)

 - [Служебные](concepts/data-collection/unified-agent/services.md)

 - [Рекомендации по использованию агента](concepts/data-collection/unified-agent/best-practices.md)

 - [Возможные ошибки](concepts/data-collection/unified-agent/errors.md)

 - [Удаление](concepts/data-collection/unified-agent/delete.md)

## Концепции

 - [Обзор сервиса](concepts/index.md)

 - [Модель данных](concepts/data-model.md)

### Визуализация

 - [Обзор](concepts/visualization/index.md)

 - [Обзор метрик](concepts/visualization/metric-explorer.md)

 - [Строка запроса](concepts/visualization/query-string.md)

 - [Виджеты](concepts/visualization/widget.md)

 - [Дашборд](concepts/visualization/dashboard.md)

 - [Язык запросов](concepts/querying.md)

### Алертинг

 - [Обзор](concepts/alerting.md)

 - [Алерт](concepts/alerting/alert.md)

 - [Аннотация](concepts/alerting/annotation.md)

 - [Канал уведомлений](concepts/alerting/notification-channel.md)

 - [Эскалации](concepts/alerting/escalations.md)

 - [Прореживание данных](concepts/decimation.md)

 - [Удаление устаревших метрик (TTL)](concepts/ttl.md)

 - [Квоты и лимиты](concepts/limits.md)

## Практические руководства

 - [Все практические руководства](tutorials/index.md)

 - [Автомасштабирование группы ВМ для обработки сообщений из очереди](tutorials/autoscale-monitoring.md)

 - [Мониторинг показаний датчиков и уведомления о событиях](tutorials/monitoring.md)

 - [Настройка дашбордов и алертов для Audit Trails](tutorials/alerts-monitoring.md)

 - [Поиск проблем с производительностью кластера Managed Service for PostgreSQL](tutorials/mpg-performance-problems.md)

 - [Сбор метрик кластера «1С:Предприятие» на базе Linux](tutorials/collect-metrics-1c-cluster.md)

## Yandex Managed Service for Prometheus®

 - [Обзор](operations/prometheus/index.md)

### Запись метрик

 - [Обзор](operations/prometheus/ingestion/index.md)

 - [Агент сбора метрик](operations/prometheus/ingestion/prometheus-agent.md)

 - [Remote Write](operations/prometheus/ingestion/remote-write.md)

 - [Диагностика и устранение проблем](operations/prometheus/ingestion/troubleshooting.md)

### Чтение метрик

 - [Обзор](operations/prometheus/querying/index.md)

 - [Remote Read](operations/prometheus/querying/remote-read.md)

 - [Визуализация](operations/prometheus/querying/monitoring.md)

 - [Grafana](operations/prometheus/querying/grafana.md)

 - [Правила записи](operations/prometheus/recording-rules.md)

 - [Правила алертинга](operations/prometheus/alerting-rules.md)

 - [Чтение и запись метрик кластера Kubernetes](operations/prometheus/read-write-for-kubernetes.md)

 - [Управление доступом](security/index.md)

## Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

### REST

 - [Обзор](api-ref/index.md)

#### MetricsData

 - [Обзор](api-ref/MetricsData/index.md)

 - [read](api-ref/MetricsData/read.md)

 - [write](api-ref/MetricsData/write.md)

 - [prometheusMetrics](api-ref/MetricsData/prometheusMetrics.md)

#### MetricsMeta

 - [Обзор](api-ref/MetricsMeta/index.md)

 - [listLabelKeys](api-ref/MetricsMeta/listLabelKeys.md)

 - [listLabelValues](api-ref/MetricsMeta/listLabelValues.md)

 - [listMetricNames](api-ref/MetricsMeta/listMetricNames.md)

 - [listMetrics](api-ref/MetricsMeta/listMetrics.md)

### gRPC (англ.)

 - [Обзор](api-ref/api-ref-grpc/index.md)

 - [DashboardService](api-ref/api-ref-grpc/DashboardService.md)

## Справочник метрик

 - [Все справочники метрик](metrics-ref/index.md)

 - [AI Studio](metrics-ref/ai-studio-ref.md)

 - [API Gateway](metrics-ref/api-gateway-ref.md)

 - [Application Load Balancer](metrics-ref/alb-ref.md)

 - [Audit Trails](metrics-ref/at-ref.md)

 - [BareMetal](metrics-ref/baremetal-ref.md)

 - [Certificate Manager](metrics-ref/certificate-manager-ref.md)

 - [Cloud Backup](metrics-ref/backup-ref.md)

 - [Cloud CDN](metrics-ref/cdn-ref.md)

 - [Cloud Functions](metrics-ref/functions-ref.md)

 - [Cloud Logging](metrics-ref/logging-ref.md)

 - [Cloud Notification Service](metrics-ref/cns-ref.md)

 - [Yandex Cloud Postbox](metrics-ref/postbox-ref.md)

 - [Compute Cloud](metrics-ref/compute-ref.md)

 - [Container Registry](metrics-ref/container-registry-ref.md)

 - [Yandex Data Processing](metrics-ref/data-processing-ref.md)

 - [Data Transfer](metrics-ref/data-transfer-ref.md)

 - [Cloud DNS](metrics-ref/dns-ref.md)

 - [Identity and Access Management](metrics-ref/iam-ref.md)

 - [Yandex IoT Core](metrics-ref/iot-core-ref.md)

 - [Key Management Service](metrics-ref/kms-ref.md)

 - [Yandex Lockbox](metrics-ref/lockbox-ref.md)

 - [Managed Service for Apache Airflow™](metrics-ref/managed-airflow-ref.md)

 - [Managed Service for Apache Kafka®](metrics-ref/managed-kafka-ref.md)

 - [Managed Service for Apache Spark™](metrics-ref/managed-spark-ref.md)

 - [Managed Service for ClickHouse®](metrics-ref/managed-clickhouse-ref.md)

 - [Yandex MPP Analytics for PostgreSQL](metrics-ref/managed-greenplum-ref.md)

 - [Managed Service for GitLab](metrics-ref/managed-gitlab-ref.md)

 - [Managed Service for Kubernetes](metrics-ref/managed-kubernetes-ref.md)

 - [Yandex StoreDoc](metrics-ref/managed-mongodb-ref.md)

 - [Managed Service for MySQL®](metrics-ref/managed-mysql-ref.md)

 - [Managed Service for OpenSearch](metrics-ref/managed-opensearch-ref.md)

 - [Managed Service for PostgreSQL](metrics-ref/managed-postgresql-ref.md)

 - [Managed Service for Trino](metrics-ref/managed-trino-ref.md)

 - [Yandex Managed Service for Valkey™](metrics-ref/managed-valkey-ref.md)

 - [Managed Service for YDB](metrics-ref/ydb-ref.md)

 - [Managed Service for YTsaurus](metrics-ref/managed-ytsaurus-ref.md)

 - [Message Queue](metrics-ref/message-queue-ref.md)

 - [Monitoring](metrics-ref/monitoring-ref.md)

 - [Network Load Balancer](metrics-ref/network-load-balancer-ref.md)

 - [Object Storage](metrics-ref/storage-ref.md)

 - [Serverless Integrations](metrics-ref/serverless-integrations-ref.md)

 - [Serverless Containers](metrics-ref/serverless-containers-ref.md)

 - [SmartCaptcha](metrics-ref/captcha-ref.md)

 - [Smart Web Security](metrics-ref/smartwebsecurity-ref.md)

 - [Unified Agent](metrics-ref/unifiedagent-ref.md)

## Вопросы и ответы

 - [Общие вопросы](qa/general.md)

 - [Навигация](qa/navigation.md)

 - [Сбор и экспорт метрик](qa/metrics-export.md)

 - [Метрики и единицы измерения](qa/metrics-measure.md)

 - [Алерты / уведомления](qa/alerts.md)

 - [Все вопросы на одной странице](qa/all.md)

 - [Правила тарификации](pricing.md)

 - [Справочник Terraform](tf-ref.md)

 - [История изменений](release-notes.md)

 - [Обучающие курсы](training.md)