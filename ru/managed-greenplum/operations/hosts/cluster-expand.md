# Расширение кластера

Вы можете расширить кластер {{ mgp-name }}, добавив хосты-сегменты. Количество добавляемых хостов не может быть меньше двух. Вы также можете увеличить [количество сегментов на хост](../../concepts/index.md).

Во время расширения кластера данные автоматически перераспределяются равномерно по всем хостам кластера (включая добавленные хосты). Подробнее см. в разделе [{#T}](../../concepts/expand.md).

## Расширить кластер {#add-hosts}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите [на страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Выберите кластер и откройте вкладку ![hosts-edit](../../_assets/../../_assets/console-icons/cube.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.greenplum.action_expand-open }}** в правом верхнем углу.
    1. Укажите настройки расширения кластера:

        * **{{ ui-key.yacloud.greenplum.field_expand-segment-host-count }}** — количество хостов-сегментов, на которое нужно расширить кластер.

            {% include [mgp-expand-setting-host-count](../../../_includes/mdb/mgp/expand/setting-host-count.md) %}

        * **{{ ui-key.yacloud.greenplum.field_expand-add-segments-per-host-count }}** — количество добавляемых сегментов на хост.

            {% include [setting-segment-count](../../../_includes/mdb/mgp/expand/setting-segment-count.md) %}

        * **{{ ui-key.yacloud.greenplum.field_expand-close-cluster }}** — [закрыть ли кластер для доступа](../../concepts/expand.md#setting-close-cluster).

            Если настройка включена, то к кластеру нельзя подключиться и в него не поступают новые пользовательские запросы. В результате расширение кластера будет выполняться быстрее.
            
            {% include [close-and-delay-warning](../../../_includes/mdb/mgp/expand/close-and-delay-warning.md) %}

        * **{{ ui-key.yacloud.greenplum.field_expand-delay-redistribution }}** — [использовать ли фоновое перераспределение данных](../../concepts/expand.md#setting-delay-redistribution).

            * Если фоновый режим выключен, то процесс перераспределения будет запущен однократно сразу после завершения подготовки к расширению кластера.

                {% include [updating-long](../../../_includes/mdb/mgp/expand/updating-long.md) %}

                {% note warning %}

                {% include [manual-redistribution](../../../_includes/mdb/mgp/expand/manual-redistribution.md) %}

                {% endnote %}

            * Если фоновый режим включен, то процесс перераспределения будет отложен. Процесс будет выполняться по заданному расписанию как [регламентная операция](../../concepts/maintenance.md#regular-ops).

                {% include [updating-short](../../../_includes/mdb/mgp/expand/updating-short.md) %}

        * **{{ ui-key.yacloud.greenplum.field_expand-duration }}** — [таймаут (в секундах), после истечения которого процесс перераспределения данных будет прерван](../../concepts/expand.md#setting-duration).

            {% include [setting-expand-duration](../../../_includes/mdb/mgp/expand/setting-expand-duration.md) %}

        * **{{ ui-key.yacloud.greenplum.field_expand-parallel }}** — [количество потоков, которые будут запущены в ходе процесса перераспределения данных](../../concepts/expand.md#setting-parallel).

            {% include [setting-expand-parallel](../../../_includes/mdb/mgp/expand/setting-expand-parallel.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.greenplum.action_expand-start }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы расширить кластер:

    1. Посмотрите описание команды CLI для расширения кластера:

        ```bash
        {{ yc-mdb-gp }} cluster expand --help
        ```

    1. Выполните команду, чтобы расширить кластер:

        ```bash
        {{ yc-mdb-gp }} cluster expand <имя_или_идентификатор_кластера> \
           --segment-host-count <количество_добавляемых_хостов_сегментов> \
           --add-segments-per-host-count <количество_добавляемых_сегментов_на_хост> \
           --close-cluster <временный_запрет_на_подключение_к_кластеру> \
           --delay-redistribution <фоновое_перераспределение_данных> \
           --duration-seconds <таймаут_перераспределения_данных> \
           --parallel <количество_потоков_перераспределения_данных>
        ```

        Где:

        * `--segment-host-count` — количество хостов-сегментов, на которое нужно расширить кластер.

            {% include [mgp-expand-setting-host-count](../../../_includes/mdb/mgp/expand/setting-host-count.md) %}

        * `--add-segments-per-host-count` — количество добавляемых сегментов на хост.

            {% include [setting-segment-count](../../../_includes/mdb/mgp/expand/setting-segment-count.md) %}

        * `--close-cluster` — [закрыть ли кластер для доступа](../../concepts/expand.md#setting-close-cluster): `true` или `false`.

            {% include [setting-close-cluster](../../../_includes/mdb/mgp/expand/setting-close-cluster.md) %}

        * `--delay-redistribution` — [использовать ли фоновое перераспределение данных](../../concepts/expand.md#setting-delay-redistribution): `true` или `false`.

            {% include [setting-delay-redistribution](../../../_includes/mdb/mgp/expand/setting-delay-redistribution.md) %}

        * `--duration-seconds` — [таймаут (в секундах), после истечения которого процесс перераспределения данных будет прерван](../../concepts/expand.md#setting-duration).

            {% include [setting-expand-duration](../../../_includes/mdb/mgp/expand/setting-expand-duration.md) %}

        * `--parallel` — [количество потоков, которые будут запущены в ходе процесса перераспределения данных](../../concepts/expand.md#setting-parallel).

            {% include [setting-expand-parallel](../../../_includes/mdb/mgp/expand/setting-expand-parallel.md) %}

        Идентификатор и имя кластера можно получить со [списком кластеров в каталоге](../cluster-list.md#list-clusters).

- REST API {#api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. Воспользуйтесь методом [Cluster.Expand](../../api-ref/Cluster/expand.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/<идентификатор_кластера>/expand' \
            --data '{
                      "segmentHostCount": "<количество_добавляемых_хостов-сегментов>",
                      "addSegmentsPerHostCount": "<количество_добавляемых_сегментов_на_хост>",
                      "duration": "<таймаут_перераспределения_данных>",
                      "parallel": "<количество_потоков_перераспределения_данных>",
                      "closeCluster": "<временный_запрет_на_подключение_к_кластеру>",
                      "delayRedistribution": "<фоновое_перераспределение_данных>"
                    }'
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](../cluster-list.md#list-clusters).

        Параметры тела запроса:

        * `segmentHostCount` — количество хостов-сегментов, на которое нужно расширить кластер.

            {% include [mgp-expand-setting-host-count](../../../_includes/mdb/mgp/expand/setting-host-count.md) %}

        * `addSegmentsPerHostCount` — количество добавляемых сегментов на хост.

            {% include [setting-segment-count](../../../_includes/mdb/mgp/expand/setting-segment-count.md) %}

        * `duration` — [таймаут](../../concepts/expand.md#setting-duration) в секундах, после истечения которого процесс перераспределения данных будет прерван.

            {% include [setting-expand-duration](../../../_includes/mdb/mgp/expand/setting-expand-duration.md) %}

        * `parallel` — [количество потоков](../../concepts/expand.md#setting-parallel), которые будут запущены в ходе процесса перераспределения данных.

            {% include [setting-expand-parallel](../../../_includes/mdb/mgp/expand/setting-expand-parallel.md) %}

        * `closeCluster` — [закрыть кластер](../../concepts/expand.md#setting-close-cluster) для доступа: `true` или `false`.

            {% include [setting-close-cluster](../../../_includes/mdb/mgp/expand/setting-close-cluster.md) %}

        * `delayRedistribution` — [использовать фоновое перераспределение данных](../../concepts/expand.md#setting-delay-redistribution): `true` или `false`.

            {% include [setting-delay-redistribution](../../../_includes/mdb/mgp/expand/setting-delay-redistribution.md) %}

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/Cluster/expand.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

    1. [Получите IAM-токен для аутентификации в API](../../api-ref/authentication.md) и поместите токен в переменную среды окружения:

        {% include [api-auth-token](../../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Воспользуйтесь вызовом [ClusterService.Expand](../../api-ref/grpc/Cluster/expand.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/greenplum/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "segment_host_count": "<количество_добавляемых_хостов-сегментов>",
                  "add_segments_per_host_count": "<количество_добавляемых_сегментов_на_хост>",
                  "duration": "<таймаут_перераспределения_данных>",
                  "parallel": "<количество_потоков_перераспределения_данных>",
                  "close_cluster": "<временный_запрет_на_подключение_к_кластеру>",
                  "delay_redistribution": "<фоновое_перераспределение_данных>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.greenplum.v1.ClusterService.Expand
        ```

        Идентификатор кластера можно запросить со [списком кластеров в каталоге](../cluster-list.md#list-clusters).

        Параметры тела запроса:

        * `segment_host_count` — количество хостов-сегментов, на которое нужно расширить кластер.

            {% include [mgp-expand-setting-host-count](../../../_includes/mdb/mgp/expand/setting-host-count.md) %}

        * `add_segments_per_host_count` — количество добавляемых сегментов на хост.

            {% include [setting-segment-count](../../../_includes/mdb/mgp/expand/setting-segment-count.md) %}

        * `duration` — [таймаут](../../concepts/expand.md#setting-duration) в секундах, после истечения которого процесс перераспределения данных будет прерван.

            {% include [setting-expand-duration](../../../_includes/mdb/mgp/expand/setting-expand-duration.md) %}

        * `parallel` — [количество потоков](../../concepts/expand.md#setting-parallel), которые будут запущены в ходе процесса перераспределения данных.

            {% include [setting-expand-parallel](../../../_includes/mdb/mgp/expand/setting-expand-parallel.md) %}

        * `close_cluster` — [закрыть кластер](../../concepts/expand.md#setting-close-cluster) для доступа: `true` или `false`.

            {% include [setting-close-cluster](../../../_includes/mdb/mgp/expand/setting-close-cluster.md) %}

        * `delay_redistribution` — [использовать фоновое перераспределение данных](../../concepts/expand.md#setting-delay-redistribution): `true` или `false`.

            {% include [setting-delay-redistribution](../../../_includes/mdb/mgp/expand/setting-delay-redistribution.md) %}

    1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../../api-ref/Cluster/expand.md#yandex.cloud.operation.Operation).

{% endlist %}

## Мониторинг перераспределения данных {#redistribute-monitoring}

Доступно несколько способов мониторинга [процесса перераспределения данных](../../concepts/expand.md#redistribution):

* Если кластер [закрыт от нагрузки](#setting-close-cluster) и [фоновое перераспределение данных](#setting-delay-redistribution) выключено, то отслеживать ход процесса можно только с помощью инструментов мониторинга {{ yandex-cloud }}.

    [Наблюдайте за графиком](../monitoring.md#monitoring-cluster) **Expansion progress** на вкладке **{{ ui-key.yacloud.mdb.cluster.switch_monitoring }}** страницы управления кластером или запрашивайте значения [метрик](../../metrics.md#managed-greenplum-expand-metrics) `gp_expand.*` с помощью сервиса [{{ monitoring-full-name }}](../../../monitoring/concepts/index.md).

* Если кластер не закрыт от нагрузки, то также можно выполнять SQL-запросы к объектам служебной схемы данных `gpexpand`.

    {% include [gpexpand-schema-availability](../../../_includes/mdb/mgp/expand/gpexpand-schema-availability.md) %}

    Чтобы отслеживать ход процесса перераспределения данных с помощью SQL-запросов:

    1. [Подключитесь к базе данных](../connect.md) `postgres` от имени пользователя с [ролью](../../concepts/cluster-users.md#mdb_admin) `mdb_admin`.
    1. Выполните запрос, чтобы получить текущий статус процесса:

        {% include [sql-redistribution-status](../../../_includes/mdb/mgp/expand/sql-redistribution-status.md) %}

    Результат запроса будет содержать [различную информацию]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-system_catalogs-gp_expansion_tables.html) о ходе процесса перераспределения данных. В столбце `status` будет указан текущий статус обработки конкретных таблиц:

    * `NOT STARTED` — запланировано перераспределение данных таблицы, таблица находится в очереди на перераспределение.

        Если кластер [не закрыт от нагрузки](../../concepts/expand.md#setting-close-cluster), то при необходимости [можно повлиять на приоритет таблицы](#table-priority), чтобы изменить ее позицию в очереди.

    * `IN PROGRESS` — происходит перераспределение данных таблицы.
    * `COMPLETED` — перераспределение данных таблицы завершено.
    * `NO LONGER EXISTS` — таблица больше не существует.

## Дополнительные действия {#additional-actions}

### Изменить приоритет перераспределения таблиц {#table-priority}

На этапе [подготовки к расширению кластера](../../concepts/expand.md#preparation) каждой таблице назначается ранг, влияющий на ее приоритет в очереди на перераспределение. Чем выше ранг таблицы, тем выше ее приоритет в очереди и тем быстрее будет выполнено перераспределение данных таблицы.

При необходимости можно изменить ранг одной или нескольких таблиц, если кластер [не закрыт от нагрузки](../../concepts/expand.md#setting-close-cluster). Для этого нужно изменить таблицу в служебной схеме данных `gpexpand`.

{% include [gpexpand-schema-availability](../../../_includes/mdb/mgp/expand/gpexpand-schema-availability.md) %}

Чтобы изменить ранг перераспределяемых таблиц:

1. [Подключитесь к базе данных](../connect.md) `postgres` от имени пользователя с [ролью](../../concepts/cluster-users.md#mdb_admin) `mdb_admin`.

1. Выполните запрос, чтобы получить текущий статус процесса перераспределения данных:

    {% include [sql-redistribution-status](../../../_includes/mdb/mgp/expand/sql-redistribution-status.md) %}

    В том числе будут выведены полные имена таблиц (`fq_name`) и их ранги (`rank`).

1. Измените ранг для одной или нескольких таблиц:

    ```sql
    UPDATE gpexpand.status_detail
    SET rank=<нужный_ранг>
    WHERE fq_name IN (<список_полных_имен_таблиц>);
    ```

    Подробнее см. в [документации {{ GP }}]({{ gp.docs.vmware }}/6/greenplum-database/admin_guide-expand-expand-redistribute.html#ranking-tables-for-redistribution).

### Запустить перераспределение данных вручную {#start-redistribute}

Если при расширении кластера не использовалось [фоновое перераспределение данных](../../concepts/expand.md#setting-delay-redistribution) и был установлен недостаточно большой [таймаут для процесса перераспределения данных](../../concepts/expand.md#setting-duration), то этот процесс может завершиться раньше, чем будут перераспределены данные всех таблиц.

При этом часть данных останется распределенной неравномерно. Как следствие, в [логах кластера](../cluster-logs.md) будет возникать ошибка `Unknown error: Partially Distributed Data`. Чтобы устранить ошибку, вручную запустите перераспределение данных:

1. Узнайте общее количество сегментов в кластере:

    1. [Получите детальную информацию о кластере](../cluster-list.md#get-cluster).
    1. Умножьте количество сегментов на хост на количество хостов-сегментов.

1. [Подключитесь к нужной базе данных](../connect.md) от имени пользователя с [ролью](../../concepts/cluster-users.md#mdb_admin) `mdb_admin`.

1. Найдите таблицы, данные которых распределены неравномерно:

    ```sql
    SELECT *
        FROM
            (SELECT oid, relname FROM pg_class) pgc
            JOIN
            (SELECT localoid AS oid, numsegments FROM gp_distribution_policy) gpdp
            USING (oid)
        WHERE numsegments != <общее_количество_сегментов>;
    ```

    Будет выведен список таблиц, в котором для каждой таблицы указаны:
    * `oid` — идентификатор таблицы;
    * `relname` — имя таблицы;
    * `numsegment` — количество сегментов, по которым размещены данные.

    Подробнее см. в документации {{ GP }}, посвященной таблице [gp_distribution_policy]({{ gp.docs.vmware }}/6/greenplum-database/ref_guide-system_catalogs-gp_distribution_policy.html).

1. Запустите перераспределение данных, пользуясь информацией, полученной ранее.

    Чтобы перераспределить данные отдельной таблицы, выполните запрос:

    * Для обычной таблицы:

        ```sql
        ALTER TABLE ONLY <имя_таблицы> EXPAND TABLE;
        ```

    * Для [партиционированной]({{ gp.docs.vmware }}/6/greenplum-database/admin_guide-ddl-ddl-partition.html#about-table-partitioning) таблицы:

        ```sql
        ALTER TABLE <имя_таблицы>
        SET WITH (REORGANIZE=true) <политика_распределения>;
        ```

        Чтобы узнать значение политики распределения {{ GP }} для отдельной партиции таблицы, выполните запрос:

        ```sql
        SELECT pg_get_table_distributedby(<OID_партиции>) AS distribution_policy;
        ```

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
