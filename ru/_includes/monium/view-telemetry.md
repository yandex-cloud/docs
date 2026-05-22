{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. На главной странице [{{ monium-name }}]({{ link-monium }}) слева выберите раздел с нужным типом данных:

      {% list tabs group=monium_telemetry_type %}

      - {{ ui-key.yacloud_monitoring.aside-navigation.menu-item.explorer.title }} {#metrics}

        {% include [view-telemetry-common-steps](view-telemetry-common-steps.md) %}

        ![image](../../_assets/monium/petclinic-metrics.png)

        Подробнее о [работе с метриками](../../monium/metrics/metric-explorer.md).

      - {{ ui-key.yacloud_monitoring.aside-navigation.menu-item.logs.title }} {#logs}

        {% include [view-telemetry-common-steps](view-telemetry-common-steps.md) %}

        ![image](../../_assets/monium/petclinic-logs.png)

        Подробнее о [работе с логами](../../monium/logs/logs-explorer.md).

      - {{ ui-key.yacloud_monitoring.aside-navigation.menu-item.traces.title }} {#traces}

        {% include [view-telemetry-common-steps](view-telemetry-common-steps.md) %}

        ![image](../../_assets/monium/petclinic-traces.png)

        Подробнее о [работе с трейсами](../../monium/traces/operations/traces-explorer.md).

      {% endlist %}

  1. Чтобы посмотреть информацию о шарде с данными, слева выберите **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.shards.title }}** и затем шард с названием вашего сервиса.

{% endlist %}