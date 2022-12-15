# Мониторинг и логи в {{ mmy-name }}

#### Как посмотреть графики кластера и хостов? {#charts}

В [консоли управления]({{ link-console-main }}) перейдите на страницу кластера. Чтобы просмотреть [графики кластера](../../managed-mysql/operations/monitoring.md#monitoring-cluster), перейдите в раздел **Мониторинг**. Для [графиков отдельных хостов](../../managed-mysql/operations/monitoring.md#monitoring-hosts) перейдите в раздел **Хосты** → **Мониторинги**.

Чтобы посмотреть графики в сервисе [{{ monitoring-full-name }}]({{ link-monitoring }}), на главной странице выберите сервисный дашборд **{{ mmy-short-name }}**. Для просмотра отдельных метрик перейдите в раздел **Обзор метрик** и задайте параметру `service` значение **{{ mmy-short-name }}**.


#### Как настроить алерты? {#alerts}

Настроить алерты можно можно в сервисе [{{ monitoring-full-name }}]({{ link-monitoring }}): для этого воспользуйтесь инструкцией в разделе [{#T}](../../monitoring/operations/alert/create-alert.md).

При выборе метрики задайте параметру `service` значение **{{ mmy-short-name }}**.


#### Как посмотреть логи? {#logs}

{% list tabs %}

- Консоль управления

   1. Перейдите на страницу кластера и выберите вкладку **Логи**.
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
