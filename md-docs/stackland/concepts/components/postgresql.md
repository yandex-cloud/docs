[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Stackland](../../index.md) > Концепции > [Компоненты](overview.md) > Managed Service for PostgreSQL

# Managed PostgreSQL

Managed PostgreSQL — это управляемый сервис для работы с открытой объектно-реляционной системой управления базами данных (СУБД) PostgreSQL. Сервис упрощает развертывание и обновление кластера баз данных, обеспечивает отказоустойчивость, а также предоставляет инструменты для резервного копирования и мониторинга.

С помощью Managed PostgreSQL можно:

* создавать и восстанавливать кластеры с помощью кастомного ресурса `PostgresqlCluster`;
* создавать разовые резервные копии с помощью кастомного ресурса `PostgresqlBackup`.

Управлять интеграцией с PostgreSQL можно с помощью параметров кастомного ресурса `ManagedPostgresConfig`.

## Конфигурация {#configuration}

Пример:

```yaml
apiVersion: stackland.yandex.cloud/v1alpha1
kind: ManagedPostgresConfig
metadata:
  name: main # Поле обязательно и должно иметь значение main
spec:
  enabled: true
  settings:
    monitoring:
      enabled: true
    stackland-postgres:
      replicas: 1
      resources:
        requests:
          cpu: "200m"
          memory: "256Mi"
        limits:
          cpu: "1000m"
          memory: "1Gi"
    stackland-wal-g:
      resources:
        requests:
          cpu: "200m"
          memory: "256Mi"
        limits:
          cpu: "1000m"
          memory: "1Gi"
```

Где:

* `enabled` — включает или отключает компонент.
* `settings.stackland-postgres` — настройки пода оператора:
  * `replicas` — количество реплик оператора.
  * `resources` — ограничения ресурсов (requests/limits) для пода оператора.
* `settings.stackland-wal-g` — ресурсы для sidecar WAL-G (бэкапы/восстановление): `resources` с `requests` и `limits`.
* `settings.monitoring` — мониторинг: `enabled: true/false`. По умолчанию включён, если блок не задан.
* `settings.performance-diagnostics` — диагностика производительности: `enabled: true/false`.
* `settings.defaultPostgresResources` — ресурсы по умолчанию для инстансов PostgreSQL в кластерах (requests/limits).
* `settings.defaultPoolerResources` — ресурсы по умолчанию для инстансов Pooler (PgBouncer).

Все блоки в `settings` опциональны; можно задать только нужные.

## Диагностика производительности {#performance-diagnostics}

Performance Diagnostics — это функция сбора и визуализации статистики производительности PostgreSQL кластеров. Она позволяет анализировать производительность SQL-запросов и активность сессий для выявления узких мест и оптимизации работы базы данных.

Система диагностики производительности состоит из следующих компонентов:

* **perfdiag sidecar** — контейнер-сайдкар, который собирает статистику из PostgreSQL.
* **ClickHouse®** — хранилище для долгосрочного хранения метрик производительности.
* **Grafana Dashboard** — преднастроенный дашборд «PostgreSQL Cluster Performance Diagnostics» для визуализации собранных данных.

### Собираемые метрики {#collected-metrics}

Performance Diagnostics собирает следующие типы метрик:

Статистика активности сессий:

* Текущее состояние сессий (`state`, `query`, `pid`, `user`, `application_name`).
* События ожидания (`wait_event`, `wait_event_type`).
* Блокирующие процессы (`blocking_pids`).

Статистика выполнения запросов:

* Время выполнения (среднее и суммарное).
* Использование CPU (`user time`, `system time`).
* Операции ввода-вывода (чтение и запись в файловую систему, работа с shared-, local-, temp-блоками).
* Количество обработанных строк.
* Объём сгенерированных WAL-записей.
* Количество вызовов запроса.

### Включение функции {#enabling}

Для использования Performance Diagnostics необходимо:

1. Включить функцию на уровне платформы в конфигурации `ManagedPostgresConfig`:

   ```yaml
   spec:
     settings:
       performance-diagnostics:
         enabled: true
   ```

2. Включить сбор статистики для конкретного кластера в `PostgresqlCluster`:

   ```yaml
   spec:
     enablePerfDiagStatsCollect: true
   ```

Подробнее в разделе [Диагностика производительности PostgreSQL](../../operations/postgresql/performance-diagnostics.md).