{% list tabs group=instructions %}

- {{ monium-name }} UI {#console}

  1. On the [{{ monium-name }}]({{ link-monium }}) home page, select a data type section on the left:

      {% list tabs group=monium_telemetry_type %}

      - {{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }} {#metrics}

        {% include [view-telemetry-common-steps](view-telemetry-common-steps.md) %}

        ![image](../../_assets/monium/petclinic-metrics.png)

        More on [metrics](../../monium/metrics/metric-explorer.md).

      - {{ ui-key.yacloud_monitoring.aside-navigation.menu-item.logs.title }} {#logs}

        {% include [view-telemetry-common-steps](view-telemetry-common-steps.md) %}

        ![image](../../_assets/monium/petclinic-logs.png)

        More on [logs](../../monium/logs/logs-explorer.md).

      - {{ ui-key.yacloud_monitoring.aside-navigation.menu-item.traces.title }} {#traces}

        {% include [view-telemetry-common-steps](view-telemetry-common-steps.md) %}

        ![image](../../_assets/monium/petclinic-traces.png)

        More on [traces](../../monium/traces/operations/traces-explorer.md).

      {% endlist %}

  1. To view information about the data shard, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.shards.title }}** on the left and then, the shard with your service name.

{% endlist %}