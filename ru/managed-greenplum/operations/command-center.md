# Мониторинг и управление сессиями и запросами в командном центре

В [командном центре {{ GP }}](../concepts/command-center.md) вы можете:

* [{#T}](#list).
* [{#T}](#consumption-history).
* [{#T}](#terminate-session).
* [{#T}](#terminate-query).

{% note info %}

Командный центр доступен в кластерах с версией {{ GP }} 6.25 и выше.

{% endnote %}

## Посмотреть информацию о сессиях и запросах {#list}

Вы можете посмотреть список сессий и запросов и подробную информацию по ним. По каждой сессии можно изучить историю этой сессии и ее запросов. По каждому запросу можно изучить план его выполнения и JSON-файл с деталями.

Чтобы посмотреть информацию о сессиях и запросах:

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и перейдите на вкладку ![image](../../_assets/mdb/mgp-command-center.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}**.
    1. Выберите, что вы хотите посмотреть, и перейдите на нужную вкладку:

        * текущие сессии или запросы — вкладка **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_current-state }}**;
        * сессии или запросы за прошедший момент времени — вкладка **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_states-history }}**.

    1. Выберите раздел **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-session }}** или **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-query }}**. Во вкладке **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_states-history }}** эти разделы располагаются под графиком.
    1. Чтобы отфильтровать список сессий или запросов, нажмите кнопку ![image](../../_assets/mdb/mgp-command-center-filter.svg) **{{ ui-key.yacloud.common.label_filters }}** и выберите нужные параметры.
    1. Чтобы посмотреть детали:

        * сессии — нажмите на имя сессии;
        * запроса — нажмите на ключ выполняемого запроса.

{% endlist %}

## Просмотреть историю потребления для завершенных запросов {#consumption-history}

В истории потребления доступно несколько системных метрик. Они показывают, как кластер {{ mgp-name }} потреблял ресурсы для обработки запросов в разные моменты времени. Также вы можете посмотреть список завершенных запросов. С помощью полученной информации вы можете определить, как управлять CPU и памятью хостов кластера для эффективной обработки запросов.

Чтобы посмотреть историю потребления для завершенных запросов:

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и перейдите на вкладку ![image](../../_assets/mdb/mgp-command-center.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_consumption-history }}**.
    1. Выберите нужный показатель потребления:

        * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-running-time-seconds }}** — время в секундах, которое понадобилось ресурсам CPU для обработки запросов.
        * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-vm-peak-kb }}** — максимальное количество памяти, которое потребовалось для обработки запроса за все время жизни кластера.
        * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-read-bytes }}** — память в байтах, которая понадобилась для чтения данных.
        * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-write-bytes }}** — память в байтах, которая понадобилась для записи данных в БД.
        * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-spill-total-bytes }}** — дополнительный объем памяти, который потребовался для выполнения запросов.
        * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-total-time }}** — суммарное количество памяти в байтах, затраченное на обработку запроса.

        После того как вы выберете показатель потребления, отобразится график с деталями и список запросов. На графике указаны значение показателя, пользователь, который выполнил запрос, и время выполнения запроса.

    1. Чтобы отфильтровать результаты, нажмите кнопку ![image](../../_assets/mdb/mgp-command-center-filter.svg) **{{ ui-key.yacloud.common.label_filters }}** и выберите нужные параметры.

{% endlist %}

## Прервать текущую сессию {#terminate-session}

Чтобы освободить ресурсы для сессий, вы можете прервать, например, простаивающую сессию в статусе `Idle`. Для этого:

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и перейдите на вкладку ![image](../../_assets/mdb/mgp-command-center.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}**.
    1. В разделе **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_current-state }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-session }}** нажмите на значок ![image](../../_assets/options.svg) в нужной строке и выберите пункт **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_action-terminate-session }}**.

        Если у вас отображается пункт **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_action-terminate-query }}**, выберите его и остановите запрос.

    1. Подтвердите остановку сессии.

{% endlist %}

## Прервать текущий запрос {#terminate-query}

Чтобы освободить ресурсы для выполнения запросов, вы можете прервать, например, запрос в статусе `Idle` в простаивающей сессии. Для этого:

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и перейдите на вкладку ![image](../../_assets/mdb/mgp-command-center.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}**.
    1. В разделе **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_current-state }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-query }}** нажмите на значок ![image](../../_assets/options.svg) в нужной строке и выберите пункт **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_action-terminate-query }}**.
    1. Подтвердите остановку сессии.

{% endlist %}
