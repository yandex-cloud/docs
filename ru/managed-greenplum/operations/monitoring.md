# Мониторинг состояния кластера {{ GP }} и хостов

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

Новые данные для графиков поступают каждые {{ graph-update }}.

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

## Мониторинг состояния кластера {#monitoring-cluster}

Для просмотра детальной информации о состоянии кластера {{ mgp-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите [на страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![monitoring.svg](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}**.
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

    * **Xid wraparound** — использование [последовательности идентификаторов транзакций]({{ gp.docs.vmware }}/7/greenplum-database/admin_guide-intro-about_mvcc.html#transaction-id-wraparound) (в процентах).

    * **Background activities** — группа графиков, показывающих информацию о фоновых процессах:

        * **Tables vacuum age** — количество пользовательских таблиц, [очистка](../concepts/maintenance.md#custom-table-vacuum) которых выполнялась N дней назад.
        * **Tables analyze age** — количество пользовательских таблиц, [сбор статистики](../concepts/maintenance.md#get-statistics) для которых выполнялся N дней назад.
        * **Expansion progress** — ход [процесса перераспределения данных](../concepts/expand.md#redistribution) при расширении кластера:

            * **Tables** — процент обработанных таблиц.
            * **Bytes** — процент перераспределенных байт данных.

            {% note info %}

            Этот график показывает ход процесса, даже если перераспределение данных было запущено не в виде [фонового процесса](../concepts/expand.md#setting-delay-redistribution).

            {% endnote %}

{% endlist %}

## Мониторинг состояния хостов {#monitoring-hosts}

Для просмотра детальной информации о состоянии отдельных хостов {{ mgp-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите [на страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку ![hosts.svg](../../_assets/console-icons/cube.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** → **{{ ui-key.yacloud.mdb.cluster.hosts.switch_monitoring }}**.
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

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог с кластером, для которого нужно настроить алерты.
  1. В списке сервисов выберите ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. В блоке **{{ ui-key.yacloud_monitoring.dashboard.tab.service-dashboards }}** выберите:
      * **{{ mgp-name }} — Cluster Overview** для настройки алертов кластера;
      * **{{ mgp-name }} — Host Overview** для настройки алертов хостов.
  1. На нужном графике с показателями нажмите на значок ![options](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
  1. Если показателей на графике больше одного, выберите запрос данных для формирования метрики и нажмите **{{ ui-key.yacloud_monitoring.dialog.confirm.button_continue }}**. Подробнее о языке запросов см. в [документации {{ monitoring-full-name }}](../../monitoring/concepts/querying.md).
  1. Задайте значения порогов `{{ ui-key.yacloud_monitoring.alert.status_alarm }}` и `{{ ui-key.yacloud_monitoring.alert.status_warn }}` для оповещения.
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

{% endlist %}

{% include [other-indicators](../../_includes/mdb/other-indicators.md) %}

Полный список поддерживаемых метрик см. в [документации {{ monitoring-name }}](../../monitoring/metrics-ref/managed-greenplum-ref.md).


## Состояние и статус кластера {#cluster-health-and-status}

{% include [health-and-status](../../_includes/mdb/monitoring-cluster-health-and-status.md) %}

Для просмотра состояния и статуса кластера:

1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
1. Наведите курсор на индикатор в столбце **{{ ui-key.yacloud.common.availability }}** в строке нужного кластера.

### Состояния кластера {#cluster-health}

{% include [monitoring-cluster-health](../../_includes/mdb/monitoring-cluster-health.md) %}

### Статусы кластера {#cluster-status}

{% include [monitoring-cluster-status](../../_includes/mdb/monitoring-cluster-status.md) %}


{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
