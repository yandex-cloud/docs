#### Где я могу отслеживать использование дискового пространства, чтобы не превысить лимит в 95% для перехода в read-only? {#disk-space}

Отслеживать использование дискового пространства можно:
* в консоли управления с помощью инструментов [мониторинга состояния кластера](../../managed-postgresql/operations/monitoring.md#monitoring-cluster);
* в сервисе [{{ monitoring-full-name }}]({{ link-monitoring }}) с возможностью [настроить алерты](../../managed-postgresql/operations/monitoring.md#monitoring-integration) по заданным метрикам.

#### Логи хранятся на том же диске, что и данные {{ PG }}? Как они тарифицируются? {#logs-storage}

Логи хранятся отдельно от диска с данными и ротируются автоматически. Посмотреть информацию о логах можно командой [CLI](../../cli/):

```bash
yc managed-postgresql cluster list-logs <идентификатор_кластера>
```

Использование хранилища с логами кластера не тарифицируется.

{% include [log-duration](../../_includes/mdb/log-duration-qa.md) %}

#### Как включить логирование SQL-запросов? {#sql-query-logging}

Чтобы включить логирование SQL-запросов:

1. Убедитесь, что в базе данных [установлено расширение `pg_stat_statements`](../../managed-postgresql/operations/extensions/cluster-extensions.md#list-extensions). Если расширение не установлено, [добавьте его](../../managed-postgresql/operations/extensions/cluster-extensions.md#update-extensions).

   При использовании CLI выполните команду:

   ```bash
   {{ yc-mdb-pg }} database update <имя_БД> \
      --cluster-name <имя_кластера> \
      --extensions <список_установленных_расширений>,pg_stat_statements
   ```

   В параметре `--extensions` укажите `pg_stat_statements` и все остальные расширения, которые должны остаться включенными. Если в базе данных нет других расширений, укажите только `pg_stat_statements`.

1. [Измените настройки СУБД](../../managed-postgresql/operations/update.md#change-postgresql-config):

   * Установите для параметра [**Log min duration statement**](../../managed-postgresql/concepts/settings-list.md#setting-log-min-duration-statement) значение `60000` мс. В лог будут попадать запросы, время выполнения которых составляет одну минуту или больше. При необходимости постепенно уменьшайте значение. Значение `0` включает логирование всех запросов и может значительно увеличить объем логов и нагрузку на кластер.
   * Установите для параметра [**Auto explain sample rate**](../../managed-postgresql/concepts/settings-list.md#setting-auto-explain-sample-rate) значение `1`.
   * Если нужно записывать в лог планы выполнения запросов, добавьте `auto_explain` в параметр [**Shared preload libraries**](../../managed-postgresql/concepts/settings-list.md#setting-shared-libraries), установите для параметра [**Auto explain log min duration**](../../managed-postgresql/concepts/settings-list.md#setting-auto-explain-log-min-duration) значение `60000` мс и включите параметр [**Auto explain log analyze**](../../managed-postgresql/concepts/settings-list.md#setting-auto-explain-log-analyze).

   Все перечисленные параметры можно изменить с помощью консоли управления, CLI, API или {{ TF }}. Например, чтобы включить логирование запросов и их планов с помощью CLI, выполните команду:

   ```bash
   {{ yc-mdb-pg }} cluster update-config <имя_или_идентификатор_кластера> \
      --set log_min_duration_statement=60000 \
      --set auto_explain_sample_rate=1 \
      --set auto_explain_log_min_duration=60000 \
      --set auto_explain_log_analyze=true \
      --set shared_preload_libraries=SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN
   ```

   Если планы выполнения запросов не нужны, не передавайте параметры `auto_explain_log_min_duration`, `auto_explain_log_analyze` и `shared_preload_libraries`. Если к кластеру уже подключены другие библиотеки общего пользования, укажите их вместе с `SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN` в параметре `shared_preload_libraries`.

1. [Посмотрите записи в логах кластера](../../managed-postgresql/operations/cluster-logs.md#get-log). Для этого достаточно прав на просмотр логов в кластере. Чтобы выполнять запросы к представлению `pg_stat_statements`, достаточно иметь право на подключение к базе данных — роль `mdb_monitor` не требуется.

#### Что такое WAL и для чего они нужны? {#wal}

[Журналы Write-Ahead Log](https://postgrespro.ru/docs/postgresql/12/wal-intro) нужны для записи данных на диск и их репликации. Они создаются при запросах на запись и занимают место на диске до момента полной записи информации с журналов на диски хостов — это обеспечивает отказоустойчивость и надежность СУБД.

Подробнее о принципах работы {{ PG }} читайте в [официальной документации](https://postgrespro.ru/docs/postgresql/12).

#### Что означает параметр Cached в мониторинге RAM хоста кластера {{ PG }}? {#cached}

В Cached помещаются кешированные данные. Большинство операций выполняется на уровне оперативной памяти, так как вся информация базы данных хранится именно там. Кеширование происходит не только для баз данных, но и для диска — из-за этого объём кешированных данных может превышать размер хранилища.

В случае увеличения потребления оперативной памяти приложениями часть памяти с кешем может высвобождаться.

Подробнее о кешировании данных дисков в Linux читайте в [документации](https://www.linuxatemyram.com/).


#### Как получать алерты о критических показателях кластера {{ PG }}? {#notifications}

Воспользуйтесь сервисом [{{ monitoring-full-name }}]({{ link-monitoring }}) и [настройте алерты](../../managed-postgresql/operations/monitoring.md#monitoring-integration) по критичным для вас параметрам.


#### Как настроить алерт, который срабатывает при заполнении определенного процента дискового пространства? {#disk-space-percentage}

[Создайте алерт](../../managed-postgresql/operations/monitoring.md#monitoring-integration) с метрикой `disk.used_bytes` в сервисе {{ monitoring-full-name }}. Метрика показывает размер использованного дискового пространства в кластере {{ mpg-name }}.

Для `disk.used_bytes` используются пороги для оповещения. Их рекомендуемые значения:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` — 90% дискового пространства.
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}` — 80% дискового пространства.

Значения порогов задаются только в байтах. Например, рекомендуемые значения для диска размером в 100 ГБ:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` — `96636764160` байт (90%).
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}` — `85899345920` байт (80%).
