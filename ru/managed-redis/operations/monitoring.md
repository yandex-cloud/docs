---
title: Мониторинг состояния кластера {{ VLK }} и хостов
description: Вы можете отслеживать состояние кластера {{ mrd-name }} и отдельных его хостов с помощью инструментов мониторинга в консоли управления. Эти инструменты предоставляют диагностическую информацию в виде графиков.
---

# Мониторинг состояния кластера {{ VLK }} и хостов

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

{% include [monitoring-period](../../_includes/mdb/monitoring-freq.md) %}

{% include [monitoring-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

{% include [alerts](../../_includes/mdb/alerts.md) %}

## Мониторинг состояния кластера {#monitoring-cluster}

Для просмотра детальной информации о состоянии кластера {{ mrd-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с нужным кластером.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.redis.cluster.switch_monitoring }}**.
  
  1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

  На странице появятся следующие графики:

  * **Can Read** — отображает кластеры, доступные на чтение.

  * **Can Write** — отображает кластеры, доступные на запись.

  * **Cache Hit Rate** — процент попаданий в кеш на каждом хосте.

      Значения, близкие к 1, говорят об эффективном использовании кластера в качестве кеширующего сервера. Если процент попаданий в кеш близок к 0, возможно, следует изменить логику работы приложения, время жизни ключей или [политику управления оперативной памятью](../concepts/settings-list.md#settings-maxmemory-policy) при ее дефиците.

  * **Client recent max input buffer size** — использование памяти для обслуживания клиентских подключений, выполняющих запись данных (в байтах).

  * **Client recent max output buffer size** — использование памяти для обслуживания клиентских подключений, выполняющих чтение данных:

      * **Soft Limit** — мягкий лимит использования памяти;
      * **Hard Limit** — жесткий лимит использования памяти.

      При превышении **Soft Limit** кластер в течение нескольких секунд будет ожидать его снижения. Если значение не уменьшится, подключение будет закрыто.
      При превышении **Hard Limit** соединение будет закрыто сразу.

  * **Commands Processed** — среднее количество команд, обработанных каждым хостом кластера.

  * **Connected Clients** — количество открытых соединений для каждого хоста кластера.

      Если кластер [шардированный](../concepts/sharding.md) или использует [репликацию](../concepts/replication.md), часть соединений будет использована для обмена данными между хостами кластера.
      Если при подключении к кластеру возникают ошибки, возможно, неактивные приложения держат соединения открытыми слишком долго. В этом случае [измените в настройках {{ VLK }}](../operations/update.md#change-redis-config) значение параметра [Timeout](../concepts/settings-list.md#settings-timeout).

  * **Copy-on-write allocations** — потребление памяти процессами {{ VLK }} при использовании механизма [COW (Copy-on-write)](https://ru.wikipedia.org/wiki/Копирование_при_записи) (в байтах).

      На графике показаны последние измеренные {{ VLK }} значения параметров:

      * **module_fork_last_cow_size** — количество данных, скопированных при вызове `fork()` с использованием механизма COW.
      * **aof_last_cow_size** — количество данных, скопированных при создании AOF-файла.
      * **rdb_last_cow_size** — количество данных, скопированных при создании RDB-файла.

      Подробнее см. в разделе [Резервные копии](../concepts/backup.md).

  * **DB keys** — количество ключей, хранящихся во всех базах данных кластера.

  * **Evicted keys** — количество ключей, удаленных из памяти при вставке новых данных.

      По умолчанию для управления памятью используется политика **noeviction** — не удалять ключи, вернуть ошибку, если для вставки новых данных недостаточно памяти. Чтобы использовать другую политику управления памятью, [измените в настройках {{ VLK }}](./update.md#change-redis-config) значение параметра [Maxmemory policy](../concepts/settings-list.md#settings-maxmemory-policy).

  * **Inner memory limit** — объем оперативной памяти, доступной для использования процессами {{ VLK }} (в байтах):

      * **maxmemory** — максимальный объем памяти, выделяемый для пользовательских данных;
      * **used_memory** — фактическое использованием памяти на хосте.

      Если значение параметра **used_memory** достигнет значения параметра **maxmemory**, при попытке вставить новые записи {{ VLK }} применит режим управления памятью, установленный настройкой [Maxmemory policy](../concepts/settings-list.md#settings-maxmemory-policy).

      {% note info %}

      Значение параметра **maxmemory** для хостов {{ VLK }} устанавливается в размере {{ mrd-memory-used }} от объема доступной памяти. Подробнее см. в разделе [Управление памятью](../concepts/memory-management.md).

      {% endnote %}

  * **Outer memory limit** — показывает объем всей оперативной памяти, доступной для использования на хостах (в байтах):

      * **memory_limit** — объем памяти, выделенной каждому хосту;
      * **used_memory_rss** — использование памяти процессами {{ VLK }}.

      При приближении значения параметра **used_memory_rss** к значению параметра **memory_limit** процесс {{ VLK }} может быть принудительно завершен операционной системой. Чтобы избежать этого:
      * измените логику работы приложения таким образом, чтобы снизить объем данных, хранимых в {{ VLK }};
      * [измените в настройках {{ VLK }}](./update.md#change-redis-config) значение параметра [Maxmemory policy](../concepts/settings-list.md#settings-maxmemory-policy), отвечающего за политику управления памятью при ее дефиците;
      * [повысьте класс хоста](./update.md#change-resource-preset).

  * **Redis Used Memory on Masters** — использование оперативной памяти на хостах-мастерах (в байтах):

      * **db_hashtable_overhead** — для хранения хеш-таблиц всех баз данных;
      * **used_memory_scripts** — для хранения и работы [скриптов](https://valkey.io/commands/script-load);
      * **mem_aof_buffer** — для буфера [AOF](../concepts/replication.md#setting-appendonly);
      * **mem_clients_normal** — для обслуживания внешних подключений;
      * **mem_clients_slaves** — для обслуживания подключений репликации;
      * **mem_replication_backlog** — для циклического буфера репликации;
      * **used_memory_startup** — для процессов {{ VLK }} при запуске (например, после перезагрузки кластера);
      * **used_memory_dataset** — для хранения данных.
      * **mem_cluster_links** — для сетевых соединений в режиме кластера.

  * **Redis Used Memory on Replicas** — использование оперативной памяти на хостах-репликах (в байтах):

      * **db_hashtable_overhead** — для хранения хеш-таблиц всех баз данных;
      * **used_memory_scripts** — для хранения и работы [скриптов](https://valkey.io/commands/script-load);
      * **mem_aof_buffer** — для буфера [AOF](../concepts/replication.md#setting-appendonly);
      * **mem_clients_normal** — для обслуживания внешних подключений;
      * **mem_clients_slaves** — для обслуживания подключений репликации;
      * **mem_replication_backlog** — для циклического буфера репликации;
      * **used_memory_startup** — для процессов {{ VLK }} при запуске (например, после перезагрузки кластера);
      * **used_memory_dataset** — для хранения данных.
      * **mem_cluster_links** — для сетевых соединений в режиме кластера.

  * **Redis-server OOM kills (for last hour)** — количество прерываний процессов {{ VLK }} из-за нехватки оперативной памяти (_OOM_ — out-of-memory) за последний час.

      Чтобы сократить количество прерываний:
      * измените логику работы приложения таким образом, чтобы снизить объем данных, хранимых в {{ VLK }};
      * [измените в настройках {{ VLK }}](./update.md#change-redis-config) значение параметра [Maxmemory policy](../concepts/settings-list.md#settings-maxmemory-policy), отвечающего за политику управления оперативной памятью при ее дефиците;
      * [повысьте класс хоста](./update.md#change-resource-preset).

  * **Replication buffer size** — размер буфера [репликации](../concepts/replication.md#replication) (в байтах):

      * **repl_backlog_size** — максимальный объем памяти, доступный под буфер репликации;
      * **repl_backlog_histlen** — текущий объем памяти, занятый данными в буфере репликации.

      Когда память в циклическом буфере будет исчерпана, запустится процесс полной репликации. Это снизит производительность кластера, т. к. при полной репликации значительно возрастает использование оперативной памяти и нагрузка на CPU и сеть.

  * **Replication Lag** — отставание реплики от мастера (в секундах).

      Ненулевое значение говорит о долгом выполнении команд на реплике или ее перегруженности.

      Подробнее читайте в разделе [{#T}](../concepts/replication.md).

  * **Slowlog top operations on Master** — список из 5 самых медленных команд, выполненных на хосте-мастере за одну минуту.
  
  * **Slowlog top operations on Replicas** — список из 5 самых медленных команд, выполненных на каждом хосте-реплике за одну минуту.

  * **Slowlog new records** - отображает новые записи в slow log.

      Медленной считается команда, время на выполнение которой превысило значение настройки кластера [Slowlog log slower than](../concepts/settings-list.md#settings-slowlog-slower-than). На графике показывается только первая часть команды, а также количество ее вызовов за одну минуту.

{% endlist %}

## Мониторинг состояния хостов {#monitoring-hosts}

Для просмотра детальной информации о состоянии отдельных хостов {{ mrd-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с нужным кластером.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** → **{{ ui-key.yacloud.mdb.cluster.hosts.switch_monitoring }}**.
  1. Выберите нужный хост из выпадающего списка.

  На этой странице выводятся графики, показывающие нагрузку на отдельный хост кластера:

  * **CPU usage** — загрузка процессорных ядер. При повышении нагрузки значение `idle` уменьшается.
  * **Disk read/write bytes** — скорость дисковых операций (байт/с).
  * **Disk IOPS** — интенсивность дисковых операций (операций/с).
  * **Disk space usage** — объем занятого и общего места на диске.
  * **Memory usage** — использование оперативной памяти (в байтах). При высоких нагрузках значение параметра `Free` уменьшается, а значения остальных — растут.
  * **Network bytes** — скорость обмена данными по сети (байт/с).
  * **Network packets** — интенсивность обмена данными по сети (пакетов/с).

  На графиках **Disk read/write bytes** и **Disk IOPS** характеристика **Read** растет при активном чтении из базы данных, а **Write** — при записи в нее.

  Для хостов с ролью **Replica** нормально преобладание **Received** над **Sent** на графиках **Network bytes** и **Network packets**.

{% endlist %}


## Настройка алертов в {{ monitoring-full-name }} {#monitoring-integration}

Чтобы настроить алерты показателей состояния [кластера](#monitoring-cluster) и [хостов](#monitoring-hosts):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с кластером, для которого нужно настроить алерты.
  1. В списке сервисов выберите ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
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

Текущий объем RAM на хостах можно посмотреть в [детальной информации о кластере](cluster-list.md#get-cluster). Полный список поддерживаемых метрик см. в [документации {{ monitoring-name }}](../../monitoring/metrics-ref/managed-redis-ref.md).


## Состояние и статус кластера {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

Для просмотра состояния и статуса кластера:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с нужным кластером.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
  1. Наведите курсор на индикатор в столбце **{{ ui-key.yacloud.common.availability }}** в строке нужного кластера.

{% endlist %}

### Состояния кластера {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Статусы кластера {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

