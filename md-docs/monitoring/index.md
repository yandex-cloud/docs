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

 - [Поставка метрик с хостов вне {{ yandex-cloud }}](operations/unified-agent/non-yc.md)

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

 - [Настройка дашбордов и алертов для {{ at-name }}](tutorials/alerts-monitoring.md)

 - [Поиск проблем с производительностью кластера {{ mpg-name }}](tutorials/mpg-performance-problems.md)

 - [Сбор метрик кластера «1С:Предприятие» на базе Linux](tutorials/collect-metrics-1c-cluster.md)

## {{ managed-prometheus-name }}

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

 - [Чтение и запись метрик кластера {{ k8s }}](operations/prometheus/read-write-for-kubernetes.md)

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

 - [{{ ai-studio-name }}](metrics-ref/ai-studio-ref.md)

 - [{{ api-gw-name }}](metrics-ref/api-gateway-ref.md)

 - [{{ alb-name }}](metrics-ref/alb-ref.md)

 - [{{ at-name }}](metrics-ref/at-ref.md)

 - [{{ baremetal-name }}](metrics-ref/baremetal-ref.md)

 - [{{ certificate-manager-name }}](metrics-ref/certificate-manager-ref.md)

 - [{{ backup-name }}](metrics-ref/backup-ref.md)

 - [{{ cdn-name }}](metrics-ref/cdn-ref.md)

 - [{{ sf-name }}](metrics-ref/functions-ref.md)

 - [{{ cloud-logging-name }}](metrics-ref/logging-ref.md)

 - [{{ cns-name }}](metrics-ref/cns-ref.md)

 - [{{ postbox-name }}](metrics-ref/postbox-ref.md)

 - [{{ compute-name }}](metrics-ref/compute-ref.md)

 - [{{ container-registry-name }}](metrics-ref/container-registry-ref.md)

 - [{{ dataproc-name }}](metrics-ref/data-processing-ref.md)

 - [{{ data-transfer-name }}](metrics-ref/data-transfer-ref.md)

 - [{{ dns-name }}](metrics-ref/dns-ref.md)

 - [{{ iam-name }}](metrics-ref/iam-ref.md)

 - [{{ iot-name }}](metrics-ref/iot-core-ref.md)

 - [{{ kms-name }}](metrics-ref/kms-ref.md)

 - [{{ lockbox-name }}](metrics-ref/lockbox-ref.md)

 - [{{ maf-name }}](metrics-ref/managed-airflow-ref.md)

 - [{{ mkf-name }}](metrics-ref/managed-kafka-ref.md)

 - [{{ msp-name }}](metrics-ref/managed-spark-ref.md)

 - [{{ mch-name }}](metrics-ref/managed-clickhouse-ref.md)

 - [{{ mgp-name }}](metrics-ref/managed-greenplum-ref.md)

 - [{{ mgl-name }}](metrics-ref/managed-gitlab-ref.md)

 - [{{ managed-k8s-name }}](metrics-ref/managed-kubernetes-ref.md)

 - [{{ mmg-name }}](metrics-ref/managed-mongodb-ref.md)

 - [{{ mmy-name }}](metrics-ref/managed-mysql-ref.md)

 - [{{ mos-name }}](metrics-ref/managed-opensearch-ref.md)

 - [{{ mpg-name }}](metrics-ref/managed-postgresql-ref.md)

 - [{{ mtr-name }}](metrics-ref/managed-trino-ref.md)

 - [{{ mrd-name }}](metrics-ref/managed-valkey-ref.md)

 - [{{ ydb-name }}](metrics-ref/ydb-ref.md)

 - [{{ myt-name }}](metrics-ref/managed-ytsaurus-ref.md)

 - [{{ message-queue-name }}](metrics-ref/message-queue-ref.md)

 - [{{ monitoring-name }}](metrics-ref/monitoring-ref.md)

 - [{{ network-load-balancer-name }}](metrics-ref/network-load-balancer-ref.md)

 - [{{ objstorage-name }}](metrics-ref/storage-ref.md)

 - [{{ si-name }}](metrics-ref/serverless-integrations-ref.md)

 - [{{ serverless-containers-name }}](metrics-ref/serverless-containers-ref.md)

 - [{{ captcha-name }}](metrics-ref/captcha-ref.md)

 - [{{ sws-name }}](metrics-ref/smartwebsecurity-ref.md)

 - [{{ unified-agent-short-name }}](metrics-ref/unifiedagent-ref.md)

## Вопросы и ответы

 - [Общие вопросы](qa/general.md)

 - [Навигация](qa/navigation.md)

 - [Сбор и экспорт метрик](qa/metrics-export.md)

 - [Метрики и единицы измерения](qa/metrics-measure.md)

 - [Алерты / уведомления](qa/alerts.md)

 - [Все вопросы на одной странице](qa/all.md)

 - [Правила тарификации](pricing.md)

 - [Справочник {{ TF }}](tf-ref.md)

 - [История изменений](release-notes.md)

 - [Обучающие курсы](training.md)