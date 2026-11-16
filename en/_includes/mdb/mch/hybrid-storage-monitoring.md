To monitor the amount of space [MergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/mergetree) table parts occupy in {{ objstorage-name }}, use the `ch_s3_disk_parts_size` metric in {{ monitoring-full-name }}.

{% list tabs group=instructions %}

- Management console {#console}

    1. Open the [management console]({{ link-console-main }}).
    1. [Navigate]({{ link-console-main }}/link/monitoring) to **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
    1. Open the **Metric Explorer** section.
    1. Run this request:

        ```text
        "ch_s3_disk_parts_size"{service="managed-clickhouse", resource_type="cluster", node="by_host", resource_id="<cluster_ID>", subcluster_name="clickhouse_subcluster"}
        ```

{% endlist %}
