# Yandex Cloud Stackland

Платформа контейнеризации с интегрированными PaaS‑сервисами Yandex Cloud. Объединяет все необходимые компоненты для централизованного управления микросервисными и ИИ‑приложениями.

Stackland базируется на Kubernetes®, что позволяет работать с привычными инструментами для управления микросервисными приложениями, а также управлять платформенными сервисами Yandex Cloud через Kubernetes API.

В платформу интегрированы объектное хранилище, Managed Service for PostgreSQL, Managed Service for ClickHouse®, Managed Service for Apache Kafka®, а также готовый инструментарий для обеспечения приложений доступом к графическим ускорителям и высокопроизводительным сетям для задач распределенного инференса. Запланирована интеграция баз данных с поддержкой векторного поиска для RAG-сценариев.

Платформа позволит быстро развернуть в закрытом контуре AI Studio для разработки AI-приложений и агентов, а также SpeechSense для речевой аналитики и BI-систему DataLens.

# Yandex Cloud Stackland

 - [Что нового](release-notes.md)

 - [Установка](quickstart.md)

## Практические руководства

 - [Все руководства](tutorials/index.md)

 - [Установить Stackland на Yandex BareMetal](tutorials/install-on-yc-bms.md)

 - [Настройка внешнего доступа к поду в кластере](tutorials/expose-app-domain.md)

## Пошаговые инструкции

 - [Все инструкции](operations/index.md)

### Пользователи и группы

 - [Создать пользователя](operations/iam/create-user.md)

 - [Создать группу пользователей](operations/iam/create-group.md)

 - [Подключить SAML-федерацию](operations/iam/connect-saml-federation.md)

 - [Назначить права доступа](operations/iam/assign-role.md)

### Базы данных

#### Managed Service for PostgreSQL

 - [Создать кластер PostgreSQL](operations/postgresql/create-cluster.md)

 - [Изменить настройки кластера](operations/postgresql/edit-cluster.md)

 - [Диагностика производительности](operations/postgresql/performance-diagnostics.md)

 - [Создать резервную копию](operations/postgresql/new-copy.md)

 - [Восстановить кластер](operations/postgresql/recover-copy.md)

 - [Удалить кластер](operations/postgresql/delete-cluster.md)

#### Managed Service for ClickHouse®

 - [Создать кластер ClickHouse®](operations/clickhouse/create-cluster.md)

 - [Изменить настройки кластера](operations/clickhouse/edit-cluster.md)

 - [Создать резервную копию](operations/clickhouse/new-copy.md)

 - [Восстановить кластер](operations/clickhouse/recover-copy.md)

 - [Удалить кластер](operations/clickhouse/delete-cluster.md)

### Бакеты

 - [Создать бакет](operations/storage/create-bucket.md)

 - [Создать AccessKey](operations/storage/create-accesskey.md)

 - [Удалить бакет](operations/storage/delete-bucket.md)

 - [Удалить AccessKey](operations/storage/delete-accesskey.md)

### Брокер сообщений

 - [Создать кластер](operations/kafka/create-cluster.md)

 - [Создать топик](operations/kafka/create-topic.md)

 - [Создать пользователя](operations/kafka/create-user.md)

 - [Подключиться к кластеру](operations/kafka/connect-to-kafka.md)

 - [Удалить кластер](operations/kafka/delete-cluster.md)

 - [Удалить топик](operations/kafka/delete-topic.md)

 - [Удалить пользователя](operations/kafka/delete-user.md)

### Логирование

 - [Посмотреть логи](operations/logging/logs-view.md)

### Мониторинг

 - [Создать дашборд](operations/monitoring/dashboard-create.md)

 - [Изменить дашборд](operations/monitoring/dashboard-update.md)

 - [Удалить дашборд](operations/monitoring/dashboard-delete.md)

 - [Управление доступом к дашбордам](operations/monitoring/dashboard-access.md)

 - [Создать канал уведомлений](operations/monitoring/alerts-create-contact-point.md)

 - [Создать правило алертинга](operations/monitoring/alerts-create-rule.md)

### DataLens

 - [Загрузить образы](operations/datalens/install-images.md)

 - [Включить DataLens](operations/datalens/configure.md)

 - [Отключить DataLens](operations/datalens/disable.md)

### Политики

 - [Активировать пресет с политиками](operations/policy-manager/apply-preset.md)

 - [Деактивировать политику](operations/policy-manager/apply-mute.md)

 - [Удалить пресет с политиками](operations/policy-manager/delete-preset.md)

### Проекты

 - [Все инструкции](operations/projects/index.md)

 - [Создать проект](operations/projects/create-project.md)

 - [Управлять пространствами имен](operations/projects/manage-namespaces.md)

 - [Настроить роли проекта](operations/projects/project-roles.md)

 - [Установить квоты в пространствах имен](operations/projects/namespace-quotas.md)

 - [Создать квоту для проекта](operations/projects/quotas.md)

### SpeechSense

 - [Загрузить образы](operations/speechsense/install-images.md)

 - [Настроить и активировать](operations/speechsense/configure.md)

 - [Отключить](operations/speechsense/disable.md)

### Дисковая подсистема

 - [Диагностика дисковой подсистемы](operations/disk-storage/troubleshooting.md)

### Управление кластером

 - [Обновить кластер](operations/cluster-upgrade.md)

## Концепции

 - [Проекты](concepts/projects.md)

 - [Ресурсная модель](concepts/resource-model.md)

### Компоненты

 - [Обзор](concepts/components/overview.md)

 - [Certificate Manager](concepts/components/certificate-manager.md)

 - [DNS](concepts/components/dns.md)

 - [IAM](concepts/components/iam.md)

 - [Logging Stack](concepts/components/logging.md)

 - [Managed Service for Apache Kafka®](concepts/components/kafka.md)

 - [Managed Service for PostgreSQL](concepts/components/postgresql.md)

 - [Managed Service for ClickHouse®](concepts/components/clickhouse.md)

 - [DataLens](concepts/components/datalens.md)

 - [Monitoring](concepts/components/monitoring.md)

 - [Object Storage](concepts/components/storage.md)

 - [Дисковая подсистема](concepts/components/disk-storage.md)

 - [Поддержка NVIDIA® GPU](concepts/components/gpu.md)

 - [Policy Manager](concepts/components/policy-manager.md)

 - [Secrets Store](concepts/components/secrets-store.md)

 - [SpeechSense](concepts/components/speechsense.md)

### Мониторинг кластера

 - [Мониторинг ClickHouse](concepts/cluster-monitoring/clickhouse-monitoring.md)

 - [Метрики дашборда NVIDIA® DCGM](concepts/cluster-monitoring/nvidia-dcgm-monitoring.md)

 - [Метрики дашборда NVIDIA® DCGM с MIG](concepts/cluster-monitoring/nvidia-dcgm-mig-monitoring.md)

 - [Метрики дашборда NVIDIA® DCGM без MIG](concepts/cluster-monitoring/nvidia-dcgm-no-mig-monitoring.md)

 - [Мониторинг оборудования](concepts/hardware-monitoring.md)

 - [Управление доступом](access-management.md)

 - [Правила тарификации](pricing.md)

 - [Диагностика и устранение неполадок](operations/troubleshooting.md)