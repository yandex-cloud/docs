# Мониторинг состояния кластера и хостов

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

Новые данные для графиков поступают каждые {{ graph-update }}.

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

## Мониторинг состояния кластера {#monitoring-cluster}

Для просмотра детальной информации о состоянии кластера {{ mgp-name }}:

{% list tabs %}

- Консоль управления

    1. Перейдите [на страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mgp-name }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![monitoring.svg](../../_assets/monitoring.svg) **Мониторинг**.
    1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

    На странице отображаются следующие графики:

    * **Alive hosts** — работоспособность хостов кластера.

    * **Alive segments** — работоспособность первичного и резервного мастеров, основных и зеркальных сегментов.

    * **Connections** — количество подключений к БД в каждом из состояний:

        * **Active** — активные;
        * **Waiting** — ожидают;
        * **Idle** — простаивают;
        * **Idle in transaction** — простаивают в транзакции;
        * **Aborted** — прерванные.

    * **Group resource cpu** — загрузка процессорных ядер по группам процессов:

        * **admin_group** — в административной группе;
        * **default_group** — в группе по умолчанию.

    * **Group resource memory** — использование оперативной памяти (в байтах) по группам процессов:

        * **admin_group** — в административной группе;
        * **default_group** — в группе по умолчанию.

    * **Master** — определение первичного хоста-мастера.

    * **Master replication lag** — отставание репликации мастера (в байтах).

    * **Master replication state** — работоспособность репликации мастера.

    * **Segment health** — количество сегментов с различной работоспособностью:

        * **total** — все;
        * **not sync** — несинхронизированные;
        * **down** — недоступные;
        * **not prefer role** — непредпочтительные.

    * **Spill files count** — количество временных файлов.

    * **Spill files size** — суммарный размер временных файлов (в байтах).

    * **Xid wraparound** — использование [последовательности идентификаторов транзакций](https://docs.greenplum.org/6-16/admin_guide/managing/maintain.html) (в процентах).

{% endlist %}

## Мониторинг состояния хостов {#monitoring-hosts}

Для просмотра детальной информации о состоянии отдельных хостов {{ mgp-name }}:

{% list tabs %}

- Консоль управления

    1. Перейдите [на страницу каталога]({{ link-console-main }}) и выберите сервис **{{mgp-name }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![hosts.svg](../../_assets/mdb/hosts.svg) **Хосты** → **Мониторинги**.
    1. Выберите нужный хост из выпадающего списка.

    На этой странице выводятся графики, показывающие нагрузку на отдельный хост кластера (мастер или сегмент):

    * **CPU** — загрузка процессорных ядер. При повышении нагрузки значение `Idle` уменьшается.
    * **Disk IOPS in progress** — количество незавершенных дисковых операций.
    * **Disk io time** — длительность дисковых операций.
    * **Disk read and write** — объем дисковых операций (в байтах).
    * **Disk read and write time** — длительность дисковых операций чтения и записи.
    * **Disk usage** — использование дискового пространства (выводится два графика: в байтах и в процентах).
    * **Memory usage** — использование оперативной памяти (в байтах). При высоких нагрузках значение параметра `Free` уменьшается, а значения остальных — растут.
    * **Network** — объем данных, переданных по сети (в байтах).

{% endlist %}

## Интеграция с {{ monitoring-full-name }} {#monitoring-integration}

Чтобы настроить алерты показателей состояния [кластера](#monitoring-cluster) и [хостов](#monitoring-hosts):

{% list tabs %}

- Консоль управления

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с кластером, для которого нужно настроить алерты.
  1. В списке сервисов выберите ![image](../../_assets/monitoring.svg) **{{ monitoring-short-name }}**.
  1. В блоке **Сервисные дашборды** выберите:
      * **{{ mes-name }} — Cluster Overview** для настройки алертов кластера;
      * **{{ mes-name }} — Host Overview** для настройки алертов хостов.
  1. На нужном графике с показателями нажмите на значок ![options](../../_assets/horizontal-ellipsis.svg) и выберите пункт **Создать алерт**.
  1. Если показателей на графике больше одного, выберите запрос данных для формирования метрики и нажмите **Продолжить**. {% if audience == "external" %}Подробнее о языке запросов см. в [документации {{ monitoring-full-name }}](../../monitoring/concepts/querying.md).{% endif %}
  1. Задайте значения порогов `Alarm` и `Warning` для оповещения.
  1. Нажмите кнопку **Создать алерт**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Полный список поддерживаемых метрик см. в [документации {{ monitoring-name }}](../../monitoring/metrics-ref/index.md#managed-greenplum).

## Состояние и статус кластера {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

Для просмотра состояния и статуса кластера:

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mgp-name }}**.
1. Наведите курсор на индикатор в столбце **Доступность** в строке нужного кластера.

### Состояния кластера {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Статусы кластера {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
