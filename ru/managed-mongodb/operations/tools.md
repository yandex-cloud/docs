# Инструменты для анализа производительности

## Встроенные утилиты диагностики {#monitoring-tools}

В {{ MG }} есть утилиты получения данных о производительности:

* [mongostat](https://docs.mongodb.com/database-tools/mongostat/#bin.mongostat) — собирает статистику утилизации ресурсов CPU и памяти процессами {{ MG }},
* [mongotop](https://docs.mongodb.com/database-tools/mongotop/#bin.mongotop) — собирает статистику чтения/записи данных по каждой коллекции.

При вызове этих утилит используйте строку подключения с логином и паролем пользователя с ролью `mdbMonitor`, например:

```bash
mongostat 5 --uri="mongodb://{имя_пользователя_с ролью_mdbMonitor}:{пароль}@{хост}:27018/?authSource=admin"
mongotop 5 --uri="mongodb://{имя_пользователя_с ролью_mdbMonitor}:{пароль}@{хост}:27018/?authSource=admin"
```

Здесь обе утилиты выводят набор данных о производительности c интервалом опроса (polling interval) в 5 секунд.

Подробнее об использовании утилит `monostat` и `mongotop` см. в [документации {{ MG }}](https://docs.mongodb.com/manual/administration/monitoring/).

### Профилировщик {#explore-profiler}

В {{ MG }} есть [встроенный профилировщик](https://docs.mongodb.com/manual/reference/database-profiler/). Он собирает данные о запросах. Затем на основе этих данных формируется стратегия оптимизации запросов. Работой профилировщика управляют [настройки {{ MG }}](../concepts/settings-list.md), которые вы можете задать при [создании кластера](./cluster-create.md) или [изменении настроек СУБД](./update.md#change-mongod-config):

* [operationProfiling.mode](../concepts/settings-list.md#setting-operation-profiling);
* [operationProfiling.slowOpThreshold](../concepts/settings-list.md#setting-slow-op-threshold).

{% note warning %}

Использование значения `all` для настройки `operationProfiling.mode` и близкого к `0` значения для настройки `operationProfiling.slowOpThreshold` значительно снижает производительность кластера.

{% endnote %}

Чтобы просмотреть данные, собранные профилировщиком, обратитесь к коллекции `system.profile` в каждой БД. Коллекции профилировщика доступны для чтения [пользователю](./cluster-users.md#adduser) с ролью [`mdbMonitor`](../concepts/users-and-roles.md#mdbMonitor). По умолчанию данные дублируются в логах.

Подробнее о настройке профилировщика и о том, как интерпретировать его результаты, читайте в [документации {{ MG }}](https://docs.mongodb.com/manual/reference/database-profiler/).

### Выполняемые в данный момент запросы {#list-running-queries}

Чтобы посмотреть не относящиеся к текущему пользователю запросы, от имени пользователя с ролью [`mdbMonitor`](../concepts/users-and-roles.md#mdbMonitor) выполните [операцию db.currentOp()](https://docs.mongodb.com/manual/reference/method/db.currentOp/):

```javascript
db.currentOp()
```

Чтобы посмотреть запросы текущего пользователя, выполните операцию `db.currentOp()` со значением `true` для [настройки](https://docs.mongodb.com/manual/reference/method/db.currentOp/#behavior) `ownOps`:

```javascript
db.currentOp({ "$ownOps": true })
```

## Логи {#explore-logs}

Наиболее подробная информация о работе {{ MG }} содержится в логах.

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mmg-name }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/logs.svg) **Логи**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы посмотреть логи **{{ mmg-name }}**:

    1. Посмотрите описание команды CLI для просмотра логов:

        ```bash
        {{ yc-mdb-mg }} cluster list-logs --help
        ```

    1. Для получения всех логов кластера выполните команду:

        ```bash
        {{ yc-mdb-mg }} cluster list-logs --id <идентификатор кластера>
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

- API

    Воспользуйтесь методом API [listLogs](../api-ref/Cluster/listLogs.md) и передайте идентификатор кластера в параметре `clusterId` запроса.

    Идентификатор кластера можно получить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

{% endlist %}
