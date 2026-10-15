Чтобы узнать, какой объем занимают куски таблиц [MergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/mergetree) в {{ objstorage-name }}, воспользуйтесь метрикой `ch_s3_disk_parts_size` в сервисе {{ monitoring-full-name }}:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Откройте [консоль управления]({{ link-console-main }}).
    1. [Перейдите]({{ link-console-main }}/link/monitoring) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
    1. Откройте раздел **Обзор метрик**.
    1. Выполните запрос:

        ```text
        "ch_s3_disk_parts_size"{service="managed-clickhouse", resource_type="cluster", node="by_host", resource_id="<идентификатор_кластера>", subcluster_name="clickhouse_subcluster"}
        ```

{% endlist %}
