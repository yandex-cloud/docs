Чтобы узнать, какой объем занимают куски таблиц [MergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/mergetree) в {{ objstorage-name }}, воспользуйтесь метрикой `ch_s3_disk_parts_size` в сервисе {{ monium-full-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Откройте [консоль управления]({{ link-console-main }}).
    1. [Перейдите]({{ link-monium }}) в сервис {{ monium-name }}.
    1. Откройте раздел ![compass](../../../_assets/console-icons/compass.svg) **Обзор** → ![pulse](../../../_assets/console-icons/rectangle-pulse.svg) **Метрики**.
    1. Выполните запрос:

        ```text
        "ch_s3_disk_parts_size"{service="managed-clickhouse", resource_type="cluster", node="by_host", resource_id="<идентификатор_кластера>", subcluster_name="clickhouse_subcluster"}
        ```

{% endlist %}
