# Мониторинг и логи в {{ mmy-name }}

#### Как посмотреть графики кластера и хостов? {#charts}

В [консоли управления]({{ link-console-main }}) перейдите на страницу кластера. Чтобы просмотреть [графики кластера](../../managed-mysql/operations/monitoring.md#monitoring-cluster), перейдите в раздел **{{ ui-key.yacloud.mysql.cluster.switch_monitoring }}**. Для [графиков отдельных хостов](../../managed-mysql/operations/monitoring.md#monitoring-hosts) перейдите в раздел **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** → **{{ ui-key.yacloud.mdb.cluster.hosts.switch_monitoring }}**.

Чтобы посмотреть графики в сервисе [{{ monitoring-full-name }}]({{ link-monitoring }}), на главной странице выберите сервисный дашборд **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**. Для просмотра отдельных метрик перейдите в раздел **{{ ui-key.yacloud_monitoring.header.title.mx-mode }}** и задайте параметру `service` значение **{{ ui-key.yacloud_monitoring.services.label_mysql }}**.

#### Как посмотреть логи? {#logs}

{% list tabs %}

- Консоль управления

   1. Перейдите на страницу кластера и выберите вкладку **{{ ui-key.yacloud.mysql.cluster.switch_logs }}**.
   1. В верхней части страницы выберите один из доступных логов:
      * `MYSQL_ERROR` — основной лог {{ MY }}, содержит сообщения об ошибках. Включен всегда.
      * `MYSQL_SLOW_QUERY` — информация о медленных запросах. Включен, если параметр `long_query_time` больше `0`.
      * `MYSQL_AUDIT` — информация о подключениях к базе данных.
      * `MYSQL_GENERAL` — полный список всех запросов. Рекомендуется включать только для отладки кластеров в среде разработки.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Посмотрите описание команды CLI для просмотра логов:

      ```
      {{ yc-mdb-my }} cluster list-logs --help
      ```

   1.  Выполните команду `{{ yc-mdb-my }} cluster cluster list-logs`.

{% endlist %}

{% include [log-duration](../../_includes/mdb/log-duration-qa.md) %}

#### Как посмотреть текущие запросы? {#current-queries}

Чтобы посмотреть запросы текущего пользователя, выполните запрос:

```sql
SHOW PROCESSLIST;
```

Подробное описание результата см. в [документации {{ MY }}](https://dev.mysql.com/doc/refman/5.7/en/show-processlist.html).

#### Какая еще диагностика доступна? {#trouble-info}

Пользователь с [привилегией](../../managed-mysql/concepts/settings-list.md#setting-administrative-privileges) `PROCESS` уровня кластера может выполнять запросы:
* `SHOW FULL PROCESSLIST;`
* `SHOW ENGINE INNODB STATUS;`
* `SELECT` из системных схем `performance_schema` и `sys`.

Чтобы выдать привилегию `PROCESS`, выполните команду [CLI](../../cli/):

```bash
{{ yc-mdb-my }} user update \
    --global-permissions PROCESS <имя пользователя> \
    --cluster-id <идентификатор кластера>
```


#### Как настроить алерты? {#alerts}

Используйте сервис [{{ monitoring-full-name }}]({{ link-monitoring }}), инструкция по настройке в разделе [{#T}](../../monitoring/operations/alert/create-alert.md).

При выборе метрики задайте параметру `service` значение **{{ ui-key.yacloud_monitoring.services.label_mysql }}**.


#### Как настроить алерт, который срабатывает при заполнении определенного процента дискового пространства? {#disk-space-percentage}

[Создайте алерт](../../managed-mysql/operations/monitoring.md#monitoring-integration) с метрикой `disk.used_bytes` в сервисе {{ monitoring-full-name }}. Метрика показывает размер использованного дискового пространства в кластере {{ mmy-name }}.

Для `disk.used_bytes` используются пороги для оповещения. Их рекомендуемые значения:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` — 90% дискового пространства.
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}` — 80% дискового пространства.

Значения порогов задаются только в байтах. Например, рекомендуемые значения для диска размером в 100 ГБ:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` — `96636764160` байтов (90%).
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}` — `85899345920` байтов (80%).
