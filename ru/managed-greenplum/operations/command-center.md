---
title: Работа с командным центром {{ GP }}
description: Используя командный центр, вы можете просматривать информацию о сессиях и запросах, а также управлять ими.
---

# Работа с командным центром {{ GP }}

В командном центре {{ GP }} вы можете:

* [Посмотреть информацию о сессиях и запросах](#list).
* [Просмотреть историю потребления для завершенных запросов](#consumption-history).
* [Прервать текущую сессию](#terminate-session).
* [Прервать текущий запрос](#terminate-query).

Также ознакомьтесь с [примерами работы](#examples) в командном центре — они помогут понять, как и в каких ситуациях можно использовать командный центр.

Подробнее о статистике, которую можно получить с помощью командного центра, читайте в разделе [{#T}](../concepts/command-center.md).

{% note info %}

Командный центр {{ GP }} позволяет проводить только базовый операционный анализ сессий и запросов. Если ваша задача требует углубленного стратегического исследования и расширенных инструментов анализа, используйте [экспорт логов в {{ cloud-logging-full-name }}](./mgp-to-cloud-logging.md). Сервис {{ cloud-logging-full-name }} позволяет [визуализировать логи в {{ grafana-name }}](../../logging/tutorials/grafana-logs-plugin.md) и выполнять их [обработку с помощью {{ yds-short-name }} и {{ yq-name }}](../../logging/tutorials/cloud-logging.md).

{% endnote %}

## Посмотреть информацию о сессиях и запросах {#list}

Вы можете посмотреть список сессий и запросов и подробную информацию по ним. По каждой сессии можно изучить историю этой сессии и ее запросов. По каждому запросу можно изучить план его выполнения и JSON-файл с деталями.

Чтобы посмотреть информацию о сессиях и запросах:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и перейдите на вкладку ![image](../../_assets/console-icons/pulse.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}**.
    1. Выберите, что вы хотите посмотреть, и перейдите на нужную вкладку:

        * текущие сессии или запросы — вкладка **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_current-state }}**;
        * сессии или запросы за прошедший момент времени — вкладка **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_states-history }}**.

    1. Выберите раздел **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-session }}** или **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-query }}**. Во вкладке **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_states-history }}** эти разделы располагаются под графиком.
    1. Чтобы отфильтровать список сессий или запросов, нажмите кнопку ![image](../../_assets/console-icons/funnel.svg) **{{ ui-key.yacloud.common.label_filters }}** и выберите нужные параметры.
    1. Чтобы посмотреть детали:

        * сессии — нажмите на имя сессии;
        * запроса — нажмите на ключ выполняемого запроса.

        Параметры сессий и запросов описаны в разделе [Параметры командного центра {{ GP }}](../concepts/command-center-parameters.md).

{% endlist %}

## Просмотреть историю потребления для завершенных запросов {#consumption-history}

В истории потребления доступно несколько системных метрик. Они показывают, как кластер {{ GP }} потреблял ресурсы для обработки запросов в разные моменты времени. Также вы можете посмотреть список завершенных запросов. С помощью полученной информации вы можете определить, как управлять CPU и памятью хостов кластера для эффективной обработки запросов.

Чтобы посмотреть историю потребления для завершенных запросов:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и перейдите на вкладку ![image](../../_assets/console-icons/pulse.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_consumption-history }}**.
    1. Выберите нужный показатель потребления:

        * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-running-time-seconds }}** — время в секундах, которое понадобилось ресурсам CPU для обработки запросов.
        * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-vm-peak-kb }}** — максимальное количество памяти, которое потребовалось для обработки запроса за все время жизни кластера.
        * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-read-bytes }}** — память в байтах, которая понадобилась для чтения данных.
        * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-write-bytes }}** — память в байтах, которая понадобилась для записи данных в БД.
        * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-spill-total-bytes }}** — дополнительный объем памяти, который потребовался для выполнения запросов.
        * **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-total-time }}** — суммарное количество памяти в байтах, затраченное на обработку запроса.

        После того как вы выберете показатель потребления, отобразится график с деталями и список запросов. На графике указаны значение показателя, пользователь, который выполнил запрос, и время выполнения запроса.

    1. Чтобы отфильтровать результаты, нажмите кнопку ![image](../../_assets/console-icons/funnel.svg) **{{ ui-key.yacloud.common.label_filters }}** и выберите нужные параметры.

{% endlist %}

## Прервать текущую сессию {#terminate-session}

Чтобы освободить ресурсы для сессий, вы можете прервать простаивающую сессию в статусе `{{ ui-key.yacloud.greenplum.perf-diag.label_session-status-idle }}`:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и перейдите на вкладку ![image](../../_assets/console-icons/pulse.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}**.
    1. В разделе **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_current-state }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-session }}** нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в нужной строке и выберите пункт **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_action-terminate-session }}**.

        Если у вас отображается пункт **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_action-terminate-query }}**, выберите его и остановите запрос.

    1. Подтвердите остановку сессии.

{% endlist %}

## Прервать текущий запрос {#terminate-query}

Чтобы освободить ресурсы для выполнения запросов, вы можете прервать запрос в статусе `{{ ui-key.yacloud.greenplum.perf-diag.label_session-status-idle }}` в простаивающей сессии. Для этого:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и перейдите на вкладку ![image](../../_assets/console-icons/pulse.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}**.
    1. В разделе **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_current-state }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-query }}** нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в нужной строке и выберите пункт **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_action-terminate-query }}**.
    1. Подтвердите остановку запроса.

{% endlist %}

## Примеры анализа текущего состояния {#current-analysis}

Командный центр {{ GP }} поддерживает следующие виды анализа текущего состояния кластера:

* Анализ метрик, например [поиск тяжелой сессии](#heavy-session) или [анализ структуры выполнения запросов](#nested-query).
* Анализ событий, например [поиск простаивающей сессии](#current-session) или [поиск блокирующей сессии](#blocker-session).

### Поиск текущей сессии, которая потребляет аномальное количество ресурсов {#heavy-session}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и перейдите на вкладку ![image](../../_assets/console-icons/pulse.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_current-state }}**.
    1. Отсортируйте сессии по одному из столбцов: **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-cpu-time }}**, **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-peak-memory }}**, **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-spill-total-bytes }}**, **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-write-bytes }}**, **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-read-bytes }}**, **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-recv-total-bytes }}** или **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-sent-total-bytes }}**. 
    1. Найдите сессии, которые потребляют наибольшее количество выбранного ресурса.
    1. Для каждой выбранной сессии:
       1. Нажмите на номер сессии. Откроется страница с информацией об этой сессии.
       1. Сопоставьте показатели вычислительной нагрузки и нагрузки на ввод-вывод (**{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-cpu-time }}**, **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-peak-memory }}**, **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-spill-total-bytes }}**, **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-write-bytes }}**, **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-read-bytes }}**, **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-recv-total-bytes }}**, **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-sent-total-bytes }}**) с общими графиками нагрузки на кластер или его отдельные хосты.
    1. Определите, какая из сессий внесла наибольший вклад в потребление ресурсов.
    1. Чтобы посмотреть детали о состояниях сессии в разные моменты времени и отследить изменение показателей во времени, перейдите на вкладку **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_tab-session-history }}**.

    {% note info %}

    Найти проблемы с потреблением ресурсов в конкретной сессии может только инициатор запросов, так как только он знает ожидаемое время работы конкретных запросов.

    {% endnote %}

{% endlist %}

### Анализ структуры выполнения запросов {#nested-query}

Вы можете выявить запросы, которые выполняются неэффективно из-за логики построения SQL-выражений или порядка операций.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и перейдите на вкладку ![image](../../_assets/console-icons/pulse.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_current-state }}**.
    1. Перейдите на вкладку **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-session }}**.
    1. Включите отображение только активных сессий. Для этого выключите все кнопки-статусы, кроме **{{ ui-key.yacloud.greenplum.perf-diag.label_session-status-active }}**.
    1. Отсортируйте сессии по столбцу **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-backend-start }}**.
    1. Найдите долгоживущую сессию с высокими значениями в столбцах **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-cpu-time }}** и **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-peak-memory }}**. Нажмите на номер этой сессии. Откроется страница с информацией о ней.
    1. Проанализируйте значения **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-cpu-time }}**, **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-peak-memory }}**, **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-spill-total-bytes }}**, **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-skew }}**, **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-sent-total-bytes }}**, **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-recv-total-bytes }}** и **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-retransmits }}**.

       * Если вы видите высокие значения **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-sent-total-bytes }}** и **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-recv-total-bytes }}**, а также ненулевое значение **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-retransmits }}**:
         1. Перейдите на вкладку **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-query }}**.
         1. Примените фильтр **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-client-ssid }}**, указав идентификатор транзакции выбранной сессии.
         1. Отсортируйте запросы по столбцу **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-running-query-key }}** по убыванию.
         1. Откройте планы выполнения нескольких запросов.
         1. Если после `Sort`, `Aggregate` или `Distinct` вы видите `Gather` или `Gather Merge`, перенесите `GROUP BY`/`DISTINCT`/`ORDER BY` в подзапросы.
         1. Если вы видите широкие выборки с полным набором столбцов, ограничьте результат с помощью `LIMIT` или постраничного вывода, а также отберите только необходимые столбцы и примените фильтры на ранних этапах запроса.

       * Если вы видите ненулевое значение **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-spill-total-bytes }}**:
         1. Перейдите на вкладку **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-query }}**.
         1. Примените фильтр **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-client-ssid }}**, указав идентификатор транзакции выбранной сессии.
         1. Отсортируйте запросы по столбцу **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-running-query-key }}** по убыванию.
         1. Откройте планы выполнения нескольких запросов.
         1. Если вы видите подзапросы с зависимостью от внешней строки (`EXISTS` или `IN` с корреляцией), а в плане выполнения присутствуют узлы `SubPlan` или `InitPlan`, декоррелируйте такие подзапросы.
         1. Если вы видите сортировку или материализацию, а затем `WindowAgg` над большими выборками, примените предагрегацию или фильтрацию, а также исключите лишние столбцы до применения оконных функций.
         1. Если вы видите `Sort` или `Distinct` на разных уровнях вложенности, уменьшите количество таких операций и глубину их вложенности.

       * Если вы видите высокие значения **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-cpu-time }}** или **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-peak-memory }}** при ненулевых значениях **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-skew }}**:
         1. Перейдите на вкладку **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-query }}**.
         1. Примените фильтр **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-client-ssid }}**, указав идентификатор транзакции выбранной сессии.
         1. Отсортируйте запросы по столбцу **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-running-query-key }}** по убыванию.
         1. Откройте планы выполнения нескольких запросов и проверьте, как выполняются соединения:
            * Если соединения выполняются по столбцам, отличным от фактического ключа распределения таблиц, перепишите запрос.
            * Если соединяются крупные наборы, а фильтры отсутствуют или применяются после `JOIN`, используйте фильтрацию в подзапросах до `JOIN`.

{% endlist %}

### Поиск простаивающей сессии {#current-session}

Допустим, пользователь закончил работу с БД, но оставил свою сессию открытой. В таком случае сессия простаивает и потребляет ресурсы кластера, что приводит к снижению его производительности. Чтобы найти и прервать такую сессию:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и перейдите на вкладку ![image](../../_assets/console-icons/pulse.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_current-state }}**.
    1. Отсортируйте сессии по столбцу **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-backend-start }}**.
    1. Найдите сессию в статусе `{{ ui-key.yacloud.greenplum.perf-diag.label_session-status-idle }}`, которая длится наибольшее количество времени. Нажмите на номер этой сессии. Откроется страница с информацией о ней.
    1. В разделе **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_section_session-info }}** в поле **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-query-started }}** посмотрите, когда был отправлен последний запрос.
    1. Если сессия не выполняет запросы, а удержание соединения не требуется по логике клиентского приложения, такую сессию можно прервать. Для этого в правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_action-terminate-session }}** и подтвердите остановку сессии.

{% endlist %}

### Поиск блокирующей сессии {#blocker-session}

В некоторых случаях сессия надолго захватывает строки таблицы или ее метаданные. Это может создавать очередь из заблокированных сессий, ожидающих захвата ресурса. Чтобы определить, какая сессия является блокирующей:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и перейдите на вкладку ![image](../../_assets/console-icons/pulse.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_current-state }}**.
    1. Перейдите на вкладку **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-session }}**.
    1. Для отображения дерева блокировок нажмите кнопку ![image](../../_assets/console-icons/branches-down.svg).
    1. Исследуйте дерево блокировок и определите основные блокирующие сессии. 
    1. По каждой блокирующей сессии проверьте:
        * Статус — как правило, `{{ ui-key.yacloud.greenplum.perf-diag.label_session-status-active }}` или `{{ ui-key.yacloud.greenplum.perf-diag.label_session-status-idle-transaction }}`.
        * Значения параметров **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-backend-start }}** и **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-state-changed }}**.
        * Количество потребляемых ресурсов.
        * Количество заблокированных сессий.
        * Текст запроса.
    1. Если блокирующая сессия долго находится в состоянии `{{ ui-key.yacloud.greenplum.perf-diag.label_session-status-active }}` и потребляет вычислительные ресурсы, причиной может быть тяжелый запрос. В этом случае может помочь оптимизация запросов и бизнес-логики.
    1. Если сессия блокирует множество других сессий и давно находится в состоянии `{{ ui-key.yacloud.greenplum.perf-diag.label_session-status-idle-transaction }}`, вы можете ее прервать после дополнительных проверок:
        1. Убедитесь, что **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-cpu-time }}** не увеличивается, а поле **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-session-waiting-reason }}** пустое.
        1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_action-terminate-session }}**.
        1. Подтвердите остановку сессии.

    {% note tip %}

    Для предотвращения длительных блокировок:
    * оптимизируйте запросы и уменьшите разовый объем обрабатываемых данных;
    * разнесите по времени интерактивные запросы и тяжелые операции;
    * задайте таймауты выполнения запросов и ожидания блокировки.

    {% endnote %}

{% endlist %}

## Примеры анализа истории состояний и истории потребления {#historical-analysis}

Командный центр {{ GP }} поддерживает следующие виды анализа истории сессий и запросов:

* Анализ метрик, например [поиск тяжелых запросов](#past-statements) и [поиск запросов с большой нагрузкой на сеть](#net-load).
* Анализ событий, например [поиск отмененных запросов и ошибок выполнения](#cancelations).

### Поиск запросов, вызвавших высокую нагрузку CPU {#past-statements}

Допустим, в определенный период потребление вычислительной мощности CPU было выше обычного. Чтобы определить, какие запросы вызвали эту аномалию:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Узнайте, когда было зафиксировано высокое потребление CPU:

        1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
        1. Нажмите на имя нужного кластера и перейдите в ![image](../../_assets/console-icons/pulse.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_states-history }}**.
        1. Задайте фильтр **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-monitoring-cpu-usage }}**.
        1. Определите по графику, когда потребление CPU стало аномально высоким.

            Для этого наведите курсор на высокий пик. Появится всплывающее окно с информацией о состоянии кластера в выбранный момент. В этом окне указано время, когда произошел всплеск.

    1. Определите, какие запросы привели к высокому потреблению CPU:

        1. Перейдите на вкладку **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_consumption-history }}**.
        1. Задайте диапазон времени на основе анализа истории состояний.
        1. Сгруппируйте запросы по пользователю, базе данных и идентификатору запроса. Так вы получите группы, которые содержат похожие друг на друга запросы.
        1. Отсортируйте полученные группы запросов по столбцу **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-cpu-time }}**.
        1. Откройте группу с наибольшим значением **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-cpu-time }}**.
        1. Изучите SQL-текст запросов и их планы выполнения, чтобы определить, что привело к высокому потреблению CPU.

       {% note tip %}

        Найти проблемы с потреблением CPU в конкретной сессии может только инициатор запросов, однако на необходимость в оптимизации могут указать следующие признаки:
        * сложные вычисления и выражения, выполняемые построчно;
        * сортировки и агрегации без фильтрации данных;
        * многократные проходы по большим таблицам без использования индексов или распределения данных;
        * повторные вычисления подзапросов или функций внутри выражений.

       {% endnote %}

{% endlist %}

### Поиск запросов, вызвавших большую нагрузку на сеть {#net-load}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Определите приблизительный интервал времени, когда наблюдались сетевые проблемы и ошибки, например:

       * жалобы на сбои подключения к кластеру или долгие отклики;
       * сетевые аномалии и ошибки по данным логов и мониторинга кластера. 

    1. Определите причину появления ошибок:

        1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
        1. Нажмите на имя нужного кластера и перейдите в ![image](../../_assets/console-icons/pulse.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_states-history }}**.
        1. Задайте диапазон времени, в который наблюдались ошибки.
        1. В выпадающем списке над графиком последовательно выберите **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-monitoring-connections }}**, а затем **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-monitoring-net-usage }}**. Сравните графики.
        1. Если наблюдались необычно большие значения **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-monitoring-net-usage }}**, то наиболее вероятная причина — аномальная сетевая активность. 
        1. Если наблюдались необычно большие значения **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-monitoring-connections }}**, то наиболее вероятная причина — всплеск соединений. 

    1. Если причина ошибок — аномальная сетевая активность:

        1. Перейдите на вкладку **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_consumption-history }}**.
        1. Задайте диапазон времени на основе анализа истории состояний.
        1. Выберите **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-group-by }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-group-by-user }}**.
        1. Отсортируйте группы запросов по столбцам **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-sent-total-bytes }}** и **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-recv-total-bytes }}**.
        1. Найдите пользователя с максимальными значениями в этих столбцах. Отфильтруйте группы запросов по этому пользователю.
        1. Выберите **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-group-by }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-group-by-query-id }}** и отключите группировку по пользователю.
        1. Найдите запросы, которые генерировали больше всего трафика. Сохраните текст этих запросов и время их старта.
        1. Перейдите на вкладку **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-session }}**.
        1. Используя поиск по тексту запросов, найдите нужные запросы.
        1. Определите источник трафика с помощью столбца **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-application }}**.
        1. По результатам анализа на стороне приложений с аномальной сетевой активностью:
            * ограничьте объем выгружаемых данных;
            * используйте материализованные представления или временные таблицы;
            * оптимизируйте распределение таблиц (DISTRIBUTED BY) и обновите статистику таблиц перед выполнением больших вставок;
            * пересмотрите архитектуру ETL-пайплайнов.

    1. Если причина ошибок — всплеск соединений:

        1. Под графиком перейдите на вкладку **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-session }}**.
        1. Отсортируйте сессии по столбцу **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-backend-start }}**.
        1. Выберите на графике момент времени с наибольшими значениями **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-monitoring-connections }}**. Используйте блок **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-at-time }}** и стрелки **<** **>** для точного задания момента времени.
        1. Используя фильтры **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-user }}** и **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-application }}**, сравните количество созданных сессий в секунду для каждого источника.
        1. Если один источник создает намного больше сессий, чем остальные:
            * Проверьте, что приложение переиспользует соединения.
            * Настройте параметры повторных подключений: интервал между повторами и общее количество попыток.
        1. При необходимости измените настройки [менеджера подключений](../concepts/pooling.md) по результатам анализа.

{% endlist %}

### Поиск отмененных запросов и ошибок выполнения {#cancelations}

Если пользователь жалуется на большое время ожидания и потерю соединения, однако от других пользователей таких жалоб нет, это может указывать на ошибки выполнения или отмену запросов.

Чтобы определить, какие запросы были отменены или вызвали ошибки выполнения:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Нажмите на имя нужного кластера и перейдите в ![image](../../_assets/console-icons/pulse.svg) **{{ ui-key.yacloud.greenplum.cluster.perf-diag.section_command-center }}** → **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_states-history }}**.
    1. Перейдите на вкладку **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-entity-query }}**.
    1. Выберите момент времени, когда наблюдались проблемы по данным мониторинга. Используйте блок **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-at-time }}** и стрелки **<** **>** для точного задания момента времени.
    1. Отсортируйте запросы по столбцу **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-query-status }}**.
    1. Найдите запросы со статусом `{{ ui-key.yacloud.greenplum.perf-diag.label_query-status-canceled }}` или `{{ ui-key.yacloud.greenplum.perf-diag.label_query-status-error }}`.
    1. Установите источники запросов по значениям в столбцах **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-user }}** и **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-application }}**. При необходимости используйте фильтры **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-user }}** и **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_filter-application }}**.
    1. Если один источник создает намного больше отмененных и ошибочных запросов, чем остальные:
  
       * Проверьте и, при необходимости, оптимизируйте бизнес-логику и структуру SQL-запросов.

         Обратите особое внимание на частые полные выборки, отсутствие фильтрации данных, избыточные соединения таблиц или вложенные подзапросы.

       * Задайте интервал между повторными подключениями и общее количество попыток.

    1. При необходимости используйте [менеджер подключений](../concepts/pooling.md), чтобы ограничить количество одновременных активных подключений и сбалансировать нагрузку между клиентами.
    
       Оптимальные параметры зависят от числа сегментов и ресурсов кластера.

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
