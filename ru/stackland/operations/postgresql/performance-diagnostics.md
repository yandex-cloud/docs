# Диагностика производительности {{ PG }}

Performance Diagnostics — это функция сбора и визуализации статистики производительности кластеров {{ PG }}. Она позволяет анализировать производительность SQL-запросов и активность сессий для выявления узких мест и оптимизации работы базы данных.

## Перед началом работы {#before-you-begin}

Убедитесь, что:

* Установлен компонент Managed PostgreSQL.
* Установлен и активен компонент Managed {{ CH }}.
* Установлен компонент Monitoring с Grafana.
* У вас есть права на изменение конфигурации `ManagedPostgresConfig` и создание кластеров `PostgresqlCluster`.

## Включение диагностики на уровне платформы {#enable-platform}

Чтобы включить функцию Performance Diagnostics для всех PostgreSQL кластеров выполните команду:

```bash
kubectl patch ManagedPostgresConfigs main --type='merge' -p='{"spec":{"settings": {"performance-diagnostics":{"enabled":true}}}}'
```

После включения функции на уровне платформы будут развернуты необходимые компоненты для сбора и хранения метрик ({{ CH }}, Grafana dashboard).

## Включение сбора статистики для кластера {#enable-cluster}

После включения функции на уровне платформы необходимо включить сбор статистики для каждого кластера отдельно.

Чтобы включить сбор статистики для PostgreSQL кластера:

1. Создайте или обновите спецификацию кластера `PostgresqlCluster`:

   {% include notitle [YAML-файл](../../_includes/yamls/operations/postgresql/enable-perfdiag-cluster.md) %}

   Где `enablePerfDiagStatsCollect: true` включает сбор статистики производительности для данного кластера.

2. Примените конфигурацию:

   ```bash
   kubectl apply -f postgresql-cluster.yaml
   ```

3. Дождитесь перезапуска подов кластера. Проверить статус можно командой:

   ```bash
   kubectl get pods -l postgresql=my-postgres-cluster
   ```

После включения в каждом поде кластера будет запущен sidecar-контейнер `perfdiag`, который собирает статистику из {{ PG }} и отправляет ее в {{ CH }}.

## Просмотр данных в Grafana {#view-grafana}

Чтобы просмотреть собранные метрики производительности:

1. Откройте Grafana.

2. В меню слева выберите **Dashboards**.

3. Найдите и откройте дашборд **PostgreSQL Cluster Performance Diagnostics**.

4. В верхней части дашборда выберите:
   * **Cluster** — имя кластера.
   * **Time range** — временной диапазон для анализа.

### Панели дашборда {#dashboard-panels}

Дашборд содержит следующие разделы и панели:

#### Sessions activity statistics {#sessions-stats}

**Sessions stats (for the moment of interval end)** — таблица с информацией о текущих сессиях {{ PG }} на момент окончания выбранного интервала времени. Содержит данные о:

* Времени сбора данных (`collect_time`).
* Хосте и роли хоста (`host`, `host_role`).
* Базе данных и пользователе (`database`, `user`).
* Состоянии сессии (`state`).
* Выполняемом запросе (`query`).
* Идентификаторе процесса (`pid`).
* Приложении и клиенте (`application_name`, `client_addr`, `client_hostname`, `client_port`).
* Событиях ожидания (`wait_event_type`, `wait_event`).
* Временных метках (`backend_start`, `xact_start`, `query_start`, `state_change`).
* Идентификаторах транзакций (`backend_xid`, `backend_xmin`).
* Типе бэкенда (`backend_type`).
* Блокирующих процессах (`blocking_pids`).
* Идентификаторе запроса (`queryid`).

#### Per-statement statistics {#per-statement-stats}

Раздел содержит графики временных рядов и таблицу со статистикой выполнения SQL-запросов.

**Графики временных рядов:**

* **Top queries by average execution time** — топ запросов по среднему времени выполнения (в миллисекундах).
* **Top queries by consumed CPU user time** — топ запросов по потреблению процессорного времени в пользовательском режиме (в ядрах CPU).
* **Top queries by consumed CPU system time** — топ запросов по потреблению процессорного времени в системном режиме (в ядрах CPU).
* **Top queries by avg rows scanned** — топ запросов по среднему количеству просканированных строк.
* **Top queries by reads from filesystem** — топ запросов по объему чтения из файловой системы (в байтах).
* **Top queries by writes to filesystem** — топ запросов по объему записи в файловую систему (в байтах).
* **Top queries by average calls per second** — топ запросов по среднему количеству вызовов в секунду.
* **Shared blocks read** — количество прочитанных разделяемых блоков памяти.
* **Shared blocks written** — количество записанных разделяемых блоков памяти.
* **Query-local blocks read** — количество прочитанных локальных блоков памяти запроса.
* **Query-local blocks written** — количество записанных локальных блоков памяти запроса.
* **Temp blocks read** — количество прочитанных временных блоков.
* **Temp blocks written** — количество записанных временных блоков.
* **Top queries by generated WALs** — топ запросов по объему сгенерированных WAL-записей (в байтах).

**Таблица:**

**Per-query statistics for period (sorted by avg CPU consumption)** — сводная таблица статистики по каждому запросу за выбранный период, отсортированная по среднему потреблению CPU. Содержит:
  * Роль хоста (`host_role`).
  * Пользователя и базу данных (`user`, `database`).
  * Идентификатор и текст запроса (`queryid`, `query`).
  * Общее количество вызовов (`total_calls`).
  * Общее количество просканированных строк (`total_rows_scanned`).
  * Общее время выполнения (`total_exec_time`).
  * Среднее время выполнения (`average_exec_time`).
  * Общее время CPU (`total_cpu_time`).
  * Среднее время CPU (`average_cpu_time`).
  * Общий объем операций с файловой системой (`total_fs_bytes`).
  * Средний объем чтения из файловой системы (`average_fs_reads_bytes`).
  * Средний объем записи в файловую систему (`average_fs_writes_bytes`).

## Анализ производительности {#performance-analysis}

### Выявление медленных запросов {#slow-queries}

Чтобы найти медленные запросы:

1. На панели **Per-Statement Statistics** отсортируйте запросы по **Average Execution Time** или **Total Execution Time**.
2. Обратите внимание на запросы с высоким временем выполнения.
3. Проанализируйте план выполнения таких запросов с помощью `EXPLAIN ANALYZE`.

### Анализ использования ресурсов {#resource-usage}

Чтобы выявить запросы, потребляющие много ресурсов:

1. Проверьте панель **CPU Usage** для запросов с высоким использованием процессора.
2. Проверьте панель **I/O Operations** для запросов с интенсивными операциями ввода-вывода.
3. Проверьте панель **WAL Generated** для запросов, генерирующих много WAL-записей.

### Выявление блокировок {#blocking}

Чтобы найти блокирующие процессы:

1. На панели **Sessions Activity Statistics** найдите сессии с непустым полем `blocking_pids`.
2. Определите, какие запросы вызывают блокировки.
3. Оптимизируйте логику работы с транзакциями или добавьте индексы.

## Отключение диагностики {#disable}

Чтобы отключить сбор статистики для конкретного кластера:

```
kubectl patch ManagedPostgresConfigs main --type='merge' -p='{"spec":{"settings": {"performance-diagnostics":{"enabled":false}}}}'
```

{% note warning %}

При отключении функции на уровне платформы будут удалены все собранные метрики из {{ CH }}.

{% endnote %}

## См. также {#see-also}

* [{#T}](../../concepts/components/postgresql.md)
* [{#T}](create-cluster.md)
* [{#T}](../../concepts/components/monitoring.md)
