---
title: Мониторинг состояния кластера, хостов и шардов в {{ mrd-name }}
description: Вы можете отслеживать состояние кластера {{ mrd-name }}, его хостов и шардов с помощью инструментов мониторинга в консоли управления. Эти инструменты предоставляют диагностическую информацию в виде графиков.
---

# Мониторинг состояния кластера, хостов и шардов в {{ mrd-name }}

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-period](../../_includes/mdb/monitoring-freq.md) %}

{% include [monitoring-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Мониторинг состояния кластера {#monitoring-cluster}

Для просмотра детальной информации о состоянии кластера {{ mrd-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с нужным кластером.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.redis.cluster.switch_monitoring }}**.
      
      На открывшейся странице будут отображены графики, отражающие состояние кластера.
  
      {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}
  
  Для кластера отображаются графики:

  * **Hosts available for read** — доступность хостов кластера для чтения.
  * **Hosts available for write** — доступность хостов кластера для записи.

  В блоке **Traffic**:

  * **Connected Clients** — количество открытых подключений к сервисам на хостах кластера.

      Если кластер [шардированный](../concepts/sharding.md) или использует [репликацию](../concepts/replication.md), часть подключений будет использована для обмена данными между хостами кластера.
      Если при подключении к кластеру возникают ошибки, причиной могут быть неактивные приложения, которые слишком долго держат подключения открытыми. В этом случае [измените в настройках {{ VLK }}](../operations/update.md#change-valkey-config) значение параметра [Timeout](../concepts/settings-list.md#settings-timeout).

  * **Commands Processed** — скорость обработки команд на каждом хосте кластера.
  * **Commandstats** — скорость вызова команд на каждом хосте кластера.

  В блоке **Latency**:

  * **Latencystats, p50** — медианное время выполнения команд. 
  * **Latencystats, p99** — время выполнения команд в 99 процентиле.
  * **Latencystats, p99.9** — время выполнения команд в 99.9 процентиле.

  В блоке **DB Metrics**:

  * **DB keys** — количество ключей на каждом хосте кластера.
  * **Evicted keys** — количество ключей, удаленных из памяти при вставке новых данных. Информация отображается для каждого хоста кластера.
  * **Cache Hit Rate** — процент запросов, данные для которых были получены из кеша. Информация отображается для каждого хоста кластера.
  * **Replication Lag** — отставание реплики от мастера (в секундах).
  * **IO threads active** — количество активных потоков на каждом хосте кластера.
  * **Valkey-server OOM kills (for last hour)** — количество ошибок `Out of Memory` на каждом хосте кластера.

  В блоке **Resources** → **Memory**:

  * **Outer memory limit** — лимит и использование оперативной памяти процессами на каждом хосте кластера.
  * **Inner Memory limit** — лимит и использование оперативной памяти на каждом хосте кластера.
  * **Memory fragmentation ratio** — соотношение выделенной к фактически используемой памяти на каждом хосте кластера.
  * **Valkey Used Memory on Masters** — использование оперативной памяти на хостах-мастерах кластера.
  * **Valkey Used Memory on Replicas** — использование оперативной памяти на хостах-репликах кластера.
  * **Replication buffer size** — размер используемой и доступной памяти для буфера [репликации](../concepts/replication.md#replication) на каждом хосте кластера.
  * **Client recent max input buffer size** — максимальный размер буфера для обслуживания входящих клиентских подключений на каждом хосте кластера.
  * **Client recent max output buffer size** — максимальный размер буфера для обслуживания исходящих клиентских подключений на каждом хосте кластера.
  * **Copy-on-write allocations** — объем памяти, выделяемый механизмом COW при создании дочерних процессов. Информация отображается для каждого хоста кластера.

  В блоке **Resources** → **CPU**:

  * **CPU usage main thread** — использование процессорного времени (системного и пользовательского) основным потоком на каждом хосте кластера.
  * **CPU usage main thread on Masters** — использование процессорного времени (системного и пользовательского) основным потоком на хостах-мастерах кластера. 
  * **CPU usage main thread on Replicas** — использование процессорного времени (системного и пользовательского) основным потоком на хостах-репликах кластера. 

  В блоке **Resources** → **Network**:

  * **Network usage** — количество входящего и исходящего сетевого трафика на каждом хосте кластера.
  * **Network usage on Masters** — количество входящего и исходящего сетевого трафика на хостах-мастерах кластера.
  * **Network usage on Replicas** — количество входящего и исходящего сетевого трафика на хостах-репликах кластера.
  * **Replication network usage** — количество входящего и исходящего сетевого трафика репликации на каждом хосте кластера.
  * **Replication network usage on Masters** — количество входящего и исходящего сетевого трафика репликации на хостах-мастерах кластера.
  * **Replication network usage on Replicas** — количество входящего и исходящего сетевого трафика репликации на хостах-репликах кластера.

  В блоке **Resources** → **Disk**:

  * **Disk IO** — скорость дисковых операций на каждом хосте кластера.
  * **Disk space usage percentage** — процент использования дискового пространства на каждом хосте кластера.
  * **Disk space usage** — использование дискового пространства на каждом хосте кластера.

  В блоке **Errors**:

  * **Errorstats** — скорость возникновения ошибочных запросов на каждом хосте кластера.
  * **Sentinel error replies** — количество ошибочных ответов {{ RD }} Sentinel на каждом хосте кластера.
  * **ACL errors** — скорость возникновения ошибок доступа на каждом хосте кластера.

  В блоке **Slowlog**:

  * **Slowlog top operations on Master** — количество записей каждой команды в Slowlog на хостах-мастерах кластера.
  * **Slowlog top operations on Replicas** — количество записей каждой команды в Slowlog на хостах-репликах кластера.
  * **Slowlog new records** — количество новых записей в Slowlog на каждом хосте кластера.

{% endlist %}

## Мониторинг состояния хостов {#monitoring-hosts}

Для просмотра детальной информации о состоянии отдельных хостов {{ mrd-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с нужным кластером.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** → **{{ ui-key.yacloud.mdb.cluster.hosts.switch_monitoring }}**.
  1. Выберите нужный хост из выпадающего списка.

  На этой странице выводятся графики, показывающие нагрузку на отдельный хост кластера:

  * **CPU usage** — загрузка процессорных ядер. При повышении нагрузки значение `idle` уменьшается.
  * **Memory usage** — использование оперативной памяти (в байтах). При высоких нагрузках значение параметра `Free` уменьшается, а значения остальных — растут.
  * **Disk IOPS** — количество дисковых операций в секунду. Характеристика `Read` растет при активном чтении из базы данных, а `Write` — при записи в нее.
  * **Network bytes** — скорость обмена данными по сети (байт/с). Для хостов с ролью **Replica** нормально преобладание `Received` над `Sent`.
  * **Network packets** — интенсивность обмена данными по сети (пакетов/с). Для хостов с ролью **Replica** нормально преобладание `Received` над `Sent`.
  * **Disk space usage** — объем занятого и общего места на диске.

  В блоке **Disk Metrics Details**:

  * **Disk write latency (percentiles)** — задержка записи на диск по процентилям.
  * **Disk write bytes** — средняя и максимальная скорость записи на диск (байт/с).
  * **Disk write operations** — среднее и максимальное количество операций записи в секунду.
  * **Disk read latency (percentiles)** — задержка чтения с диска по процентилям.
  * **Disk read bytes** — средняя и максимальная скорость чтения с диска (байт/с).
  * **Disk read operations** — среднее и максимальное количество операций чтения в секунду.
  * **Disk write throttler latency (percentiles)** — задержка записи, внесенная при превышении квоты диска, по процентилям.
  * **Disk read throttler latency (percentiles)** — задержка чтения, внесенная при превышении квоты диска, по процентилям.
  * **Disk used quota** — средний и максимальный процент использования квоты для дисковых операций.

{% endlist %}

## Мониторинг состояния шардов {#monitoring-shards}

Для просмотра детальной информации о состоянии шардов {{ mrd-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с нужным кластером.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.redis.cluster.switch_monitoring }}**.
  1. Перейдите на вкладку **Шарды** и выберите шард.
      
      На открывшейся странице будут отображены графики, отражающие состояние выбранного шарда и его хостов.
  
      {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}
  
  Для шардов отображаются графики:

  * **Hosts available for read** — доступность хостов шарда для чтения.
  * **Hosts available for write** — доступность хостов шарда для записи.

  В блоке **Traffic**:

  * **Connected Clients** — количество открытых подключений к сервисам на хостах шарда.

      Если кластер [шардированный](../concepts/sharding.md) или использует [репликацию](../concepts/replication.md), часть подключений будет использована для обмена данными между хостами кластера.
      Если при подключении к кластеру возникают ошибки, причиной могут быть неактивные приложения, которые слишком долго держат подключения открытыми. В этом случае [измените в настройках {{ VLK }}](../operations/update.md#change-valkey-config) значение параметра [Timeout](../concepts/settings-list.md#settings-timeout).

  * **Commands Processed** — скорость обработки команд на каждом хосте шарда.
  * **Commandstats** — скорость вызова команд на каждом хосте шарда.

  В блоке **Latency**:

  * **Latencystats, p50** — медианное время выполнения команд на шарде. 
  * **Latencystats, p99** — время выполнения команд в 99 процентиле на шарде.
  * **Latencystats, p99.9** — время выполнения команд в 99.9 процентиле на шарде.

  В блоке **DB Metrics**:

  * **DB keys** — количество ключей на каждом хосте шарда.
  * **Evicted keys** — количество ключей, удаленных из памяти при вставке новых данных. Информация отображается для каждого хоста шарда.
  * **Cache Hit Rate** — процент запросов, данные для которых были получены из кеша. Информация отображается для каждого хоста шарда.
  * **Replication Lag** — отставание реплики от мастера (в секундах).
  * **IO threads active** — количество активных потоков на каждом хосте шарда.
  * **Valkey-server OOM kills (for last hour)** — количество ошибок `Out of Memory` на каждом хосте шарда.

  В блоке **Resources** → **Memory**:

  * **Outer memory limit** — лимит и использование оперативной памяти процессами на каждом хосте шарда.
  * **Inner Memory limit** — лимит и использование оперативной памяти на каждом хосте шарда.
  * **Memory fragmentation ratio** — соотношение выделенной к фактически используемой памяти на каждом хосте шарда.
  * **Valkey Used Memory on Masters** — использование оперативной памяти на хостах-мастерах шарда.
  * **Valkey Used Memory on Replicas** — использование оперативной памяти на хостах-репликах шарда.
  * **Replication buffer size** — размер используемой и доступной памяти для буфера [репликации](../concepts/replication.md#replication) на каждом хосте шарда.
  * **Client recent max input buffer size** — максимальный размер буфера для обслуживания входящих клиентских подключений на каждом хосте шарда.
  * **Client recent max output buffer size** — максимальный размер буфера для обслуживания исходящих клиентских подключений на каждом хосте шарда.
  * **Copy-on-write allocations** — объем памяти, выделяемый механизмом COW при создании дочерних процессов. Информация отображается для каждого хоста шарда.

  В блоке **Resources** → **CPU**:

  * **CPU usage main thread** — использование процессорного времени (системного и пользовательского) основным потоком на каждом хосте шарда.
  * **CPU usage main thread on Masters** — использование процессорного времени (системного и пользовательского) основным потоком на хостах-мастерах шарда. 
  * **CPU usage main thread on Replicas** — использование процессорного времени (системного и пользовательского) основным потоком на хостах-репликах шарда. 

  В блоке **Resources** → **Network**:

  * **Network usage** — количество входящего и исходящего сетевого трафика на каждом хосте шарда.
  * **Network usage on Masters** — количество входящего и исходящего сетевого трафика на хостах-мастерах шарда.
  * **Network usage on Replicas** — количество входящего и исходящего сетевого трафика на хостах-репликах шарда.
  * **Replication network usage** — количество входящего и исходящего сетевого трафика репликации на каждом хосте шарда.
  * **Replication network usage on Masters** — количество входящего и исходящего сетевого трафика репликации на хостах-мастерах шарда.
  * **Replication network usage on Replicas** — количество входящего и исходящего сетевого трафика репликации на хостах-репликах шарда.

  В блоке **Resources** → **Disk**:

  * **Disk IO** — скорость дисковых операций на каждом хосте шарда.
  * **Disk space usage percentage** — процент использования дискового пространства на каждом хосте шарда.
  * **Disk space usage** — использование дискового пространства на каждом хосте шарда.

  В блоке **Errors**:

  * **Errorstats** — скорость возникновения ошибочных запросов на каждом хосте шарда.
  * **Sentinel error replies** — количество ошибочных ответов {{ RD }} Sentinel на каждом хосте шарда.
  * **ACL errors** — скорость возникновения ошибок доступа на каждом хосте шарда.

  В блоке **Slowlog**:

  * **Slowlog top operations on Master** — количество записей каждой команды в Slowlog на хостах-мастерах шарда.
  * **Slowlog top operations on Replicas** — количество записей каждой команды в Slowlog на хостах-репликах шарда.
  * **Slowlog new records** — количество новых записей в Slowlog на каждом хосте шарда.

{% endlist %}


## Настройка алертов в {{ monitoring-full-name }} {#monitoring-integration}

Чтобы настроить алерты показателей состояния [кластера](#monitoring-cluster) и [хостов](#monitoring-hosts):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с кластером, для которого нужно настроить алерты.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. В блоке **{{ ui-key.yacloud_monitoring.homepage.title_service-dashboards }}** выберите:
      * **{{ mrd-name }} — Cluster Overview** для настройки алертов кластера;
      * **{{ mrd-name }} — Host Overview** для настройки алертов хостов.
  1. На нужном графике нажмите на значок ![options](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud_monitoring.dashboard.dash.create-alert }}**.
  1. Если на графике несколько показателей, выберите запрос данных для формирования метрики и нажмите **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. Подробнее о языке запросов см. [документацию {{ monitoring-full-name }}](../../monitoring/concepts/querying.md).
  1. Задайте значения порогов `Alarm` и `Warning` для срабатывания алерта.
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Рекомендуемые значения порогов для некоторых метрик:

| Метрика                                                                                                   | Обозначение         | `Alarm`                  | `Warning`                |
|----------------------------------------------------------------------------------------------------------:|:-------------------:|:------------------------:|:------------------------:|
| Доступность БД на запись                                                                                  | `can_write`         | `Равно 0`                | —                        |
| Количество ошибок Out of Memory, за час                                                                   | `redis_oom_count`   | `Больше 2`               | `Больше 0`               |
| Утилизация RAM (только для [политики noeviction](../concepts/settings-list.md#settings-maxmemory-policy)) | `redis_used_memory` | 90% от объема RAM        | 75% от объема RAM        |
| Размер использованного хранилища                                                                          | `disk.used_bytes`   | 90% от размера хранилища | 80% от размера хранилища |

Для метрики `disk.used_bytes` значения порогов `Alarm` и `Warning` задаются только в байтах. Например, рекомендуемые значения для диска размером в 100 ГБ:

* `Alarm` — `96636764160` байтов (90%).
* `Warning` — `85899345920` байтов (80%).

Текущий объем RAM на хостах можно посмотреть в [детальной информации о кластере](cluster-list.md#get-cluster). Полный список поддерживаемых метрик см. в [документации {{ monitoring-name }}](../../monitoring/metrics-ref/managed-valkey-ref.md).


## Состояние и статус кластера {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

Для просмотра состояния и статуса кластера:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с нужным кластером.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Наведите курсор на индикатор в столбце **{{ ui-key.yacloud.common.availability }}** в строке нужного кластера.

{% endlist %}

### Состояния кластера {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Статусы кластера {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

