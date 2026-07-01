# Monium

Monium платформа для сбора, хранения и анализа телеметрии (метрик, логов и трейсов) облачных ресурсов и приложений, расположенных в любой инфраструктуре. Помогает следить за состоянием сервисов, получать уведомления о проблемах, находить причины сбоев и расследовать инциденты.

Для сервиса действует <a href="https://yandex.ru/legal/cloud_sla">соглашение об уровне обслуживания</a>. Уровень обслуживания сервиса определен в документе <a href="https://yandex.ru/legal/cloud_sla_monium">Уровень обслуживания Yandex Monitoring</a>.

# Monium

 - [Начало работы](quickstart.md)

 - [Обзор](overview.md)

## Поставка данных

 - [Обзор](collector/index.md)

 - [Особенности OTLP в Monium](collector/otlp-protocol.md)

 - [Создание и настройка проекта](collector/project.md)

### Otel Collector

 - [Настройка OTel Collector](collector/opentelemetry.md)

 - [OpenTelemetry SDK](collector/otlp-sdk.md)

 - [Пример для демо-приложения Java без использования агента](collector/otel-clinic-standalone-example.md)

 - [Пример для демо-приложения Java с использованием агента](collector/otel-clinic-example.md)

 - [Пример мониторинга ансамбля микросервисов в Kubernetes](collector/otel-k8s-example.md)

 - [Пример мониторинга Nginx в Kubernetes](collector/otel-k8s-nginx.md)

 - [Устранение неполадок при поставке данных](collector/troubleshooting.md)

### Fluent Bit

 - [Настройка Fluent Bit](collector/fluentbit.md)

 - [Пример для демо-приложения Java с Fluent Bit](collector/otel-clinic-fluentbit-example.md)

 - [Обработка логов](logs/write/fluent-bit.md)

### Unified Agent

 - [Обзор](concepts/data-collection/unified-agent/index.md)

 - [Установка и обновление](concepts/data-collection/unified-agent/installation.md)

 - [Запуск и остановка](concepts/data-collection/unified-agent/run-and-stop.md)

#### Конфигурирование

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

## Метрики

 - [Начало работы с метриками приложений](metrics/quickstart-app.md)

 - [Начало работы с метриками ресурсов Yandex Cloud](metrics/quickstart.md)

 - [Обзор возможностей](metrics/overview.md)

 - [Поиск и анализ метрик](metrics/metric-explorer.md)

### Поставка и экспорт метрик

 - [Все инструкции](operations/index.md)

 - [Поставка системных метрик Linux](operations/unified-agent/linux_metrics.md)

 - [Поставка метрик пользовательских приложений](operations/unified-agent/pull_prometheus.md)

 - [Поставка метрик HAProxy и других сторонних приложений](operations/unified-agent/haproxy.md)

 - [Поставка метрик с хостов вне Yandex Cloud](operations/unified-agent/non-yc.md)

 - [Запись пользовательских метрик через API](operations/metric/add.md)

 - [Получение списка метрик](operations/metric/list.md)

 - [Выгрузка метрик](operations/metric/get.md)

 - [Экспорт метрик в формате Prometheus](operations/metric/prometheusExport.md)

### Практические руководства

 - [Все практические руководства](tutorials/index.md)

 - [Автомасштабирование группы ВМ для обработки сообщений из очереди](tutorials/autoscale-monitoring.md)

 - [Мониторинг показаний датчиков и уведомления о событиях](tutorials/monitoring.md)

 - [Настройка дашбордов и алертов для Audit Trails](tutorials/alerts-monitoring.md)

 - [Поиск проблем с производительностью кластера Managed Service for PostgreSQL](tutorials/mpg-performance-problems.md)

 - [Сбор метрик кластера «1С:Предприятие» на базе Linux](tutorials/collect-metrics-1c-cluster.md)

### Справочник метрик

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

 - [Monium Metrics](metrics-ref/monitoring-ref.md)

 - [Network Load Balancer](metrics-ref/network-load-balancer-ref.md)

 - [Object Storage](metrics-ref/storage-ref.md)

 - [Serverless Integrations](metrics-ref/serverless-integrations-ref.md)

 - [Serverless Containers](metrics-ref/serverless-containers-ref.md)

 - [SmartCaptcha](metrics-ref/captcha-ref.md)

 - [Smart Web Security](metrics-ref/smartwebsecurity-ref.md)

 - [Unified Agent](metrics-ref/unifiedagent-ref.md)

 - [Прореживание данных](concepts/decimation.md)

 - [Удаление устаревших метрик (TTL)](concepts/ttl.md)

## Логи

 - [Начало работы с логами приложений](logs/quickstart.md)

 - [Начало работы с логами ресурсов Yandex Cloud](logs/quickstart-resources.md)

 - [Миграция с Cloud Logging](logs/logging-migration.md)

### Поставка данных

 - [Преобразование данных](logs/write/converting-data.md)

 - [Fluent Bit](logs/write/fluent-bit.md)

 - [Поиск и анализ логов](logs/logs-explorer.md)

### Концепции

 - [Обзор и основные понятия](logs/concepts/glossary.md)

 - [Язык запросов](logs/query.md)

 - [Рекомендации по разметке логов](logs/concepts/attributes-guide.md)

 - [Время хранения данных (TTL)](logs/concepts/ttl.md)

 - [Метрики логов](logs/logs-metrics.md)

 - [Ограничения](logs/limits.md)

## Трейсы

 - [Начало работы](traces/index.md)

 - [Основные понятия](traces/concepts.md)

### Инструментация приложений

 - [Автоматическая инструментация](traces/instrumentation/auto.md)

 - [Ручная инструментация](traces/instrumentation/manual.md)

 - [HTTP-взаимодействия](traces/instrumentation/http.md)

 - [Работа с базами данных](traces/instrumentation/database.md)

 - [RPC-вызовы](traces/instrumentation/rpc.md)

 - [Асинхронные операции](traces/instrumentation/async.md)

 - [Обработка ошибок](traces/instrumentation/exceptions.md)

 - [Повторные попытки](traces/instrumentation/retries.md)

### Работа с трейсами

 - [Поиск трейсов и спанов](traces/operations/traces-explorer.md)

 - [Карта сервисов](traces/operations/service-map.md)

 - [Просмотр и анализ трейса](traces/operations/trace-view.md)

 - [Язык запросов](traces/operations/query-language.md)

 - [Анализ критического пути](traces/operations/critical-path.md)

 - [Связь трейсов с логами](traces/operations/traces-logs.md)

 - [Архивация трейсов](traces/operations/archiving.md)

 - [Неполные трейсы](traces/operations/incomplete-traces.md)

### LLM-мониторинг

 - [Начало работы](traces/llm/quickstart.md)

 - [Автоматическая инструментация LLM-приложений](traces/llm/auto_instrumentation.md)

 - [Ручная инструментация LLM-приложений](traces/llm/manual_instrumentation.md)

 - [Просмотр и анализ LLM-трейсов](traces/llm/traces.md)

 - [Ограничения](traces/limits.md)

## Визуализация данных

 - [Обзор](visualization/index.md)

 - [Дашборд](concepts/visualization/dashboard.md)

 - [Виджеты](concepts/visualization/widget.md)

### Работа с дашбордами

 - [Создание и управление дашбордом](operations/dashboard/create.md)

 - [Копирование дашборда](operations/dashboard/copy.md)

 - [Добавление виджета на дашборд](operations/dashboard/add-widget.md)

 - [Добавление параметра дашборда](operations/dashboard/add-parameters.md)

 - [Управление виджетами](operations/dashboard/widget-management.md)

 - [Удаление виджета с дашборда](operations/dashboard/delete-widget.md)

 - [Удаление дашборда](operations/dashboard/delete-dashboard.md)

 - [Примеры работы с gRPC API](operations/dashboard/api-examples.md)

## Алерты

### Пошаговые инструкции

 - [Создание алерта](operations/alert/create-alert.md)

 - [Создание канала уведомлений с получателем](operations/alert/create-channel.md)

 - [Создание канала уведомлений с вызовом функции](operations/alert/create-channel-function.md)

 - [Создание webhook с вызовом внешнего API](operations/alert/alert-call-function.md)

 - [Создание политики эскалаций](operations/alert/create-escalation.md)

 - [Удаление алерта](operations/alert/delete-alert.md)

### Концепции

 - [Обзор](concepts/alerting.md)

 - [Алерт](concepts/alerting/alert.md)

 - [Аннотация](concepts/alerting/annotation.md)

 - [Канал уведомлений](concepts/alerting/notification-channel.md)

 - [Эскалации](concepts/alerting/escalations.md)

 - [Мьюты](alerts/mutes.md)

 - [Алерты-выражения](alerts/alert-expression.md)

## SLO

 - [Обзор](slo/index.md)

 - [Управление SLO](slo/management.md)

 - [Добавление виджета SLO на дашборд](slo/visualisation.md)

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

## Концепции

 - [Основные понятия](concepts/glossary.md)

 - [Конфигурация объектов](concepts/configuration-model.md)

 - [Модель данных](concepts/data-model.md)

 - [Язык запросов](concepts/querying.md)

 - [Строка запроса](concepts/visualization/query-string.md)

 - [Функции для поиска метрик](concepts/querying-functions.md)

 - [Время хранения данных (TTL)](concepts/common-ttl.md)

 - [Квоты и лимиты](concepts/limits.md)

 - [Управление доступом](security/index.md)

 - [Правила тарификации](pricing.md)

 - [Справочник Terraform](tf-ref.md)

## Справочник API

 - [Аутентификация в API](api-ref/authentication.md)

### Метрики

#### REST

 - [Обзор](api-ref/index.md)

##### MetricsData

 - [Обзор](api-ref/MetricsData/index.md)

 - [read](api-ref/MetricsData/read.md)

 - [write](api-ref/MetricsData/write.md)

 - [prometheusMetrics](api-ref/MetricsData/prometheusMetrics.md)

##### MetricsMeta

 - [Обзор](api-ref/MetricsMeta/index.md)

 - [listLabelKeys](api-ref/MetricsMeta/listLabelKeys.md)

 - [listLabelValues](api-ref/MetricsMeta/listLabelValues.md)

 - [listMetricNames](api-ref/MetricsMeta/listMetricNames.md)

 - [listMetrics](api-ref/MetricsMeta/listMetrics.md)

#### gRPC (англ.)

 - [Обзор](api-ref/api-ref-grpc/index.md)

 - [DashboardService](api-ref/api-ref-grpc/DashboardService.md)

### Логи

#### gRPC (англ.)

 - [Overview](api-ref/grpc/index.md)

##### Export

 - [Overview](api-ref/grpc/Export/index.md)

 - [Get](api-ref/grpc/Export/get.md)

 - [List](api-ref/grpc/Export/list.md)

 - [Create](api-ref/grpc/Export/create.md)

 - [Update](api-ref/grpc/Export/update.md)

 - [Delete](api-ref/grpc/Export/delete.md)

 - [Run](api-ref/grpc/Export/run.md)

 - [ListOperations](api-ref/grpc/Export/listOperations.md)

 - [ListAccessBindings](api-ref/grpc/Export/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/Export/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/Export/updateAccessBindings.md)

##### LogGroup

 - [Overview](api-ref/grpc/LogGroup/index.md)

 - [Get](api-ref/grpc/LogGroup/get.md)

 - [Stats](api-ref/grpc/LogGroup/stats.md)

 - [List](api-ref/grpc/LogGroup/list.md)

 - [Create](api-ref/grpc/LogGroup/create.md)

 - [Update](api-ref/grpc/LogGroup/update.md)

 - [Delete](api-ref/grpc/LogGroup/delete.md)

 - [ListResources](api-ref/grpc/LogGroup/listResources.md)

 - [ListOperations](api-ref/grpc/LogGroup/listOperations.md)

 - [ListAccessBindings](api-ref/grpc/LogGroup/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/LogGroup/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/LogGroup/updateAccessBindings.md)

##### LogIngestion

 - [Overview](api-ref/grpc/LogIngestion/index.md)

 - [Write](api-ref/grpc/LogIngestion/write.md)

##### LogReading

 - [Overview](api-ref/grpc/LogReading/index.md)

 - [Read](api-ref/grpc/LogReading/read.md)

##### Operation

 - [Overview](api-ref/grpc/Operation/index.md)

 - [Get](api-ref/grpc/Operation/get.md)

 - [Cancel](api-ref/grpc/Operation/cancel.md)

##### Sink

 - [Overview](api-ref/grpc/Sink/index.md)

 - [Get](api-ref/grpc/Sink/get.md)

 - [List](api-ref/grpc/Sink/list.md)

 - [Create](api-ref/grpc/Sink/create.md)

 - [Update](api-ref/grpc/Sink/update.md)

 - [Delete](api-ref/grpc/Sink/delete.md)

 - [ListOperations](api-ref/grpc/Sink/listOperations.md)

 - [ListAccessBindings](api-ref/grpc/Sink/listAccessBindings.md)

 - [SetAccessBindings](api-ref/grpc/Sink/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/grpc/Sink/updateAccessBindings.md)

#### REST (англ.)

 - [Overview](api-ref/index.md)

##### Export

 - [Overview](api-ref/Export/index.md)

 - [Get](api-ref/Export/get.md)

 - [List](api-ref/Export/list.md)

 - [Create](api-ref/Export/create.md)

 - [Update](api-ref/Export/update.md)

 - [Delete](api-ref/Export/delete.md)

 - [Run](api-ref/Export/run.md)

 - [ListOperations](api-ref/Export/listOperations.md)

 - [ListAccessBindings](api-ref/Export/listAccessBindings.md)

 - [SetAccessBindings](api-ref/Export/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/Export/updateAccessBindings.md)

##### LogGroup

 - [Overview](api-ref/LogGroup/index.md)

 - [Get](api-ref/LogGroup/get.md)

 - [Stats](api-ref/LogGroup/stats.md)

 - [List](api-ref/LogGroup/list.md)

 - [Create](api-ref/LogGroup/create.md)

 - [Update](api-ref/LogGroup/update.md)

 - [Delete](api-ref/LogGroup/delete.md)

 - [ListResources](api-ref/LogGroup/listResources.md)

 - [ListOperations](api-ref/LogGroup/listOperations.md)

 - [ListAccessBindings](api-ref/LogGroup/listAccessBindings.md)

 - [SetAccessBindings](api-ref/LogGroup/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/LogGroup/updateAccessBindings.md)

##### Operation

 - [Overview](api-ref/Operation/index.md)

 - [Get](api-ref/Operation/get.md)

 - [Cancel](api-ref/Operation/cancel.md)

##### Sink

 - [Overview](api-ref/Sink/index.md)

 - [Get](api-ref/Sink/get.md)

 - [List](api-ref/Sink/list.md)

 - [Create](api-ref/Sink/create.md)

 - [Update](api-ref/Sink/update.md)

 - [Delete](api-ref/Sink/delete.md)

 - [ListOperations](api-ref/Sink/listOperations.md)

 - [ListAccessBindings](api-ref/Sink/listAccessBindings.md)

 - [SetAccessBindings](api-ref/Sink/setAccessBindings.md)

 - [UpdateAccessBindings](api-ref/Sink/updateAccessBindings.md)

 - [История изменений](release-notes.md)

## Вопросы и ответы

 - [Общие вопросы](qa/general.md)

 - [Навигация](qa/navigation.md)

 - [Сбор и экспорт метрик](qa/metrics-export.md)

 - [Метрики и единицы измерения](qa/metrics-measure.md)

 - [Алерты / уведомления](qa/alerts.md)

 - [Все вопросы на одной странице](qa/all.md)

 - [Обучающие курсы](training.md)